module Styles = {
  open Emotion
  let container = css({
    "padding": "0 10px",
    "margin": "20px auto",
    "width": "100%",
    "flexGrow": 1,
  })
  let link = css({
    "padding": 10,
    "fontSize": 24,
    "color": "inherit",
    "textDecoration": "none",
    "display": "flex",
    "flexDirection": "column",
    ":hover": {"backgroundColor": "rgba(0, 0, 0, 0.03)"},
    ":active": {"backgroundColor": "rgba(0, 0, 0, 0.05)"},
  })
  let date = css({"fontSize": 18, "opacity": 0.5})
  let title = css({"fontWeight": "bold"})
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
    "margin": "20px 10px 0",
    "fontSize": "4rem",
    "fontWeight": "bold",
    "@media (max-width: 450px)": {
      "fontSize": "2rem",
    },
  })
  let paragraph = css({
    "fontSize": "1.2rem",
		"margin": "0 20px 20px",
    "@media (max-width: 450px)": {
      "fontSize": "1rem",
    },
  })
  let email = css({
    "color": "inherit",
    "fontWeight": "700",
  })
}

@react.component
let make = () => {
  let list = Pages.useCollection("talks")
  let (email, setEmail) = React.useState(() => "#")

  React.useEffect0(() => {
    setEmail(_ => "mailto:bloodyowl@icloud.com?subject=Talk%20invitation")
    None
  })

  <>
    <WidthContainer>
      <Header />
      {switch list {
      | NotAsked
      | Loading =>
        <div className=Styles.container ariaLabel="Loading" role="alert" ariaBusy=true>
          {Belt.Array.range(0, 6)
          ->Array.map(index =>
            <div className=Styles.link key={index->Int.toString}>
              <div className=Styles.datePlaceholder /> <div className=Styles.titlePlaceholder />
            </div>
          )
          ->React.array}
        </div>
      | Done(Ok({items: list})) => <>
          <Pages.Head> <title> {"Talks"->React.string} </title> </Pages.Head>
          <h2 className={Styles.bigTitle}> {"Talks"->React.string} </h2>
          <p className={Styles.paragraph}>
            {"Want me talk at your event? "->React.string}
            <a href={email} className={Styles.email}> {`Contact me →`->React.string} </a>
          </p>
          <div className=Styles.container>
            {list
            ->Array.map(item =>
              <a
                className=Styles.link
                key=item.slug
                href={switch item.meta->Dict.get("url")->Option.map(JSON.Decode.classify) {
                | Some(String(value)) => value
                | _ => "/"
                }}>
                {<>
                  {switch item.meta->Dict.get("firstDate")->Option.map(JSON.Decode.classify) {
                  | Some(String(value)) => <div className=Styles.date> {value->React.string} </div>
                  | _ => React.null
                  }}
                  <div className=Styles.title> {item.title->React.string} </div>
                </>}
              </a>
            )
            ->React.array}
          </div>
        </>
      | Done(Error(_)) => <Pages.ErrorIndicator />
      }}
    </WidthContainer>
  </>
}
