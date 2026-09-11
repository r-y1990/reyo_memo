+++
title = "3X歳男性の自由研究"
date = "2026-08-20"
description = "エンジニアに寄った自由研究（自由研究ってほどでもない）なので読む人選ぶかもすまん"

categories = ["雑記", "TECH"]

tags = ["diary", "random", "雑記", "エンジニアリング"]
draft = false
+++

夏休み二日目(三日目)雑記

今日は作業を色々した。
自由研究とかわくわくする感じのタイトルですが、ゴリゴリのエンジニア内容なのであんましおもろくないと思います。

## mesi画像取得自動化

配信画面にMeshiの画像があるのは知ってるとおもうんですが、それを自動で取得するようにしました。
もともとGoogleDriveをローカルのGドライブに割り当ててそこから該当パスの飯画像を参照していたんですが、

スマホから飯画像アップロード → 反映待ち（ネットワークドライブなので遅い） → OBSの画像ソースから選択
と言った実は結構な手間がかかってます。
めんどくて当分変えてなかったりすることも多かった。

なのでGoogleDriveから任意のフォルダにダウンロード → OBS側でフォルダの画像を表示（スライドショー）
とすることで自動化。Bot立ち上げのタイミングで行うことにしたので面倒な日次操作もない。
7日以上のものは家にあるネットワークドライブにバックアップするようにした。

これでスマホから画像をアップロードし忘れない限りちゃんと更新される。

## GPT5.6の従量課金？APIをCopilotで使う

プログラム書くには切っても切り離せない生成AI君

会社でCopilot CLIを使ってるんだが、もうコレ無しでコード書けねぇなってなった。
でもFreeプランだとすぐ使い切りそうだなぁ。と思ったのでできるだけ安くどうにかできないかなって。
結果5ドルでそれなりに遊べそうな感じになった。
従量課金じゃなくてプリペイドになったけど、こっちの方が安全かなって。

会社で5.6のコスパ重視モデルのLunaを使ってたんですが、結構精度がいい気がしたのでもうこれでよくね？となってどうにかしてCopilotで使えないかをGPTに聞くという形で行った。

まずはプロジェクトの作成
「`OpenAI Platform`」とかで検索
左上のところからCreateProjectとかあったと思う。

{{< figure src="openaiplatform.png" >}}

Billingの設定で5ドルの購入を行う
無料がいい人は頑張ってCopilotのFreeで頑張ってくれ。

**購入の時にAuto-reloadの設定を切らないと勝手にチャージされるかも！！！！！！！！！**

{{< figure src="credit.png" >}}

金額の上限を設定する。
僕は5ドルで遊びたかったので5ドルに。
もっとやりたい人は適当にやってください。
`Enforce a hard limit` は付けた方がいいです。
これ以上使うと、APIの実行が失敗するという制約です。
意図せず多く使っちゃう的なのをなくせます。

{{< figure src="Limit.png" >}}

API Keyの作成
Create secret keyを押してシークレットを表示してどっかに取っとく。

{{< figure src="apikey.png" >}}

これで基本的な設定は終わり。

あとは環境側の設定をします。
僕はWindowsで開発してるのでWindowsで、MacとかLinuxの人はうまいこと置き換えてください。（そんな人読まないと思うけど）

前提： PowerShell 7をWindowsTerminalを使ってます。

CopilotCLIのインストール
VSCODEのCopilotChat使う場合は多分拡張機能側に設定があるのでそっちで。

```
winget install GitHub.Copilot
```

環境変数の設定

```powershell
# 任意のテキストエディタで編集
vim $PROFILE # mac とかだと.zashrcみたいなやつ

# わからんという人はいないと思うけどわからん人は
# 下記で出てきたファイルパスの奴をメモ帳とかで開くといい
echo $PROFILE
```

以下の設定を入れる

```
$env:COPILOT_PROVIDER_TYPE = "openai"
$env:COPILOT_PROVIDER_BASE_URL = "https://api.openai.com/v1"
$env:COPILOT_PROVIDER_API_KEY = "メモっといたAPI Key"
$env:COPILOT_MODEL = "gpt-5.6-luna"
$env:COPILOT_PROVIDER_WIRE_API = "responses"
```

これであとはCopilotやればいい。

```powershell
copilot --banner
```

（bannerオプションをつけるとかっこいいスライドインが見れる）

{{< figure src="banner.png" >}}

Copilot 画面が立ち上がる。
右下見るとLunaを使えてる事がわかりますね。
ここでこのコード書いて！とかやればいいんです。すごいね。

{{< figure src="copilotcli.png" >}}

これで修正した奴結構やり取りあった上にそこそこ修正してもらった。

{{< figure src="copilot.png" >}}

これでも10円くらい。結構遊べるかも。
当分コード書くのには困らないわね。
トークンとかわからないからどうなのかはわからないけどそこそこ遊べるんかなぁって感じ。
Copilot側の制限にかからなければ。

{{< figure src="riyouryou.png" >}}

## 黒画面の整理

PowerShellの表示もいい加減デフォルトをやめるか～となったのでちょっと修正
会社ではWarpというターミナルを使っていたが、Windows版が日本語対応さすがにひどかったのでやめ。

- 入力補助というか履歴からコマンドやるやつ換系（設定）
- NerdFont
- Oh My Posh

この三つを入れた。（最後のは設定だけど）

前提

- PowerShell7を入れる
- Wingetをつかう

> 入力の履歴

```powershell
Install-Module PSReadLine -Scope CurrentUser -Force
Import-Module PSReadLine

Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView
```

入力の履歴がでる

{{< figure src="yosoku.png" >}}

> Oh My Posh

変な名前だが結構優秀

```
winget install JanDeDobbeleer.OhMyPosh
```

アイコンを使うので、デフォルトだと表示しきれないらしくNerd Fontってやつを入れた方がいいらしい。

```
oh-my-posh font install meslo
```

あとはWindowsTerminalの設定からフォントをMesloLGM NerdFontに変更する。

この辺躓いたので適宜Jsonのほうで設定(左下の奴)を修正したりしたきがする

{{< figure src="pssettei.png" >}}

> 起動時の設定

`$PROFILE` に以下を追記。

```
# PSReadLine
import-Module PSReadLine

Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView

# Terminal Icons
Import-Module Terminal-Icons

# oh my posh setting
# ここはちゃんと設定ファイル作らないといけなかった気がする
oh-my-posh init pwsh --config "$HOME\.config\prompt.omp.json" | Invoke-Expression
```

<details><summary>Poshの設定例</summary>

設定には `$HOME\.config\prompt.omp.json` を指定したがデフォルトは違いそう。
まぁ管理するためにここに修正した。

好みでデフォルトだとパス表示が相対だったので絶対パスに修正
segments -> properties -> style

```json
{
  "$schema": "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json",
  "version": 4,

  "blocks": [
    {
      "type": "prompt",
      "alignment": "left",
      "newline": false,
      "segments": [
        {
          "type": "path",
          "style": "plain",
          "template": "📁 {{ .Path }} ",
          "properties": {
            "style": "full"
          }
        },
        {
          "type": "git",
          "style": "plain",
          "template": " {{ .HEAD }} {{ if .Working.Changed }}✗{{ end }} "
        }
      ]
    },
    {
      "type": "prompt",
      "alignment": "left",
      "newline": true,
      "segments": [
        {
          "type": "text",
          "style": "plain",
          "template": "❯ "
        }
      ]
    }
  ],

  "final_space": true
}
```

</details>

見た目はこんな感じに、もうちょいカラフルでもいいかも。
あとPowershellはlsが使えるがデフォがこれ、ls -l相当なのでLinuxに寄せたいしそういうのもあるみたい。
気が向いたら入れてみたいところ。

{{< figure src="terminal.png" >}}

## 最後に

と言ったとこで自由研究という名目で結構頑張りました。
コードの修正も楽になるね。Botの機能拡充ももう少しやりたいところ。

夏休みもうおわりそうなのに何もできてなくて泣きそうですが、まぁなんかやったというところで満足感がある。
ぶっちゃけ画像精査してないのでまずいの乗ってないかちょっと不安です。

なんかあったら教えて頂戴。

ほな。
