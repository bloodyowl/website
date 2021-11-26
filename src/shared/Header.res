module Styles = {
  open Emotion
  let container = css({
    "display": "flex",
    "flexDirection": "row",
    "alignItems": "center",
    "flexGrow": 1,
    "minHeight": "70vh",
    "justifyContent": "space-between",
    "padding": "20px 0",
    "@media (max-width: 600px)": {
      "flexDirection": "column",
      "justifyContent": "center",
    },
  })
  let branding = css({
    "display": "flex",
    "flexDirection": "row",
    "alignItems": "center",
    "flexGrow": 1,
    "textDecoration": "none",
    "color": "inherit",
    "@media (max-width: 600px)": {
      "flexGrow": 0,
      "flexDirection": "column",
      "textAlign": "center",
    },
  })
  let logoContainer = css({
    "width": "10%",
    "minWidth": 80,
  })
  let logoContents = css({
    "paddingBottom": "100%",
    "position": "relative",
  })
  let logo = css({
    "position": "absolute",
    "top": 0,
    "left": 0,
    "width": "100%",
    "height": "100%",
    "objectFit": "contain",
    "objectPosition": "50% 50%",
  })
  let title = css({
    "margin": 0,
    "display": "flex",
    "flexDirection": "column",
    "fontWeight": "normal",
    "fontSize": "1.25rem",
    "lineHeight": 1.2,
  })
  let nav = css({
    "@media (max-width: 600px)": {
      "display": "flex",
      "flexDirection": "column",
      "alignItems": "center",
    },
  })
  let link = css({
    "fontSize": "1.25rem",
    "fontWeight": "700",
    "padding": "10px 20px",
    "textDecoration": "none",
    "color": "inherit",
    "::before": {
      "content": `"→ "`,
    },
  })
}

@react.component
let make = () => {
  <header className=Styles.container>
    <Pages.Link href="/" className={Styles.branding}>
      <div className={Styles.logoContainer}>
        <div className={Styles.logoContents}>
          <img src={"/public/assets/images/logo.svg"} alt="" className={Styles.logo} />
        </div>
      </div>
      <Spacer height="10px" width="0" />
      <h1 className={Styles.title}>
        <span> {"Matthias Le Brun"->React.string} </span>
        <strong> {"@bloodyowl"->React.string} </strong>
      </h1>
    </Pages.Link>
    <Spacer height="20px" width="0" />
    <nav className={Styles.nav}>
      <Pages.Link href="/design" className={Styles.link}> {"Design"->React.string} </Pages.Link>
      <Pages.Link href="/talks" className={Styles.link}> {"Talks"->React.string} </Pages.Link>
      <Pages.Link href="/blog" className={Styles.link}> {"Blog"->React.string} </Pages.Link>
    </nav>
  </header>
}
