---
date: 2019-01-22
title: Static single page application
---

As you can see from the URL, this little website is hosted on GitHub pages, meaning it can only be static. 

The approach I chose here was to build it like a single page application that I'd render at build time. 

This approach gives the best of both worlds :

- an familiar and powerful way to build UIs
- a fast initial load
- a fast navigation after the first load: any transition that occur after will only query the smallest amount data it possibly can in order to render the next route

## Getting the data for the blog

I have a blog direction with markdown files. In order to get them, I made a few bindings to glob, remarkable and front-matter so that I can transform posts into two kinds of records:

```reasonml
module PostShallow = {
  type t = {
    title: string,
    date: string,
    slug: string,
  };
};

module Post = {
  type t = {
    title: string,
    date: string,
    body: string,
  };
};
```

`postShallow` will be used in listings, and `post` for the detail page. 

## The routing

Given I use ReasonReact, I use the builtin Router solution. At first it was in my `App` component state. 

```reasonml
let component = React.reducerComponent("App");

let make = (_) => {
  ...component,
  initialState: () => React.Router.dangerouslyGetInitialUrl(),
  reducer: (action, _state) =>
    switch action {
    | SetRoute(url) => Update(url)
    },
  /* ... */
}
```

In order to make it statically renderable, I moved it from `state` to props. I now have a `Main` module with a recursive render function that calls itself whenever there's a URL change. 

```reasonml
let rec render = (~url=React.Router.dangerouslyGetInitialUrl(), ()) => {
  /* render logic here */
  let watcherId = ref(None);
  watcherId :=
    Some(
      React.Router.watchUrl(url => {
        (watcherId^)
        ->Option.map(watcherId => React.Router.unwatchUrl(watcherId))
        ->ignore;
        render(~url, ());
      }),
    );
}
```

This render function will only be used on the client. At build time we'll call App directly. An important thing to remember here is that your CSS reset needs to be in App, otherwise it'll only be called once the client boots. 

## The data

Initially I planned to put data in route component states themselves, but this would've required extra steps in serialisation I didn't want to take for such a simple project. 

I simply moved the data up the `App` component state, and passed two things to the routes:

- the data they need
- a callback to set this data when received

The app state actually looks quite simple:

```reasonml
type state = {
  posts: Map.String.t(RequestStatus.t(Result.t(Post.t, Errors.t))),
  postList: RequestStatus.t(Result.t(array(PostShallow.t), Errors.t)),
};
```

This way, only App is changed when the store shape changes. I could've passed the initial data so that routes can hydrate their initial state, but that would defeat the purpose for an efficient loading experience: it would've refreshed the data every time the route mounts instead of keeping it. 

## The styles

I use [bs-css](https://github.com/SentiaAnalytics/bs-css), which recently switched to emotion. It simply required to write a little binding to emotion-server in order to render styles on the server. 

```reasonml
module Emotion = {
  [@bs.module "emotion-server"]
  external renderStylesToString: string => string = "renderStylesToString";
};
```

## Hydration

For the hydration, I just check if my root element is empty and hydrate instead of render if it's not. 

```reasonml
let markup =
  DomRe.(
    Document.getElementById("root", document)
    ->Option.map(Element.innerHTML)
    ->Option.flatMap(item => item == "" ? None : Some(item))
  );
  
switch (markup) {
| Some(_) =>
  ReactDOMRe.hydrateToElementWithId(<App url ?initialData />, "root")
| None =>
  ReactDOMRe.renderToElementWithId(<App url ?initialData />, "root")
};
```

## Prerender all the pages

First, I render a dummy HTML file using html-webpack-plugin, it'll be used as a template for all the pages. The plugin will just add the right app JS. 

I just list all pages with their URLs and the App state they need to render, and replace elements from the template with the rendered HTML, title and initial data and write files in the build directory. 

```reasonml
Node.Fs.writeFileAsUtf8Sync(
  "./build/" ++ String.concat("/", path) ++ "/index.html",
  index
  ->Js.String.replace(
      {|<div id="root"></div>|},
      {j|<div id="root">$prerendered</div><script id="data">window.initialData = $data</script>|j},
      _,
    )
  ->Js.String.replace(
      {|<title>TITLE</title>|},
      {j|<title>$title | @bloodyowl</title><meta property="og:title" content="$title | @bloodyowl" />|j},
      _,
    ),
);
```
