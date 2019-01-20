open Belt;

let component = React.statelessComponent("BlogPost");

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

Css.(
  {
    global(
      "pre",
      [
        padding2(~v=10->px, ~h=20->px),
        backgroundColor("F4F7F8"->hex),
        overflowX(auto),
        `declaration(("WebkitOverflowScrolling", "touch")),
      ],
    );
    global("code", [fontFamily(Theme.codeFontFamily)]);
    global(".hljs-keyword", [color("DA6BB5"->hex)]);
    global(".hljs-constructor", [color("E6A241"->hex)]);
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
  }
);

let make =
    (~post: RequestStatus.t(Result.t(Post.t, Errors.t)), ~onLoadRequest, _) => {
  ...component,
  didMount: _ => {
    switch (post) {
    | NotAsked => onLoadRequest()
    | _ => ()
    };
  },
  render: _ => {
    switch (post) {
    | NotAsked
    | Loading => <ActivityIndicator />
    | Done(Ok(post)) =>
      <div className=Styles.container>
        <h1 className=Styles.title> post.title->React.string </h1>
        <div className=Styles.date>
          {post.date->Js.Date.fromString->Date.getFormattedString->React.string}
        </div>
        <div
          className=Styles.body
          dangerouslySetInnerHTML={"__html": post.body}
        />
        <BeOpWidget />
      </div>
    | Done(Error(_)) => <ErrorIndicator />
    };
  },
};
