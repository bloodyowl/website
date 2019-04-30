let component = ReasonReact.statelessComponent("ErrorIndicator");

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

[@react.component]
let make = () =>
  ReactCompat.useRecordApi({
    ...component,
    render: _ =>
      <div className=Styles.container>
        <div className=Styles.text>
          {js|An error occured 😕|js}->ReasonReact.string
        </div>
      </div>,
  });
