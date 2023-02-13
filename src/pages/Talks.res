module Styles = {
  open Emotion
  let container = css({
    "padding": "0 10px",
    "margin": "20px auto",
    "width": "100%",
    "flexGrow": 1,
  })
  let link = css({
    "padding": "20px 0",
    "fontSize": 24,
    "color": "inherit",
    "textDecoration": "none",
    "display": "flex",
    "flexDirection": "column",
    "paddingRight": "70px",
  })
  let animationName = keyframes({
    "from": {
      "transform": "scaleX(0)",
    },
  })
  let linkContainer = css({
    "position": "relative",
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
  let videoLink = css({
    "position": "absolute",
    "right": 10,
    "top": "50%",
    "transform": "translateY(-50%)",
    "padding": 10,
    "border": "0.5px dashed",
    "color": "#000",
    "borderRadius": "100%",
    "@media (hover: hover)": {
      "&:hover": {
        "border": "0.5px solid",
        "backgroundColor": " #000",
        "color": "#fff",
      },
    },
  })
  let videoLinkSvg = css({
    "display": "block",
  })
  let date = css({"fontSize": 18, "opacity": 0.5})
  let title = css({
    "fontWeight": "bold",
    "lineHeight": 1.2,
    "margin": 0,
    "fontSize": "1em",
    "position": "relative",
  })
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
  let description = css({
    "color": "rgba(0, 0, 0, .5)",
    "fontSize": "1.2rem",
    "paddingTop": 5,
  })
  let paragraph = css({
    "fontSize": "1.2rem",
    "margin": "0 15px 20px",
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
    let subject = encodeURIComponent("Hello 👋")
    setEmail(_ => `mailto:bloodyowl@icloud.com?subject=${subject}`)
    None
  })

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
            <title> {"Talks - Matthias Le Brun (@bloodyowl)"->React.string} </title>
          </Pages.Head>
          <h2 className={Styles.bigTitle}> {"talks"->React.string} </h2>
          <p className={Styles.paragraph}>
            {"want me talk at your event? "->React.string}
            <br />
            <a href={email} className={Styles.email}> {`→ drop me an email`->React.string} </a>
          </p>
          <div className=Styles.container>
            {list
            ->Array.map(item =>
              <div className=Styles.linkContainer key=item.slug>
                <a
                  className=Styles.link
                  href={switch item.meta->Dict.get("url")->Option.map(JSON.Decode.classify) {
                  | Some(String(value)) => value
                  | _ => "/"
                  }}>
                  {<>
                    {switch item.meta->Dict.get("firstDate")->Option.map(JSON.Decode.classify) {
                    | Some(String(value)) =>
                      <div className=Styles.date> {value->React.string} </div>
                    | _ => React.null
                    }}
                    <h3 className=Styles.title>
                      <span> {item.title->React.string} </span>
                    </h3>
                    {switch item.meta->Dict.get("description")->Option.map(JSON.Decode.classify) {
                    | Some(String(description)) =>
                      <div className=Styles.description> {description->React.string} </div>
                    | _ => React.null
                    }}
                  </>}
                </a>
                {switch item.meta->Dict.get("video")->Option.map(JSON.Decode.classify) {
                | Some(String(videoUrl)) =>
                  <a href={videoUrl} title="Video" className=Styles.videoLink>
                    <svg
                      className=Styles.videoLinkSvg
                      width="24"
                      height="24"
                      fill="none"
                      viewBox="0 0 24 24"
                      xmlns="http://www.w3.org/2000/svg">
                      <path
                        d="M6.25 4h11.5a3.25 3.25 0 0 1 3.245 3.066L21 7.25v9.5a3.25 3.25 0 0 1-3.066 3.245L17.75 20H6.25a3.25 3.25 0 0 1-3.245-3.066L3 16.75v-9.5a3.25 3.25 0 0 1 3.066-3.245L6.25 4h11.5-11.5Zm3.803 5.585A.5.5 0 0 0 10 9.81v4.382a.5.5 0 0 0 .724.447l4.382-2.19a.5.5 0 0 0 0-.895l-4.382-2.191a.5.5 0 0 0-.671.223Z"
                        fill="currentColor"
                      />
                    </svg>
                  </a>
                | _ => React.null
                }}
              </div>
            )
            ->React.array}
          </div>
        </>
      | Done(Error(_)) => <Pages.ErrorIndicator />
      }}
    </WidthContainer>
  </>
}
