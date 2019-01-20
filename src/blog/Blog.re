open Node;
open Belt;

[@bs.module "fs"] external mkdirSync: string => unit = "mkdirSync";

module Posts = {
  type t('a) = {
    body: string,
    meta: 'a,
  };
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
  let get = () => {
    try (
      {
        mkdirSync(Path.join([|Process.cwd(), "build/blog"|]));
        mkdirSync(Path.join([|Process.cwd(), "build/blog/json"|]));
      }
    ) {
    | _ => ()
    };
    Glob.glob(Path.join([|Process.cwd(), "blog/**/*.md"|]))
    ->Future.mapOk(files =>
        files->Array.map(item => (item, Fs.readFileAsUtf8Sync(item)))
      )
    ->Future.mapOk(posts =>
        posts->Array.map(((path, item)) => {
          let front = FrontMatter.parse(item);
          (
            path,
            {
              body: Remarkable.render(remarkable, front##body),
              meta: front##attributes,
            },
          );
        })
      )
    ->Future.mapOk(posts => {
        posts->Array.map(((path, item)) =>
          Fs.writeFileAsUtf8Sync(
            Path.join([|
              Process.cwd(),
              "build/blog/json/",
              path->Path.basename_ext(".md") ++ ".json",
            |]),
            Js.Json.stringifyAny({"body": item.body, "meta": item.meta})
            ->Option.getWithDefault(""),
          )
        );
        Fs.writeFileAsUtf8Sync(
          Path.join([|Process.cwd(), "build/blog/json/", "all.json"|]),
          posts
          ->Array.map(((path, item)) =>
              Js.Obj.empty()
              ->Js.Obj.assign(item.meta)
              ->Js.Obj.assign({"slug": path->Path.basename_ext(".md")})
            )
          ->Js.Json.stringifyAny
          ->Option.getWithDefault(""),
        );
      })
    ->Future.tap(Js.log);
  };
};

Posts.get();
