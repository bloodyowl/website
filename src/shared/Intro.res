module Styles = {
  open Emotion
  let container = css({
    "display": "flex",
    "flexDirection": "row",
    "alignItems": "center",
    "flexGrow": 1,
    "@media (max-width: 500px)": {
      "flexDirection": "column",
    },
  })
  let imageContainer = css({
    "width": "30%",
    "padding": 10,
    "border": "0.5px dashed",
    "borderRadius": 50,
  })
  let imageContents = css({
    "paddingBottom": "100%",
    "position": "relative",
    "overflow": "hidden",
  })
  let image = css({
    "position": "absolute",
    "top": 0,
    "left": 0,
    "width": "100%",
    "height": "100%",
    "objectFit": "contain",
    "objectPosition": "50% 50%",
    "transform": "translateZ(0)",
    "borderRadius": 40,
  })
  let text = css({
    "padding": 20,
    "fontSize": "1.25rem",
  })
  let firstParagraph = css({
    "marginTop": 0,
  })

  let link = css({
    "display": " block",
    "fontWeight": "bold",
    "color": "inherit",
  })
}
@react.component
let make = () => {
  let (email, setEmail) = React.useState(() => "#")

  React.useEffect0(() => {
    setEmail(_ => "mailto:bloodyowl@icloud.com?subject=Hello")
    None
  })

  <div className={Styles.container}>
    <div className={Styles.imageContainer}>
      <div className={Styles.imageContents}>
        <img
          className={Styles.image}
          alt="Matthias Le Brun"
          src="https://avatars.githubusercontent.com/bloodyowl?size=400"
        />
      </div>
    </div>
    <Spacer width="30px" />
    <div className={Styles.text}>
      <p className={Styles.firstParagraph}>
        <strong>
          {`My name is Matthias Le Brun (aka @bloodyowl).`->React.string}
          <br />
          {`I'm currently Lead Front-End Developer at Swan.`->React.string}
        </strong>
      </p>
      <p> <strong> {`Want to get in touch?`->React.string} </strong> </p>
      <a className=Styles.link href="https://twitter.com/bloodyowl">
        {`→ Twitter`->React.string}
      </a>
      <a className=Styles.link href="https://github.com/bloodyowl">
        {`→ GitHub`->React.string}
      </a>
      <a className=Styles.link href="https://dribbble.com/bloodyowl">
        {`→ Dribbble`->React.string}
      </a>
      <a className=Styles.link href="https://www.linkedin.com/in/bloodyowl">
        {`→ LinkedIn`->React.string}
      </a>
      <a className=Styles.link href={email}> {`→ Email`->React.string} </a>
    </div>
  </div>
}
