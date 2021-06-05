type talk = {
  date: string,
  name: string,
  description: string,
  url: string,
}

module Styles = {
  open Emotion
  let container = css({"display": "flex", "flexDirection": "row"})
  let list = css({"display": "flex", "flexDirection": "column", "alignItems": "stretch"})
  let item = css({"marginLeft": -10, "display": "flex", "flexDirection": "row"})
  let link = css({
    "flexGrow": 1,
    "textDecoration": "none",
    "padding": 10,
    "borderRadius": 10,
    "color": Theme.darkBody,
    ":hover": {
      "backgroundColor": "rgba(0, 0, 0, 0.03)",
    },
    ":active": {
      "backgroundColor": "rgba(0, 0, 0, 0.05)",
    },
    "@media (prefers-color-scheme: dark)": {
      "color": Theme.lightBody,
      ":hover": {
        "backgroundColor": "rgba(255, 255, 255, 0.1)",
      },
      ":active": {
        "backgroundColor": "rgba(255, 255, 255, 0.15)",
      },
    },
  })
  let date = css({"opacity": 0.5, "fontSize": 14})
  let name = css({"fontSize": 24, "paddingBottom": 2, "fontWeight": "bold"})
  let description = css({"fontSize": 16, "paddingBottom": 4})
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
