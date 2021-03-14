open Belt

type card = {
  image: string,
  name: string,
  url: option<string>,
}

module Card = {
  module Styles = {
    open Emotion
    let container = css({
      "flexShrink": 0,
      "display": "flex",
      "flexDirection": "column",
      "alignItems": "stretch",
      "textDecoration": "none",
      "color": Theme.darkBody,
      "@media (prefers-color-scheme: dark)": {"color": "#FFF"},
      "padding": "20px 20px 20px 0",
      "scrollSnapAlign": "start",
    })
    let image = css({
      "width": 128,
      "height": 128,
      "borderRadius": 25,
      "transition": "300ms ease-out transform, 300ms ease-out box-shadow",
      "boxShadow": "0 5px 10px rgba(0, 0, 0, 0.1)",
      ":hover": {
        "boxShadow": "0 3px 7px rgba(0, 0, 0, 0.3)",
      },
    })
    let text = css({"textAlign": "center", "fontSize": 18, "paddingTop": 10})
  }

  @react.component
  let make = (~card, ()) => {
    let contents =
      <>
        <img className=Styles.image src=card.image alt="" />
        <div className=Styles.text> {card.name->React.string} </div>
      </>
    switch card.url {
    | Some(href) => <a href className=Styles.container> contents </a>
    | None => <div className=Styles.container> contents </div>
    }
  }
}

module Styles = {
  open Emotion
  let root = css({"display": "block"})
  let container = css({
    "overflowX": "auto",
    "display": "flex",
    "flexDirection": "row",
    "alignItems": "flexStart",
    "justifyContent": "flexStart",
    "WebkitOverflowScrolling": "touch",
    "scrollSnapType": "x mandatory",
  })
}

@react.component
let make = (~cards, ()) =>
  <div className=Styles.root>
    <div className=Styles.container>
      {cards->Array.map(((id, card)) => <Card key=id card />)->React.array}
    </div>
  </div>
