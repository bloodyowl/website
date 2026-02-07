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
    "paddingBottom": "50%",
    "position": "relative",
    "margin": "auto",
    "overflow": "hidden",
    "borderRadius": 20,
    "boxShadow": "0 20px 30px rgba(0, 0, 0, 0.1)",
  })
  let video = css({
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
  let list = Pages.useCollection("music")

  <>
    {switch list {
    | NotAsked | Loading | Done(Error(_)) =>
      <Section>
        <Pages.ActivityIndicator />
      </Section>
    | Done(Ok(tracks)) =>
      let reversedTracks = tracks.items->Array.copy
      reversedTracks->Array.reverse
      <>
        <Pages.Head>
          <title> {"Music - Matthias Le Brun (@bloodyowl)"->React.string} </title>
        </Pages.Head>
        {reversedTracks
        ->Array.map(track => {
          <Section key=track.slug>
            <WidthContainer>
              <div className=Styles.container>
                <div>
                  <div className=Styles.imageContent>
                    {React.cloneElement(
                      <iframe
                        width="560"
                        height="315"
                        src=?{switch track.meta->Dict.get("url") {
                        | Some(String(url)) => Some(url ++ "&color=white")
                        | _ => None
                        }}
                        title="YouTube video player"
                        style={ReactDOMStyle.make(~border="none", ())}
                        allowFullScreen=true
                        className=Styles.video
                      />,
                      {
                        "allow": "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share",
                        "referrerPolicy": "strict-origin-when-cross-origin",
                      },
                    )}
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
