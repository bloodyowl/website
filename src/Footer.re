let component = React.statelessComponent("Footer");

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

let make = _ => {
  ...component,
  render: _ =>
    <div className=Styles.container>
      "Copyright 2019 - Matthias Le Brun"->React.string
    </div>,
};
