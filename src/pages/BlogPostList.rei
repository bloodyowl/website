let make:
  (
    ~list: RequestStatus.t(Belt.Result.t(array(PostShallow.t), Errors.t)),
    ~onLoadRequest: unit => unit,
    array(React.reactElement)
  ) =>
  React.component(React.stateless, React.noRetainedProps, React.actionless);
