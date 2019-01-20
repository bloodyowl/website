const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const CopyWebpackPlugin = require("copy-webpack-plugin");
const outputDir = path.join(__dirname, "build/");

const isProd = process.env.NODE_ENV === "production";

module.exports = {
  entry: "./src/Main.bs.js",
  mode: isProd ? "production" : "development",
  output: {
    path: outputDir,
    publicPath: "/",
    filename: "app.js"
  },
  plugins: [
    new CopyWebpackPlugin([
      { from: "**/*", to: "./public", context: "./public" }
    ]),
    new HtmlWebpackPlugin({
      template: "src/index.html"
    }),
    new HtmlWebpackPlugin({
      template: "src/index.html",
      filename: "prerender/__source.html",
    }),
  ],
  devServer: {
    compress: true,
    contentBase: outputDir,
    port: process.env.PORT || 8000,
    historyApiFallback: true
  }
};
