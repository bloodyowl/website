module Posts: {
  let get:
    unit =>
    Future.t(Belt.Result.t(array((Post.t, PostShallow.t)), Js.Exn.t));
};

module Json: {
  let make:
    array((Post.t, PostShallow.t)) => array((Post.t, PostShallow.t));
};
