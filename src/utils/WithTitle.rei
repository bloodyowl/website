type action;

type state;

let suffix: string => string;

let make:
  (~title: string, array(React.reactElement)) =>
  React.component(state, React.noRetainedProps, action);
