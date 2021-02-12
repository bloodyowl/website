open Belt

type talk = {
  date: string,
  name: string,
  description: string,
  url: string,
}

module Styles = {
  open Css
  let container = style(list{display(flexBox), flexDirection(row)})
  let list = style(list{display(flexBox), flexDirection(column), alignItems(stretch)})
  let item = style(list{marginLeft(-10->px), display(flexBox), flexDirection(row)})
  let link = style(list{
    flexGrow(1.0),
    textDecoration(none),
    color(Theme.darkBody->hex),
    padding(10->px),
    borderRadius(10->px),
    hover(list{backgroundColor(rgba(0, 0, 0, #num(0.03)))}),
    active(list{backgroundColor(rgba(0, 0, 0, #num(0.05)))}),
    media(
      "(prefers-color-scheme: dark)",
      list{
        color(Theme.lightBody->hex),
        hover(list{backgroundColor(rgba(255, 255, 255, #num(0.1)))}),
        active(list{backgroundColor(rgba(255, 255, 255, #num(0.15)))}),
      },
    ),
  })
  let date = style(list{opacity(0.5), fontSize(14->px)})
  let name = style(list{fontSize(20->px), paddingBottom(5->px), fontWeight(bold)})
  let description = style(list{fontSize(14->px)})
}

@react.component
let make = (~talks, ()) =>
  <div className=Styles.container>
    <div role="list" className=Styles.list>
      {talks
      ->Array.map(((id, talk)) =>
        <div key=id className=Styles.item role="listitem">
          <a href=talk.url className=Styles.link>
            <div className=Styles.date> {talk.date->React.string} </div>
            <div className=Styles.name> {talk.name->React.string} </div>
            <div className=Styles.description> {talk.description->React.string} </div>
          </a>
        </div>
      )
      ->React.array}
    </div>
  </div>
