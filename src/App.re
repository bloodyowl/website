type action =
  | SetRoute(React.Router.url);

type state = {url: React.Router.url};

let component = React.reducerComponent("App");

let make = _ => {
  ...component,
  initialState: () => {url: React.Router.dangerouslyGetInitialUrl()},
  reducer: (action, _) =>
    switch (action) {
    | SetRoute(url) => Update({url: url})
    },
  didMount: ({send, onUnmount}) => {
    let watcherId = React.Router.watchUrl(url => send(SetRoute(url)));
    onUnmount(() => React.Router.unwatchUrl(watcherId));
  },
  render: ({state}) =>
    <>
      <Header />
      {switch (state.url.path) {
       | [] => <Home />
       | _ => React.null
       }}
      <Footer />
    </>,
};
