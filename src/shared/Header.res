module Styles = {
  open Css
  let container = style(list{
    backgroundColor(Theme.lightBody->hex),
    media("(prefers-color-scheme: dark)", list{backgroundColor("111"->hex)}),
    display(flexBox),
    flexDirection(row),
    alignItems(stretch),
    flexWrap(wrap),
    media("(max-width: 620px)", list{flexDirection(column)}),
  })
  let left = style(list{
    display(flexBox),
    flexDirection(row),
    alignItems(stretch),
    flexWrap(wrap),
    flexGrow(1.0),
    color(Theme.darkBody->hex),
    media("(prefers-color-scheme: dark)", list{color(Theme.lightBody->hex)}),
    textDecoration(none),
  })
  let heading = style(list{
    padding4(~left=zero, ~right=20->px, ~top=20->px, ~bottom=23->px),
    display(flexBox),
    flexDirection(row),
    alignItems(center),
    flexGrow(1.0),
  })
  let name = style(list{fontWeight(bold), marginRight(10->px), whiteSpace(nowrap)})
  let logo = style(list{marginRight(10->px), marginLeft(20->px), alignSelf(center)})
  let navigation = style(list{
    display(flexBox),
    flexDirection(row),
    alignItems(center),
    media("(max-width: 620px)", list{flexGrow(1.), backgroundColor("D4E1E6"->hex)}),
    media("(max-width: 620px) and (prefers-color-scheme: dark)", list{backgroundColor("111"->hex)}),
  })
  let link = style(list{
    padding3(~h=20->px, ~top=20->px, ~bottom=23->px),
    flexShrink(0.0),
    textDecoration(none),
    color(Theme.darkBody->hex),
    media("(prefers-color-scheme: dark)", list{color(Theme.lightBody->hex)}),
    textAlign(center),
    media(
      "(max-width: 620px)",
      list{flexBasis(25.0->pct), padding3(~h=10->px, ~top=10->px, ~bottom=13->px)},
    ),
  })
  let activeLink = style(list{fontWeight(bold)})
}

@react.component
let make = () =>
  <div className=Styles.container>
    <Pages.Link className=Styles.left href="/">
      {<>
        <img
          src="/public/assets/images/owl.svg" width="32" height="32" alt="" className=Styles.logo
        />
        <div className=Styles.heading role="heading" ariaLevel=1>
          <div className=Styles.name> {"Matthias Le Brun"->React.string} </div>
          <div> {"@bloodyowl"->React.string} </div>
        </div>
      </>}
    </Pages.Link>
    <div className=Styles.navigation>
      <Pages.Link
        className=Styles.link activeClassName=Styles.activeLink matchSubroutes=true href="/blog/">
        {"Blog"->React.string}
      </Pages.Link>
      <a className=Styles.link href="https://twitter.com/bloodyowl"> {"Twitter"->React.string} </a>
      <a className=Styles.link href="https://github.com/bloodyowl"> {"GitHub"->React.string} </a>
      <a className=Styles.link href="https://www.linkedin.com/in/bloodyowl">
        {"LinkedIn"->React.string}
      </a>
    </div>
  </div>
