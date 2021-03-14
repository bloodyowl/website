module Styles = {
  open Emotion
  let container = css({
    "display": "flex",
    "flexGrow": 1,
    "alignItems": "center",
    "justifyContent": "center",
  })
  let text = css({"fontSize": 22, "fontWeight": "bold", "textAlign": "center"})
}

@react.component
let make = () =>
  <div className=Styles.container>
    <div className=Styles.text> {`An error occured 😕`->React.string} </div>
  </div>
