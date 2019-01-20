open Belt;

module Emotion = {
  [@bs.module "emotion-server"]
  external renderStylesToString: string => string = "renderStylesToString";
};

let index = Node.Fs.readFileSync("./build/prerender/__source.html", `utf8);

[@bs.module "fs"] external mkdirSync: string => unit = "mkdirSync";

Blog.Posts.get()
->Future.mapOk(Blog.Json.make)
->Future.mapOk(posts =>
    [
      ([], App.default),
      (
        ["blog"],
        {
          ...App.default,
          postList: Done(Ok(posts->Array.map(((_, shallow)) => shallow))),
        },
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
            )
          ),
      )
  )
->Future.mapOk(pages =>
    pages->List.forEach(((path, initialData)) => {
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
        index->Js.String.replace(
                 {|<div id="root"></div>|},
                 {j|<div id="root">$prerendered</div><script id="data">window.initialData = $data</script>|j},
                 _,
               ),
      );
    })
  );
