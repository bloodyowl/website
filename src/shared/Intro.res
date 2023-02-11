module Styles = {
  open Emotion
  let container = css({
    "display": "flex",
    "flexDirection": "row",
    "alignItems": "flex-start",
    "flexGrow": 1,
    "@media (max-width: 500px)": {
      "flexDirection": "column",
    },
  })
  let bigTitle = css({
    "margin": "20px 0 10px",
    "fontSize": "4rem",
    "fontWeight": "bold",
    "@media (max-width: 450px)": {
      "fontSize": "2rem",
    },
  })
  let imageContainer = css({
    "width": "30%",
    "padding": 10,
    "border": "0.5px dashed",
    "borderRadius": 50,
    "marginTop": 40,
    "@media (max-width: 500px)": {
      "marginTop": 0,
      "marginLeft": 10,
      "borderRadius": 30,
    },
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
    "@media (max-width: 500px)": {
      "marginTop": 0,
      "borderRadius": 20,
    },
  })
  let text = css({
    "padding": 20,
    "fontSize": "1.25rem",
  })
  let firstParagraph = css({
    "marginTop": 0,
  })

  let inlineLink = css({
    "fontWeight": "bold",
    "color": "inherit",
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
    let subject = encodeURIComponent("Hello 👋")
    setEmail(_ => `mailto:bloodyowl@icloud.com?subject=${subject}`)
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
      <h2 className={Styles.bigTitle}> {`hello 👋`->React.string} </h2>
      <p className={Styles.firstParagraph}>
        <strong>
          {`my name is Matthias Le Brun (aka @bloodyowl), I'm a software engineer from Paris, France.`->React.string}
        </strong>
      </p>
      <p className={Styles.firstParagraph}>
        <strong>
          {`I'm currently Front-End Lead Manager (& Chief Shitpost Officer) at `->React.string}
          <a className=Styles.inlineLink href="https://swan.io"> {"Swan"->React.string} </a>
          {`, where we build embedded banking solutions.`->React.string}
        </strong>
      </p>
      <h2> {`get in touch`->React.string} </h2>
      <a className=Styles.link href="https://twitter.com/bloodyowl">
        {`→ twitter`->React.string}
      </a>
      <a className=Styles.link href="https://github.com/bloodyowl">
        {`→ github`->React.string}
      </a>
      <a className=Styles.link href="https://dribbble.com/bloodyowl">
        {`→ dribbble`->React.string}
      </a>
      <a className=Styles.link href="https://www.linkedin.com/in/bloodyowl">
        {`→ linkedin`->React.string}
      </a>
      <a className=Styles.link href={email}> {`→ email`->React.string} </a>
    </div>
  </div>
}
