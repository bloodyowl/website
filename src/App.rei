type action;

type state;

let make:
  (
    ~url: React.Router.url,
    ~initialData: Belt.Map.String.t(
                    RequestStatus.t(Belt.Result.t(Resource.t, Errors.t)),
                  )
                    =?,
    array(React.reactElement)
  ) =>
  React.component(state, React.noRetainedProps, action);
