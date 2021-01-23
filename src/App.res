include CssReset

open Belt

module Styles = {
  open Css
  let container = style(list{
    minHeight(100.->vh),
    display(flexBox),
    flexDirection(column),
    alignItems(stretch),
  })
}

@react.component
let make = (~url: ReasonReactRouter.url, ~config: Pages.config, ()) =>
  <div className=Styles.container>
    <Pages.Head>
      <html lang="en" />
      <meta charSet="UTF-8" />
      <style> {`@import url("//hello.myfonts.net/count/3cae5f")`->React.string} </style>
      <meta name="google-site-verification" content="w75-P-0ywXWkyZvYPbkSM3VSM2hny25UrfeiWJt3B1k" />
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
      <meta name="twitter:card" content="summary_large_image" />
      <meta property="og:type" content="website" />
      <meta property="og:image" content={config.baseUrl ++ "/public/assets/images/share.jpg"} />
      <meta name="twitter:image" content={config.baseUrl ++ "/public/assets/images/share.jpg"} />
      <meta name="twitter:site" content="@bloodyowl" />
      <meta property="og:image:width" content="1500" />
      <meta property="og:image:height" content="777" />
      <link rel="shortcut icon" href="/public/assets/images/favicon.png" />
      {
        let url = config.baseUrl ++ ("/" ++ String.concat("/", url.path))
        <link rel="canonical" href={url->Js.String2.endsWith("/") ? url : url ++ "/"} />
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
          Array.concatMany([
            ["/", "blog"],
            getAll("blog")->Array.map(slug => "/blog/" ++ slug),
            ["404.html"],
          ]),
        getRedirectMap: None,
      },
    ],
  },
)
