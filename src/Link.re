open Belt;

type action =
  | SetRoute(React.Router.url);

type state = React.Router.url;

let component = React.reducerComponent("Link");

let externalLinkRe = [%re "/^https?:\\/\\//"];

let make =
    (
      ~href,
      ~className=?,
      ~activeClassName=?,
      ~matchSubroutes=false,
      ~onClick=?,
      children,
    ) => {
  ...component,
  initialState: () => React.Router.dangerouslyGetInitialUrl(),
  didMount: ({send, onUnmount}) => {
    let watchId = React.Router.watchUrl(url => send(SetRoute(url)));
    onUnmount(() => React.Router.unwatchUrl(watchId));
  },
  reducer: (action, _state) =>
    switch (action) {
    | SetRoute(url) => React.Update(url)
    },
  render: ({state}) => {
    let path = "/" ++ String.concat("/", state.React.Router.path);
    let isActive =
      matchSubroutes ? Js.String.startsWith(href, path) : path === href;
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
