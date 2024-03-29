var path =  require('path');

module.exports = {
  entry: ["./server.ts"],
  output: {
    filename: 'api.bundle.js',
    path: path.resolve(__dirname,"dist")
  },
  module: {
    rules: [
      { test: /\.tsx?$/, loader: 'ts-loader',exclude: /node_modules/,},
      { test: /\.json/, loader: "json-loader", exclude:/node_modules/,}
    ]
  },
  resolve: {
    modules: ['node_modules'],
    extensions: [".tsx", ".ts", ".js",".json"]
  },
  target: 'node',
  node: {
        __dirname: true
    },
  plugins: []
};