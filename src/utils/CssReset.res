let _ = {
  open Css
  global(
    fontFace(
      ~fontFamily="HelveticaNowDisplay",
      ~src=list{
        url("/public/assets/webfonts/regular.woff2"),
        url("/public/assets/webfonts/regular.woff"),
      },
      ~fontStyle=normal,
      ~fontWeight=#num(400),
      ~fontDisplay=#swap,
      (),
    ),
  )
}

let _ = {
  open Css
  global(
    fontFace(
      ~fontFamily="HelveticaNowDisplay",
      ~src=list{
        url("/public/assets/webfonts/bold.woff2"),
        url("/public/assets/webfonts/bold.woff"),
      },
      ~fontStyle=normal,
      ~fontWeight=#num(700),
      ~fontDisplay=#swap,
      (),
    ),
  )
}

let _ = {
  open Css
  global(
    "body",
    list{
      padding(zero),
      margin(zero),
      backgroundColor("fff"->hex),
      media("(prefers-color-scheme: dark)", list{backgroundColor("222"->hex)}),
      fontFamily(#custom(Theme.defaultTextFontFamily)),
      display(flexBox),
      flexDirection(column),
      minHeight(100.->vh),
      overflowX(hidden),
    },
  )
}

let _ = {
  open Css
  global("#root", list{display(flexBox), flexDirection(column), flexGrow(1.0)})
}

let _ = {
  open Css
  global(
    "html",
    list{
      color(Theme.darkBody->hex),
      media("(prefers-color-scheme: dark)", list{color(Theme.lightBody->hex)}),
      fontSize(1.->em),
      lineHeight(#abs(1.4)),
      unsafe("WebkitFontSmoothing", "antialiased"),
      unsafe(
        "WebkitTextSizeAdjust",
        "100%",
      ) /* Prevent adjustments of font size after orientation changes in iOS. */,
    },
  )
}

let _ = {
  open Css
  global("*, *:before, *:after", list{boxSizing(borderBox)})
}
