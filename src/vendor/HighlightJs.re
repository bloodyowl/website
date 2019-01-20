[@bs.module "highlight.js"]
external highlightAuto: string => {. "value": string} = "highlightAuto";

[@bs.module "highlight.js"]
external highlight: (~lang: string, string) => {. "value": string} =
  "highlight";
