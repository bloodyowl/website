type card = {
  image: string,
  name: string,
  url: option(string),
};

let make:
  (~cards: array((string, card)), array(React.reactElement)) =>
  React.component(React.stateless, React.noRetainedProps, React.actionless);
