open Belt;
open DomRe;

let markup =
  Document.getElementById("root", document)
  ->Option.map(Element.innerHTML)
  ->Option.flatMap(item => item == "" ? None : Some(item));

switch (markup) {
| Some(_) => ReactDOMRe.hydrateToElementWithId(<App />, "root")
| None => ReactDOMRe.renderToElementWithId(<App />, "root")
};
