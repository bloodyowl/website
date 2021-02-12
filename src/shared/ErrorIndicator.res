module Styles = {
  open Css
  let container = style(list{
    display(flexBox),
    flexGrow(1.0),
    alignItems(center),
    justifyContent(center),
  })
  let text = style(list{fontSize(22->px), fontWeight(bold), textAlign(center)})
}

@react.component
let make = () =>
  <div className=Styles.container>
    <div className=Styles.text> {`An error occured 😕`->React.string} </div>
  </div>
