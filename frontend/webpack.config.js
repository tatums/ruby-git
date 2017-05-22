const webpack = require('webpack')
const path = require('path')

function root(__path) {
  return path.join(__dirname, __path);
}

module.exports = {
  entry: './src/main.js',
  output: {
    path: __dirname + '/dist',
    filename: "bundle.js"
  },
  plugins: [
    new webpack.ContextReplacementPlugin(
      // The (\\|\/) piece accounts for path separators in *nix and Windows
      /angular(\\|\/)core(\\|\/)(esm(\\|\/)src|src)(\\|\/)linker/,
      root('./src'), // location of your src
      { }
    )
  ],
  module: {
    loaders: [

      // load and compile javascript
      { test: /\.js$/, exclude: /node_modules/, loader:"babel-loader" },

      // load scss
      { test: /\.scss$/, exclude: /node_modules/, loader: 'raw-loader!sass-loader' },

      // load css and process less
      { test: /\.css$/, loader: "style!css"},

      // load JSON files and HTML
      { test: /\.json$/, loader: "json" },
      { test: /\.html$/, exclude: /node_modules/, loader:"html-loader" },
      //{ test: /\.html$/, exclude: /node_modules/, loader:"raw-loader" },

      // load fonts(inline base64 URLs for <=8k)
      { test: /\.(ttf|eot|svg|otf)$/, loader: "file" },
      { test: /\.woff(2)?$/, loader: "url?limit=8192&minetype=application/font-woff"},

      // load images (inline base64 URLs for <=8k images)
      { test: /\.(png|jpg)$/, loader: 'url-loader?limit=8192'}
    ]
  },

  // webpack dev server configuration
  devServer: {
    contentBase: "./dist",
    historyApiFallback: true,
    //hot: true,
    overlay: {
      errors: true
    }
  }
}
