# mfa-with-1password

## What's this
コマンドラインでAWSのMFAなどのワンタイムパスワードを聞かれた際に、tmuxを使って1Passwordからパスワードを取得して貼り付けられるようにします。

## Installation
1. `aws-mfa.sh`を任意の場所にダウンロードする
2. `aws-mfa.sh`内の`YourAccount`を自分のアカウント名に変更する（もしくは環境変数を設定する）
3. `.tmux.conf`に以下のような設定を加える

```
bind a run-shell '/path/to/aws-mfa.sh <AuthFile> <ServiceName> #{pane_id}'
```
* \<AuthFile>
  * 認証情報を保存しておくファイルのパスを指定
* \<ServiceName>
  * 1Passwordで、ワンタイムパスワードを取得する対象のサービス名を指定

## Usage
ワンタイムパスワードの入力を求められたら、上記で設定したtmuxのコマンドを実行します。
