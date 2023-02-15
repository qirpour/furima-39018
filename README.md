

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| name               | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| first_name         | string  | null: false               |
| last_name          | string  | null: false               |
| first_name_kana    | string  | null: false               |
| last_name_kana     | string  | null: false               |
| year_id            | integer | null: false               |
| month_id           | integer | null: false               |
| day_id             | integer | null: false               |

### Association

- has_many :items
- has_many :purchases
- has_many :comments

## items テーブル

| Column             | Type         | Options                        |
| ------------------ | ------------ | ------------------------------ |
| image              | text         | null: false                    |
| title              | string       | null: false                    |
| explanation        | text         | null: false                    |
| price              | integer      | null: false                    |
| category_id        | integer      | null: false                    |
| condition_id       | integer      | null: false                    |
| delivery_charge_id | integer      | null: false                    |
| prefectures_id     | integer      | null: false                    |
| delivery_days_id   | integer      | null: false                    |
| user               | references   | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :comments
- has_one  :purchase

## purchases テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| user           | references | null: false, foreign_key: true |
| item           | references | null: false, foreign_key: true |

### Association

- belongs_to :users
- belongs_to :item
- has_one  :address

## addresses テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| postal_code    | string     | null: false                    |
| prefectures_id | references | null: false                    |
| city           | string     | null: false                    |
| house_number   | string     | null: false                    |
| building_name  | string     |                                |
| telephone      | integer    | null: false                    |
| purchase_id    | integer    | null: false, foreign_key: true |

### Association

- belongs_to :purchase

## comments テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| comment_text   | string     | null: false                    |
| item           | references | null: false, foreign_key: true |
| user           | references | null: false, foreign_key: true |

### Association

- belongs_to :items
- belongs_to :users