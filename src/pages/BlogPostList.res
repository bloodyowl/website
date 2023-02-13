module Styles = {
  open Emotion
  let container = css({
    "padding": "0 10px",
    "margin": "20px auto",
    "width": "100%",
    "flexGrow": 1,
  })
  let animationName = keyframes({
    "from": {
      "transform": "scaleX(0)",
    },
  })
  let link = css({
    "padding": "10px 0",
    "fontSize": 24,
    "color": "inherit",
    "textDecoration": "none",
    "display": "flex",
    "flexDirection": "column",
    "& h3 span": {
      "position": "relative",
    },
    "@media (hover: hover)": {
      ":hover": {
        "& h3 span::after": {
          "content": `""`,
          "position": "absolute",
          "bottom": 0,
          "left": 0,
          "right": 0,
          "height": 3,
          "backgroundColor": "#000",
          "transformOrigin": "0 0",
          "animation": `200ms ease-in-out ${animationName}`,
        },
      },
    },
  })
  let date = css({"fontSize": 18, "opacity": 0.5})
  let title = css({"fontWeight": "bold", "fontSize": "1em", "margin": 0, "lineHeight": 1.2})
  let pulse = keyframes({"50%": {"opacity": 0.5}})
  let datePlaceholder = css({
    "width": "100%",
    "height": 18,
    "margin": "3px 0",
    "maxWidth": 90,
    "backgroundColor": "rgba(0, 0, 0, 0.05)",
    "animation": `2000ms infinite ${pulse}`,
  })
  let titlePlaceholder = css({
    "width": "100%",
    "height": 24,
    "margin": "3px 0",
    "maxWidth": 440,
    "backgroundColor": "rgba(0, 0, 0, 0.05)",
    "animation": `2000ms infinite ${pulse}`,
  })
  let bigTitle = css({
    "margin": "20px 10px",
    "fontSize": "4rem",
    "fontWeight": "bold",
    "@media (max-width: 450px)": {
      "fontSize": "2rem",
    },
  })
}

@react.component
let make = () => {
  let list = Pages.useCollection("blog")

  <>
    <WidthContainer>
      {switch list {
      | NotAsked
      | Loading =>
        <div className=Styles.container ariaLabel="Loading" role="alert" ariaBusy=true>
          {Belt.Array.range(0, 6)
          ->Array.map(index =>
            <div className=Styles.link key={index->Int.toString}>
              <div className=Styles.datePlaceholder />
              <div className=Styles.titlePlaceholder />
            </div>
          )
          ->React.array}
        </div>
      | Done(Ok({items: list})) =>
        <>
          <Pages.Head>
            <title> {"Blog - Matthias Le Brun (@bloodyowl)"->React.string} </title>
          </Pages.Head>
          <h2 className={Styles.bigTitle}> {"blog"->React.string} </h2>
          <div className=Styles.container>
            {list
            ->Array.map(item =>
              <Pages.Link className=Styles.link key=item.slug href={"/blog/" ++ (item.slug ++ "/")}>
                {<>
                  <div className=Styles.date>
                    {item.date
                    ->Option.map(Date.fromString)
                    ->Option.map(DateUtils.getFormattedString)
                    ->Option.map(React.string)
                    ->Option.getWithDefault(React.null)}
                  </div>
                  <h3 className=Styles.title>
                    <span> {item.title->React.string} </span>
                  </h3>
                </>}
              </Pages.Link>
            )
            ->React.array}
          </div>
        </>
      | Done(Error(_)) => <Pages.ErrorIndicator />
      }}
    </WidthContainer>
  </>
}
