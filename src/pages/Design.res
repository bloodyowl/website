let colors = ["#8D90FC", "#C181FC", "#65E197"]

module Styles = {
  open Emotion
  let container = css({
    "margin": 50,
    "display": "flex",
    "flexDirection": "column",
    "alignItems": "stretch",
    "justifyContent": "center",
    "flexGrow": 1,
  })
  let imageContent = css({
    "paddingBottom": "75%",
    "position": "relative",
    "margin": "auto",
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
    <WidthContainer> <Header /> </WidthContainer>
    {switch list {
    | NotAsked | Loading | Done(Error(_)) =>
      <Section backgroundColor="#8D90FC" color="#000"> <Pages.ActivityIndicator /> </Section>
    | Done(Ok(designs)) =>
      designs.items
      ->Array.mapWithIndex((design, index) => {
        <Section
          key=design.slug
          isLast={index == designs.items->Array.length - 1}
          color="#000"
          backgroundColor={colors
          ->Array.get(mod(index, colors->Array.length))
          ->Option.getWithDefault("#65E197")}>
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
                    alt=?{switch design.meta->Js.Dict.get("alt")->Option.map(JSON.Decode.classify) {
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
      ->React.array
    }}
  </>
}
