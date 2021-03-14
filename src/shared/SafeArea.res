module Styles = {
  open Emotion
  let container = css({
    "display": "flex",
    "flexDirection": "column",
    "alignItems": "stretch",
    "justifyContent": "center",
    "flexGrow": 1,
    "paddingLeft": "env(safe-area-inset-left)",
    "paddingRight": "env(safe-area-inset-right)",
  })
}

@react.component
let make = (~children) => {
  <div className=Styles.container> children </div>
}
