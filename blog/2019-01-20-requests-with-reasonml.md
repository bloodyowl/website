---
date: 2019-01-20
title: Requests with ReasonML
---

> This is how I choose to represent requests in my ReasonReact apps, there might be different ways that work well for you, but if this is something that you struggle with, that could be a good introduction to see how sum types can help you.

Given there's no union type in JavaScript, we tend to use the following representation to store a request status in a component state

```javascript
/* pseudo code */
type state(data, error) = {
  isLoading: bool,
  error: nullable(error),
  data: nullable(data)
};
```

and do something like this:

```javascript
User.get((error, data) => {
  if (error) {
    setState({ isLoading: false, error });
  } else {
    setState({ isLoading: false, data });
  }
});
/* or */
User.get().then(
  data => setState({ isLoading: false, data }),
  error => setState({ isLoading: false, error })
);
```

This pattern has two unfortunate consequences. The first one is that **you can represent impossible states** with it:

| isLoading | error   | data   | Is possible? |
| --------- | ------- | ------ | ------------ |
| `FALSE`   | `NULL`  | `NULL` | ✅           |
| `TRUE`    | `NULL`  | `NULL` | ✅           |
| `FALSE`   | `ERROR` | `NULL` | ✅           |
| `TRUE`    | `ERROR` | `NULL` | ❌           |
| `FALSE`   | `NULL`  | `DATA` | ✅           |
| `TRUE`    | `NULL`  | `DATA` | ❌           |
| `FALSE`   | `ERROR` | `DATA` | ❌           |
| `TRUE`    | `ERROR` | `DATA` | ❌           |

The other one is that it makes you mix two different things:

- the request **temporal** status
- the request **success** status

## Representing the request status

Typed functional language often have a `Result` or `Either` type. A result can be:

- `Ok`, I have this data
- `Error`, here what's faield

```reason
type result('ok, 'error) =
  | Ok('ok)
  | Error('error);
```

## Representing the request temporal status

A request can be **inactive** (or "not asked"), **loading** or **done**. Let's create a type that fits that definition:

```reason
module RequestStatus = {
  type t('a) =
    | NotAsked
    | Loading
    | Done('a);
};
```

## Combining the two

```reason
type state = {
  user: RequestStatus.t(Result.t(User.t, UserError.t)),
};

type action =
  | LoadUser
  | ReceiveUser(Result.t(User.t, UserError.t));
```

In **state**, we need to have a representation at any point in time, so we need to wrap the `Result` in a `RequestStatus` type.

In **action**, `Load` and `Receive` already express temporality, `Receive` will only need to contain the **request success status**.

One big advantage of this approach is that we don't need to transform the success status in order to store it in the state, we only need to wrap it in a `RequestStatus`, meaning we only need one codepath in trivial situations.

In my component's reducer, I'll have something like the following:

```reason
switch (action) {
| LoadUser =>
  UpdateWithSideEffects(
    {user: Loading},
    (
      ({send}) =>
        User.query(payload => send(ReceiveUser(payload)))
    ),
  )
| ReceiveUser(payload) => Update({user: Done(payload)})
};
```

In my render function, I can then simply pattern match and have exhaustivity checks for free:

```reason
switch (state.user) {
| NotAsked => <Button onPress=(() => send(LoadUser)) title="Load" />
| Loading => <ActivityIndicator />
| Done(Error(error)) => <ErrorIndicator error />
| Done(Ok(user)) => <UserCard user />
};
```
