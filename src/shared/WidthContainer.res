module Styles = {
  open Emotion
  let container = css({
    "width": "100%",
    "margin": "0 auto",
    "padding": 10,
    "maxWidth": 1024,
    "position": "relative",
    "flexGrow": 1,
    "display": "flex",
    "flexDirection": "column",
    "alignItems": "stretch",
  })
}

@react.component
let make = (~children) => {
  <div className={Styles.container}> {children} </div>
}
