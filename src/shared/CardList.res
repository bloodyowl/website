open Belt

type card = {
  image: string,
  name: string,
  url: option<string>,
}

module Card = {
  module Styles = {
    open Css
    let container = style(list{
      flexShrink(0.0),
      display(flexBox),
      flexDirection(column),
      alignItems(stretch),
      textDecoration(none),
      color(Theme.darkBody->hex),
      media("(prefers-color-scheme: dark)", list{color("fff"->hex)}),
      padding4(~left=zero, ~right=20->px, ~top=20->px, ~bottom=20->px),
      unsafe("scrollSnapAlign", "start"),
    })
    let image = style(list{
      width(128->px),
      height(128->px),
      borderRadius(25->px),
      transitionDuration(300),
      transitionTimingFunction(#easeOut),
      boxShadow(Shadow.box(~y=5->px, ~blur=10->px, rgba(0, 0, 0, #num(0.1)))),
      transitionProperty("transform, box-shadow"),
      hover(list{
        transforms(list{scale(0.96, 0.96)}),
        boxShadow(Shadow.box(~y=3->px, ~blur=7->px, rgba(0, 0, 0, #num(0.3)))),
      }),
    })
    let text = style(list{textAlign(center), fontSize(18->px), paddingTop(10->px)})
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
  open Css
  let root = style(list{display(block)})
  let container = style(list{
    overflowX(auto),
    display(flexBox),
    flexDirection(row),
    alignItems(flexStart),
    justifyContent(flexStart),
    unsafe("WebkitOverflowScrolling", "touch"),
    unsafe("scrollSnapType", "x mandatory"),
  })
}

@react.component
let make = (~cards, ()) =>
  <div className=Styles.root>
    <div className=Styles.container>
      {cards->Array.map(((id, card)) => <Card key=id card />)->React.array}
    </div>
  </div>
