# slidev

公式のテンプレートを使うなら `yarn create` だが、不要なものも入っている。
このフォルダをコピーして手動インストールするほうが簡単。

## 公式テンプレートからの変更点

pnpmは使わないので `.npmrc` は削除した。

`slidev build` の機能は使わないので `package.json` から削除した。
それにともない `netlify.toml` や `vercel.json` は不要になるので削除した。

PDFへのエクスポート機能が欲しいので `playwright-chromium` パッケージを追加した。

テーマはデフォルトから変更した。

