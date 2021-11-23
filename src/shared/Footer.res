module Styles = {
  open Emotion
  let container = css({
    "backgroundColor": Theme.darkBody,
    "color": "#fff",
    "textAlign": "center",
    "padding": 20,
    "fontSize": 14,
  })
  let link = css({
    "color": "#EC8AC5",
    ":hover": {"color": "#F9BDE1"},
  })
  let text = css({"opacity": 0.5})
}

@react.component
let make = () =>
  <div className=Styles.container>
    <div> {"Copyright 2021 - Matthias Le Brun"->React.string} </div>
    <div>
      <span className=Styles.text> {"Do you like the content? "->React.string} </span>
      <a className=Styles.link href="https://github.com/sponsors/bloodyowl">
        {" Sponsor me on GitHub"->React.string}
      </a>
    </div>
  </div>
