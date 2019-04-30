[@react.component]
let make:
  (
    ~url: ReasonReactRouter.url=?,
    ~href: Js.String.t,
    ~className: string=?,
    ~activeClassName: string=?,
    ~matchSubroutes: bool=?,
    ~onClick: ReactEvent.Mouse.t => unit=?,
    ~children: React.element,
    unit
  ) =>
  React.element;
