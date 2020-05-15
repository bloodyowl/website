let suffix = title => title ++ " | @bloodyowl";

[@react.component]
let make = (~title, ~children, ()) => {
  React.useEffect1(
    () => {
      Seo.set(~title=title->suffix, ());
      None;
    },
    [|title|],
  );
  children;
};
