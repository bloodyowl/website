module Styles = {
  open Css
  let title = style(list{margin2(~v=20->px, ~h=zero), fontSize(42->px), fontWeight(bold)})
}

@react.component
let make = (~text, ~level=2, ()) =>
  <div className=Styles.title role="heading" ariaLevel=level> {text->ReasonReact.string} </div>
