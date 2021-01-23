open Belt

module Styles = {
  open Css
  let container = style(list{
    maxWidth(600->px),
    padding2(~v=zero, ~h=10->px),
    margin2(~v=20->px, ~h=auto),
    width(100.->pct),
    flexGrow(1.),
  })
  let title = style(list{
    margin(zero),
    fontSize(48->px),
    marginTop(50->px),
    marginBottom(10->px),
    lineHeight(#abs(1.15)),
  })
  let date = style(list{fontSize(14->px), opacity(0.5), marginBottom(50->px)})
  let body = style(list{
    marginTop(40->px),
    fontSize(18->px),
    selector(
      "a",
      list{
        color("135EFF"->hex),
        hover(list{color("13A3FF"->hex)}),
        media("(prefers-color-scheme: dark)", list{color("13A3FF"->hex)}),
      },
    ),
    selector("img", list{maxWidth(100.0->pct), height(auto)}),
  })
  let share = style(list{
    maxWidth(640->px),
    width(100.->pct),
    display(flexBox),
    flexDirection(row),
    alignItems(center),
    justifyContent(spaceBetween),
    margin2(~h=auto, ~v=20->px),
    padding(20->px),
    backgroundColor("fff"->hex),
    media("(prefers-color-scheme: dark)", list{backgroundColor("222"->hex)}),
    borderRadius(10->px),
    boxShadows(list{
      Shadow.box(~y=15->px, ~blur=15->px, ~spread=-5->px, rgba(0, 0, 0, #num(0.2))),
      Shadow.box(~y=zero, ~blur=zero, ~spread=1->px, rgba(0, 0, 0, #num(0.1))),
    }),
    media("(max-width: 540px)", list{flexDirection(column)}),
  })
  let shareTitle = style(list{fontWeight(extraBold), fontSize(18->px)})
  let shareButton = style(list{
    backgroundColor("00aced"->hex),
    color("fff"->hex),
    padding2(~h=20->px, ~v=10->px),
    textDecoration(none),
    borderRadius(5->px),
    fontWeight(extraBold),
    active(list{opacity(0.5)}),
  })
}

@bs.val external window: {..} = "window"

{
  open Css

  global(
    "pre",
    list{
      padding2(~v=10->px, ~h=20->px),
      backgroundColor("F4F7F8"->hex),
      overflowX(auto),
      unsafe("WebkitOverflowScrolling", "touch"),
      fontSize(16->px),
      borderLeftWidth(2->px),
      borderLeftColor(Theme.darkBody->hex),
      borderLeftStyle(solid),
      media("(prefers-color-scheme: dark)", list{backgroundColor(rgba(255, 255, 255, #num(0.05)))}),
    },
  )
  global(
    "code",
    list{fontFamily(#custom(Theme.codeFontFamily)), fontSize(0.85->em), lineHeight(#abs(1.))},
  )
  global(".hljs-keyword", list{color("DA6BB5"->hex)})
  global(".hljs-constructor", list{color("DD792B"->hex)})
  global(".hljs-identifier", list{color("1E9EA7"->hex)})
  global(".hljs-module-identifier", list{color("C84682"->hex)})
  global(".hljs-string", list{color("3BA1C8"->hex)})
  global(".hljs-comment", list{color("aaa"->hex)})
  global(".hljs-operator", list{color("DA6BB5"->hex)})
  global(".hljs-attribute", list{color("4CB877"->hex)})
  global("table", list{width(100.->pct), textAlign(center)})
  global(
    "table thead th",
    list{backgroundColor(Theme.lightBody->hex), padding2(~v=10->px, ~h=zero)},
  )
  global(
    "blockquote",
    list{
      opacity(0.6),
      borderLeft(4->px, solid, Theme.darkBody->hex),
      margin(zero),
      padding2(~h=20->px, ~v=zero),
    },
  )
}

@react.component
let make = (~slug, ()) => {
  let post = Pages.useItem("blog", ~id=slug)
  <>
    {switch post {
    | NotAsked
    | Loading =>
      <ActivityIndicator />
    | Done(Ok(post)) => <>
        <Pages.Head> <title> {post.title->React.string} </title> </Pages.Head>
        <div className=Styles.container>
          <h1 className=Styles.title> {post.title->ReasonReact.string} </h1>
          <div className=Styles.date>
            {post.date
            ->Option.map(Js.Date.fromString)
            ->Option.map(Date.getFormattedString)
            ->Option.map(ReasonReact.string)
            ->Option.getWithDefault(React.null)}
          </div>
          <div role="article" className=Styles.body dangerouslySetInnerHTML={"__html": post.body} />
          <div className=Styles.share>
            <div className=Styles.shareTitle> {j`Liked this article?`->ReasonReact.string} </div>
            <Spacer height=10 width=0 />
            <a
              className=Styles.shareButton
              onClick={event => {
                event->ReactEvent.Mouse.preventDefault
                window["open"](
                  (event->ReactEvent.Mouse.target)["href"],
                  "",
                  "width=500,height=400",
                )->ignore
              }}
              target="_blank"
              href={"https://www.twitter.com/intent/tweet?text=" ++
              Js.Global.encodeURIComponent(
                post.title ++ (" from @bloodyowl https://bloodyowl.io/blog/" ++ post.slug),
              )}>
              {`→ Share it on Twitter`->ReasonReact.string}
            </a>
          </div>
          <BeOpWidget />
        </div>
      </>
    | Done(Error(_)) => <ErrorIndicator />
    }}
  </>
}
