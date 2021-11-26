open CardList

@react.component
let make = () => {
  <>
    <WidthContainer> <Header /> </WidthContainer>
    <Section backgroundColor="#8D90FC" color="#000"> <Intro /> </Section>
    <Section backgroundColor="#C181FC" color="#000">
      <Center>
        <Heading text="Things I work with" />
        <CardList
          cards=[
            (
              "rescript",
              {
                name: "ReScript",
                image: "/public/assets/images/technologies/rescript.svg",
                url: Some("https://rescript-lang.org"),
              },
            ),
            (
              "react",
              {
                name: "React",
                image: "/public/assets/images/technologies/react.svg",
                url: Some("https://reasonml.github.io/reason-react"),
              },
            ),
            (
              "sketch",
              {
                name: "Sketch",
                image: "/public/assets/images/technologies/sketch.svg",
                url: Some("https://sketchapp.com"),
              },
            ),
            (
              "js",
              {
                name: "JavaScript",
                image: "/public/assets/images/technologies/js.svg",
                url: None,
              },
            ),
          ]
        />
      </Center>
    </Section>
    <Section isLast=true backgroundColor="#FC74EC" color="#000">
      <Center>
        <Heading text="Projects" />
        <CardList
          cards=[
            (
              "putaindecode",
              {
                name: "Putain de Code !",
                image: "/public/assets/images/projects/putaindecode.svg",
                url: Some("https://putaindecode.io"),
              },
            ),
            (
              "podcast",
              {
                name: "Podcast",
                image: "/public/assets/images/projects/podcast.svg",
                url: Some("https://soundcloud.com/putaindecode"),
              },
            ),
            (
              "parisjs",
              {
                name: "Paris.JS",
                image: "/public/assets/images/projects/parisjs.svg",
                url: Some("https://parisjs.org"),
              },
            ),
            (
              "twitch",
              {
                name: "Twitch",
                image: "/public/assets/images/projects/twitch.svg",
                url: Some("https://www.twitch.tv/bldwl"),
              },
            ),
          ]
        />
      </Center>
    </Section>
  </>
}
