let component = ReasonReact.statelessComponent("BeOpWidget");

module Styles = {
  open Css;
  let container = style([padding2(~v=10->px, ~h=zero)]);
};

[@react.component]
let make = () =>
  ReactCompat.useRecordApi({
    ...component,
    shouldUpdate: _ => false,
    render: _ =>
      <div className=Styles.container> <div className="BeOpWidget" /> </div>,
  });
