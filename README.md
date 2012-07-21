# anything-myrurema

anything-myrurema は myrurema gem を使って emacs で Ruby のマニュアル(るりま)を読むツールです。るりまサーチの検索結果ページを開くこともできます。

## 準備

myrurema gem をインストールします。このドキュメントでは Ruby1.9.3 を例としています。myrurema gem の導入の詳細は https://github.com/yhara/myrurema を参照して下さい。

    gem install myrurema
    rurema --init
    rurema --init --rubyver=1.9.3

インデックスファイルを作成します。そのため、bitclust-core gem をインストールします(myrurema にも bitclust が付随しているので、ruby -I を利用する方法もあります)。

    gem install bitclust-core
    (bitclust  -d $HOME/.rurema/db/1.9.3 list --class; bitclust  -d $HOME/.rurema/db/1.9.3 list --method; bitclust  -d $HOME/.rurema/db/1.9.3 list --library) > ~/.emacs.d/myrurema.index

インデックスファイルの作成がうまくゆかない場合は、 https://gist.github.com/3154649 を ~/.emacs.d/myrurema.index として配置して下さい。ただし、Ruby1.9.3 向けの内容です。

emacs 側は、anything 類を導入後、anything-myrurema.el をロードパスの通ったところに配置し、require します。

    (require 'anything-myrurema)

## 使用方法

M-x anything-myrurema するか、anything-myrurema に適当なキーを割り当てます。

候補ウィンドウ

![Sample Image](https://github.com/mori-dev/anything-myrurema/raw/master/doc/img/sample1.png)

アクション選択ウィンドウ

![Sample Image](https://github.com/mori-dev/anything-myrurema/raw/master/doc/img/sample3.png)

結果の表示

![Sample Image](https://github.com/mori-dev/anything-myrurema/raw/master/doc/img/sample2.png)
