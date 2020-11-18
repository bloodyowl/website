include CssReset;

open Belt;

module Styles = {
  open Css;
  let container =
    style([
      minHeight(100.->vh),
      display(flexBox),
      flexDirection(column),
      alignItems(stretch),
    ]);
};

[@react.component]
let make = (~url: ReasonReactRouter.url, ~config: Pages.config, ()) => {
  <div className=Styles.container>
    <Pages.Head>
      <meta charSet="UTF-8" />
      <style>
        {|@import url("//hello.myfonts.net/count/3cae5f")|}->React.string
      </style>
      <meta
        name="google-site-verification"
        content="w75-P-0ywXWkyZvYPbkSM3VSM2hny25UrfeiWJt3B1k"
      />
      <meta
        name="viewport"
        content="width=device-width, initial-scale=1, shrink-to-fit=no"
      />
      {let url = config.baseUrl ++ "/" ++ String.concat("/", url.path);
       <link
         rel="canonical"
         href={url->Js.String2.endsWith("/") ? url : url ++ "/"}
       />}
    </Pages.Head>
    <Header />
    {switch (url.path) {
     | [] => <Home />
     | ["blog"] => <BlogPostList />
     | ["blog", slug] => <BlogPost slug />
     | _ => <ErrorIndicator />
     }}
    <Footer />
  </div>;
};

let default =
  Pages.make(
    make,
    {
      siteTitle: "Matthias Le Brun",
      siteDescription: "Front-end developer and designer. ReasonML, ReasonReact, ReactJS.",
      distDirectory: "dist",
      baseUrl: "https://bloodyowl.io",
      staticsDirectory: Some("statics"),
      paginateBy: 20,
      variants: [|
        {
          subdirectory: None,
          localeFile: None,
          contentDirectory: "contents",
          getUrlsToPrerender: ({getAll}) =>
            Array.concatMany([|
              [|"/", "blog"|],
              getAll("blog")->Array.map(slug => "/blog/" ++ slug),
              [|"404.html"|],
            |]),
        },
      |],
    },
  );
