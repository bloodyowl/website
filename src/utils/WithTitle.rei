type action;

type state;

let suffix: string => string;

[@react.component]
let make: (~title: string, ~children: React.element, unit) => React.element;
