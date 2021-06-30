const path = require('path');

module.exports = {
  mode: 'development',
  entry: './src/index.tsx',
  output: {
    path: path.resolve(__dirname, 'dist'),
    publicPath: './app/javascript/packs/',
    filename: 'bundle.js',
  },
  watch: true,
  // 追加
  watchOptions: {
    // 最初の変更からここで設定した期間に行われた変更は1度の変更の中で処理が行われる
    aggregateTimeout: 200,
    // ポーリングの間隔
    poll: 1000
  },
  module: {
    rules: [
      {
        test: /\.css$/,
        use: ['style-loader', 'css-loader'],
      },
      {
        test: /\.tsx?$/,
        use: 'ts-loader',
        exclude: /node_modules/,
      }
    ]
  },
  devServer: {
    contentBase: path.resolve(__dirname, 'dist'),
    hot: true,
    open: true,
    port: 3050,
    host: '0.0.0.0',
    historyApiFallback: true,
  },
  resolve: {
    extensions: ['.js', '.ts', '.tsx']
  },
}