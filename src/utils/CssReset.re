Css.(
  global(
    fontFace(
      ~fontFamily="HelveticaNowDisplay",
      ~src=[
        url("/public/assets/webfonts/regular.woff2"),
        url("/public/assets/webfonts/regular.woff"),
      ],
      ~fontStyle=normal,
      ~fontWeight=`num(400),
      ~fontDisplay=`swap,
      (),
    ),
  )
);

Css.(
  global(
    fontFace(
      ~fontFamily="HelveticaNowDisplay",
      ~src=[
        url("/public/assets/webfonts/bold.woff2"),
        url("/public/assets/webfonts/bold.woff"),
      ],
      ~fontStyle=normal,
      ~fontWeight=`num(700),
      ~fontDisplay=`swap,
      (),
    ),
  )
);

Css.(
  global(
    "body",
    [
      padding(zero),
      margin(zero),
      backgroundColor("fff"->hex),
      media(
        "(prefers-color-scheme: dark)",
        [backgroundColor("040404"->hex)],
      ),
      fontFamily(`custom(Theme.defaultTextFontFamily)),
      display(flexBox),
      flexDirection(column),
      minHeight(100.->vh),
      overflowX(hidden),
    ],
  )
);

Css.(
  global(
    "#root",
    [display(flexBox), flexDirection(column), flexGrow(1.0)],
  )
);

Css.(
  global(
    "html",
    [
      color(Theme.darkBody->hex),
      media("(prefers-color-scheme: dark)", [color(Theme.lightBody->hex)]),
      fontSize(1.->em),
      lineHeight(`abs(1.4)),
      unsafe("WebkitFontSmoothing", "antialiased"),
      unsafe("WebkitTextSizeAdjust", "100%") /* Prevent adjustments of font size after orientation changes in iOS. */
    ],
  )
);

Css.(global("*, *:before, *:after", [boxSizing(borderBox)]));
