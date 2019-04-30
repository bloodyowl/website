include CssReset;

open Belt;

type action =
  | LoadPost(string)
  | ReceivePost(string, Result.t(Post.t, Errors.t))
  | LoadPostList
  | ReceivePostList(Result.t(array(PostShallow.t), Errors.t));

type state = {
  posts: Map.String.t(RequestStatus.t(Result.t(Post.t, Errors.t))),
  postList: RequestStatus.t(Result.t(array(PostShallow.t), Errors.t)),
};

let default = {posts: Map.String.empty, postList: NotAsked};

let component = ReasonReact.reducerComponent("App");

module Styles = {
  open Css;
  let container =
    style([
      minHeight(100.->vh),
      display(flexBox),
      flexDirection(column),
      alignItems(stretch),
    ]);
};

[@react.component]
let make = (~url: ReasonReact.Router.url, ~initialData=?, ()) =>
  ReactCompat.useRecordApi({
    ...component,
    initialState: () => initialData->Option.getWithDefault(default),
    reducer: (action, state) =>
      switch (action) {
      | LoadPost(slug) =>
        UpdateWithSideEffects(
          {
            ...state,
            posts: state.posts->Map.String.set(slug, RequestStatus.Loading),
          },
          ({send}) =>
            Post.query(slug)
            ->Future.get(value => send(ReceivePost(slug, value))),
        )
      | ReceivePost(slug, payload) =>
        Update({
          ...state,
          posts:
            state.posts->Map.String.set(slug, RequestStatus.Done(payload)),
        })
      | LoadPostList =>
        UpdateWithSideEffects(
          {...state, postList: RequestStatus.Loading},
          ({send}) =>
            PostShallow.query()
            ->Future.get(value => send(ReceivePostList(value))),
        )
      | ReceivePostList(payload) =>
        Update({...state, postList: RequestStatus.Done(payload)})
      },
    render: ({state, send}) => {
      <div className=Styles.container>
        <Header url />
        {switch (url.path) {
         | [] => <Home />
         | ["blog"] =>
           <BlogPostList
             list={state.postList}
             onLoadRequest={() => send(LoadPostList)}
           />
         | ["blog", slug] =>
           <BlogPost
             post={
               state.posts
               ->Map.String.get(slug)
               ->Option.getWithDefault(RequestStatus.NotAsked)
             }
             onLoadRequest={() => send(LoadPost(slug))}
           />
         | _ => <ErrorIndicator />
         }}
        <Footer />
      </div>;
    },
  });
