Emotion.injectGlobal(`
@font-face {
  font-family: HelveticaNowDisplay;
  src: url("/public/assets/webfonts/regular.woff2"),
    url("/public/assets/webfonts/regular.woff");
  font-style: normal;
  font-weight: 400;
  font-display: swap;
}
@font-face {
  font-family: HelveticaNowDisplay;
  src: url("/public/assets/webfonts/bold.woff2"),
    url("/public/assets/webfonts/bold.woff");
  font-style: normal;
  font-weight: 700;
  font-display: swap;
}
body {
  padding: 0;
  margin: 0;
  background-color: #fff;
  font-family: HelveticaNowDisplay, "Helvetica Neue", Helvetica, Arial,
    sans-serif;
  display: flex;
  flex-direction: column;
  min-height: 100vh;
  overflow-x: hidden;
}
@media (prefers-color-scheme: dark) {
  body {
    background-color: #222;
  }
}
#root {
  display: flex;
  flex-direction: column;
  flex-grow: 1;
}
html {
  color: #46515b;
  font-size: 1em;
  line-height: 1.4;
  -webkit-font-smoothing: antialiased;
  -webkit-text-size-adjust: 100%;
}
@media (prefers-color-scheme: dark) {
  html {
    color: #e4ebee;
  }
}
*,
*:before,
*:after {
  box-sizing: border-box;
}
`)

module Styles = {
  open Emotion
  let container = css({
    "minHeight": "100vh",
    "display": "flex",
    "flexDirection": "column",
    "alignItems": "stretch",
  })
}

@val external window: {..} = "window"
@react.component
let make = (~url: RescriptReactRouter.url, ~config: Pages.config, ()) => {
  React.useEffect1(() => {
    let () = window["scrollTo"](. 0, 0)
    None
  }, [url.path->List.toArray->Array.joinWith("/")])

  <div className=Styles.container>
    <Pages.Head>
      <html lang="en" />
      <meta charSet="UTF-8" />
      <style> {`@import url("//hello.myfonts.net/count/3cae5f")`->React.string} </style>
      <meta name="google-site-verification" content="w75-P-0ywXWkyZvYPbkSM3VSM2hny25UrfeiWJt3B1k" />
      <meta
        name="viewport"
        content="width=device-width, initial-scale=1, shrink-to-fit=no, viewport-fit=cover"
      />
      <meta name="twitter:card" content="summary_large_image" />
      <meta property="og:type" content="website" />
      <meta property="og:image" content={config.baseUrl ++ "/public/assets/images/share.jpg"} />
      <meta name="twitter:image" content={config.baseUrl ++ "/public/assets/images/share.jpg"} />
      <meta name="twitter:site" content="@bloodyowl" />
      <meta property="og:image:width" content="1500" />
      <meta property="og:image:height" content="777" />
      <link rel="shortcut icon" href="/public/assets/images/favicon.png" />
      {
        let url = config.baseUrl ++ ("/" ++ url.path->List.toArray->Array.joinWith("/"))
        <link rel="canonical" href={url->String.endsWith("/") ? url : url ++ "/"} />
      }
      <script>
        {`window.beOpAsyncInit = function() {
        BeOpSDK.init({
          account: "556e1d2772a6b60100844051"
        });
        BeOpSDK.watch();
      };`->React.string}
      </script>
      <script async=true src="https://widget.beop.io/sdk.js" />
    </Pages.Head>
    <Header />
    {switch url.path {
    | list{} => <Home />
    | list{"blog"} => <BlogPostList />
    | list{"blog", slug} => <BlogPost slug />
    | _ => <ErrorIndicator />
    }}
    <Footer />
  </div>
}

let default = Pages.make(
  make,
  {
    siteTitle: "Matthias Le Brun",
    siteDescription: "Front-end developer and designer. ReasonML, ReasonReact, ReactJS.",
    mode: SPA,
    distDirectory: "dist",
    baseUrl: "https://bloodyowl.io",
    staticsDirectory: Some("statics"),
    paginateBy: 20,
    variants: [
      {
        subdirectory: None,
        localeFile: None,
        contentDirectory: "contents",
        getUrlsToPrerender: ({getAll}) =>
          Belt.Array.concatMany([
            ["/", "blog"],
            getAll("blog")->Array.map(slug => "/blog/" ++ slug),
            ["404.html"],
          ]),
        getRedirectMap: None,
      },
    ],
  },
)
