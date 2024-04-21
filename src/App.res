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

@media (prefers-reduced-motion: reduce) {
  *,
  *::before,
  *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
    scroll-behavior: auto !important;
  }
}

body {
   font-family: HelveticaNowDisplay, "Helvetica Neue", Helvetica, Arial,
    sans-serif;
    margin: 0; padding: 0;
    }
*, *::before, *::after { box-sizing: border-box; }
a:active, button:active {opacity: 0.5}
`)

Emotion.injectGlobal(`pre, .hljs {
  color: #adbac7;
  background: #22272e;
}

.hljs-doctag,
.hljs-keyword,
.hljs-meta .hljs-keyword,
.hljs-template-tag,
.hljs-template-variable,
.hljs-type,
.hljs-variable.language_ {
  /* prettylights-syntax-keyword */
  color: #f47067;
}

.hljs-title,
.hljs-title.class_,
.hljs-title.class_.inherited__,
.hljs-title.function_ {
  /* prettylights-syntax-entity */
  color: #dcbdfb;
}

.hljs-attr,
.hljs-attribute,
.hljs-literal,
.hljs-meta,
.hljs-number,
.hljs-operator,
.hljs-variable,
.hljs-selector-attr,
.hljs-selector-class,
.hljs-selector-id {
  /* prettylights-syntax-constant */
  color: #6cb6ff;
}

.hljs-regexp,
.hljs-string,
.hljs-meta .hljs-string {
  /* prettylights-syntax-string */
  color: #96d0ff;
}

.hljs-built_in,
.hljs-symbol {
  /* prettylights-syntax-variable */
  color: #f69d50;
}

.hljs-comment,
.hljs-code,
.hljs-formula {
  /* prettylights-syntax-comment */
  color: #768390;
}

.hljs-name,
.hljs-quote,
.hljs-selector-tag,
.hljs-selector-pseudo {
  /* prettylights-syntax-entity-tag */
  color: #8ddb8c;
}

.hljs-subst {
  /* prettylights-syntax-storage-modifier-import */
  color: #adbac7;
}

.hljs-section {
  /* prettylights-syntax-markup-heading */
  color: #316dca;
  font-weight: bold;
}

.hljs-bullet {
  /* prettylights-syntax-markup-list */
  color: #eac55f;
}

.hljs-emphasis {
  /* prettylights-syntax-markup-italic */
  color: #adbac7;
  font-style: italic;
}

.hljs-strong {
  /* prettylights-syntax-markup-bold */
  color: #adbac7;
  font-weight: bold;
}

.hljs-addition {
  /* prettylights-syntax-markup-inserted */
  color: #b4f1b4;
  background-color: #1b4721;
}

.hljs-deletion {
  /* prettylights-syntax-markup-deleted */
  color: #ffd8d3;
  background-color: #78191b;
}

.hljs-char.escape_,
.hljs-link,
.hljs-params,
.hljs-property,
.hljs-punctuation,
.hljs-tag {
  /* purposely ignored */
}`)

module Styles = {
  open Emotion
  let animation = keyframes({
    "from": {
      "opacity": 0,
      "transform": "translateY(20px)",
    },
  })
  let route = css({
    "animation": `300ms ease-in-out ${animation}`,
  })
}

type props = Pages.App.appProps

let make = ({url, config}: props) => {
  React.useEffect1(() => {
    let () = globalThis["scrollTo"](. 0, 0)
    None
  }, [url.path->List.toArray->Array.join("/")])

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
          let url = config.baseUrl ++ ("/" ++ url.path->List.toArray->Array.join("/"))
          <link rel="canonical" href={url->String.endsWith("/") ? url : url ++ "/"} />
        }
      </Pages.Head>
      <WidthContainer>
        <Header />
      </WidthContainer>
      <div className={Styles.route} key={url.path->List.toArray->Array.join("/")}>
        {switch url.path {
        | list{} => <Home />
        | list{"design"} => <Design />
        | list{"talks"} => <Talks />
        | list{"blog"} => <BlogPostList />
        | list{"blog", slug} => <BlogPost slug />
        | _ => React.null
        }}
      </div>
      <WidthContainer>
        <Footer />
      </WidthContainer>
    </div>
  </>
}

let default = Pages.make(
  make,
  {
    siteTitle: "Matthias Le Brun (@bloodyowl) - Software Engineer in Paris",
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
