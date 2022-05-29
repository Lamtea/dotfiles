-- グローバルオプション
local o = vim.o
-- バッファオプション
local bo = vim.bo
-- ウィンドウオプション
local wo = vim.wo

-- 検索時に大文字小文字の違いを無視(英字のみ)
o.ignorecase = true
-- 検索時に検索ワードに大文字を含んでいる場合は大文字小文字を区別(英字のみ)
o.smartcase = true
-- ウィンドウ縦分割時に新規ウィンドウを右に配置
o.splitright = true
-- ターミナルでTrueColorを使用
o.termguicolors = true
-- 指定時間入力がなければスワップファイルを更新
o.updatetime = 300
-- コマンドのタブ補完をbashのような動作に指定
o.wildmode = "list:longest,full"
-- OSのクリップボードとneovimのレジスタを共有
o.clipboard = o.clipboard .. "unnamedplus"
-- タブ挿入時はスペースに変換
bo.expandtab = true
-- {}等の字句を考慮してインデントを1つ後ろに設定
bo.smartindent = true
-- タブ挿入時の空白数
bo.tabstop = 4
-- 新しい行挿入時の空白数
bo.shiftwidth = 4
-- 行番号を表示
wo.number = true
-- カーソル行からの相対位置を表示
wo.relativenumber = true
-- 行番号のさらに左に目印桁を表示
wo.signcolumn = "yes"
-- カーソル行のある位置をハイライト表示
wo.cursorline = true
