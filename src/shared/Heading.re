let component = React.statelessComponent("Heading");

module Styles = {
  open Css;
  let title =
    style([
      margin2(~v=20->px, ~h=zero),
      fontSize(42->px),
      fontWeight(bold),
    ]);
};

let make = (~text, ~level=2, _) => {
  ...component,
  render: _ =>
    <div className=Styles.title role="heading" ariaLevel=level>
      text->React.string
    </div>,
};
