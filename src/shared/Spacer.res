@react.component
let make = (~width="10px", ~height="10px", ()) =>
  <div
    className={
      open Emotion
      css({"width": width, "height": height, "flexShrink": 0})
    }
  />
