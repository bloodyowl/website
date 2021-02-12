module Styles = {
  open Css
  let container = style(list{
    backgroundColor(Theme.darkBody->hex),
    media("(prefers-color-scheme: dark)", list{backgroundColor("000"->hex)}),
    color("fff"->hex),
    textAlign(center),
    padding(20->px),
    fontSize(14->px),
  })
}

@react.component
let make = () =>
  <div className=Styles.container> {"Copyright 2020 - Matthias Le Brun"->React.string} </div>
