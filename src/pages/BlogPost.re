open Belt;

module Styles = {
  open Css;
  let container =
    style([
      maxWidth(600->px),
      padding2(~v=zero, ~h=10->px),
      margin2(~v=20->px, ~h=auto),
      width(100.->pct),
      flexGrow(1.),
    ]);
  let title =
    style([
      margin(zero),
      fontSize(48->px),
      marginTop(50->px),
      marginBottom(10->px),
      lineHeight(`abs(1.15)),
    ]);
  let date = style([fontSize(14->px), opacity(0.5), marginBottom(50->px)]);
  let body =
    style([
      marginTop(40->px),
      fontSize(18->px),
      selector(
        "a",
        [
          color("135EFF"->hex),
          hover([color("13A3FF"->hex)]),
          media("(prefers-color-scheme: dark)", [color("13A3FF"->hex)]),
        ],
      ),
      selector("img", [maxWidth(100.0->pct), height(auto)]),
    ]);
};

{
  open Css;

  global(
    "pre",
    [
      padding2(~v=10->px, ~h=20->px),
      backgroundColor("F4F7F8"->hex),
      overflowX(auto),
      unsafe("WebkitOverflowScrolling", "touch"),
      fontSize(16->px),
      borderLeftWidth(2->px),
      borderLeftColor(Theme.darkBody->hex),
      borderLeftStyle(solid),
      media(
        "(prefers-color-scheme: dark)",
        [backgroundColor(rgba(255, 255, 255, `num(0.05)))],
      ),
    ],
  );
  global(
    "code",
    [
      fontFamily(`custom(Theme.codeFontFamily)),
      fontSize(0.85->em),
      lineHeight(`abs(1.)),
    ],
  );
  global(".hljs-keyword", [color("DA6BB5"->hex)]);
  global(".hljs-constructor", [color("DD792B"->hex)]);
  global(".hljs-identifier", [color("1E9EA7"->hex)]);
  global(".hljs-module-identifier", [color("C84682"->hex)]);
  global(".hljs-string", [color("3BA1C8"->hex)]);
  global(".hljs-comment", [color("aaa"->hex)]);
  global(".hljs-operator", [color("DA6BB5"->hex)]);
  global(".hljs-attribute", [color("4CB877"->hex)]);
  global("table", [width(100.->pct), textAlign(center)]);
  global(
    "table thead th",
    [backgroundColor(Theme.lightBody->hex), padding2(~v=10->px, ~h=zero)],
  );
  global(
    "blockquote",
    [
      opacity(0.6),
      borderLeft(4->px, solid, Theme.darkBody->hex),
      margin(zero),
      padding2(~h=20->px, ~v=zero),
    ],
  );
};

[@react.component]
let make = (~slug, ()) => {
  let post = Pages.useItem("blog", ~id=slug);
  <>
    {switch (post) {
     | NotAsked
     | Loading => <ActivityIndicator />
     | Done(Ok(post)) =>
       <>
         <Pages.Head> <title> post.title->React.string </title> </Pages.Head>
         <div className=Styles.container>
           <h1 className=Styles.title> post.title->ReasonReact.string </h1>
           <div className=Styles.date>
             {post.date
              ->Option.map(Js.Date.fromString)
              ->Option.map(Date.getFormattedString)
              ->Option.map(ReasonReact.string)
              ->Option.getWithDefault(React.null)}
           </div>
           <div
             role="article"
             className=Styles.body
             dangerouslySetInnerHTML={"__html": post.body}
           />
           <BeOpWidget />
         </div>
       </>
     | Done(Error(_)) => <ErrorIndicator />
     }}
  </>;
};
