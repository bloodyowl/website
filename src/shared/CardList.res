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
      "padding": "20px 20px 20px 0",
      "color": "inherit",
    })
    let imageContainer = css({
      "padding": 10,
      "border": "0.5px dashed",
      "borderRadius": 50,
    })
    let image = css({
      "width": 128,
      "height": 128,
      "borderRadius": 40,
      "display": "block",
      "mixBlendMode": "hard-light",
    })
    let text = css({"textAlign": "center", "fontSize": 18, "paddingTop": 10})
  }

  @react.component
  let make = (~card, ()) => {
    let contents =
      <>
        <div className=Styles.imageContainer>
          <img className=Styles.image src=card.image alt="" />
        </div>
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
    "display": "flex",
    "flexDirection": "row",
    "alignItems": "center",
    "justifyContent": "center",
    "flexWrap": "wrap",
  })
}

@react.component
let make = (~cards, ()) =>
  <div className=Styles.root>
    <div className=Styles.container>
      {cards->Array.map(((id, card)) => <Card key=id card />)->React.array}
    </div>
  </div>
