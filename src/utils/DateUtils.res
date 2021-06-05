let padLeft = value =>
  switch String.length(value) {
  | 1 => "0" ++ value
  | _ => value
  }

let getFormattedString = date =>
  Date.getUTCFullYear(date)->Int.toString ++
  "/" ++
  (Date.getUTCMonth(date) + 1)->Int.toString->padLeft ++
  "/" ++
  Date.getUTCDate(date)->Int.toString->padLeft
