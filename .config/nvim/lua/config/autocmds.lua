-- Autocmds are automatically loaded on the VeryLazy event
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    local function fetch_dashinfo()
      local function get_status()
        local status = ""

        local branch_out = ""
        local git_status_out = nil

        local num_ahead = 0
        local num_behind = 0

        local todo = 0

        local function finish()
          git_status_out = git_status_out or ""
          local status_map = {
            ["??"] = "?",
            [" M"] = "*",
            [" D"] = "*",
            [" A"] = "*",
            ["M "] = "/",
            ["D "] = "/",
            ["A "] = "/",
            ["MM"] = "*",
            ["AM"] = "*",
            ["AD"] = "*",
            ["AA"] = "*",
            ["UU"] = "!",
            ["AU"] = "!",
            ["UA"] = "!",
            ["AA"] = "!",
            ["DU"] = "!",
            ["UD"] = "!",
            ["DD"] = "!",
          }

          for entry in string.gmatch(git_status_out, "[^\n]+") do
            local entry_status = entry:sub(1, 2)
            local status_symbol = status_map[entry_status]
            if not string.match(status, status_symbol) then
              status = status .. status_symbol
            end
          end

          git_status = { { "  —  ", hl = "footer" }, { branch_out .. status, hl = "special" } }

          if num_behind > 0 then
            table.insert(git_status, { " • ", hl = "footer" })
            table.insert(git_status, { num_behind .. "↓", hl = "special" })
          end

          if num_ahead > 0 then
            table.insert(git_status, { " • ", hl = "footer" })
            table.insert(git_status, { num_ahead .. "↑", hl = "special" })
          end

          vim.schedule(function()
            local Snacks = require("snacks")
            Snacks.dashboard.update()
          end)
        end

        vim.system({ "git", "rev-parse", "--abbrev-ref", "HEAD" }, function(res)
          todo = todo - 1
          branch_out = strip_str(res.stdout) or ""
          if todo == 0 then
            finish()
            return
          end
        end)
        vim.system({ "git", "status", "--porcelain" }, function(res)
          todo = todo - 1
          git_status_out = res.stdout or ""
          if todo == 0 then
            finish()
            return
          end
        end)
        vim.system({ "git", "rev-list", "--count", "HEAD..@{u}" }, function(res)
          todo = todo - 1
          num_behind = tonumber(strip_str(res.stdout)) or 0
          if todo == 0 then
            finish()
            return
          end
        end)
        vim.system({ "git", "rev-list", "--count", "@{u}..HEAD" }, function(res)
          todo = todo - 1
          num_ahead = tonumber(strip_str(res.stdout)) or 0
          if todo == 0 then
            finish()
            return
          end
        end)
      end

      local function get_issues()
        vim.system({ "gh", "issue", "list", "--json", "number" }, function(res)
          local _, num_issues = string.gsub(res.stdout, "{", "")
          if num_issues <= 0 then
            return
          end
          gh_issues = {
            { " • ", hl = "footer" },
            { "⦿" .. num_issues, hl = "special" },
          }
          vim.schedule(function()
            local Snacks = require("snacks")
            Snacks.dashboard.update()
          end)
        end)
      end

      get_issues()
      get_status()
    end
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*/leet/*",

  callback = function(args)
    local bufnr = args.buf

    if vim.b[bufnr].leetcode_fixed then
      return
    end

    vim.defer_fn(function()
      if vim.api.nvim_buf_is_valid(bufnr) then
        vim.cmd("silent! normal! u")
        vim.b[bufnr].leetcode_fixed = true
      end
    end, 500)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.keymap.set({ "n", "x" }, "<localleader>r", function()
      Snacks.debug.run()
    end, { desc = "Run Lua", buffer = true })
  end,
})

local function augroup(name)
  return vim.api.nvim_create_augroup("mcvim" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    if vim.fn.has("nvim-0.13") == 1 then
      vim.hl.hl_op()
    else
      (vim.hl or vim.highlight).on_yank()
    end
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc_jumped then
      return
    end
    vim.b[buf].last_loc_jumped = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "checkhealth",
    "dap-float",
    "dbout",
    "gitsigns-blame",
    "grug-far",
    "help",
    "lspinfo",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("man_unlisted"),
  pattern = { "man" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("json_conceal"),
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})
