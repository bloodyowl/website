open Belt;

module Emotion = {
  [@bs.module "emotion-server"] [@bs.val]
  external renderStylesToString: string => string = "renderStylesToString";
};

let index = Node.Fs.readFileSync("./build/index.html", `utf8);

let urls = [[]];

urls->List.forEach(path => {
  let prerendered =
    Emotion.renderStylesToString(
      ReactDOMServerRe.renderToString(
        <App url={path, search: "", hash: ""} />,
      ),
    );

  Node.Fs.writeFileAsUtf8Sync(
    "./build/" ++ String.concat("/", path) ++ "index.html",
    index->Js.String.replace(
             {|<div id="root"></div>|},
             {j|<div id="root">$prerendered</div>|j},
             _,
           ),
  );
});
