open CardList

@react.component
let make = () => {
  <>
    <Section> <Intro /> </Section>
    <Section>
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
              "ts",
              {
                name: "TypeScript",
                image: "/public/assets/images/technologies/typescript.svg",
                url: Some("https://www.typescriptlang.org"),
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
    <Section>
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
