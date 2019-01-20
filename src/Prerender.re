open Belt;

module Emotion = {
  [@bs.module "emotion-server"]
  external renderStylesToString: string => string = "renderStylesToString";
};

let index = Node.Fs.readFileSync("./build/prerender/__source.html", `utf8);

[@bs.module "fs"] external mkdirSync: string => unit = "mkdirSync";

module Sitemap = {
  let make = posts => {
    let posts =
      posts
      ->List.map(((path, _, _)) => {
          let path = String.concat("/", path);
          let path = Js.String.endsWith(path, "/") ? path : path ++ "/";
          {j|<url>
    <loc>https://bloodyowl.github.io/$path</loc>
</url>
|j};
        })
      ->List.reduce("", (++));
    {j|<?xml version="1.0" encoding="utf-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">
$posts
</urlset>|j};
  };
};

Blog.Posts.get()
->Future.mapOk(Blog.Json.make)
->Future.mapOk(posts =>
    [
      ([], App.default, "Matthias Le Brun"),
      (
        ["blog"],
        {
          ...App.default,
          postList: Done(Ok(posts->Array.map(((_, shallow)) => shallow))),
        },
        "Blog",
      ),
    ]
    ->List.concat(
        posts
        ->List.fromArray
        ->List.map(((post, postShallow: PostShallow.t)) =>
            (
              ["blog", postShallow.slug],
              {
                ...App.default,
                posts:
                  App.default.posts
                  ->Map.String.set(postShallow.slug, Done(Ok(post))),
              },
              post.title,
            )
          ),
      )
  )
->Future.mapOk(pages => {
    pages->List.forEach(((path, initialData, title)) => {
      let prerendered =
        Emotion.renderStylesToString(
          ReactDOMServerRe.renderToString(
            <App url={path, search: "", hash: ""} initialData />,
          ),
        );
      let data =
        Js.Json.stringifyAny(initialData)
        ->Option.map(string =>
            string->Js.String.replaceByRe([%re "/</g"], {js|\\u003c|js}, _)
          );
      try (
        {
          mkdirSync("./build/" ++ String.concat("/", path));
        }
      ) {
      | _ => ()
      };
      Node.Fs.writeFileAsUtf8Sync(
        "./build/" ++ String.concat("/", path) ++ "/index.html",
        index
        ->Js.String.replace(
            {|<div id="root"></div>|},
            {j|<div id="root">$prerendered</div><script id="data">window.initialData = $data</script>|j},
            _,
          )
        ->Js.String.replace(
            {|<title>Matthias Le Brun | @bloodyowl</title>|},
            {j|<title>$title | @bloodyowl</title>|j},
            _,
          ),
      );
    });
    Node.Fs.writeFileAsUtf8Sync("./build/sitemap.xml", Sitemap.make(pages));
  });
