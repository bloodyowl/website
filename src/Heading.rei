let make:
  (~text: string, ~level: int=?, array(React.reactElement)) =>
  React.component(React.stateless, React.noRetainedProps, React.actionless);
