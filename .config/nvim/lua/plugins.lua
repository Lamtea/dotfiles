-- プラグイン読込
vim.cmd([[packadd packer.nvim]])
require("packer").startup(function(use)
	-- プラグインマネージャ
	use({
		"wbthomason/packer.nvim", -- lua製プラグインマネージャ
		opt = true,
	})

	-- ライブラリ
	use("nvim-lua/plenary.nvim") -- 関数ライブラリ
	use("nvim-lua/popup.nvim") -- popup api
	use("kyazdani42/nvim-web-devicons") -- アイコンライブラリ(vim-deviconのluaフォーク)
	use("MunifTanjim/nui.nvim") -- UIコンポーネントライブラリ
	use("tami5/sqlite.lua") -- sqliteライブラリ(sqlite必須 see:github)
	use("tpope/vim-repeat") -- プラグインでの.リピート対応(vimscript)

	-- 通知
	use({
		"rcarriga/nvim-notify", -- ポップアップ通知
		config = function()
			require("notify").setup({
				stages = "fade_in_slide_out",
				background_colour = "FloatShadow",
				timeout = 3000,
			})
			vim.notify = require("notify")
		end,
	})

	-- カラースキーム
	use({
		"EdenEast/nightfox.nvim", -- lsp, treesitter等に対応したテーマ
		config = function()
			require("nightfox").setup({
				options = {
					transparent = true,
				},
			})
			vim.cmd("colorscheme nightfox")
		end,
	})

	-- LSPと補完
	use("neovim/nvim-lspconfig") -- LSPクライアント
	use("williamboman/nvim-lsp-installer") -- LSPインストーラー(:LspInstall :LspInstallinfo コマンドでlsをインストールする see:github)
	use("hrsh7th/cmp-nvim-lsp") -- LSP補完用ソース
	use("hrsh7th/cmp-buffer") -- バッファ補完用ソース
	use("hrsh7th/cmp-path") -- パス補完用ソース
	use("hrsh7th/cmp-cmdline") -- コマンドライン補完用ソース
	use("hrsh7th/cmp-nvim-lsp-signature-help") -- 関数シグネチャ補完用ソース
	use("hrsh7th/cmp-nvim-lsp-document-symbol") -- /検索用ソース
	use("hrsh7th/cmp-nvim-lua") -- Lua API用ソース
	use("hrsh7th/cmp-emoji") -- 絵文字用ソース
	use("hrsh7th/nvim-cmp") -- 補完エンジン
	use("hrsh7th/cmp-vsnip") -- vscodeスニペット用ソース
	use("hrsh7th/vim-vsnip") -- vscodeスニペット(vimscript)
	use("rafamadriz/friendly-snippets") -- vscodeスニペット定義ファイル
	use({
		"jose-elias-alvarez/null-ls.nvim", -- LSP用linter, formatter(各種linter, 各種formatter必須 see: setup)
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})
	use("onsails/lspkind-nvim") -- 補完にアイコン表示
	use({
		"tami5/lspsaga.nvim", -- LSP高性能UI
		config = function()
			require("lspsaga").setup({
				debug = false,
				use_saga_diagnostic_sign = true,
				error_sign = "",
				warn_sign = "",
				hint_sign = "",
				infor_sign = "",
				diagnostic_header_icon = "   ",
				code_action_icon = " ",
				code_action_prompt = {
					enable = true,
					sign = true,
					sign_priority = 40,
					virtual_text = true,
				},
				finder_definition_icon = "  ",
				finder_reference_icon = "  ",
				max_preview_lines = 10,
				finder_action_keys = {
					open = "o",
					vsplit = "s",
					split = "i",
					quit = "q",
					scroll_down = "<C-f>",
					scroll_up = "<C-b>",
				},
				code_action_keys = {
					quit = "q",
					exec = "<CR>",
				},
				rename_action_keys = {
					quit = "<C-c>",
					exec = "<CR>",
				},
				definition_preview_icon = "  ",
				border_style = "single",
				rename_prompt_prefix = "➤",
				server_filetype_map = {},
				diagnostic_prefix_format = "%d. ",
			})
		end,
	})
	use({
		"folke/lsp-colors.nvim", -- LSP用のカラー追加
		config = function()
			require("lsp-colors").setup({
				Error = "#db4b4b",
				Warning = "#e0af68",
				Information = "#0db9d7",
				Hint = "#10B981",
			})
		end,
	})
	use({
		"folke/trouble.nvim", -- LSP診断UI
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				height = 10,
				auto_close = true, -- 診断がない場合は自動で閉じる
				use_diagnostic_signs = true, -- LSPクライアントと同じ記号を使用
			})
		end,
	})
	use({
		"j-hui/fidget.nvim", -- LSPプログレス
		config = function()
			require("fidget").setup({
				task = function(task_name, message, percentage)
					return string.format(
						"%s%s [%s]",
						message,
						percentage and string.format(" (%s%%)", percentage) or "",
						task_name
					)
				end,
			})
		end,
	})
	use("RRethy/vim-illuminate") -- LSP単語ハイライト

	local lsp_on_attach = function(client, bufnr)
		require("illuminate").on_attach(client) -- 単語ハイライトをアタッチ

		local function buf_set_keymap(...)
			vim.api.nvim_buf_set_keymap(bufnr, ...)
		end

		local opts = { noremap = true, silent = true }
		buf_set_keymap("n", "gD", "lua vim.lsp.buf.declaration()", opts) -- 標準コマンド拡張(move to global declaration)
		buf_set_keymap("n", "gd", "lua vim.lsp.buf.definition()", opts) -- 標準コマンド拡張(move to local declaration)
		-- buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts) 標準コマンド拡張(show man page) lspsaga使用
		buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
		-- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts) lspsaga使用
		buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
		buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
		buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
		buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
		-- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts) lspsaga使用
		-- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts) lspsaga使用
		-- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts) trouble使用
		-- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts) lspsaga使用
		-- buf_set_keymap('n', '<space>p', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts) lspsaga使用
		-- buf_set_keymap('n', '<space>n', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts) lspsaga使用
		buf_set_keymap("n", "<space>q", "lua vim.lsp.diagnostic.setloclist()", opts)
		buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts) -- バージョン 0.8 は format メソッドを使用すること(see: github)
	end

	local lsp_installer = require("nvim-lsp-installer")
	local lsp_config = require("lspconfig")
	local lsp_capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
	lsp_installer.setup()
	for _, server in ipairs(lsp_installer.get_installed_servers()) do
		lsp_config[server.name].setup({
			on_attach = lsp_on_attach, -- キーバインドのアタッチ
			capabilities = lsp_capabilities, -- 補完設定
		})
	end

	lsp_config.sumneko_lua.setup({
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" }, -- neovim設定ファイル用(vimがグローバルオブジェクトのため)
				},
			},
		},
	})

	local null_ls = require("null-ls")
	local null_ls_augroup = vim.api.nvim_create_augroup("LspFormatting", {})
	null_ls.setup({
		sources = {
			-- code action
			null_ls.builtins.code_actions.gitsigns, -- gitsignsをコードアクションで実行できる
			null_ls.builtins.code_actions.eslint, -- for javascript/typescript
			null_ls.builtins.code_actions.shellcheck, -- for bash
			-- diagnostics
			null_ls.builtins.diagnostics.codespell, -- for spell
			null_ls.builtins.diagnostics.cppcheck, -- for c/cpp
			null_ls.builtins.diagnostics.editorconfig_checker, -- for editorconfig
			null_ls.builtins.diagnostics.eslint, -- for javascript/typescript
			null_ls.builtins.diagnostics.flake8, -- for python
			null_ls.builtins.diagnostics.golangci_lint, -- for go
			null_ls.builtins.diagnostics.hadolint, -- for dockerfile
			null_ls.builtins.diagnostics.jsonlint, -- for json
			null_ls.builtins.diagnostics.ktlint, -- kotlin
			null_ls.builtins.diagnostics.luacheck.with({
				extra_args = { "--globals vim" },
			}), -- for lua(vimのグローバルオブジェクト警告のため)
			null_ls.builtins.diagnostics.markdownlint, -- for markdown
			null_ls.builtins.diagnostics.php, -- for php
			null_ls.builtins.diagnostics.rubocop, -- for ruby
			null_ls.builtins.diagnostics.shellcheck, -- for bash
			null_ls.builtins.diagnostics.stylelint, -- for css
			null_ls.builtins.diagnostics.sqlfluff.with({
				extra_args = { "--dialect", "postgres" },
			}), -- for postgresql
			null_ls.builtins.diagnostics.tidy, -- for html/xml
			null_ls.builtins.diagnostics.tsc, -- for typescript
			null_ls.builtins.diagnostics.yamllint, -- for yaml
			-- formatting
			null_ls.builtins.formatting.black, -- for python
			-- null_ls.builtins.formatting.codespell, -- for spell
			null_ls.builtins.formatting.clang_format, -- for c/cpp/cs/java
			null_ls.builtins.formatting.dart_format, -- for dart
			null_ls.builtins.formatting.fourmolu, -- for haskell
			null_ls.builtins.formatting.gofmt, -- for go
			null_ls.builtins.formatting.isort, -- for python
			null_ls.builtins.formatting.ktlint, -- for kotlin
			null_ls.builtins.formatting.phpcsfixer, -- for php
			null_ls.builtins.formatting.prettier, -- for multiple(vscodeだとlinterから呼ぶことが多い)
			null_ls.builtins.formatting.rubocop, -- for ruby
			null_ls.builtins.formatting.rustfmt, -- for rust
			null_ls.builtins.formatting.shfmt, -- for bash
			null_ls.builtins.formatting.sqlfluff.with({
				extra_args = { "--dialect", "postgres" },
			}), -- for postgresql
			null_ls.builtins.formatting.stylua, -- for lua
			null_ls.builtins.formatting.tidy.with({
				disabled_filetypes = { "html" },
			}), -- for xml
			null_ls.builtins.formatting.trim_whitespace, -- 末尾の空白除去
		},
		-- ファイル保存時にnull-lsを使用してフォーマットする(バージョン 0.8 になるとnull-ls使用にできるので現状は問い合わせを我慢 see:github)
		on_attach = function(client, bufnr)
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = null_ls_augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = null_ls_augroup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.formatting_sync() -- バージョン 0.8 の場合は format メソッドを使用すること(see: github)
					end,
				})
			end
		end,
	})

	local lsp_kind = require("lspkind")
	lsp_kind.init({
		mode = "symbol_text",
		preset = "codicons",
		symbol_map = {
			Text = "",
			Method = "",
			Function = "",
			Constructor = "",
			Field = "ﰠ",
			Variable = "",
			Class = "ﴯ",
			Interface = "",
			Module = "",
			Property = "ﰠ",
			Unit = "塞",
			Value = "",
			Enum = "",
			Keyword = "",
			Snippet = "",
			Color = "",
			File = "",
			Reference = "",
			Folder = "",
			EnumMember = "",
			Constant = "",
			Struct = "פּ",
			Event = "",
			Operator = "",
			TypeParameter = "",
		},
	})

	vim.g.completeopt = "menu,menuone,noselect" -- 補完設定
	local cmp = require("cmp")
	cmp.setup({
		formatting = {
			format = lsp_kind.cmp_format({
				mode = "symbol",
				maxwidth = 100,
				before = function(_, vim_item)
					return vim_item
				end,
			}),
		},
		snippet = {
			expand = function(args)
				vim.fn["vsnip#anonymous"](args.body) -- vscodeスニペット設定
			end,
		},
		mapping = cmp.mapping.preset.insert({
			["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
			["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
			["<TAB>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
			["<S-TAB>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.close(),
			["<CR>"] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = true,
			}),
		}),
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "vsnip" },
			{ name = "path" },
			{ name = "emoji", insert = true },
			{ name = "nvim-lua" },
			{ name = "nvim_lsp_signature_help" },
		}, {
			{ name = "buffer" },
		}),
	})

	cmp.setup.cmdline("/", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "nvim_lsp_document_symbol" },
		}, {
			{ name = "buffer" },
		}),
	})

	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})

	vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true, noremap = true }) -- hover
	vim.keymap.set("n", "<space>c", "<cmd>Lspsaga code_action<CR>", { silent = true, noremap = true })
	vim.keymap.set("x", "<space>c", ":<C-u>Lspsaga range_code_action<CR>", { silent = true, noremap = true })
	vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true, noremap = true })
	vim.keymap.set(
		"n",
		"<C-f>",
		[[<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>]],
		{ silent = true, noremap = true }
	)
	vim.keymap.set(
		"n",
		"<C-b>",
		[[<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>]],
		{ silent = true, noremap = true }
	)
	vim.keymap.set("n", "<space>k", "<cmd>Lspsaga signature_help<CR>", { silent = true, noremap = true })
	vim.keymap.set("n", "<space>r", "<cmd>Lspsaga rename<CR>", { silent = true, noremap = true })
	vim.keymap.set("n", "<space>d", "<cmd>Lspsaga preview_definition<CR>", { silent = true, noremap = true })
	vim.keymap.set("n", "<space>e", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true, noremap = true })
	vim.keymap.set(
		"n",
		"<space>E",
		[[<cmd>lua require('lspsaga.diagnostic').show_cursor_diagnostics()<CR>]],
		{ silent = true, noremap = true }
	)
	vim.keymap.set("n", "<space>n", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true, noremap = true })
	vim.keymap.set("n", "<space>p", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true, noremap = true })
	vim.keymap.set("n", "<M-f>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true, noremap = true })
	vim.cmd([[tnoremap <silent> <M-f> <C-\><C-n>:Lspsaga close_floaterm<CR>]])
	vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<CR>", { silent = true, noremap = true })
	vim.api.nvim_set_keymap(
		"n",
		"<leader>xw",
		"<cmd>Trouble workspace_diagnostics<CR>",
		{ silent = true, noremap = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>xd",
		"<cmd>Trouble document_diagnostics<CR>",
		{ silent = true, noremap = true }
	)
	vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<CR>", { silent = true, noremap = true })
	vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<CR>", { silent = true, noremap = true })
	vim.api.nvim_set_keymap("n", "gr", "<cmd>Trouble lsp_references<CR>", { silent = true, noremap = true })

	-- ファジーファインダー
	use({
		"nvim-telescope/telescope.nvim", -- ファインダー(ripgrep推奨 see:github)
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local trouble = require("trouble.providers.telescope")
			require("telescope").setup({
				defaults = {
					mappings = {
						i = { ["<c-t>"] = trouble.open_with_trouble },
						n = { ["<c-t>"] = trouble.open_with_trouble },
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
				},
			})
			require("telescope").load_extension("fzf")
		end,
	})
	use({
		"nvim-telescope/telescope-fzf-native.nvim", -- ソーター(cmake必須 see:github)
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	})

	vim.api.nvim_set_keymap(
		"n",
		"<leader>ff",
		[[<cmd>lua require('telescope.builtin').find_files()<CR>]],
		{ noremap = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>fg",
		[[<cmd>lua require('telescope.builtin').live_grep()<CR>]],
		{ noremap = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>fb",
		[[<cmd>lua require('telescope.builtin').buffers()<CR>]],
		{ noremap = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>fh",
		[[<cmd>lua require('telescope.builtin').oldfiles()<CR>]],
		{ noremap = true }
	) -- (h)istory
	vim.api.nvim_set_keymap(
		"n",
		"<leader>fc",
		[[<cmd>lua require('telescope.builtin').commands()<CR>]],
		{ noremap = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>fn",
		[[<cmd>lua require('telescope.builtin').treesitter()<CR>]],
		{ noremap = true }
	) -- node
	vim.api.nvim_set_keymap(
		"n",
		"<leader>gl",
		[[<cmd>lua require('telescope.builtin').git_branches()<CR>]],
		{ noremap = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>gc",
		[[<cmd>lua require('telescope.builtin').git_commits()<CR>]],
		{ noremap = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>gb",
		[[<cmd>lua require('telescope.builtin').git_bcommits()<CR>]],
		{ noremap = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>gf",
		[[<cmd>lua require('telescope.builtin').git_files()<CR>]],
		{ noremap = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>gg",
		[[<cmd>lua require('telescope.builtin').git_status()<CR>]],
		{ noremap = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>gs",
		[[<cmd>lua require('telescope.builtin').git_stash()<CR>]],
		{ noremap = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>ld",
		[[<cmd>lua require('telescope.builtin').lsp_definitions()<CR>]],
		{ noremap = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>lr",
		[[<cmd>lua require('telescope.builtin').lsp_references()<CR>]],
		{ noremap = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>ls",
		[[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]],
		{ noremap = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>ll",
		[[<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>]],
		{ noremap = true }
	)

	-- treesitter
	use({
		"nvim-treesitter/nvim-treesitter", -- パーサー(モジュールによってはnode.jsが必須. エラーがないか :checkhealth で要確認)
		run = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = "all",
				sync_install = true,
				highlight = {
					enable = true,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<CR>", -- normal modeからnodeを初期選択してvisual modeに入れる
						node_incremental = "<CR>", -- 親nodeをたどって選択
						scope_incremental = "<TAB>", -- scope範囲で親nodeをたどって選択
						node_decremental = "<S-TAB>", -- 子nodeまで選択を戻す
					},
				},
				indent = {
					enable = true, -- インデント有効(実験的 see:github, 代替はnvim-yati see:github)
				},
				textobjects = {
					select = {
						enable = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
							["ab"] = "@block.outer",
							["ib"] = "@block.inner",
							["aC"] = "@conditional.outer",
							["iC"] = "@conditional.inner",
							["al"] = "@loop.outer",
							["il"] = "@loop.inner",
							["ap"] = "@parameter.outer",
							["ip"] = "@parameter.inner",
							["aF"] = "@frame.outer",
							["iF"] = "@frame.inner",
							["aS"] = "@statement.outer",
							["iS"] = "@scopename.inner",
							["am"] = "@comment.outer", -- comment
							["ao"] = "@call.outer", -- object
							["io"] = "@call.inner", -- object
						},
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>sn"] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>sp"] = "@parameter.inner",
						},
					},
					move = {
						enable = true,
						goto_next_start = {
							["]f"] = "@function.outer",
							["]c"] = "@class.outer",
							["]b"] = "@block.outer",
						},
						goto_next_end = {
							["]F"] = "@function.outer",
							["]C"] = "@class.outer",
							["]B"] = "@block.outer",
						},
						goto_previous_start = {
							["[f"] = "@function.outer",
							["[c"] = "@class.outer",
							["[b"] = "@block.outer",
						},
						goto_previous_end = {
							["[F"] = "@function.outer",
							["[C"] = "@class.outer",
							["[B"] = "@block.outer",
						},
					},
					lsp_interop = {
						enable = true,
						peek_definition_code = {
							["<leader>lf"] = "@function.outer",
							["<leader>lc"] = "@class.outer",
						},
					},
				},
				textsubjects = {
					enable = true, -- incremental_selectionと違いトリビアごと選択できる
					prev_selection = ",",
					keymaps = {
						["."] = "textsubjects-smart",
						[";"] = "textsubjects-container-outer",
						["i;"] = "textsubjects-container-inner",
					},
				},
				rainbow = {
					enable = true,
					extended_mode = true,
					max_file_line = nil, -- 大きなファイルで重くなる場合は最大行数を設定
				},
				context_commentstring = {
					enable = true,
				},
				matchup = {
					enable = true,
				},
				autotag = {
					enable = true,
				},
			})
		end,
	})
	use({
		"nvim-treesitter/nvim-treesitter-context", -- メソッド等のスコープが長いとき先頭行に表示してくれる(context.vimの代替)
		config = function()
			require("treesitter-context").setup({
				enable = true,
			})
		end,
	})
	use("p00f/nvim-ts-rainbow") -- 対応する括弧の色分け表示
	use("JoosepAlviste/nvim-ts-context-commentstring") -- コメンティングにtreesitterを使用(tsx/jsx等のスタイル混在時に便利, numToStr/Comment.nvimで使用)
	use({
		"haringsrob/nvim_context_vt", -- 閉括弧にvirtual textを表示
		config = function()
			require("nvim_context_vt").setup({
				enabled = true,
				disable_virtual_lines = true, -- pythonなどのインデントベースの場合は非表示(virtual textで行がズレて見にくい)
			})
		end,
	})
	use("andymass/vim-matchup") -- マッチングペアをハイライト, 移動, 編集(キーバインドについては see:github, vimscript)
	use({
		"windwp/nvim-ts-autotag", -- タグを自動で閉じてくれる
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	})
	use({
		"m-demare/hlargs.nvim", -- 引数を色分け表示
		requires = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("hlargs").setup()
		end,
	})
	use("nvim-treesitter/nvim-treesitter-textobjects") -- シンタックスベースの編集サポート(キーバインドは textobjects 参照, 言語別対応については see:github)
	use("RRethy/nvim-treesitter-textsubjects") -- シンタックスベースの範囲選択(キーバインドは textsubjects 参照)
	use("mfussenegger/nvim-ts-hint-textobject") -- シンタックスベースの範囲選択(EasyMotion系)
	use("David-Kunz/treesitter-unit") -- シンタックスベースの範囲選択(ユニット単位, ざっくり系)
	use("mizlan/iswap.nvim") -- シンタックスベースのスワップ(EasyMotion系)

	vim.api.nvim_set_keymap("x", "iu", [[:lua require('treesitter-unit').select()<CR>]], { noremap = true })
	vim.api.nvim_set_keymap("x", "au", [[:lua require('treesitter-unit').select(true)<CR>]], { noremap = true })
	vim.api.nvim_set_keymap("o", "iu", [[:<c-u>lua require('treesitter-unit').select()<CR>]], { noremap = true })
	vim.api.nvim_set_keymap("o", "au", [[:<c-u>lua require('treesitter-unit').select(true)<CR>]], { noremap = true })
	vim.cmd([[omap <silent> m :<C-u>lua require('tsht').nodes()<CR>]]) -- motion
	vim.cmd([[vnoremap <silent> m :lua require('tsht').nodes()<CR>]]) -- motion
	vim.api.nvim_set_keymap("n", "<Leader>ss", "<cmd>ISwap<CR>", { noremap = true }) -- swap motion
	vim.api.nvim_set_keymap("n", "<Leader>sw", "<cmd>ISwapWith<CR>", { noremap = true }) -- swap motion with

	-- ステータスライン
	use({
		"nvim-lualine/lualine.nvim", -- lua製のステータスライン
		requires = {
			"kyazdani42/nvim-web-devicons",
			opt = true,
		},
		config = function()
			local gps = require("nvim-gps")
			require("lualine").setup({
				options = {
					theme = "nightfox",
				},
				sections = {
					lualine_a = {
						"mode",
					},
					lualine_b = {
						"branch",
						"diff",
						"diagnostics",
					},
					lualine_c = {
						"filename",
						{ gps.get_location, cond = gps.is_available },
					},
					lualine_x = {
						"encoding",
						"fileformat",
						"filetype",
					},
					lualine_y = {
						"progress",
					},
					lualine_z = {
						"location",
					},
				},
			})
		end,
	})
	use({
		"SmiteshP/nvim-gps", -- ステータスバーにカーソル位置のコンテキストを表示
		requires = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("nvim-gps").setup()
		end,
	})

	-- バッファライン
	use({
		"akinsho/bufferline.nvim", -- バッファをタブ表示
		tag = "v2.*",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					numbers = "both",
					diagnostics = "nvim_lsp",
					show_buffer_close_icons = false,
					show_close_icon = false,
				},
			})
		end,
	})

	vim.api.nvim_set_keymap("n", "<leader>n", "<Cmd>BufferLineCycleNext<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<leader>p", "<Cmd>BufferLineCyclePrev<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<leader>N", "<Cmd>BufferLineMoveNext<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<leader>P", "<Cmd>BufferLineMovePrev<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<leader>E", "<Cmd>BufferLineSortByExtension<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<leader>D", "<Cmd>BufferLineSortByDirectory<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<Leader>b", "<Cmd>BufferLinePick<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<Leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<Leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<Leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<Leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<Leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<Leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<Leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<Leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<Leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<Leader>q", "<Cmd>BufferLinePickClose<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<Leader>L", "<Cmd>BufferLineCloseLeft<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<Leader>R", "<Cmd>BufferLineCloseRight<CR>", { noremap = true, silent = true })

	-- サイドバー
	use({
		"sidebar-nvim/sidebar.nvim", -- 色々な情報を出すサイドバー(ファイラと違って隠しファイルも表示する設定にしてある)
		config = function()
			require("sidebar-nvim").setup({
				disable_default_keybindings = 0,
				bindings = {
					["q"] = function()
						require("sidebar-nvim").close() -- qで閉じる
					end,
				},
				open = false,
				side = "right",
				initial_width = 40,
				hide_statusline = false,
				update_interval = 1000,
				sections = {
					"datetime",
					"containers",
					"git",
					"diagnostics",
					"todos",
					"symbols",
					"buffers",
					"files",
				},
				section_separator = "------------------------------",
				datetime = {
					icon = "",
					format = "%b %d日 (%a) %H:%M",
					clocks = { { name = "local" } },
				},
				["git"] = {
					icon = "",
				},
				["diagnostics"] = {
					icon = "",
				},
				todos = {
					icon = "",
					ignored_paths = { "~" },
					initially_closed = false,
				},
				containers = {
					icon = "",
					use_podman = false,
					attach_shell = "/bin/bash",
					show_all = true,
					interval = 5000,
				},
				buffers = {
					icon = "",
					ignored_buffers = {},
					sorting = "id",
					show_numbers = true,
				},
				files = {
					icon = "",
					show_hidden = true,
					ignored_paths = { "%.git$" },
				},
				symbols = {
					icon = "ƒ",
				},
			})
		end,
	})

	vim.api.nvim_set_keymap("n", "gs", "<Cmd>SidebarNvimToggle<CR>", { noremap = true, silent = true })

	-- ファイラ
	use({
		"nvim-neo-tree/neo-tree.nvim", -- 軽くて安定したlua製ファイラ(隠しファイルを表示する場合はサイドバーを使用)
		branch = "v2.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup()
		end,
	})

	vim.keymap.set("n", "gx", "<Cmd>Neotree reveal toggle <CR>", { noremap = true, silent = true }) -- xは特に意味はないが公式キーマップ((s)idebarの下の段)

	-- スクロールバー
	use({
		"petertriho/nvim-scrollbar", -- スクロールバーを表示(nvim-hlslensと連携してスクロールバーにハイライト表示)
		config = function()
			require("scrollbar.handlers.search").setup()
			require("scrollbar").setup({
				handlers = {
					diagnostic = true,
					search = true,
				},
			})
		end,
	})

	-- スタート画面
	use({
		"goolord/alpha-nvim", -- スタート画面に履歴等表示
		requires = {
			"kyazdani42/nvim-web-devicons",
		},
		config = function()
			require("alpha").setup(require("alpha.themes.startify").config)
		end,
	})

	-- ターミナル
	use({
		"akinsho/toggleterm.nvim", -- ターミナルをウィンドウ表示(floatingはlspsagaのほうを使用, ターミナルの停止は<C-\><C-n>)
		tag = "v1.*",
		config = function()
			require("toggleterm").setup()
		end,
	})
	vim.keymap.set("n", "<M-t>", "<cmd>ToggleTerm<CR>", { silent = true, noremap = true })

	-- ヘルプ
	use({
		"folke/which-key.nvim", -- キーを一覧表示(`or'でマーク, "(normal)or<C-r>(insert)でレジスタ, <leader>kでキー)
		config = function()
			require("which-key").setup()
		end,
	})

	vim.api.nvim_set_keymap("n", "<leader>k", "<Cmd>WhichKey<CR>", { noremap = true, silent = true }) -- (k)ey

	-- ハイライト
	use({
		"norcalli/nvim-colorizer.lua", -- 色コードや名称をカラー表示
		config = function()
			require("colorizer").setup()
		end,
	})
	use({
		"folke/todo-comments.nvim", -- todo系コメントハイライトとtrouble, telecopeに表示(タグについては see:github)
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup()
		end,
	})
	use("myusuf3/numbers.vim") -- insertモード時は絶対行にする(vimscript)
	use({
		"lukas-reineke/indent-blankline.nvim", -- インデントを見やすく表示
		config = function()
			require("indent_blankline").setup({
				space_char_blankline = " ",
				show_current_context = true, -- treesitterベースでスコープを表示
				show_current_context_start = false, -- アンダースコア表示はしない
			})
		end,
	})

	vim.api.nvim_set_keymap("n", "<Leader>xt", "<cmd>TodoTrouble<CR>", { noremap = true })
	vim.api.nvim_set_keymap("n", "<Leader>ft", "<cmd>TodoTelescope<CR>", { noremap = true })

	-- 移動
	use({
		"phaazon/hop.nvim", -- ラベルジャンプ(EasyMotion風)
		config = function()
			require("hop").setup()
		end,
	})
	use("unblevable/quick-scope") -- 1行内ラベルジャンプ(キーバインドはvariables.luaで定義, vimscript)
	use("bkad/CamelCaseMotion") -- キャメルケースの移動(キーバインドはvariables.luaで定義, vimscript)

	vim.api.nvim_set_keymap("n", "<leader>m", [[<cmd>lua require('hop').hint_words()<CR>]], {}) -- motion
	vim.api.nvim_set_keymap("x", "<leader>m", [[<cmd>lua require('hop').hint_words()<CR>]], {}) -- motion

	-- 編集
	use("machakann/vim-sandwich") -- クォートなどでサンドイッチされたテキストの編集(キーバインドは標準(標準コマンドの拡張あり) see:github, vimscript)

	-- レジスタ
	use({
		"AckslD/nvim-neoclip.lua", -- レジスタを共有できtelescope可(insert modeではselect以外<C->: <CR> select, p paste, k paste-behind, q replay-macro, d delete)
		requires = {
			{ "tami5/sqlite.lua", module = "sqlite" },
			{ "nvim-telescope/telescope.nvim" },
		},
		config = function()
			require("neoclip").setup({
				enable_persistent_history = true,
			})
			require("telescope").load_extension("neoclip")
		end,
	})

	vim.api.nvim_set_keymap("n", "<leader>fr", "<Cmd>Telescope neoclip<CR>", { noremap = true, silent = true })

	-- 検索
	use("kevinhwang91/nvim-hlslens") -- 検索時にカーソルの隣にマッチ情報表示(nvim-scrollbarと連携してスクロールバーにハイライト表示)

	local hlslens_opts = { noremap = true, silent = true }
	vim.api.nvim_set_keymap(
		"n",
		"n",
		[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
		hlslens_opts
	) -- 標準コマンド拡張(順方向に再検索)
	vim.api.nvim_set_keymap(
		"n",
		"N",
		[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
		hlslens_opts
	) -- 標準コマンド拡張(逆方向に再検索)
	vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], hlslens_opts)
	vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], hlslens_opts)
	vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], hlslens_opts)
	vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], hlslens_opts)
	vim.api.nvim_set_keymap("n", "<Leader>h", ":noh<CR>", hlslens_opts) -- 標準コマンド実行(ハイライトを消す)

	-- コメント
	use({
		"numToStr/Comment.nvim", -- コメンティング(nvim-ts-context-commentstringを使用(treesitter), キーバインドは標準(標準コマンド拡張あり) see:github)
		config = function()
			require("Comment").setup({
				pre_hook = function()
					return require("ts_context_commentstring.internal").calculate_commentstring()
				end,
				post_hook = nil,
			})
		end,
	})

	-- 括弧
	use({
		"windwp/nvim-autopairs", -- 括弧を自動で閉じてくれる
		config = function()
			require("nvim-autopairs").setup({
				map_cr = false,
			})
		end,
	})

	-- テスト
	use({
		"michaelb/sniprun", -- 部分実行できるコードランナー
		run = "bash ./install.sh",
		config = function()
			require("sniprun").setup()
		end,
	})

	vim.api.nvim_set_keymap(
		"n",
		"<leader>rr",
		[[<Cmd>lua require('sniprun').run()<CR>]],
		{ noremap = true, silent = true }
	) -- runner run
	vim.api.nvim_set_keymap(
		"x",
		"<leader>rr",
		[[<Cmd>lua require('sniprun').run('v')<CR>]],
		{ noremap = true, silent = true }
	) -- runner run
	vim.api.nvim_set_keymap(
		"n",
		"<leader>rd",
		[[<Cmd>lua require('sniprun').reset()<CR>]],
		{ noremap = true, silent = true }
	) -- runner delete
	vim.api.nvim_set_keymap(
		"n",
		"<leader>rc",
		[[<Cmd>lua require('sniprun.display').close_all()<CR>]],
		{ noremap = true, silent = true }
	) -- runner close

	-- git
	use({
		"TimUntersberger/neogit", -- gitクライアント(dでdiffviewが起動できる)
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("neogit").setup({
				disable_commit_confirmation = true,
				kind = "tab",
				commit_popup = {
					kind = "split",
				},
				integrations = {
					diffview = true,
				},
			})
		end,
	})
	use({
		"sindrets/diffview.nvim", -- git diff(キーバインドは標準 see: github)
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("diffview").setup()
		end,
	})

	vim.api.nvim_set_keymap("n", "<leader><leader>gg", "<Cmd>Neogit<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<leader><leader>gd", "<Cmd>DiffviewOpen<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap(
		"n",
		"<leader><leader>gh",
		"<Cmd>DiffviewFileHistory<CR>",
		{ noremap = true, silent = true }
	)

	use({
		"lewis6991/gitsigns.nvim", -- gitの状態をカラムにサイン表示
		config = function()
			require("gitsigns").setup({
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "]h", function()
						if vim.wo.diff then
							return "]h"
						end
						vim.schedule(function()
							gs.next_hunk()
						end)
						return "<Ignore>"
					end, { expr = true })

					map("n", "[h", function()
						if vim.wo.diff then
							return "[h"
						end
						vim.schedule(function()
							gs.prev_hunk()
						end)
						return "<Ignore>"
					end, { expr = true })

					-- Actions
					map({ "n", "v" }, "<leader><leader>gs", ":Gitsigns stage_hunk<CR>")
					map({ "n", "v" }, "<leader><leader>gr", ":Gitsigns reset_hunk<CR>")
					map("n", "<leader><leader>gS", gs.stage_buffer)
					map("n", "<leader><leader>gu", gs.undo_stage_hunk)
					map("n", "<leader><leader>gR", gs.reset_buffer)
					map("n", "<leader><leader>gg", gs.preview_hunk)
					map("n", "<leader><leader>gb", function()
						gs.blame_line({ full = true })
					end)
					map("n", "<leader><leader>gB", gs.toggle_current_line_blame)
					-- map("n", "<leader><leader>gd", gs.diffthis) diffview
					-- map("n", "<leader><leader>gD", function()
					-- 	   gs.diffthis("~")
					-- end) diffview
					map("n", "<leader><leader>gD", gs.toggle_deleted)

					-- Text object
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
				end,
			})
		end,
	})

	-- github
	use({
		"pwntester/octo.nvim", -- :Octo <object> <action> [argument] コマンド(TAB補完推奨)でgithub-cliと同じようなことができる(github-cli必須)
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"kyazdani42/nvim-web-devicons",
		},
		config = function()
			require("octo").setup()
		end,
	})

	-- デバッガー
	use("mfussenegger/nvim-dap") -- noevim用デバッガアダプタプロトコル(各種debugger必須, インストール後に :helptags ALL を実行しておく)
	use("mfussenegger/nvim-dap-python") -- python用dap
	use("leoluz/nvim-dap-go") -- go用dap
	use("suketa/nvim-dap-ruby") -- ruby用dap

	local dap = require("dap")
	local dap_python = require("dap-python")
	dap_python.setup(require("os").getenv("HOME") .. "/.pyenv/shims/python")
	dap_python.test_runner = "pytest"

	local dap_go = require("dap-go")
	dap_go.setup()

	local dap_ruby = require("dap-ruby")
	dap_ruby.setup()

	dap.adapters.lldb = {
		type = "executable",
		command = "lldb-vscode",
		name = "lldb",
	}
	dap.configurations.c = {
		{
			name = "Launch",
			type = "lldb",
			request = "launch",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
			-- attach = { pidProperty = "pid", pidSelect = "ask" },
			-- env = { LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES" },
			args = {},
		},
	}
	dap.configurations.cpp = dap.configurations.c
	dap.configurations.rust = dap.configurations.c

	dap.adapters.haskell = {
		type = "executable",
		command = "haskell-debug-adapter",
		args = { "--hackage-version=0.0.33.0" },
	}
	dap.configurations.haskell = {
		{
			type = "haskell",
			request = "launch",
			name = "Debug",
			workspace = "${workspaceFolder}",
			startup = "${file}",
			stopOnEntry = true,
			logFile = vim.fn.stdpath("data") .. "/haskell-dap.log",
			logLevel = "WARNING",
			ghciEnv = vim.empty_dict(),
			ghciPrompt = "λ: ",
			ghciInitialPrompt = "λ: ",
			ghciCmd = "stack ghci --test --no-load --no-build --main-is TARGET --ghci-options -fprint-evld-with-show",
		},
	}

	vim.api.nvim_set_keymap("n", "<F4>", "<Cmd>lua require'dap'.disconnect({})<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<F5>", "<Cmd>lua require'dap'.continue()<CR>", { noremap = true, silent = true }) -- vscode
	vim.api.nvim_set_keymap("n", "<F6>", "<Cmd>lua require'dap'.load_launchjs()<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<F7>", "lua require'dap'.run_last()", { noremap = true, silent = true })
	vim.api.nvim_set_keymap(
		"n",
		"<F8>",
		"lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))",
		{ noremap = true, silent = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<F9>",
		"<Cmd>lua require'dap'.toggle_breakpoint()<CR>",
		{ noremap = true, silent = true }
	) -- vscode
	vim.api.nvim_set_keymap("n", "<F10>", "<Cmd>lua require'dap'.step_over()<CR>", { noremap = true, silent = true }) -- vscode
	vim.api.nvim_set_keymap("n", "<F11>", "<Cmd>lua require'dap'.step_into()<CR>", { noremap = true, silent = true }) -- vscode
	vim.api.nvim_set_keymap("n", "<S-F11>", "<Cmd>lua require'dap'.step_out()<CR>", { noremap = true, silent = true }) -- vscode
	vim.api.nvim_set_keymap("n", "<F12>", "<Cmd>lua require'dap'.repl.open()<CR>", { noremap = true, silent = true })

	vim.api.nvim_set_keymap(
		"n",
		"<leader>dr",
		"lua require'telescope'.extensions.dap.commands{}",
		{ noremap = true, silent = true }
	) -- run
	vim.api.nvim_set_keymap(
		"n",
		"<leader>dc",
		"<Cmd>lua require'telescope'.extensions.dap.configurations{}<CR>",
		{ noremap = true, silent = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>dd",
		"<Cmd>lua require'telescope'.extensions.dap.list_breakpoints{}<CR>",
		{ noremap = true, silent = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>dv",
		"<Cmd>lua require'telescope'.extensions.dap.variables{}<CR>",
		{ noremap = true, silent = true }
	)

	vim.cmd([[nnoremap <silent> <leader>tpp :lua require('dap-python').test_method()<CR>]])
	vim.cmd([[nnoremap <silent> <leader>tpa :lua require('dap-python').test_class()<CR>]])
	vim.cmd([[vnoremap <silent> <leader>tps <ESC>:lua require('dap-python').debug_selection()<CR>]])
	vim.cmd([[nmap <silent> <leader>tg :lua require('dap-go').debug_test()<CR>]])

	-- コマンド
	use("mileszs/ack.vim") -- :Ack
end)
