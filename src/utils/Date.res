let padLeft = value =>
  switch String.length(value) {
  | 1 => "0" ++ value
  | _ => value
  }

let getFormattedString = date =>
  Js.Date.getUTCFullYear(date)->int_of_float->string_of_int ++
    ("/" ++
    ((Js.Date.getUTCMonth(date)->int_of_float + 1)->string_of_int->padLeft ++
      ("/" ++
      Js.Date.getUTCDate(date)->int_of_float->string_of_int->padLeft)))
