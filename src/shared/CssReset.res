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
#root {
  display: flex;
  flex-direction: column;
  flex-grow: 1;
}
html {
  color: #111;
  font-size: 1em;
  line-height: 1.4;
  -webkit-font-smoothing: antialiased;
  -webkit-text-size-adjust: 100%;
}
*,
*:before,
*:after {
  box-sizing: border-box;
}
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
