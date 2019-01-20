type action;

type state = {
  posts:
    Belt.Map.String.t(RequestStatus.t(Belt.Result.t(Post.t, Errors.t))),
  postList: RequestStatus.t(Belt.Result.t(array(PostShallow.t), Errors.t)),
};

let default: state;

let make:
  (
    ~url: React.Router.url,
    ~initialData: state=?,
    array(React.reactElement)
  ) =>
  React.component(state, React.noRetainedProps, action);
