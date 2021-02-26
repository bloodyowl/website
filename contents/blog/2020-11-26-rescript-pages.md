---
title: ReScript Pages
date: 2020-11-26
---

Last year, I wrote about how this [static single application](/blog/2019-01-22-static-single-page-application) was built. From that time, I had to build several static websites, and at some point had to make them simpler to use.

The main websites I've built with the previous solutions are quite different:
- [This website](https://bloodyowl.io), which is fairly simple and just has a blog and a static page
- [Putain de code!](https://putaindecode.io), which has a bit more content
- [BeOp](https://beop.io), our company website, which needs i18n, and requires more ease of use, as not only tech people work on it

<img alt="BeOp" src="/public/assets/images/beop.png" width="2644" height="1644" />

I recently rebuilt the latter, and wanted to share the resources between the three. I believe that in development, it is good to **repeat yourself** at first, observe what time does, **then** commonise what you can. 

So I started creating a shared «framework» that'd work on the three websites: [ReScript Pages](https://github.com/bloodyowl/rescript-pages).

Fundamentally, the principles from [the previous post](/blog/2019-01-22-static-single-page-application) apply, except it's _a bit_ more flexible and complete.

## 1. A user-friendly dev server

My previous solution made you run a command after updating some files so that you could preview. That was annoying in the long run. ReScript Pages includes a dev server with a live reload.

<video style="width:100%" src="/public/assets/videos/dev.mov" controls>
</video>

## 2. Same experience in dev

The dev server gives you the pre-rendered page: no surprises with hydration. 

## 3. i18n native support

The configuration gives you `variants` for each language you have. The various paths and subdirectories are handled without needing to do anything else: all your links will work without needing to touch anything.

```reason
let default =
  Pages.make(
    make,
    {
      siteTitle: "Matthias Le Brun",
      siteDescription: "Front-end developer and designer. ReasonML, ReasonReact, ReactJS.",
      mode: SPA,
      distDirectory: "dist",
      baseUrl: "https://bloodyowl.io",
      staticsDirectory: Some("statics"),
      paginateBy: 20,
      variants: [|
        {
          subdirectory: None,
          localeFile: None,
          contentDirectory: "contents",
          getUrlsToPrerender: ({getAll}) =>
            Array.concatMany([|
              [|"/", "blog"|],
              getAll("blog")->Array.map(slug => "/blog/" ++ slug),
              [|"404.html"|],
            |]),
        },
      |],
    },
  );
```

## 4. Easy SEO & styling

I've embedded [react-helmet](https://github.com/nfl/react-helmet) and [bs-css](https://github.com/reasonml-labs/bs-css) so that everything can be pre-rendered properly, with all the good parts in.

## 5. A damn simple API

Here's the actual component displaying this very page:

```reason
[@react.component]
let make = (~slug, ()) => {
  let post = Pages.useItem("blog", ~id=slug);
  <>
    {switch (post) {
     | NotAsked
     | Loading => <ActivityIndicator />
     | Done(Ok(post)) =>
       <>
         <Pages.Head> <title> post.title->React.string </title> </Pages.Head>
         <div className=Styles.container>
           <h1 className=Styles.title> post.title->ReasonReact.string </h1>
           <div className=Styles.date>
             {post.date
              ->Option.map(Js.Date.fromString)
              ->Option.map(Date.getFormattedString)
              ->Option.map(ReasonReact.string)
              ->Option.getWithDefault(React.null)}
           </div>
           <div
             className=Styles.body
             dangerouslySetInnerHTML={"__html": post.body}
           />
           <BeOpWidget />
         </div>
       </>
     | Done(Error(_)) => <ErrorIndicator />
     }}
  </>;
};
```

React Hooks really have unlocked a way to make **APIs that look and feel simple**.

## 6. Some bonus features

- RSS feed generation
- Sitemap generation
- Post scheduling support

## Conclusion

Overall it's been a really fun project to build (and also a bit frustrating, let's be honest, tweaking complex path resolutions, utterly complex webpack configs and flexible data-stores isn't always a pleasure).

If you're curious, don't hesitate to check:

- [ReScript Pages docs](https://bloodyowl.github.io/rescript-pages/)
- [ReScript Pages source](https://github.com/bloodyowl/rescript-pages)
- [This website source](https://github.com/bloodyowl/website)

Hope you like it! 👋