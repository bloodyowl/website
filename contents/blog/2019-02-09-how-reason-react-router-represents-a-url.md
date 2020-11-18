---
date: 2019-02-09
title: How ReasonReact.Router represents a URL
---

ReasonReact embeds a small router out of the box.

Its API surface is smaller than most solutions you can find out there, but it leverage some languages data-structures in an interesting way, particularly in how it represents URL paths.

Here's how it looks:

```reason
type url = {
  path: list(string),
  search: string,
  hash: string,
};
```

The most interesting part here is the way path is represented: a list, with each item in it being a segment (separated by `/`).

Lists in OCaml/ReasonML are **linked lists**, which means they are composed roughly that way:

```reason
type list('a) =
  | Empty
  | One('a, list('a)); /* look! it's a recursive type */
```

The rest of the list (or _tail_) is another list! And you can loop through it using recursion and pattern matching:

```reason
let rec map = (list, f) =>
  switch (list) {
  | Empty => Empty /* we're at the end, return empty*/
  | One(x, rest) =>
    One(f(x), map(rest, f)) /* tranform x, and map the rest*/
  };
```

In ReasonML, there's syntactic sugar for that: the equivalent of `Empty` is `[]`, and of `One(x, rest)` is `[x, ...rest]` (and `x :: rest` in OCaml).

So `map` would in reality look like:

```reason
let rec map = (list, f) =>
  switch (list) {
  | [] => []
  | [x, ...rest] => [f(x), ...map(rest, f)]
  };
```

In the context of a router, lists are pretty interesting too, as URL paths generally represent **depth** (e.g. `/users/id` is one level deeper than `/users`):

```reason
switch (url.path) {
| [] => <Home />
| ["me", ...subPath] => <Settings id=me.id subPath />
| ["users", id, "settings", ...subPath] => <Settings id subPath />
| _ => <NotFound />
};
```

You can handle subroutes in a descendant by passing down the tail of the path! And nice side effect: because you just take the list after an item, **you don't allocate anything**: you just pass tail the list itself.
