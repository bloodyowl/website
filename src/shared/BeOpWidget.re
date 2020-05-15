module Styles = {
  open Css;
  let container = style([padding2(~v=10->px, ~h=zero)]);
};

[@react.component]
let make = () => {
  React.useMemo(() =>
    <div className=Styles.container> <div className="BeOpWidget" /> </div>
  );
};
