---
date: 2019-01-24
title: Orchestrating requests at component level
---

[In a previous article](/blog/2019-01-20-requests-with-reasonml/), we saw how we can model request statuses in our ReasonReact component state, so that we prevent weird or impossible states.

Now, let's see how we can orchestrate them **within** our components.

When I was using JavaScript, I generally put all the logic involving server requests in Redux. This wasn't an obligation, but thinking in actions really helped figuring out what was happening, which was harder when calling `setState` all over the place. Using Reason, and given the evolution of React, I feel I don't need this anymore:

- with reducer components, **thinking in actions and state** can happen locally
- props drilling is ok when backed by a **static type system**
- portals reduce the need for a global store that components subscribe to: you can **pass the data** from a component **to a portal** that's rendered elsewhere
- true isolation between components makes a lot of things easier: they're **reusable**, their **data dependencies are explicit** and statically analysable, and their implementation doesn't leak to a shared store
- reducer components embed a [powerful update mechanism](https://reasonml.github.io/reason-react/docs/en/state-actions-reducer#state-update-through-reducer), which is much more practical than using lifecycle or chaining promises in actions

## In practice

Let's say we have a component that needs to fetch a `User` and then fetch their `Statistics`, which are identified by a value we might find in the payload of the first request.

First, we can write an interface file (`.rei`) that lets us define what we want to expose from the implementation file we're about to do:

```reason
type state;

type action;

let make = array(React.reactElement) =>
  React.component(state, React.noRetainedProps, action);
```

This will help the compiler notice dead code, and making `state` and `action` opaque to the outside world even enables us to check if action constructors ever used, enabling the removal of entire codepaths that aren't ever executed!

Now for the implementation file:

Define the state we want:

```reason
type state = {
  user: RequestStatus.t(Result.t(User.t, Errors.t)),
  statistics: RequestStatus.t(Result.t(Statistics.t, Errors.t)),
};
```

The actions that will occur:

```reason
type action =
  | LoadUser
  | ReceiveUser(Result.t(User.t, Errors.t))
  | LoadStatistics(string)
  | ReceiveStatistics(Result.t(Statistics.t, Errors.t));
```

Our initial state will look like this:

```reason
let initialState = {user: NotAsked, statistics: NotAsked};
```

So, we now have the basics! We can start writing our reducer:

```reason
let reducer = (action, state) =>
  switch (action) {
  /* show as loading, then start the request */
  | LoadUser =>
    UpdateWithSideEffects(
      {...state, user: Loading},
      (
        ({send}) =>
          User.get()->Future.get(payload => send(ReceiveUser(payload)))
      ),
    )
  /* when we find a statisticsKey, set the user and start the second request */
  | ReceiveUser(Ok({statisticsKey: Some(key)}) as user) =>
    UpdateWithSideEffects(
      {...state, user: Done(user)},
      (({send}) => send(LoadStatistics(key))),
    )
  /* otherwise just set the user */
  | ReceiveUser(user) => Update({...state, user: Done(user)})
  | LoadStatistics(key) =>
    UpdateWithSideEffects(
      {...state, statistics: Loading},
      (
        ({send}) =>
          Statistics.get(key)
          ->Future.get(payload => send(ReceiveStatistics(payload)))
      ),
    )
  | ReceiveStatistics(statistics) =>
    Update({...state, statistics: Done(statistics)})
  };
```

Pattern matching our actions is really interesting here:

- If the `User` request fails or doesn't contain a `statisticsKey`, we don't even bother querying `Statistics`: we just store the error or user in state, and can render UI accordingly
- We can easily see the request chaining

All that's left to do is a bit of pattern matching in our render function:

```reason
switch (state.user) {
| NotAsked => React.null
| Loading => <ActivityIndicator />
| Done(Error(error)) => <ErrorIndicator error />
| Done(Ok(user)) =>
  <>
    <UserCard user />
    {
      switch (state.statistics) {
      | NotAsked => React.null
      | Loading => <ActivityIndicator />
      | Done(Error(error)) => <ErrorIndicator error />
      | Done(Ok(statistics)) => <Stats statistics />
      }
    }
  </>
};
```
