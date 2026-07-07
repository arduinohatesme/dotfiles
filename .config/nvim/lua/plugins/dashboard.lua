local colors = require("extras.dashcols")
local git_status = {}
local gh_issues = {}

local function getHost()
	local f = io.popen("hostname")
	local hostname = f:read("*a")
	f:close()
	return string.gsub(hostname, "%s+", "")
end

local hostname = getHost()

local function strip_str(input)
  local new_str, _ = string.gsub(input, "%s+", "")
  return new_str
end

local function get_status()
  local status = ""

  local branch_out = ""
  local git_status_out = nil

  local num_ahead = 0
  local num_behind = 0

  local completed = 0
  local total = 4

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
    completed = completed + 1
    branch_out = strip_str(res.stdout) or ""
    if completed >= total then
      finish()
      return
    end
  end)
  vim.system({ "git", "status", "--porcelain" }, function(res)
    completed = completed + 1
    git_status_out = res.stdout or ""
    if completed >= total then
      finish()
      return
    end
  end)
  vim.system({ "git", "rev-list", "--count", "HEAD..@{u}" }, function(res)
    completed = completed + 1
    num_behind = tonumber(strip_str(res.stdout)) or 0
    if completed >= total then
      finish()
      return
    end
  end)
  vim.system({ "git", "rev-list", "--count", "@{u}..HEAD" }, function(res)
    completed = completed + 1
    num_ahead = tonumber(strip_str(res.stdout)) or 0
    if completed >= total then
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

local function footer()
  local lazy_stats = require("lazy.stats").stats()
  local ms = string.format("%.2f", lazy_stats.startuptime)
  local foot = {
    align = "center",
    text = {
      { lazy_stats.loaded .. "/" .. lazy_stats.count, hl = "special" },
      { " • ", hl = "footer" },
      { ms, hl = "special" },
    },
  }
  if Snacks.git.get_root() then
    for _, chunk in ipairs(git_status) do
      table.insert(foot.text, chunk)
    end
    for _, chunk in ipairs(gh_issues) do
      table.insert(foot.text, chunk)
    end
  end
  return foot
end

return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    dashboard = {
      enabled = true,
      preset = {
        pick = function(cmd, opts)
          return Snacks.picker.files(cmd, opts)()
        end,
        header = [[
      ::::    ::: :::::::::: ::::::::  :::     ::: :::::::::::   :::   ::: 
     :+:+:   :+: :+:       :+:    :+: :+:     :+:     :+:      :+:+: :+:+: 
    :+:+:+  +:+ +:+       +:+    +:+ +:+     +:+     +:+     +:+ +:+:+ +:+ 
   +#+ +:+ +#+ +#++:++#  +#+    +:+ +#+     +:+     +#+     +#+  +:+  +#+  
  +#+  +#+#+# +#+       +#+    +#+  +#+   +#+      +#+     +#+       +#+   
 #+#   #+#+# #+#       #+#    #+#   #+#+#+#       #+#     #+#       #+#    
###    #### ########## ########      ###     ########### ###       ###     
  ]],
        -- stylua: ignore
        ---@type snacks.dashboard.Item[]
        keys = {
          { key = "f", desc = "Find File", action = function() require("telescope.builtin").find_files() end },
          { key = "n", desc = "New File", action = ":ene | startinsert" },
          { key = "s", desc = "Search Files", action = function() require("telescope.builtin").live_grep() end},
          { key = "r", desc = "Restore Session", section = "session" },
          { key = "c", desc = "Config", action = function()
            require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
          end },
          { key = "q", desc = "Quit", action = ":qa" },
        },
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        footer,
      },
    },
  },

  init = function()
    get_issues()
    get_status()
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = colors.head })
        vim.api.nvim_set_hl(0, "SnacksDashboardDesc", { fg = colors.txt })
        vim.api.nvim_set_hl(0, "SnacksDashboardKey", { fg = colors.key })
        vim.api.nvim_set_hl(0, "SnacksDashboardFooter", { fg = colors.txt })
        vim.api.nvim_set_hl(0, "SnacksDashboardSpecial", { fg = colors.imp })
      end,
    })
  end,
}
