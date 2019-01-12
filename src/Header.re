let component = React.statelessComponent("Header");

module Styles = {
  open Css;
  let container =
    style([
      backgroundColor(Theme.lightBody->hex),
      display(flexBox),
      flexDirection(row),
      alignItems(stretch),
    ]);
  let heading =
    style([
      padding4(~left=zero, ~right=20->px, ~top=20->px, ~bottom=23->px),
      display(flexBox),
      flexDirection(row),
      alignItems(center),
      flexGrow(1.0),
      flexWrap(wrap),
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
      overflowX(auto),
      `declaration(("WebkitOverflowScrolling", "touch")),
    ]);
  let link =
    style([
      padding3(~h=20->px, ~top=20->px, ~bottom=23->px),
      flexShrink(0),
      textDecoration(none),
      color(Theme.darkBody->hex),
    ]);
  let activeLink = style([fontWeight(bold)]);
};

let make = _ => {
  ...component,
  render: _ =>
    <div className=Styles.container>
      <img
        src="/public/assets/images/owl.svg"
        width="32"
        height="32"
        alt=""
        className=Styles.logo
      />
      <div className=Styles.heading role="heading" ariaLevel=1>
        <div className=Styles.name> "Matthias Le Brun"->React.string </div>
        <div> "@bloodyowl"->React.string </div>
      </div>
      <div className=Styles.navigation>
        <Link
          className=Styles.link
          activeClassName=Styles.activeLink
          href="https://twitter.com/bloodyowl">
          "Twitter"->React.string
        </Link>
        <Link
          className=Styles.link
          activeClassName=Styles.activeLink
          href="https://github.com/bloodyowl">
          "GitHub"->React.string
        </Link>
      </div>
    </div>,
};
