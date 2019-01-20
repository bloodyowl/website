include CssReset;

open Belt;

type action =
  | Load(string)
  | Receive(string, Result.t(Resource.t, Errors.t));

type state =
  Belt.Map.String.t(RequestStatus.t(Result.t(Resource.t, Errors.t)));

let component = React.reducerComponent("App");

let make = (~url: React.Router.url, ~initialData=?, _) => {
  ...component,
  initialState: () =>
    initialData->Option.getWithDefault(Belt.Map.String.empty),
  reducer: (action, state) =>
    switch (action) {
    | Load(url) =>
      UpdateWithSideEffects(
        state->Map.String.set(url, RequestStatus.Loading),
        ({send}) =>
          Request.make(~url=url ++ ".json", ())
          ->Future.get(value => send(Receive(url, value))),
      )
    | Receive(url, payload) =>
      Update(state->Map.String.set(url, RequestStatus.Done(payload)))
    },
  render: ({state}) =>
    <>
      <Header />
      {switch (url.path) {
       | [] => <Home />
       | _ => React.null
       }}
      <Footer />
    </>,
};
