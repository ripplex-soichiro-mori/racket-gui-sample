# racket-gui-sample

Mr.Ed Designerを利用したracketのGUIアプリのサンプルです。

### 実行方法

以下のコマンドでアプリが起動します。

```sh
racket myapp.rkt
```

また、Mr.Ed Designerの起動は以下のコマンドで起動できます。

```sh
racket -l mred-designer project-4872.\*.med
```

### ディレクトリツリー

```
.
├── README.md
├── images
│   └── main
│       └── background.jpeg
├── myapp.rkt                  エントリポイント
├── project-4872.*.med         Mr.Edプロジェクトファイル
└── project-4872.rkt           Mr.Edで作成したGUIの自動生成コード
```
