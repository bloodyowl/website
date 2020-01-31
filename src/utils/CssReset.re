Css.(
  global(
    fontFace(
      ~fontFamily="Madera",
      ~src=[url("/public/assets/webfonts/madera.ttf")],
      ~fontStyle=normal,
      ~fontWeight=`num(400),
      (),
    )
    ->Js.String2.replaceByRe([%re "/\\}$/"], "font-display: swap;}"),
  )
);

Js.log(
  Css.(fontFace(
      ~fontFamily="Madera",
      ~src=[url("/public/assets/webfonts/madera.ttf")],
      ~fontStyle=normal,
      ~fontWeight=`num(400),
      (),
    ))
);
Js.log( Css.(fontFace(
      ~fontFamily="Madera",
      ~src=[url("/public/assets/webfonts/madera.ttf")],
      ~fontStyle=normal,
      ~fontWeight=`num(400),
      (),
    ))
    ->Js.String2.replaceByRe([%re "/\\}$/"], "font-display: swap;}"),);

Css.(
  global(
    fontFace(
      ~fontFamily="Madera",
      ~src=[url("/public/assets/webfonts/madera-bold.ttf")],
      ~fontStyle=normal,
      ~fontWeight=`num(700),
      (),
    )
    ->Js.String2.replaceByRe([%re "/\\}$/"], "font-display: swap;}"),
  )
);

Css.(
  global(
    "body",
    [
      padding(zero),
      margin(zero),
      backgroundColor("fff"->hex),
      Theme.defaultTextFontFamily->fontFamily,
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
      fontSize(1.->em),
      lineHeight(`abs(1.4)),
      `declaration(("WebkitFontSmoothing", "antialiased")),
      `declaration(("WebkitTextSizeAdjust", "100%")) /* Prevent adjustments of font size after orientation changes in iOS. */
    ],
  )
);

Css.(global("*, *:before, *:after", [boxSizing(borderBox)]));
