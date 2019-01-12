type action;

type state;

let make:
  array(React.reactElement) =>
  React.component(state, React.noRetainedProps, action);
