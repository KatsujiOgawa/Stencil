# Stencil

# 概要
## 当アプリケーションは、本のアウトプットを投稿する事で知識定着を行う為のアプリケーションです。
## 実装機能
- レビュー新規投稿機能
- ユーザ管理機能
- ユーザーフォロー機能
- カテゴリー検索機能
- 投稿に対するコメント機能
- 最新投稿の期限カウントダウン機能
- テストユーザーログイン機能

# URL
- http://54.95.64.135/

# テスト用アカウント
  ゲストログインボタンをクリックすると、ゲストユーザーにログインできます。
  (ユーザー情報の編集ができない仕様になっています。)

# 利用方法
当アプリケーションは本のレビューを投稿する事で、内容理解を深める事を目的としています。
具体的な流れは以下の通りです。
## レビュー投稿
1. レビュー期限を選択した上で、レビュー投稿をする。
2. 投稿を作成した瞬間から、設定期限までのカウトダウンが表示されます。
3. 投稿詳細ページから投稿を編集する事ができるので、設定期限までにレビューをします。
## レビュー参照
1. レビュー一覧画面からカテゴリーを選ぶと、参照したい分野のみを一覧表示します。
2. 参照したい投稿の表紙画像、またはタイトルテキストをクリックして投稿詳細ページに遷移します。
   (ユーザー名の部分は投稿者のユーザー詳細ページのリンクになっています)
## ユーザーフォロー
1. ユーザー間での交流を行うことで読書と内容のアウトプットを活性化させる事ができます。


# 対象ユーザーと目指した課題解決
## ペルソナ
- 若年層の男女(20代〜30代前半)
- 職業による絞り込みなし
- 自己成長に意欲的な人
- 読書による学習の質をより向上させたいと考えている人
## 解決したい課題
- アウトプットによる知識定着を行いたいが、多目的なSNS等を使うと他のタイムラインが目に入ってしまい、学習以外に気を取られてしまうという課題。
- 効率的に読書を行いたいが、ついつい先延ばしにして学習が漫然としてしまうという課題。
# 実装した機能についての説明
## レビュー投稿/編集機能
- 投稿にはタイトル、表紙画像、カテゴリー選択、投稿期限選択、レビュー本文が必須です。
- 投稿後はレビュー期限を変更できません。
- 投稿作成した日時がカウントダウン開始なので、内容の編集を行ってもカウントダウンは変更されません。
- GIF:https://gyazo.com/59a3ba5e0cad7fd5a17ffeb08bc3bd90
## ユーザー管理機能
- 新規登録には、名前、メールアドレス、パスワード、確認用パスワードが必須です。
- ログインにはメールアドレスとパスワードが必須です。
- 当アプリケーションはあくまでもアウトプットが目的の為、非ログイン状態ではアプリ説明ページしか使用できません。
- 自分のユーザー詳細ページからユーザー情報の編集が可能です。また、自分の投稿やフォロー、フォロワーを参照できます。
- 他ユーザーの詳細ページから、ユーザーのフォローが可能です。また、そのユーザーの投稿やフォロー、フォロワーを参照できます。
- テスト用にゲストユーザーを設定しています。(ゲストユーザーの登録情報は編集できません) 
## カウントダウン機能
- フッターの中央部分に、自分の最終投稿のレビュー期限が常に表示されます。
- カウントダウン部分は投稿の詳細ページへのリンクになっています。
- 投稿後に内容を編集してもカウントダウンの内容はされません。
- カウントダウンが終了すると、フッターのカウントダウン表示が消えます。
- GIF:https://gyazo.com/29c22ef5dcf9475b8b57a047cbaf1688
## コメント機能
- 投稿詳細ページ下部の入力フォームから、50文字以内のコメント投稿が可能です。
- 下にスクロールすると、全てのコメントが閲覧できます。
- 自分が投稿したコメントのみ、削除ボタンが表示されます。
- コメントの投稿者名はユーザー詳細画面へのリンクになっています。


# 要件定義
- 必要ビューファイルの作成
- ユーザー管理機能
- レビュー投稿機能
- レビュー編集機能
- レビュー削除機能
- レビュー詳細機能
- レビュー一覧機能
- コメント機能
- モデル単体テストコード
- 統合テストコード
- レビュー期限カウントダウン機能実装(自分)
- AWS EC2 による自動デプロイ
- ユーザーフォロー機能
- AWS S3による画像保存
- Category検索機能
- レビュー期限のカウントダウン機能(他ユーザー)
- レスポンシブデザイン
- Haw to useページ
- ゲストログイン機能（テスト用）



# テーブル設計

## Users テーブル

| Column              | Type   | Options     |
| --------------------| ------ | ----------- |
| name                | string | null: false |
| email               | string | null: false |
| encrypted_password  | string | null: false |

### Association

- has_many :reviews
- has_many :comments
- has_many :relationships, dependent: :destroy
- has_many :followings, through: :relationships, source: :follow
- has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
- has_many :followers, through: :reverse_of_relationships, source: :user

## Reviews テーブル

| Column            | Type       | Options                        |
| ----------------- | ---------- | ------------------------------ |
| title             | string     | null: false                    |
| text              | text       | null: false                    |
| category_id       | integer    | null: false                    |
| limit_id          | integer    | null: false                    |
| user              | references | null: false, foreign_key: true |

### Association
extend ActiveHash::Associations::ActiveRecordExtensions
- belongs_to :category
- belongs_to :limit

- has_many :comments
- belongs_to :user

## Relationships テーブル

| Column      | Type       | Options                                        |
| ----------- | ---------- | ---------------------------------------------- |
| follow      | references | null: false, foreign_key: { to_table: :users } |
| user        | references | null: false, foreign_key: true                 |

### Association

- belongs_to :user
- belongs_to :follow, class_name: 'User'

## comments テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| text        | text       | null: false                    |
| user        | references | null: false, foreign_key: true |
| review      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :review
