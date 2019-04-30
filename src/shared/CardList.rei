type card = {
  image: string,
  name: string,
  url: option(string),
};

[@react.component]
let make: (~cards: array((string, card)), unit) => React.element;
