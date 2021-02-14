open Belt

module Styles = {
  open Css
  let container = style(list{
    maxWidth(640->px),
    padding2(~v=zero, ~h=10->px),
    margin2(~v=20->px, ~h=auto),
    width(100.->pct),
    flexGrow(1.),
  })
  let link = style(list{
    padding(10->px),
    fontSize(24->px),
    color(Theme.darkBody->hex),
    textDecoration(none),
    display(flexBox),
    flexDirection(column),
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
  let date = style(list{fontSize(18->px), opacity(0.5)})
  let title = style(list{fontWeight(bold)})
}

@react.component
let make = () => {
  let list = Pages.useCollection("blog")
  <>
    {switch list {
    | NotAsked
    | Loading =>
      <ActivityIndicator />
    | Done(Ok({items: list})) => <>
        <Pages.Head> <title> {"Blog"->React.string} </title> </Pages.Head>
        <div className=Styles.container>
          {list
          ->Array.map(item =>
            <Pages.Link className=Styles.link key=item.slug href={"/blog/" ++ (item.slug ++ "/")}>
              {<>
                <div className=Styles.date>
                  {item.date
                  ->Option.map(Js.Date.fromString)
                  ->Option.map(Date.getFormattedString)
                  ->Option.map(React.string)
                  ->Option.getWithDefault(React.null)}
                </div>
                <div className=Styles.title> {item.title->React.string} </div>
              </>}
            </Pages.Link>
          )
          ->React.array}
        </div>
      </>
    | Done(Error(_)) => <ErrorIndicator />
    }}
  </>
}
