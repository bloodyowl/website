open CardList

@react.component
let make = () => {
  <>
    <Section>
      <Intro />
    </Section>
    <Section>
      <Center>
        <Heading text="tools I work with" />
        <CardList
          cards=[
            (
              "react",
              {
                name: "React",
                image: "/public/assets/images/technologies/react.svg",
                url: "https://reasonml.github.io/reason-react",
              },
            ),
            (
              "ts",
              {
                name: "TypeScript",
                image: "/public/assets/images/technologies/typescript.svg",
                url: "https://www.typescriptlang.org",
              },
            ),
            (
              "graphql",
              {
                name: "GraphQL",
                image: "/public/assets/images/technologies/graphql.svg",
                url: "https://graphql.org",
              },
            ),
            (
              "sketch",
              {
                name: "Sketch",
                image: "/public/assets/images/technologies/sketch.svg",
                url: "https://sketchapp.com",
              },
            ),
            (
              "rescript",
              {
                name: "ReScript",
                image: "/public/assets/images/technologies/rescript.svg",
                url: "https://rescript-lang.org",
              },
            ),
            (
              "js",
              {
                name: "JavaScript",
                image: "/public/assets/images/technologies/js.svg",
              },
            ),
          ]
        />
      </Center>
    </Section>
    <Section>
      <Center>
        <Heading text="I'm involved in" />
        <CardList
          cards=[
            (
              "parisjs",
              {
                name: "Paris.JS",
                description: "Organizer",
                image: "/public/assets/images/projects/parisjs.svg",
                url: "https://parisjs.org",
              },
            ),
            (
              "putaindecode",
              {
                name: "Putain de Code !",
                description: "Co-Founder",
                image: "/public/assets/images/projects/putaindecode.svg",
                url: "https://putaindecode.io",
              },
            ),
            (
              "podcast",
              {
                name: "Podcast",
                description: "Host",
                image: "/public/assets/images/projects/podcast.svg",
                url: "https://soundcloud.com/putaindecode",
              },
            ),
          ]
        />
      </Center>
    </Section>
    <Section>
      <Center>
        <Heading text="some stuff I open-sourced" />
        <CardList
          cards=[
            (
              "boxed",
              {
                name: "Boxed",
                image: "/public/assets/images/open-source/boxed.svg",
                url: "https://swan-io.github.io/boxed/",
              },
            ),
            (
              "graphql-client",
              {
                name: "GraphQL Client",
                image: "/public/assets/images/open-source/graphql-client.svg",
                url: "https://swan-io.github.io/graphql-client/",
              },
            ),
            (
              "request",
              {
                name: "Request",
                image: "/public/assets/images/open-source/request.svg",
                url: "https://github.com/swan-io/request/",
              },
            ),
            (
              "rescript-pages",
              {
                name: "ReScript Pages",
                image: "/public/assets/images/open-source/rescript-pages.svg",
                url: "https://bloodyowl.github.io/rescript-pages/",
              },
            ),
            (
              "rescript-test",
              {
                name: "ReScript Test",
                image: "/public/assets/images/open-source/rescript-test.svg",
                url: "https://bloodyowl.github.io/rescript-test/",
              },
            ),
          ]
        />
      </Center>
    </Section>
  </>
}
