open Node;
open Belt;

[@bs.module "fs"] external mkdirSync: string => unit = "mkdirSync";

let remarkable =
  Remarkable.make(
    "full",
    {
      "highlight":
        Some(
          (code, lang) =>
            try (
              {
                HighlightJs.highlight(~lang, code)##value;
              }
            ) {
            | _ => ""
            },
        ),
    },
  );

let createDir = () =>
  try (
    {
      mkdirSync(Path.join([|Process.cwd(), "build/api"|]));
    }
  ) {
  | _ => ()
  };

module Posts = {
  let parse = ((path, item)) => {
    let front = FrontMatter.parse(item);
    let post: Post.t = {
      body: Remarkable.render(remarkable, front##body),
      title: front##attributes##title,
      date: front##attributes##date,
    };
    let postShallow: PostShallow.t = {
      title: front##attributes##title,
      date: front##attributes##date,
      slug: path->Path.basename_ext(".md"),
    };
    (post, postShallow);
  };
  let get = () => {
    createDir();
    Glob.glob(Path.join([|Process.cwd(), "blog/**/*.md"|]))
    ->Future.mapOk(files =>
        files->Array.map(item => (item, Fs.readFileAsUtf8Sync(item)))
      )
    ->Future.mapOk(posts => posts->Array.map(parse));
  };
};

module Json = {
  let make = posts => {
    posts->Array.forEach(((post, postShallow: PostShallow.t)) =>
      Fs.writeFileAsUtf8Sync(
        Path.join([|
          Process.cwd(),
          "build/api/",
          postShallow.slug ++ ".json",
        |]),
        post->Post.toJs->Js.Json.stringifyAny->Option.getWithDefault(""),
      )
    );
    Fs.writeFileAsUtf8Sync(
      Path.join([|Process.cwd(), "build/api/", "all.json"|]),
      posts
      ->Array.map(((_, postShallow)) => PostShallow.toJs(postShallow))
      ->Js.Json.stringifyAny
      ->Option.getWithDefault(""),
    );
    posts;
  };
};
