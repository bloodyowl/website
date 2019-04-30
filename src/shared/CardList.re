open Belt;

type card = {
  image: string,
  name: string,
  url: option(string),
};

module Card = {
  let component = ReasonReact.statelessComponent("Card");

  module Styles = {
    open Css;
    let container =
      style([
        flexShrink(0),
        display(flexBox),
        flexDirection(column),
        alignItems(stretch),
        textDecoration(none),
        color(Theme.darkBody->hex),
        padding4(~left=zero, ~right=20->px, ~top=20->px, ~bottom=20->px),
        `declaration(("scrollSnapAlign", "start")),
      ]);
    let image =
      style([
        width(128->px),
        height(128->px),
        borderRadius(25->px),
        transitionDuration(300),
        transitionTimingFunction(`easeOut),
        boxShadow(~y=5->px, ~blur=10->px, rgba(0, 0, 0, 0.1)),
        transitionProperty("transform, box-shadow"),
        hover([
          transforms([scale(0.96, 0.96)]),
          boxShadow(~y=3->px, ~blur=7->px, rgba(0, 0, 0, 0.3)),
        ]),
      ]);
    let text =
      style([textAlign(center), fontSize(18->px), paddingTop(10->px)]);
  };

  [@react.component]
  let make = (~card, ()) =>
    ReactCompat.useRecordApi({
      ...component,
      render: _ => {
        let contents =
          <>
            <img className=Styles.image src={card.image} alt="" />
            <div className=Styles.text> card.name->ReasonReact.string </div>
          </>;
        switch (card.url) {
        | Some(href) => <a href className=Styles.container> contents </a>
        | None => <div className=Styles.container> contents </div>
        };
      },
    });
};

let component = ReasonReact.statelessComponent("CardList");

module Styles = {
  open Css;
  let root = style([display(block)]);
  let container =
    style([
      overflowX(auto),
      display(flexBox),
      flexDirection(row),
      alignItems(flexStart),
      justifyContent(flexStart),
      `declaration(("WebkitOverflowScrolling", "touch")),
      `declaration(("scrollSnapType", "x mandatory")),
    ]);
};

[@react.component]
let make = (~cards, ()) =>
  ReactCompat.useRecordApi({
    ...component,
    render: _ =>
      <div className=Styles.root>
        <div className=Styles.container>
          {cards
           ->Array.map(((id, card)) => <Card key=id card />)
           ->ReasonReact.array}
        </div>
      </div>,
  });
