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
  let component = React.statelessComponent("Demo" ++ Param.name);
  let make = (~value: Param.t, _) => {
    ...component,
    render: _ =>
      <div style={ReactDOMRe.Style.make(~fontSize="32px", ())}>
        /* some markup */
         {Param.render(value)} </div>,
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

[Test it on the ReasonML playground](https://reasonml.github.io/en/try?rrjsx=true&reason=LYewJgrgNgpgBAFwJ4Ad4AUCGAnTwAqq8AvHAN4BQciRiA3FXLAnAHZ4wBccAzgtgEtWAcwbVmcbDFZgY2bi2IA+OACUYmHiFbrMAYwQA6KfoQBRWMGkIGAXwYVQkWHACymANYk4ACiy5gbn88QjQASjhlckYJPRBgFG1rSLUNLR0NA0M+TAQYWB4eAGF4xNZrHwAiABEYUEq4AGpGuGDgQ3YrMLEmGBZgT28fAD8AN0woCC5WnDxDBAAaOAB9CKjKampDbbiEpNZFxmopGTluZcilI82AHjABUd5kWGIyXQNqgHlXdUMAZWeMEMAy8IwAZtoEH8BAAvGDESoAZgATCgAB6VJY+MJhWxXTYEuAAegAVLx4vABtgPBAUHASUTroSyG1jNJZNgfONJjBcXAbkT7qMlAtGPYKOLHOBoPAAJIHABqEymkUY7lBG02yDQiBSQhs1wknW8lXlCEqPXEfUk7LkKTRlzgaIAtEo+IIRMsQGDlvrXbp0u8jO6hKIxd0KBQg18fkCThz8CALHVrAB1AQIAAWsrAPhuZqVPLg3KmxGRxJFcEqKCkowEMAA7pUI0A)
