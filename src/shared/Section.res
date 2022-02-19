module Styles = {
  open Emotion
  let container = css({
    "padding": "10vh 0",
    "position": "relative",
    "display": "flex",
    "flexDirection": "column",
    "alignItems": "stretch",
  })
  let backgroundContainer = css({
    "position": "absolute",
    "top": "0",
    "left": 0,
    "right": 0,
    "bottom": "0",
    "overflow": "hidden",
    "pointerEvents": "none",
    "transform": "translateZ(0)",
  })
  let backgroundRef = css({
    "position": "absolute",
    "top": "0",
    "left": 0,
    "right": 0,
    "bottom": "0",
  })
  let borderTopContainer = css({
    "position": "absolute",
    "top": "-100vh",
    "left": -1,
    "right": 0,
    "height": "100vh",
    "overflow": "hidden",
    "pointerEvents": "none",
    "transform": "translateZ(0)",
  })
  let backgroundOverflow = css({
    "position": "absolute",
    "top": "100%",
    "left": 0,
    "right": 0,
    "height": "100vh",
    "pointerEvents": "none",
    "transform": "translateZ(0)",
  })
  let contents = css({
    "position": "relative",
    "flexGrow": 1,
    "paddingLeft": "var(--body-start-margin)",
    "display": "flex",
    "flexDirection": "column",
    "alignItems": "stretch",
  })
}

@react.component
let make = (~children) => {
  <div className={Styles.container}>
    <div className={Styles.contents}> <WidthContainer> {children} </WidthContainer> </div>
  </div>
}
