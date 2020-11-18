module Styles = {
  open Css;
  let container = style([padding2(~v=10->px, ~h=zero)]);
};

[@react.component]
let make = () => {
  let div =
    React.useMemo(() =>
      <div className=Styles.container> <div className="BeOpWidget" /> </div>
    );
  <>
    div
    <Pages.Head>
      <script>
        {js|window.beOpAsyncInit = function() {
        BeOpSDK.init({
          account: "556e1d2772a6b60100844051"
        });
        BeOpSDK.watch();
      };|js}
        ->React.string
      </script>
      <script src="https://widget.beop.io/sdk.js" />
    </Pages.Head>
  </>;
};
