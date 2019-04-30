open Belt;

type talk = {
  date: string,
  name: string,
  description: string,
  url: string,
};

let component = ReasonReact.statelessComponent("TalkList");

module Styles = {
  open Css;
  let item = style([padding2(~v=10->px, ~h=zero)]);
  let link = style([textDecoration(none), color(Theme.darkBody->hex)]);
  let date = style([opacity(0.5), fontSize(14->px)]);
  let name =
    style([fontSize(20->px), paddingBottom(5->px), fontWeight(bold)]);
  let description = style([fontSize(14->px)]);
};

[@react.component]
let make = (~talks, ()) =>
  ReactCompat.useRecordApi({
    ...component,
    render: _ =>
      <div role="list">
        {talks
         ->Array.map(((id, talk)) =>
             <div key=id className=Styles.item role="listitem">
               <a href={talk.url} className=Styles.link>
                 <div className=Styles.date>
                   talk.date->ReasonReact.string
                 </div>
                 <div className=Styles.name>
                   talk.name->ReasonReact.string
                 </div>
                 <div className=Styles.description>
                   talk.description->ReasonReact.string
                 </div>
               </a>
             </div>
           )
         ->ReasonReact.array}
      </div>,
  });
