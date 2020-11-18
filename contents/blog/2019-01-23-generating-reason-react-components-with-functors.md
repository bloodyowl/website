---
date: 2019-01-23
title: Generating ReasonReact components with functors
---

In JavaScript, React components can either be function or classes. This makes it easy to create functions that return components (factories if you will).

With ReasonReact though, if you want to use them with JSX, components need to be modules containing a `make` function, which is a much more static construct.

Fortunately, Reason (through OCaml) has a great feature which is called functors. Think of it as a **module function**: it **takes a module as parameter and returns a module**.

## The syntax

```reason
module Make = (Param: ParamType) => {
  /* contents of the module to return */
};
```

Let's define a `ParamType` first:

```reason
module type ParamType = {
  type t;
  let name: string;
  let render: t => React.reactElement;
};
```

Now, let's create our functor. The following example is very short and now really useful, its goal is simply to show the syntax. Where functors shine is with more complicated components, where you just want to write a simple configuration to generate a component (e.g. big virtualised, paginated lists, sortables etc.)

```reason
module Make = (Param: ParamType) => {
  type state = {
    value: Param.t,
  };
  let component = React.reducerComponent("Demo" ++ Param.name);
  let make = (~value: Param.t, _) => {
    ...component,
    initialState: () => {value: value},
    reducer: ((), _state) => React.NoUpdate,
    render: ({state}) =>
      <div style={ReactDOMRe.Style.make(~fontSize="32px", ())}>
        /* some markup */
         {Param.render(state.value)} </div>,
  };
};
```

Now, in order to create a component, we just have to create a module with `Make`:

```reason
module IntValue =
  Make({
    type t = int;
    let name = "Int";
    let render = x => x->string_of_int->React.string;
  });

ReactDOMRe.renderToElementWithId(<IntValue value=2 />, "preview");
```

[Test it on the ReasonML playground](https://reasonml.github.io/en/try?rrjsx=true&reason=LYewJgrgNgpgBAFwJ4Ad4AUCGAnTwAqq8AvHAN4BQciRiA3FXLAnAHZ4wBccAzgtgEtWAcwbVmcbDFZgY2bi2IA+OACUYmHiFbrMAYwQA6KfoQBRWMGkIGAXwYVQkWHACymANYk4ACiy5gbn88QjQASjhlckZkNF4ETARvMgA3TCgILjhg4EMEe0YJPRBgFG1rSLUNLR0NA2MYSD05AGESstZrHwAiABEYUG64AGph7Jw8Q3YrMLEmGBZgT28fAD80jKycvIAaOAB9CKjKampDc+LS8tYEHcZqIQEEAXSAZQSk7h8jlVT0zO4G0ytjup0kjQgzXkvm+e32fESMB+VU02l09QAciAAKooMCI0GnKQyORfMgIpK2H73U4AHjAAhS8SQsGIZHRCF6AHlXOpDO8WTBDEsvGsAGbaBCvAQALxgxG6AGYAEwoAAe3T23zCtiUNLBAHoAFS8ErwJbYDwQFBwI0G-VgsjbYmybA+ClCoFI2xwWkGhkpJSEgoFJzQeAASRuADV-iRGO5RSdTrF4Io4EIbDSJNNvN0owhunNxAtwSTsJU1ZEVGqALRKPiCET7EBi-aZ+u6GocwyNoSiRhUhwc7m8oUuuT4EAWAbWADqTwAFhGwD5aQXY5s4F7iMq4Aag3BuigpCkBDAAO7dWYUIA)
