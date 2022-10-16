// テスト店舗テーブル
CREATE TABLE test_shop (shop_id int primary key, name text);
INSERT INTO test_shop VALUES
  (1, 'aaa'),
  (2, 'bbb'),
  (3, 'ccc'),
  (4, 'ddd');

//テスト注文テーブル
CREATE TABLE test_order (id int primary key,shop_id int, data text);
INSERT INTO test_order VALUES
  (1,1,'shop1データ'),
  (2,1,'shop1データ'),
  (3,2,'shop2データ'),
  (4,4,'shop4データ');

// テスト注文テーブルの行レベルセキュリティを許可
ALTER TABLE test_order ENABLE ROW LEVEL SECURITY ;

// テスト注文テーブルの行レベルセキュリティを設定
CREATE POLICY test_order_policy ON test_order USING(shop_id = current_setting('app.shop_id')::integer);

// テスト用ユーザー作成
create role test with LOGIN;
grant insert,select,update,delete on test_order to test;

// ログインセッションに変数を設定
select set_config('app.shop_id','1',false);

//ログイン
psql -U test -d postgres

