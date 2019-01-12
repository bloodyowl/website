type talk = {
  date: string,
  name: string,
  description: string,
  url: string,
};

let make:
  (~talks: array((string, talk)), array(React.reactElement)) =>
  React.component(React.stateless, React.noRetainedProps, React.actionless);
