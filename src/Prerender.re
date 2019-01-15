module Emotion = {
  [@bs.module "emotion-server"] [@bs.val]
  external renderStylesToString: string => string = "renderStylesToString";
};

let index = Node.Fs.readFileSync("./build/index.html", `utf8);

let prerendered =
  Emotion.renderStylesToString(ReactDOMServerRe.renderToString(<App />));

Node.Fs.writeFileAsUtf8Sync(
  "./build/index.html",
  index->Js.String.replace(
           {|<div id="root"></div>|},
           {j|<div id="root">$prerendered</div>|j},
           _,
         ),
);
