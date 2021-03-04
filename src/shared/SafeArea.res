module Styles = {
  open Css
  let container = style(list{
    display(flexBox),
    flexDirection(column),
    alignItems(stretch),
    justifyContent(center),
    flexGrow(1.0),
    unsafe("paddingLeft", "env(safe-area-inset-left)"),
    unsafe("paddingRight", "env(safe-area-inset-right)"),
  })
}

@react.component
let make = (~children) => {
  <div className=Styles.container> children </div>
}
