module Styles = {
  open Emotion
  let container = css({
    "backgroundColor": Theme.lightBody,
    "@media (prefers-color-scheme: dark)": {
      "backgroundColor": "#111",
    },
    "display": "flex",
    "flexDirection": "row",
    "alignItems": "stretch",
    "flexWrap": "wrap",
    "padding": "0 env(safe-area-inset-right) 0 env(safe-area-inset-left)",
    "@media (max-width: 620px)": {
      "flexDirection": "column",
    },
  })
  let left = css({
    "display": "flex",
    "flexDirection": "row",
    "alignItems": "stretch",
    "flexWrap": "wrap",
    "flexGrow": 1,
    "color": Theme.darkBody,
    "@media (prefers-color-scheme: dark)": {
      "color": Theme.lightBody,
    },
    "textDecoration": "none",
  })
  let heading = css({
    "padding": "20px 20px 23px 0",
    "display": "flex",
    "flexDirection": "row",
    "alignItems": "center",
    "flexGrow": 1,
  })
  let name = css({"fontWeight": "bold", "marginRight": 10, "whiteSpace": "nowrap"})
  let logo = css({"marginRight": 10, "marginLeft": 20, "alignSelf": "center"})
  let navigation = css({
    "display": "flex",
    "flexDirection": "row",
    "alignItems": "center",
    "@media (max-width: 620px)": {"flexGrow": 1, "backgroundColor": "#D4E1E6"},
    "@media (max-width: 620px) and (prefers-color-scheme: dark)": {"backgroundColor": "#111"},
  })
  let link = css({
    "padding": "20px 20px 23px",
    "flexShrink": 0,
    "textDecoration": "none",
    "color": Theme.darkBody,
    "@media (prefers-color-scheme: dark)": {"color": Theme.lightBody},
    "textAlign": "center",
    "@media (max-width: 620px)": {
      "flexBasis": "25%",
      "padding": "10px 10px 13px",
    },
  })
  let activeLink = css({"fontWeight": "bold"})
}

@react.component
let make = () =>
  <div className=Styles.container>
    <Pages.Link className=Styles.left href="/">
      {<>
        <img
          src="/public/assets/images/owl.svg" width="32" height="32" alt="" className=Styles.logo
        />
        <div className=Styles.heading role="heading" ariaLevel=1>
          <div className=Styles.name> {"Matthias Le Brun"->React.string} </div>
          <div> {"@bloodyowl"->React.string} </div>
        </div>
      </>}
    </Pages.Link>
    <div className=Styles.navigation>
      <Pages.Link
        className=Styles.link activeClassName=Styles.activeLink matchSubroutes=true href="/blog/">
        {"Blog"->React.string}
      </Pages.Link>
      <a className=Styles.link href="https://twitter.com/bloodyowl"> {"Twitter"->React.string} </a>
      <a className=Styles.link href="https://github.com/bloodyowl"> {"GitHub"->React.string} </a>
      <a className=Styles.link href="https://www.linkedin.com/in/bloodyowl">
        {"LinkedIn"->React.string}
      </a>
    </div>
  </div>
