---
date: 2019-04-19
title: An alternative migration path for ReasonReact
---

## Why the new API?

ReasonReact 0.7.0 came out recently, with a really nice set of features:

- A closer model from the official ReactJS API
- Hooks
- Zero-cost bindings

From some time now though, ReasonReact leverages function **named parameters** which provides a really nice set of features natively, such as defaults, optional parameters and ability to pattern match values.

This was possible through a JSX transformation and some bindings that would apply these arguments at call site, and return a new version of the component whenever called.

A component would look like this:

```reason
/* MyComp.re */
let make = (~param1, ~param2, children) => {
  ...component,
  render: _ => <div />
};
```

And the call site `<MyComp param1 param2 />` would desugar to something like this:

```reason
React.element(~key, ~ref, MyComp.make(~param1, ~param2, [||] /* children*/))
```

and would reuse the previous component through some magic in `React.element`, by keeping a reference to an actual React component class that'd render using the component spec it received.

This magic worked while relying on the class-based API, because it wouldn't matter that the `make` function had a different identity at each run, as `React.createElement` effectively received class.

With function component though, the story is a little different: **function identity matters** here. It'd be possible to wrap every component with a higher order one, but that wouldn't make for a good developer experience, and would possibly be a little heavier to run.

The obvious choice would then be to start using directly the JS Object as props, just like in ReactJS. However, that wouldn't let us benefit from the really nice features function params give us (defaults, optionals, pattern matching…).

Therefore was introduced the `[@react.component]` attribute. What it does in summary:

```reason
[@react.component]
let make = (~prop1, ~prop2, ()) => {
  <div />
};
```

is that it leverages `[@bs.obj]` (zero-cost except in edge-cases) and roughly generates the following:

```reason
let makeProps: (~prop1, ~prop2, unit) =>
  {. "prop1": 'a, "prop2": 'b};

let make: ({. "prop1": 'a, "prop2": 'b}) =>
  React.element;
```

This way, the new JSX API can simply desugar to:

```reason
React.createElement(MyComp.make, MyComp.makeProps(~prop1, ~prop2, ()));
```

which is, thanks to BuckleScript, compiled to:

```js
React.createElement(MyComp.make, { prop1: prop1, prop2: prop2 });
```

## Planning the migration

Of course, changing the way JSX works must have been a tough call for the ReasonReact team, as the API has been pretty stable for some time before that, but I'm sure the benefits in the long run will be really important.

Now, how do we handle the transition?

The original plan [Ricky Vetter](https://twitter.com/rickyvetter) had was to create a hook that'd wrap the old component specs and act as a compatibility API. In the end, he assessed that this way wouldn't be able to provide a script that'd be safe enough for people to use and provided a different kind of migration path.

I really found the idea to be elegant though, and if I ever released it and it was a bit rough around the edges, people wouldn't be as mad as they would've been with an official migration.

So I went on from Ricky's work, patched a few things and made [reason-react-compat](https://github.com/bloodyowl/reason-react-compat). The main concept is that it replicates the lifecycle using hooks. It has of course some small issues, such as retriggering a render each time you send a side-effect and might be a little aggressive on `willReceiveProps` (treat it as it was `getDerivedStateFromProps`). Other than that it should mostly work, and these are tradeoffs I'm personnaly willing to make for my own codebase.

After having that, I wanted to make an automated codemod, and ended up with the following list of what it needed to do (lots of points here are motivated by how my internal codebase is made):

- Add `[@react.component]` to `make` functions returning a `component` in implementation
- Wrap these components with `ReactCompat.useRecordApi`
- Turn ignored `children` (starting with `_`) to `unit` in implementation
- Turn used `children` into a named parameter and append a `unit` parameter in implementation
- Use `React.Children.toArray` at the top of every make function's body that use them as such (children type isn't guaranteed to be `array(React.element)` anymore)
- Add `[@react.component]` to `make` functions returning a `component` in interfaces
- Turn `array(React.element)` into `React.element` for children in interfaces
- Turn `React.component(a, b, c)` and `React.componentSpec(a, a, b, b, c, c)` into `React.element` in interfaces' `make` return value
- Handle all of the above for nested modules and functors

So I forked Cheng Lou's [upgrade-reason-react](https://github.com/chenglou/upgrade-reason-react) and started working with the AST (it's really fun, you should try it!) and ended up a decent transformation (at least for my test cases). If you're interested, the above transformation script is available [on GitHub](https://github.com/bloodyowl/upgrade-reason-react), you can check the input in `test/cases` and output in `output/test/cases`.

While I was at it, I also released a `useReducer` hook that allows returning an update (`NoUpdate`, `Update`, `UpdateWithSideEffects` or `SideEffects`) because I find that to be on[e of the best way to orchestrate things in your components](/blog/2019-01-24-orchestrating-requests-at-component-level/), you can check it out in [its repository](https://github.com/bloodyowl/reason-react-update).

If you want to try these, be sure to ping me in Twitter, Discord or GitHub if you run into any issue!
