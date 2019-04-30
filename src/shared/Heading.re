let component = ReasonReact.statelessComponent("Heading");

module Styles = {
  open Css;
  let title =
    style([
      margin2(~v=20->px, ~h=zero),
      fontSize(42->px),
      fontWeight(bold),
    ]);
};

[@react.component]
let make = (~text, ~level=2, ()) =>
  ReactCompat.useRecordApi({
    ...component,
    render: _ =>
      <div className=Styles.title role="heading" ariaLevel=level>
        text->ReasonReact.string
      </div>,
  });
