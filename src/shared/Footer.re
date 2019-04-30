let component = ReasonReact.statelessComponent("Footer");

module Styles = {
  open Css;
  let container =
    style([
      backgroundColor(Theme.darkBody->hex),
      color("fff"->hex),
      textAlign(center),
      padding(20->px),
      fontSize(14->px),
    ]);
};

[@react.component]
let make = () =>
  ReactCompat.useRecordApi({
    ...component,
    render: _ =>
      <div className=Styles.container>
        "Copyright 2019 - Matthias Le Brun"->ReasonReact.string
      </div>,
  });
