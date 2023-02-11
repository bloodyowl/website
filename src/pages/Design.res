let colors = ["#fff", "#eee", "#e9e9e9"]

module Styles = {
  open Emotion
  let container = css({
    "margin": 50,
    "display": "flex",
    "flexDirection": "column",
    "alignItems": "stretch",
    "justifyContent": "center",
    "flexGrow": 1,
    "@media (max-width: 600px)": {
      "margin": "0",
    },
  })
  let imageContent = css({
    "paddingBottom": "75%",
    "position": "relative",
    "margin": "auto",
    "overflow": "hidden",
    "borderRadius": 20,
    "boxShadow": "0 20px 30px rgba(0, 0, 0, 0.1)",
  })
  let image = css({
    "position": "absolute",
    "top": 0,
    "left": 0,
    "width": "100%",
    "height": "100%",
    "objectFit": "cover",
    "objectPosition": "50% 50%",
  })
}
@react.component
let make = () => {
  let list = Pages.useCollection("design")

  <>
    {switch list {
    | NotAsked | Loading | Done(Error(_)) =>
      <Section>
        <Pages.ActivityIndicator />
      </Section>
    | Done(Ok(designs)) =>
      <>
        <Pages.Head>
          <title> {"Design - Matthias Le Brun (@bloodyowl)"->React.string} </title>
        </Pages.Head>
        {designs.items
        ->Array.map(design => {
          <Section key=design.slug>
            <WidthContainer>
              <div className=Styles.container>
                <div>
                  <div className=Styles.imageContent>
                    {<img
                      src=?{switch design.meta
                      ->Js.Dict.get("image")
                      ->Option.map(JSON.Decode.classify) {
                      | Some(String(value)) => Some(value)
                      | _ => None
                      }}
                      alt=?{switch design.meta
                      ->Js.Dict.get("alt")
                      ->Option.map(JSON.Decode.classify) {
                      | Some(String(value)) => Some(value)
                      | _ => None
                      }}
                      className=Styles.image
                    />->React.cloneElement({"loading": "lazy"})}
                  </div>
                </div>
              </div>
            </WidthContainer>
          </Section>
        })
        ->React.array}
      </>
    }}
  </>
}
