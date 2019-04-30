open Belt;

let component = ReasonReact.statelessComponent("BlogPostList");

module Styles = {
  open Css;
  let container =
    style([
      maxWidth(600->px),
      padding2(~v=zero, ~h=10->px),
      margin2(~v=20->px, ~h=auto),
      width(100.->pct),
      flexGrow(1.),
    ]);
  let link =
    style([
      padding2(~v=10->px, ~h=zero),
      fontSize(26->px),
      color(Theme.darkBody->hex),
      textDecoration(none),
      display(flexBox),
      flexDirection(column),
    ]);
  let date = style([fontSize(12->px), opacity(0.5)]);
  let title = style([fontWeight(bold)]);
};

[@react.component]
let make =
    (
      ~list: RequestStatus.t(Result.t(array(PostShallow.t), Errors.t)),
      ~onLoadRequest,
      (),
    ) => {
  ReactCompat.useRecordApi({
    ...component,
    didMount: _ =>
      switch (list) {
      | NotAsked => onLoadRequest()
      | _ => ()
      },
    render: _ =>
      <>
        {switch (list) {
         | NotAsked
         | Loading => <ActivityIndicator />
         | Done(Ok(list)) =>
           <WithTitle title="Blog">
             <div className=Styles.container>
               {list
                ->Array.map(item =>
                    <Link
                      className=Styles.link
                      key={item.slug}
                      href={"/blog/" ++ item.slug ++ "/"}>
                      <>
                        <div className=Styles.date>
                          {item.date
                           ->Js.Date.fromString
                           ->Date.getFormattedString
                           ->ReasonReact.string}
                        </div>
                        <div className=Styles.title>
                          item.title->ReasonReact.string
                        </div>
                      </>
                    </Link>
                  )
                ->ReasonReact.array}
             </div>
           </WithTitle>
         | Done(Error(_)) => <ErrorIndicator />
         }}
      </>,
  });
};
