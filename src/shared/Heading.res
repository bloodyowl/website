module Styles = {
  open Emotion
  let title = css({
    "margin": "20px 0",
    "fontSize": "2.625rem",
    "fontWeight": "bold",
    "textAlign": "center",
    "@media (max-width: 450px)": {
      "fontSize": "2rem",
    },
  })
}

@react.component
let make = (~text, ~level=2, ()) =>
  <div className=Styles.title role="heading" ariaLevel=level> {text->React.string} </div>
