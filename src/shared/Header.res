module Styles = {
  open Emotion
  let container = css({
    "display": "flex",
    "flexDirection": "row",
    "alignItems": "center",
    "flexGrow": 1,
    "minHeight": "20vh",
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
      "marginBottom": 10,
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

  let link = css({
    "fontSize": "1.25rem",
    "fontWeight": "700",
    "padding": "10px 20px",
    "textDecoration": "none",
    "color": "inherit",
    "position": "relative",
    "::before": {
      "content": `"→ "`,
      "@media (max-width: 600px)": {
        "content": "none",
      },
    },
  })
  let animationName = keyframes({
    "from": {
      "transform": "scaleX(0)",
    },
  })
  let activeLink = css({
    "::after": {
      "content": `""`,
      "position": "absolute",
      "bottom": 0,
      "left": 20,
      "right": 15,
      "height": 3,
      "backgroundColor": "#000",
      "transformOrigin": "0 0",
      "animation": `200ms ease-in-out ${animationName}`,
      "@media (max-width: 600px)": {
        "right": 20,
      },
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
    <nav>
      <Pages.Link href="/design" className={Styles.link} activeClassName={Styles.activeLink}>
        {"design"->React.string}
      </Pages.Link>
      <Pages.Link href="/talks" className={Styles.link} activeClassName={Styles.activeLink}>
        {"talks"->React.string}
      </Pages.Link>
      <Pages.Link
        href="/blog"
        matchSubroutes=true
        className={Styles.link}
        activeClassName={Styles.activeLink}>
        {"blog"->React.string}
      </Pages.Link>
    </nav>
  </header>
}
