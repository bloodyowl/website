[@react.component]
let make:
  (
    ~list: RequestStatus.t(Belt.Result.t(array(PostShallow.t), Errors.t)),
    ~onLoadRequest: unit => unit,
    unit
  ) =>
  React.element;
