open Belt

module Styles = {
  open Emotion
  let container = css({
    "maxWidth": 640,
    "margin": "20px auto",
    "padding": "0 10px",
    "width": "100%",
    "flexGrow": 1,
  })
  let title = css({
    "margin": 0,
    "fontSize": 48,
    "marginTop": 50,
    "marginBottom": 10,
    "lineHeight": 1.15,
  })
  let pulse = keyframes({
    "50%": {"opacity": 0.5},
  })
  let titlePlaceholder = css({
    "width": "100%",
    "height": 48,
    "marginTop": 50,
    "marginBottom": 10,
    "maxWidth": 440,
    "backgroundColor": "rgba(0, 0, 0, 0.05)",
    "animation": `2000ms infinite ${pulse}`,
    "@media (prefers-color-scheme: dark)": {
      "backgroundColor": "rgba(255, 255, 255, 0.05)",
    },
  })
  let datePlaceholder = css({
    "width": "100%",
    "height": 18,
    "marginBottom": 50,
    "maxWidth": 90,
    "backgroundColor": "rgba(0, 0, 0, 0.05)",
    "animation": `2000ms infinite ${pulse}`,
    "@media (prefers-color-scheme: dark)": {
      "backgroundColor": "rgba(255, 255, 255, 0.05)",
    },
  })
  let bodyPlaceholder = css({
    "marginTop": 40,
    "width": "100%",
    "height": 200,
    "margin": "3px 0",
    "backgroundColor": "rgba(0, 0, 0, 0.05)",
    "animation": `2000ms infinite ${pulse}`,
    "@media (prefers-color-scheme: dark)": {
      "backgroundColor": "rgba(255, 255, 255, 0.05)",
    },
  })
  let date = css({
    "fontSize": 14,
    "opacity": 0.5,
    "marginBottom": 50,
  })
  let body = css({
    "marginTop": 40,
    "fontSize": 20,
    "lineHeight": 1.5,
    "a": {
      "color": "#135EFF",
      ":hover": {"color": "#13A3FF"},
      "@media (prefers-color-scheme: dark)": {"color": "#13A3FF"},
    },
    "img": {
      "maxWidth": "100%",
      "height": "auto",
      "opacity": 0.0,
      "transition": "300ms ease-out opacity",
    },
    "pre": {
      "padding": "10px 20px",
      "backgroundColor": "#F4F7F8",
      "overflowX": "auto",
      "WebkitOverflowScrolling": "touch",
      "fontSize": 16,
      "borderLeft": `2px solid ${Theme.darkBody}`,
      "borderLeftWidth": 2,
      "@media (prefers-color-scheme: dark)": {
        "backgroundColor": "rgba(0, 0, 0, 0.9)",
      },
    },
    "code": {
      "fontFamily": Theme.codeFontFamily,
      "fontSize": "0.85em",
      "lineHeight": 1.0,
    },
    ".hljs-keyword": {"color": "#DA6BB5"},
    ".hljs-constructor": {"color": "#DD792B"},
    ".hljs-identifier": {"color": "#1E9EA7"},
    ".hljs-module-identifier": {"color": "#C84682"},
    ".hljs-string": {"color": "#3BA1C8"},
    ".hljs-comment": {"color": "#aaa"},
    ".hljs-operator": {"color": "#DA6BB5"},
    ".hljs-attribute": {"color": "#4CB877"},
    "table": {"width": "100%", "textAlign": "center"},
    "table thead th": {
      "backgroundColor": Theme.lightBody,
      "padding": "10px 0",
      "@media (prefers-color-scheme: dark)": {
        "backgroundColor": "#111",
      },
    },
    "blockquote": {
      "opacity": 0.6,
      "borderLeft": `4px solid ${Theme.darkBody}`,
      "margin": 0,
      "padding": "20px 0",
    },
    "hr": {
      "borderColor": "rgba(0, 0, 0, 0.1)",
      "@media (prefers-color-scheme: dark)": {
        "borderColor": "rgba(255, 255, 255, 0.1)",
      },
    },
  })
  let share = css({
    "maxWidth": 640,
    "width": "100%",
    "display": "flex",
    "flexDirection": "column",
    "alignItems": "center",
    "justifyContent": "spaceBetween",
    "margin": "20px 0",
    "padding": 20,
    "backgroundColor": "#FFF",
    "@media (prefers-color-scheme: dark)": {
      "backgroundColor": "#111",
    },
    "borderRadius": 10,
    "boxShadow": "0 15px 15px 5px rgba(0, 0, 0, 0.2), 0 0 0 1px rgba(0, 0, 0, 0.1)",
    "@media (max-width: 540px)": {
      "flexDirection": "column",
    },
  })
  let shareTitle = css({"fontWeight": 900, "fontSize": 18})
  let shareButtons = css({
    "display": "flex",
    "flexDirection": "row",
    "alignItems": "center",
    "justifyContent": "center",
    "@media (max-width: 540px)": {
      "flexDirection": "column",
    },
  })
  let shareButton = css({
    "backgroundColor": "#00aced",
    "color": "#fff",
    "padding": "10px 20px",
    "textDecoration": "none",
    "borderRadius": 5,
    "fontWeight": 900,
    ":active": {"opacity": 0.5},
  })
  let sponsorButton = css({
    "backgroundColor": "#ea4aaa",
    "color": "#fff",
    "padding": "10px 20px",
    "textDecoration": "none",
    "borderRadius": 5,
    "fontWeight": 900,
    ":active": {"opacity": 0.5},
  })
}

@val external window: {..} = "window"

@react.component
let make = (~slug, ()) => {
  let post = Pages.useItem("blog", ~id=slug)
  <SafeArea>
    {switch post {
    | NotAsked
    | Loading =>
      <div className=Styles.container ariaLabel="Loading" role="alert" ariaBusy=true>
        <div className=Styles.titlePlaceholder />
        <div className=Styles.datePlaceholder />
        <div className=Styles.bodyPlaceholder />
      </div>
    | Done(Ok(post)) => <>
        <Pages.Head> <title> {post.title->React.string} </title> </Pages.Head>
        <div className=Styles.container>
          <h1 className=Styles.title> {post.title->React.string} </h1>
          <div className=Styles.date>
            {post.date
            ->Option.map(Js.Date.fromString)
            ->Option.map(Date.getFormattedString)
            ->Option.map(React.string)
            ->Option.getWithDefault(React.null)}
          </div>
          <div role="article" className=Styles.body dangerouslySetInnerHTML={"__html": post.body} />
          <div className=Styles.share>
            <div className=Styles.shareTitle> {j`Liked this article?`->React.string} </div>
            <Spacer height=10 width=0 />
            <div className=Styles.shareButtons>
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
                {`→ Share it on Twitter`->React.string}
              </a>
              <Spacer height=10 width=10 />
              <a
                className=Styles.sponsorButton
                rel="noopener"
                target="_blank"
                href={"https://github.com/sponsors/bloodyowl"}>
                {`→ Sponsor me on GitHub`->React.string}
              </a>
            </div>
          </div>
          <BeOpWidget />
        </div>
      </>
    | Done(Error(_)) => <ErrorIndicator />
    }}
  </SafeArea>
}
