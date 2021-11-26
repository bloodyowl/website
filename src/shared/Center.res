module Styles = {
  open Emotion
  let container = css({
    "display": "flex",
    "flexDirection": "column",
    "justifyContent": "center",
    "alignItems": "center",
    "flexGrow": 1,
  })
}
@react.component
let make = (~children) => {
  <div className={Styles.container}> {children} </div>
}
