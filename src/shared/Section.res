module Styles = {
  open Emotion
  let container = css({
    "minHeight": "100vh",
    "position": "relative",
    "display": "flex",
    "flexDirection": "column",
    "alignItems": "stretch",
  })
  let backgroundContainer = css({
    "position": "absolute",
    "top": "0",
    "left": 0,
    "right": 0,
    "bottom": "0",
    "overflow": "hidden",
    "pointerEvents": "none",
  })
  let backgroundRef = css({
    "position": "absolute",
    "top": "0",
    "left": 0,
    "right": 0,
    "bottom": "0",
  })
  let backgroundOverlay = css({
    "position": "absolute",
    "top": "0",
    "left": 0,
    "right": 0,
    "bottom": "0",
    "opacity": "calc(0.2 + var(--scroll-progress) / 2)",
  })
  let background = css({
    "position": "absolute",
    "top": "0",
    "left": -1,
    "right": 0,
    "bottom": 0,
    "borderLeft": "1px dashed",
    "transform": "translateX(calc(calc(1 - var(--scroll-progress)) * 1px)) translateX(calc(calc(1 - var(--scroll-progress)) * 100vw))",
  })
  let borderTopContainer = css({
    "position": "absolute",
    "top": "-100vh",
    "left": -1,
    "right": 0,
    "height": "100vh",
    "overflow": "hidden",
    "pointerEvents": "none",
  })
  let borderTop = css({
    "position": "absolute",
    "top": 0,
    "left": 0,
    "right": 0,
    "bottom": 0,
    "borderLeft": "1px dashed",
    "transform": "translateX(calc(calc(1 - var(--scroll-progress)) * 1px)) translateX(calc(calc(1 - var(--scroll-progress)) * 100vw))",
  })
  let backgroundOverflow = css({
    "position": "absolute",
    "top": "100%",
    "left": 0,
    "right": 0,
    "height": "100vh",
    "pointerEvents": "none",
  })
  let contents = css({
    "position": "relative",
    "flexGrow": 1,
    "borderBottom": "1px dashed",
    "paddingLeft": "var(--body-start-margin)",
    "display": "flex",
    "flexDirection": "column",
    "alignItems": "stretch",
  })
}

@react.component
let make = (~isLast=false, ~backgroundColor, ~color, ~children) => {
  let backgroundRef = React.useRef(Nullable.null)
  let containerRef = React.useRef(Nullable.null)

  Hooks.useScrollProgress(~containerRef, ~scrollRef=backgroundRef)

  <div
    className={Emotion.cx([Styles.container, Emotion.css({"color": color})])}
    ref={ReactDOM.Ref.domRef(containerRef)}>
    <div className={Styles.borderTopContainer}>
      <div className={Styles.borderTop}>
        <div
          className={Emotion.cx([
            Styles.backgroundOverlay,
            Emotion.css({"backgroundColor": backgroundColor}),
          ])}
        />
      </div>
    </div>
    <div className={Styles.backgroundContainer}>
      <div ref={ReactDOM.Ref.domRef(backgroundRef)} className={Styles.backgroundRef} />
      <div
        className={Emotion.cx([
          Styles.backgroundOverlay,
          Emotion.css({"backgroundColor": backgroundColor}),
        ])}
      />
      <div
        className={Emotion.cx([
          Styles.background,
          Emotion.css({"backgroundColor": backgroundColor}),
        ])}
      />
    </div>
    <div className={Styles.contents}> <WidthContainer> {children} </WidthContainer> </div>
    {isLast
      ? React.null
      : <div
          className={Emotion.cx([
            Styles.backgroundOverflow,
            Emotion.css({"backgroundColor": backgroundColor}),
          ])}
        />}
  </div>
}
