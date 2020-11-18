open Belt;

module Styles = {
  open Css;
  let container =
    style([
      maxWidth(620->px),
      padding2(~v=zero, ~h=10->px),
      margin2(~v=20->px, ~h=auto),
      width(100.->pct),
      flexGrow(1.),
    ]);
  let link =
    style([
      padding(10->px),
      fontSize(20->px),
      color(Theme.darkBody->hex),
      textDecoration(none),
      display(flexBox),
      flexDirection(column),
      borderRadius(10->px),
      hover([backgroundColor(rgba(0, 0, 0, `num(0.03)))]),
      active([backgroundColor(rgba(0, 0, 0, `num(0.05)))]),
    ]);
  let date = style([fontSize(12->px), opacity(0.5)]);
  let title = style([fontWeight(bold)]);
};

[@react.component]
let make = () => {
  let list = Pages.useCollection("blog");
  <>
    {switch (list) {
     | NotAsked
     | Loading => <ActivityIndicator />
     | Done(Ok({items: list})) =>
       <>
         <Pages.Head> <title> "Blog"->React.string </title> </Pages.Head>
         <div className=Styles.container>
           {list
            ->Array.map(item =>
                <Pages.Link
                  className=Styles.link
                  key={item.slug}
                  href={"/blog/" ++ item.slug ++ "/"}>
                  <>
                    <div className=Styles.date>
                      {item.date
                       ->Option.map(Js.Date.fromString)
                       ->Option.map(Date.getFormattedString)
                       ->Option.map(ReasonReact.string)
                       ->Option.getWithDefault(React.null)}
                    </div>
                    <div className=Styles.title>
                      item.title->ReasonReact.string
                    </div>
                  </>
                </Pages.Link>
              )
            ->ReasonReact.array}
         </div>
       </>
     | Done(Error(_)) => <ErrorIndicator />
     }}
  </>;
};
