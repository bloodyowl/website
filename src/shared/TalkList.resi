type talk = {
  date: string,
  name: string,
  description: string,
  url: string,
}

@react.component
let make: (~talks: array<(string, talk)>, unit) => React.element
