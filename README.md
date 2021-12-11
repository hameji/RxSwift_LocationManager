## アルバイト活動用のポートフォリオ

RxSwift で CLLocationManager を扱う　サンプル

## Features

## Requirements

- Xcode 12.5
- compatible with iPhone, iPad (iOS 14.5~)
- Homebrew 3.3.6
- ruby 2.6.3p62
- rbenv 1.1.2
- Bundler version 2.2.3
- CocoaPods v1.11.2

## Installation

1. github からクローン
2. Bundler の config に local path を設定
3. アプリと同 version の CocoaPods(v1.11.2)をインストール
4. アプリと同 version の CocoaPods(v1.11.2)でライブラリの導入

```
git clone https://github.com/hameji/RxSwift_LocationManager
bundle config set --local path 'vendor/bundle'
bundle install
bundle exec pod install
```

## Libraries

- [RxSwift](https://github.com/ReactiveX/RxSwift)
- RxCocoa

## Author

[hameji](https://github.com/hameji)<br>
twitter @hameji001
