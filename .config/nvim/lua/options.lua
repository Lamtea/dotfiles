local o = vim.o                             -- グローバルオプション
local bo = vim.bo                           -- バッファオプション
local wo = vim.wo                           -- ウィンドウオプション

o.ignorecase = true                         -- 検索時に大文字小文字の違いを無視(英字のみ)
o.smartcase = true                          -- 検索時に検索ワードに大文字を含んでいる場合は大文字小文字を区別(英字のみ)
o.splitright = true                         -- ウィンドウ縦分割時に新規ウィンドウを右に配置
o.termguicolors = true                      -- ターミナルでTrueColorを使用
o.updatetime = 300                          -- 指定時間入力がなければスワップファイルを更新
o.wildmode = 'list:longest,full'        	-- コマンドのタブ補完をbashのような動作に指定(リスト表示する点は違う)
o.clipboard = o.clipboard .. 'unnamedplus'	-- OSのクリップボードとneovimのレジスタを共有
bo.expandtab = true                         -- タブ挿入時はスペースに変換
bo.smartindent = true                       -- {}等の字句を考慮してインデントを1つ後ろに設定
bo.tabstop = 4                              -- タブ挿入時の空白数
bo.shiftwidth = 4                           -- 新しい行挿入時の空白数
wo.number = true                            -- 行番号を表示
wo.relativenumber = true                    -- カーソル行からの相対位置を表示
wo.signcolumn = 'yes'                       -- 行番号のさらに左に目印桁を表示
wo.cursorline = true                        -- カーソル行のある位置をハイライト表示
