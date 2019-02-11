---
date: 2019-02-10
title: What is the option type, and what does it solve?
---

Most popular languages right now have a particular value called `null`, which represent the deliberate absence of a value (JS also has `undefined`, which pretty much works the same but has a slightly different purpose). 

With that in mind, most statically typed functional languages don't have a concept of `null`. They express it using a **variant type**. This particular type can be seen as a **little container** that wraps a value (or no value), and is generally called **option** or **maybe**. 

## The type itself

It looks like the following:

```reason
type option('value) =
  | None /* meaning no value */
  | Some('value) /* meaning one value of type `'value`*/
```

`'value` here is what we call a **type parameter**, and it enables types to be «generic»: it lets you or the language inference to refine it later. 

```reason
let isMyself = fun
  | Some("Matthias") => true
  | Some(_) | None => false;
```

Here, the function will have the following signature:

```reason
let isMyself: option(string) => bool;
                  /* ^ see? it got filled! */
```

These type parameters enable us to create generic abstractions over types. We can for instance create a `map` function for options:

```reason
let map = (opt, f) =>
  switch (opt) {
  | Some(x) => Some(f(x))
  | None => None
  };
```

This function can be used for any option! Let's look at the inferred signature:

```reason
let map: (option('a), 'a => 'b) => option('b);
```

This reads as:
- we have a map function
- it takes an option containing a value of type `a`
- it takes a function that takes a value of type `a` and returns a value of type `b`
- it returns an option containing a value of type `b`

As another exemple, here's a `flatMap` function for options:

```reason
let flatMap = (opt, f) =>
  switch (opt) {
  | Some(x) => f(x)
  | None => None
  };
/* let flatMap: (option('a), 'a => option('b)) => option('b); */
```

## What option solves

```js
let item = array.find(item => item === undefined || item.active)
```

This code will return:
- an object if an item with a truthy `active` field is found
- `undefined` if an `undefined` item is found
- `undefined` if nothing is found

As a result, we're unable to know in which case we are if we  receive `undefined` as return value.

_Please note that the problem would've been the same with `null` values in the array and some library `find` function that'd return `null`_. 

If we want to actually be able to differentiate the last two cases, we'd be forced to use another function, `findIndex`:

```js
let index = array.findIndex(item => item === undefined || item.active);
if(index == -1) {
  // not found
} else {
  // found
  let item = array[index];
}
```

That looks bulkier, and that's because the `find` function in this context doesn't give you enough information: the `undefined` is «swallowed», and you need to deduce it yourself using some extra-logic (here, the `index` where the item is found, because it returns `-1` when it doesn't find anything). 

The option type solves this problem quite elegantly. Where `null` **replaces** the value, `option` **wraps** it: it's a **container**. 

```reason
/* getBy is the equivalent of find */
let item = array->Belt.Array.getBy(
  fun
    | None => true
    | Some({active}) => active
);
```

First, `array` has the following type:

```reason
let array: array(option(value));
```

And `getBy` the following one:

```reason
let getBy: (array('a), 'a => bool) => option('a);
```

Let's replace the type parameter by the refined type so that we can see what we'll get:

```reason
let getBy:
  (
    array(option(value)),
    option(value) => bool
  ) => option(option(value));
```

`item`, the return value, will therefore have the following type:

```reason
let item: option(option(value));
```

It's an `option` of `option` of `value`. This means **we can extract what actually happened** from the return value:

- if the result is `Some(Some(value))`: we found a value with a `true` `active` field
- if the result is `Some(None)`: we found a value that's `None`
- if the result is `None`: we didn't find anything
