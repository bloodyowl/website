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
  let link = style(list{
    color("135EFF"->hex),
    hover(list{color("13A3FF"->hex)}),
    media("(prefers-color-scheme: dark)", list{color("13A3FF"->hex)}),
  })
  let text = style(list{opacity(0.5)})
}

@react.component
let make = () =>
  <div className=Styles.container>
    <div> {"Copyright 2020 - Matthias Le Brun"->React.string} </div>
    <div>
      <span className=Styles.text> {"Do you like the content? "->React.string} </span>
      <a className=Styles.link href="https://github.com/sponsors/bloodyowl">
        {" Sponsor me on GitHub"->React.string}
      </a>
    </div>
  </div>
