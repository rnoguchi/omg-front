// webpack.config.js
module.exports = {
  entry: {
    app: './src/grm_list.js.jsx',
  },

  output: {
    path: '../app/assets/javascripts/webpack',
    filename: './app.js',
  },

  module: {
    loaders: [
      { test: /\.(js|jsx)$/,
        loader: "babel",
        exclude: /node_modules/,
        query: {
          presets: ["es2015", "react", "stage-0"],
        }
      },
    ]
  },
}