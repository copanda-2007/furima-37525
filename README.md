# テーブル設計

## users テーブル

| Column             | Type   | Options                  |
| ------------------ | ------ | ------------------------ |
| nickname           | string | null: false,unique: true |
| email              | string | null: false              |
| password           | string | null: false              |
| last_name          | string | null: false              |
| first_name         | string | null: false              |
| last_name_kana     | string | null: false              |
| first_name_kana    | string | null: false              |
| birrthday          | date   | null: false              |

### Association

- has_many :items
- has_many :purchases

## items テーブル

| Column                   | Type    | Options     |
| ------------------------ | ------- | ----------- |
| product                  | string  | null: false |
| description              | text    | null: false |
| category                 | integer | null: false |
| state                    | integer | null: false |
| delivery_charge_burden   | integer | null: false |
| delivery_area            | integer | null: false |
| delivery_days            | integer | null: false |
| price                    | integer | null: false |

### Association

- has_one    :purchases
- belongs_to :users

## purchases テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :users
- belongs_to :items
- has_one    :deliveries

## deliveries テーブル

| Column          | Type    | Options     |
| --------------- | ------- | ----------- |
| postcode        | string  | null: false |
| prefecture      | integer | null: false |
| city            | string  | null: false |
| block           | string  | null: false |
| building        | string  |             |
| phone_number    | string  | null: false |

### Association

- belongs_to :purchases