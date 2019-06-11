let component = ReasonReact.statelessComponent("Home");

module Styles = {
  open Css;
  let container =
    style([
      padding2(~h=10->px, ~v=50->px),
      display(flexBox),
      flexDirection(row),
      alignItems(stretch),
    ]);
  let column =
    style([
      position(relative),
      width(10.->pct),
      padding3(~h=10->px, ~top=zero, ~bottom=10->px),
      media("(max-width: 620px)", [display(none)]),
    ]);
  let avatar =
    style([
      position(sticky),
      top(10->px),
      zIndex(1),
      borderRadius(100.->pct),
      paddingBottom(100.->pct),
      backgroundImage(url("/public/assets/images/avatar.jpg")),
      backgroundSize(cover),
    ]);
  let main =
    style([
      position(relative),
      flexGrow(1.0),
      paddingLeft(20->px),
      minWidth(zero),
    ]);
  let hi =
    style([
      fontSize(12.0->vw),
      lineHeight(`abs(0.5)),
      marginBottom(10.0->vw),
      transform(translateX((-1.0)->vw)),
      fontWeight(bold),
    ]);
  let paragraph = style([maxWidth(520->px)]);
};

[@react.component]
let make = () =>
  ReactCompat.useRecordApi({
    ...component,
    render: _ =>
      <WithTitle title="Matthias Le Brun">
        <div className=Styles.container>
          <div className=Styles.column> <div className=Styles.avatar /> </div>
          <div className=Styles.main>
            <div className=Styles.hi> "Hi!"->ReasonReact.string </div>
            <p
              className=Styles.paragraph
              dangerouslySetInnerHTML={
                "__html": {js|My name is <strong>Matthias Le Brun</strong> (aka <strong>@bloodyowl</strong>), and I’m a <strong>front-end developer</strong> living in Paris, France.|js},
              }
            />
            <p
              className=Styles.paragraph
              dangerouslySetInnerHTML={
                "__html": {js|I currently work at <strong>BeOp</strong>, where we build a third-party solution for editors on the web, enabling them to create interactive content without any technical knowledge and to monetize their pages.|js},
              }
            />
            <p
              className=Styles.paragraph
              dangerouslySetInnerHTML={
                "__html": {js|I <strong>design</strong> and <strong>develop</strong> our dashboard and widget using ReasonML and ReasonReact.|js},
              }
            />
            <Heading text="Things I work with" />
            <CardList
              cards=[|
                (
                  "reason",
                  {
                    name: "ReasonML",
                    image: "/public/assets/images/technologies/reason.svg",
                    url: Some("https://reasonml.github.io"),
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
                  "jest",
                  {
                    name: "Jest",
                    image: "/public/assets/images/technologies/jest.svg",
                    url: Some("http://jestjs.io/"),
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
              |]
            />
            <Heading text="Projects" />
            <CardList
              cards=[|
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
              |]
            />
            <Heading text="Talks" />
            <TalkList
              talks=[|
                (
                  "best-practices",
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
              |]
            />
          </div>
        </div>
      </WithTitle>,
  });
