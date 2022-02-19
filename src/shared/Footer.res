module Styles = {
  open Emotion
  let container = css({
    "textAlign": "center",
    "padding": "10vh 0",
    "opacity": 0.5,
  })
}

@react.component
let make = () => {
  let (year, setYear) = React.useState(() => "")

  React.useEffect0(() => {
    setYear(_ => ` - ${Date.make()->Date.getFullYear->Int.toString}`)
    None
  })

  <footer className={Styles.container}> {`© Matthias Le Brun${year}`->React.string} </footer>
}
