open Belt;

let component = React.statelessComponent("Link");

let externalLinkRe = [%re "/^https?:\\/\\//"];

let make =
    (
      ~url=?,
      ~href,
      ~className=?,
      ~activeClassName=?,
      ~matchSubroutes=false,
      ~onClick=?,
      children,
    ) => {
  ...component,
  render: _ => {
    let isActive =
      url
      ->Option.map(url => "/" ++ String.concat("/", url.React.Router.path))
      ->Option.map(path =>
          matchSubroutes ? Js.String.startsWith(href, path) : path === href
        )
      ->Option.getWithDefault(false);
    let className =
      switch (className, activeClassName) {
      | (Some(className), Some(activeClassName)) when isActive =>
        Some(Css.merge([className, activeClassName]))
      | (None, Some(activeClassName)) when isActive => Some(activeClassName)
      | (Some(className), _) => Some(className)
      | _ => None
      };
    <a
      href
      onClick={event =>
        switch (
          ReactEvent.Mouse.metaKey(event),
          ReactEvent.Mouse.ctrlKey(event),
        ) {
        | (false, false) =>
          if (!externalLinkRe->Js.Re.test(href, _)) {
            ReactEvent.Mouse.preventDefault(event);
            React.Router.push(href);
          };
          switch (onClick) {
          | Some(onClick) => onClick(event)
          | None => ()
          };
        | _ => ()
        }
      }
      ?className>
      {children[0]->Option.getWithDefault(React.null)}
    </a>;
  },
};
