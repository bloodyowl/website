module Styles = {
  open Emotion
  let container = css({"padding": "10px 0"})
}

@react.component
let make = () => {
  let div = React.useMemo(() =>
    <div className=Styles.container> <div className="BeOpWidget" /> </div>
  )

  div
}
