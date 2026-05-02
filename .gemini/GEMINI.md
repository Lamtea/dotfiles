# GEMINI.md

## 言語設定

- すべての対話と解説を自然な日本語で行う。
- 技術用語、コマンド、ツール出力は原文のまま扱う。

## ツール設定

### 高速検索・操作（効率重視）

- **ripgrep (rg)**: `grep` よりも高速で `.gitignore` を解釈するため、コード検索の第一選択とする。
- **fd**: `find` よりも高速で直感的なため、ファイル検索に使用する。

### 静的解析・整形（品質維持）

- **prettier**: 各種ファイルの整形。
- **markdownlint-cli2**: Markdownの修正。
- **shellcheck**: シェルスクリプトの解析。
- **shfmt**: シェルスクリプトの整形。
- **ruff**: Pythonの解析・整形。
- **hadolint**: Dockerfileの解析。
- **yamllint**: YAMLの解析。
- **taplo**: TOMLの解析。
- **actionlint**: GitHub Actionsの解析。
- **codespell**: スペルチェック。

### データ操作

- **jaq**: JSONの加工・抽出（jqの代わりに高速なRust製jaqを優先）。
- **jq**: jaqで対応できない場合や失敗した場合のフォールバックとして使用。
- **yq**: YAMLの加工・抽出。

### 開発支援

- **github-cli (gh)**: Issue, PR, リポジトリ操作に使用。

## MCP設定

### 調査・検索

- **serena**: コードの構造把握や意味的な検索に最優先で使用する。
- **context7**: 最新の技術トレンド、フレームワーク、ライブラリ情報の調査に使用する。
- **github**: GitHub上のIssue, PR, 公開リポジトリの調査に使用する。

### ブラウザ操作・デバッグ

- **playwright**: ブラウザの自動操作、遷移、スクレイピングなどに使用する。

## フック設定（自動実行ルール）

- **Markdown修正後**: 完了前に必ず `markdownlint-cli2 --fix` と `prettier --write` を実行する。
