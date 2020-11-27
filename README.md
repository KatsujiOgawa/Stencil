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
- has_many :relationships
<!-- - has_many :followings, through: :relationships, source: :follow
- has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
- has_many :followers, through: :reverse_of_relationships, source: :user -->

## Reviews テーブル

| Column            | Type       | Options                        |
| ----------------- | ---------- | ------------------------------ |
| title             | string     | null: false                    |
| text              | text       | null: false                    |
| category_id       | integer    | null: false                    |
| limit_id          | integer    | null: false                    |
| user              | references | null: false, foreign_key: true |
<!-- limitはJavaScriptを用いて、非同期通信の日数カウントダウンを行う -->
<!-- Active Storageを用いて、imageの追加予定 -->

### Association

- has_many :comments
- belongs_to :user
<!-- - belongs_to :relationship アソシエーション組む可能性あり -->

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

# Relationsテーブルのアソシエーション参考資料
- https://qiita.com/mitsumitsu1128/items/e41e2ff37f143db81897