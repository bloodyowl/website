module Styles = {
  open Emotion
  let container = css({
    "padding": "50px 0",
    "display": "flex",
    "flexDirection": "row",
    "alignItems": "stretch",
  })
  let column = css({
    "position": "relative",
    "width": "10%",
    "padding": "0 10px 10px",
    "@media (max-width: 620px)": {"display": "none"},
  })
  let avatar = css({
    "position": "sticky",
    "top": 20,
    "zIndex": 1,
    "borderRadius": "100%",
    "paddingBottom": "100%",
    "backgroundImage": `url("https://avatars.githubusercontent.com/bloodyowl?size=200")`,
    "backgroundSize": "cover",
  })
  let main = css({
    "position": "relative",
    "flexGrow": 1,
    "paddingLeft": 20,
    "minWidth": "0",
  })
  let hi = css({
    "fontSize": "12vw",
    "lineHeight": "0.5",
    "marginTop": "1vw",
    "marginBottom": "5vw",
    "transform": "translateX(-1vw)",
    "fontWeight": "bold",
  })
  let paragraph = css({
    "fontSize": 20,
    "paddingRight": 10,
    "a": {
      "color": Theme.darkBody,
    },
    "strong": {"whiteSpace": "nowrap"},
  })
  let link = css({
    "display": " block",
    "fontSize": 20,
    "fontWeight": "bold",
    "color": "inherit",
  })
}

@react.component
let make = () => <>
  <Pages.Head> <title> {"Matthias Le Brun"->React.string} </title> </Pages.Head>
  <SafeArea>
    <div className=Styles.container>
      <div className=Styles.column> <div className=Styles.avatar /> </div>
      <div className=Styles.main>
        <div className=Styles.hi> {"Hi!"->React.string} </div>
        <p
          className=Styles.paragraph
          dangerouslySetInnerHTML={
            "__html": `My name is <strong>Matthias Le Brun</strong> (aka <a href="https://twitter.com/bloodyowl" target="_blank"><strong>@bloodyowl</strong></a>).`,
          }
        />
        <p
          className=Styles.paragraph
          dangerouslySetInnerHTML={
            "__html": `I’m a <strong>front-end&nbsp;developer</strong> living in Paris, France.`,
          }
        />
        <p
          className=Styles.paragraph
          dangerouslySetInnerHTML={
            "__html": `I'm <strong>Head of Product Design</strong> at <a href="https://beop.io" target="_blank"><strong>BeOp</strong></a>, where we're building a new kind of advertising platform.`,
          }
        />
        <a className=Styles.link href="https://twitter.com/bloodyowl">
          {`→ Twitter`->React.string}
        </a>
        <a className=Styles.link href="https://github.com/bloodyowl">
          {`→ GitHub`->React.string}
        </a>
        <a className=Styles.link href="https://dribbble.com/bloodyowl">
          {`→ Dribbble`->React.string}
        </a>
        <a className=Styles.link href="https://www.linkedin.com/in/bloodyowl">
          {`→ LinkedIn`->React.string}
        </a>
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
        <Heading text="Talks" />
        <TalkList
          talks=[
            (
              "simplify-ui-types",
              {
                date: "02/2021",
                name: "Simplify your UI management with (algebraic data) types",
                description: "Approaching how algebraic data-types can help in UI development. ",
                url: "https://speakerdeck.com/bloodyowl/simplify-your-ui-management-with-algebraic-data-types-9dfb731e-7c99-4269-8301-0b726f44a5ad",
              },
            ),
            (
              "simplify-ui-manager",
              {
                date: "10/2020",
                name: "Simplify your UI management with (algebraic data) types",
                description: "Approaching how algebraic data-types can help in UI development. ",
                url: "https://speakerdeck.com/bloodyowl/simplify-your-ui-management-with-algebraic-data-types",
              },
            ),
            (
              "migrating-reason-react-codebase-to-hooks",
              {
                date: "03/2020",
                name: "Migrating a large Reason+React codebase to hooks",
                description: "Sharing my experience writing complex hooks along with a codemod to upgrade to the hooks ReasonReact API. ",
                url: "https://speakerdeck.com/bloodyowl/migrating-a-large-reason-plus-react-codebase-to-hooks",
              },
            ),
            (
              "third-party-hell-2",
              {
                date: "06/2019",
                name: "Third-party hell",
                description: "Sharing my experience building third-party widgets in the browser hell. Updated version. ",
                url: "https://speakerdeck.com/bloodyowl/third-party-hell-bestofweb",
              },
            ),
            (
              "best-practices",
              {
                date: "02/2019",
                name: "Best practices",
                description: "Should we trust \"best practices\"? A take on dogmatism in the development industry.",
                url: "https://speakerdeck.com/bloodyowl/best-practices",
              },
            ),
            (
              "good-reason-typing",
              {
                date: "04/2018",
                name: "A good Reason for typing",
                description: "Revisited version of my previous Reason introduction talk.",
                url: "https://speakerdeck.com/bloodyowl/a-good-reason-for-typing",
              },
            ),
            (
              "third-party-hell",
              {
                date: "03/2018",
                name: "Third-party hell",
                description: "Sharing my experience building third-party widgets in the browser hell. ",
                url: "https://speakerdeck.com/bloodyowl/third-party-hell",
              },
            ),
            (
              "reason-ocaml",
              {
                date: "09/2017",
                name: "Reason for OCamlers",
                description: "Presenting ReasonML to regular OCaml users, showing both similarities and differences.",
                url: "https://speakerdeck.com/bloodyowl/reasonml-at-ocaml-users-in-paris",
              },
            ),
            (
              "reason",
              {
                date: "09/2017",
                name: "Reason, or How I Learned to Stop Worrying",
                description: "My first talk about ReasonML. Going through the language and the tooling",
                url: "https://speakerdeck.com/bloodyowl/reason-or-how-i-learned-to-stop-worrying-and-learnt-a-new-and-safer-language",
              },
            ),
            (
              "flow",
              {
                date: "05/2016",
                name: "Flow: strong, static typing for JavaScript",
                description: "Presenting Flow, and how it helps detecting bugs in a JavaScript codebase.",
                url: "https://speakerdeck.com/bloodyowl/flow-du-strong-static-typing-pour-javascript",
              },
            ),
            (
              "css-at-scale",
              {
                date: "06/2015",
                name: "CSS at Scale",
                description: "Going through the ways CSS makes it hard to scale application and teams, introducing alternatives like CSS-in-JS.",
                url: "https://speakerdeck.com/bloodyowl/css-at-scale",
              },
            ),
          ]
        />
      </div>
    </div>
  </SafeArea>
</>
