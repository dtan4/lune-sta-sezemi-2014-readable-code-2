メモ
==================
* RecipeDataクラスがメイン
* usersとrecipes情報をhashで管理(仕様変更にも柔軟に対処できるように)
* コマンドライン引数の最後にレシピIDを指定する(あってもなくてもいい)
* to_a(id_num <- optional)メソッドでArrayが返ってくる
* 仕様9-10は実行できる状態にまだなっていない(spec8あたりを確認すること)
* わからないことは聞いて下さい

## by dtan4
* 後々の仕様に対応できるような構造化がなされている
* メンバの追加に `add_*` というメソッドが定義されており、カプセル化がなされていてよい
* Hash の `key => value` のインデントが揃っている

### spec10
* recipes, users は Array だと重複を正しく処理できなかったため、Hash に変更した
* メソッド名を `recipes_by_user_id` とし、引数に何を渡すべきか明確にする

### spec11
* `user_id`, `recipe_id` は OptionParser で取得
* `{user,recipe}_by_id` というメソッド名により、id からユーザとレシピを取得するということがわかる
* `id_num_opts` を `recipe_id` にリネームし、レシピの id であることを明示
* レシピ情報を表示するメソッドを `show_recipes_by_user_id` に切り出し
