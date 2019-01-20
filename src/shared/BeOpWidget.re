let component = React.statelessComponent("BeOpWidget");

module Styles = {
  open Css;
  let container = style([padding2(~v=10->px, ~h=zero)]);
};

let make = _ => {
  ...component,
  shouldUpdate: _ => false,
  render: _ =>
    <div className=Styles.container> <div className="BeOpWidget" /> </div>,
};
