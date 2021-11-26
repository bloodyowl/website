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
   font-family: HelveticaNowDisplay, "Helvetica Neue", Helvetica, Arial,
    sans-serif;
    margin: 0; padding: 0;
    background-color: #65E197;}
*, *::before, *::after { box-sizing: border-box; }
:root {--scroll-progress: 0;}
a:active, button:active {opacity: 0.5}
`)

Emotion.injectGlobal(`pre, .hljs {
  color: #abb2bf;
  background: #282c34;
}

.hljs-comment,
.hljs-quote {
  color: #5c6370;
  font-style: italic;
}

.hljs-doctag,
.hljs-keyword,
.hljs-formula {
  color: #c678dd;
}

.hljs-section,
.hljs-name,
.hljs-selector-tag,
.hljs-deletion,
.hljs-subst {
  color: #e06c75;
}

.hljs-literal {
  color: #56b6c2;
}

.hljs-string,
.hljs-regexp,
.hljs-addition,
.hljs-attribute,
.hljs-meta .hljs-string {
  color: #98c379;
}

.hljs-attr,
.hljs-variable,
.hljs-template-variable,
.hljs-type,
.hljs-selector-class,
.hljs-selector-attr,
.hljs-selector-pseudo,
.hljs-number {
  color: #d19a66;
}

.hljs-symbol,
.hljs-bullet,
.hljs-link,
.hljs-meta,
.hljs-selector-id,
.hljs-title {
  color: #61aeee;
}

.hljs-built_in,
.hljs-title.class_,
.hljs-class .hljs-title {
  color: #e6c07b;
}

.hljs-emphasis {
  font-style: italic;
}

.hljs-strong {
  font-weight: bold;
}

.hljs-link {
  text-decoration: underline;
}`)

@react.component
let make = (~url: RescriptReactRouter.url, ~config: Pages.config, ()) => {
  React.useEffect1(() => {
    let () = window["scrollTo"](. 0, 0)
    None
  }, [url.path->List.toArray->Array.joinWith("/")])

  React.useEffect0(() => {
    if (
      window["navigator"]["platform"]->String.includes("iPhone") ||
        window["navigator"]["platform"]->String.includes("iPod")
    ) {
      Emotion.injectGlobal(`body {overflow: hidden;} #root {height: 100vh;overflow: auto;padding-bottom: 200px;}`)
    }
    None
  })

  <>
    <div>
      <Pages.Head>
        <html lang="en" />
        <meta charSet="UTF-8" />
        <style> {`@import url("//hello.myfonts.net/count/3cae5f")`->React.string} </style>
        <meta
          name="google-site-verification" content="w75-P-0ywXWkyZvYPbkSM3VSM2hny25UrfeiWJt3B1k"
        />
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
      </Pages.Head>
      {switch url.path {
      | list{} => <Home />
      | list{"design"} => <Design />
      | list{"talks"} => <Talks />
      | list{"blog"} => <BlogPostList />
      | list{"blog", slug} => <BlogPost slug />
      | _ => React.null
      }}
      <div
        style={ReactDOM.Style.make(
          ~position="fixed",
          ~top="0",
          ~left="0",
          ~right="0",
          ~bottom="0",
          ~backgroundImage=`linear-gradient(to left bottom, rgba(0, 0, 0, 0) 0%, rgba(0, 0, 0, 0) 49.9%,rgba(0, 0, 0, 0.1) 50%,rgba(0, 0, 0, 0) 50.1%, rgba(0, 0, 0, 0) 100%)`,
          ~pointerEvents="none",
          (),
        )}
      />
    </div>
  </>
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
            ["/", "blog", "design", "talks"],
            getAll("blog")->Array.map(slug => "/blog/" ++ slug),
            ["404.html"],
          ]),
        getRedirectMap: None,
      },
    ],
  },
)
