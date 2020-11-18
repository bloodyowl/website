module Styles = {
  open Css;
  let container =
    style([
      backgroundColor(Theme.lightBody->hex),
      display(flexBox),
      flexDirection(row),
      alignItems(stretch),
      flexWrap(wrap),
      media("(max-width: 620px)", [flexDirection(column)]),
    ]);
  let left =
    style([
      display(flexBox),
      flexDirection(row),
      alignItems(stretch),
      flexWrap(wrap),
      flexGrow(1.0),
      color(Theme.darkBody->hex),
      textDecoration(none),
    ]);
  let heading =
    style([
      padding4(~left=zero, ~right=20->px, ~top=20->px, ~bottom=23->px),
      display(flexBox),
      flexDirection(row),
      alignItems(center),
      flexGrow(1.0),
    ]);
  let name =
    style([fontWeight(bold), marginRight(10->px), whiteSpace(nowrap)]);
  let logo =
    style([marginRight(10->px), marginLeft(20->px), alignSelf(center)]);
  let navigation =
    style([
      display(flexBox),
      flexDirection(row),
      alignItems(center),
      media(
        "(max-width: 620px)",
        [flexGrow(1.), backgroundColor("D4E1E6"->hex)],
      ),
    ]);
  let link =
    style([
      padding3(~h=20->px, ~top=20->px, ~bottom=23->px),
      flexShrink(0.0),
      textDecoration(none),
      color(Theme.darkBody->hex),
      textAlign(center),
      media(
        "(max-width: 620px)",
        [
          flexBasis(33.333->pct),
          padding3(~h=20->px, ~top=10->px, ~bottom=13->px),
        ],
      ),
    ]);
  let activeLink = style([fontWeight(bold)]);
};

[@react.component]
let make = () => {
  <div className=Styles.container>
    <Pages.Link className=Styles.left href="/">
      <>
        <img
          src="/public/assets/images/owl.svg"
          width="32"
          height="32"
          alt=""
          className=Styles.logo
        />
        <div className=Styles.heading role="heading" ariaLevel=1>
          <div className=Styles.name>
            "Matthias Le Brun"->ReasonReact.string
          </div>
          <div> "@bloodyowl"->ReasonReact.string </div>
        </div>
      </>
    </Pages.Link>
    <div className=Styles.navigation>
      <Pages.Link
        className=Styles.link
        activeClassName=Styles.activeLink
        matchSubroutes=true
        href="/blog/">
        "Blog"->ReasonReact.string
      </Pages.Link>
      <Pages.Link
        className=Styles.link
        activeClassName=Styles.activeLink
        href="https://twitter.com/bloodyowl">
        "Twitter"->ReasonReact.string
      </Pages.Link>
      <Pages.Link
        className=Styles.link
        activeClassName=Styles.activeLink
        href="https://github.com/bloodyowl">
        "GitHub"->ReasonReact.string
      </Pages.Link>
    </div>
  </div>;
};
