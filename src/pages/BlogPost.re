open Belt;

let component = ReasonReact.statelessComponent("BlogPost");

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
  let title = style([margin(zero), marginBottom(10->px)]);
  let date = style([fontSize(14->px), opacity(0.5)]);
  let body = style([marginTop(40->px), fontSize(18->px)]);
};

{
  open Css;

  global(
    "pre",
    [
      padding2(~v=10->px, ~h=20->px),
      backgroundColor("F4F7F8"->hex),
      overflowX(auto),
      `declaration(("WebkitOverflowScrolling", "touch")),
      fontSize(14->px),
    ],
  );
  global(
    "code",
    [fontFamily(Theme.codeFontFamily), lineHeight(`abs(1.))],
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
let make =
    (~post: RequestStatus.t(Result.t(Post.t, Errors.t)), ~onLoadRequest, ()) =>
  ReactCompat.useRecordApi({
    ...component,
    didMount: _ =>
      switch (post) {
      | NotAsked => onLoadRequest()
      | _ => ()
      },
    render: _ =>
      switch (post) {
      | NotAsked
      | Loading => <ActivityIndicator />
      | Done(Ok(post)) =>
        <WithTitle title=post.title>
          <div className=Styles.container>
            <h1 className=Styles.title> post.title->ReasonReact.string </h1>
            <div className=Styles.date>
              post.date
              ->Js.Date.fromString
              ->Date.getFormattedString
              ->ReasonReact.string
            </div>
            <div
              className=Styles.body
              dangerouslySetInnerHTML={"__html": post.body}
            />
            <BeOpWidget />
          </div>
        </WithTitle>
      | Done(Error(_)) => <ErrorIndicator />
      },
  });
