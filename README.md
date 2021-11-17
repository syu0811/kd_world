# KD_World

このアプリは、KDアカウントを持つ神戸電子専門学校の学生が使用する、掲示板（SNS）です。
 
# Features
 
このアプリには、KDアカウントが必要なので、必然的に使用者は神戸電子専門学校の関係者になり、
匿名性のある、ほかの掲示板と比べ、安全性が高く、学生同士のコミュニケーションに最適です。
 
# Requirement
 
## ライブラリ
* OS(動作確認済み)
  * windows10
  * Linux(Ubuntu 64bit)
* ブラウザ
  * Chrome（動作確認済み）
  * etc...
* Git
* docker-compose
  * Ruby : 2.7.4
  * Ruby on Rails : 6.1.3
  * Node : 12.14.0
  * Postgresql : 13

 
# Installation

以下の手順は、windows10を想定したものです。

## Chrome

1. 以下のURLにアクセスしてインストーラーをダウンロードする。  
  [Chromeをダウンロード](https://www.google.co.jp/chrome/)
2. ダウンロードしたファイルを実行する。

## Git

1. 以下のURLにアクセスしてインストーラーをダウンロードする。  
  [Gitをダウンロード](https://git-for-windows.github.io/)
2. ダウンロードしたファイルを実行する。
3. 「Next」を押していき、途中「**Git from the command line and also from 3rd-party software**」と、選択する項目があった場合は選択すること
4. installを押すとインストールが開始する。
5. installが終わったらfinishを押して、終了する。

## docker-compose

1. windowsのタスクバー（黒い帯）にある検索部分で、「Windowsの機能の有効かまたは無効化」で検索し、起動する。
2. Hyper-V、WSL2(Windows Subsystem for Linux),仮想化プラットフォームを有効にして、OKをクリック。
3. 再起動
4. 以下のURLにアクセスしてインストーラーをダウンロードする。  
  [Dockerをダウンロード](https://www.docker.com/) Get Startedから進めばインストーラーをダウンロードできる。
5. ダウンロードしたファイルを実行する。
6. okを押し、インストールを開始する。
7. 初回DockerDesktop起動時にLinuxカーネルの差し替えを求められるなら、リンクをたどって更新ファイルを落とし、それからrestartする。
8. 最終的に、Docker Desktopの左下が緑色になっていたら完了。
 
# Usage

1. コマンドプロンプトもしくは、powershellを起動し、任意のフォルダに移動
2. Gitからcloneするし、docker-composeをBuildして、コンテナを立てる。
```console
PS> git clone https://github.com/syu0811/kd_world.git
PS> docker-compose build
PS> docker-compose up
```
3. コンソールに 「Listening on http://0.0.0.0:3000」と出ていたらOK
4. 別の端末でデータベースの作成をする。
```console
PS> docker-compose exec web bash
/kd_world# RAILS_ENV=production rails db:create db:migrate db:seed
```
5. Chromeなどのブラウザで([http://localhost:3000/](http://localhost:3000/))にアクセスする。


# Note
 
ログイン、ユーザー登録にはKDアカウントの形式で登録する必要がある。
 
# Author
 
* syu0811
