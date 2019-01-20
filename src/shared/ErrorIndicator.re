let component = React.statelessComponent("ErrorIndicator");

module Styles = {
  open Css;
  let container =
    style([
      display(flexBox),
      flexGrow(1.0),
      alignItems(center),
      justifyContent(center),
    ]);
  let text =
    style([fontSize(22->px), fontWeight(bold), textAlign(center)]);
};

let make = _ => {
  ...component,
  render: _ =>
    <div className=Styles.container>
      <div className=Styles.text> {js|An error occured 😕|js}->React.string </div>
    </div>,
};
