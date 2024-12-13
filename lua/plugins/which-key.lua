local wk = require("which-key")

wk.setup({
  plugins = {
    marks = true,
    registers = true,
    spelling = {
      enabled = true,
      suggestions = 20,
    },
    presets = {
      operators = true,
      motions = true,
      text_objects = true,
      windows = true,
      nav = true,
      z = true,
      g = true,
    },
  },
  win = {
    border = "rounded",
    no_overlap = true,
    padding = { 1, 1 }, -- Reduzido para menos espaçamento
    title = true,
    title_pos = "center",
    zindex = 1000,
  },
  layout = {
    spacing = 4, -- Ajustado para se parecer com o original
    width = { min = 20 }, -- Largura mínima das colunas
  },
  show_help = true,
  show_keys = true,
  icons = {
    breadcrumb = "»",
    separator = "➜",
    group = "+",
    mappings = true,
  },
})

-- Função para abrir terminais
local function open_terminal(direction, position)
  local Terminal = require("toggleterm.terminal").Terminal
  local cwd = vim.fn.expand("%:p:h") -- Caminho do diretório atual
  if cwd == "" or vim.bo.filetype == "" then
    cwd = nil -- Caminho padrão
  end

  local size = (direction == "horizontal" and 10) or nil
  local term = Terminal:new({
    direction = direction,
    size = size,
    dir = cwd,
    on_open = function()
      if position == "above" then
        vim.cmd("wincmd K")
      end
    end,
  })

  term:toggle()
end

-- Função para alternar janelas
local function switch_to_window(number)
  local windows = vim.api.nvim_list_wins()
  if windows[number] then
    vim.api.nvim_set_current_win(windows[number])
  else
    print("Janela " .. number .. " não encontrada.")
  end
end

-- Mapeamentos
wk.add({

  -- Grupos
  { "<leader>b", group = "Buffers" },
  { "<leader>w", group = "Windows" },
  { "<leader>l", group = "LSP/Run" },
  { "<leader>t", group = "Toggles" },
  { "<leader>g", group = "Git" },
  { "<leader>d", group = "Diagnostics" },
  { "<leader>s", group = "Search" },


  -- Alternar janelas numeradas
  { "<leader>1", function() switch_to_window(1) end, desc = "Window 1" },
  { "<leader>2", function() switch_to_window(2) end, desc = "Window 2" },
  { "<leader>3", function() switch_to_window(3) end, desc = "Window 3" },
  { "<leader>4", function() switch_to_window(4) end, desc = "Window 4" },

  -- Buffers
  { "<leader>bn", ":bnext<CR>", desc = "Next Buffer" },
  { "<leader>bp", ":bprevious<CR>", desc = "Previous Buffer" },
  { "<leader>bd", ":bdelete<CR>", desc = "Delete Buffer" },
  { "<leader>bl", ":Telescope buffers<CR>", desc = "List Buffers" },

  -- Janelas e Layouts
  { "<leader>ws", function()
      vim.cmd("split")
      vim.cmd("enew")
    end, desc = "Horizontal Split (Empty)" },
  { "<leader>wv", function()
      vim.cmd("vsplit")
      vim.cmd("enew")
    end, desc = "Vertical Split (Empty)" },
  { "<leader>wc", function()
      local current_buf = vim.api.nvim_get_current_buf()
      vim.cmd("close")
      vim.cmd("bdelete " .. current_buf)
    end, desc = "Close Window and Buffer" },
  { "<leader>wo", ":only<CR>", desc = "Close Other Windows" },
  { "<leader>wq", ":q<CR>", desc = "Quit Window" },

  -- LSP e Terminais
  { "<leader>lb", ":ToggleTermSendCommand build<CR>", desc = "Build Project" },
  { "<leader>lr", ":ToggleTermSendCommand run<CR>", desc = "Run Project" },
  { "<leader>li", ":LspInfo<CR>", desc = "LSP Info" },
  { "<leader>lf", ":Format<CR>", desc = "Format Code" },

  -- Toggles
  { "<leader>tz", ":ZenMode<CR>", desc = "Toggle Zen Mode" },
  { "<leader>tn", ":Noice dismiss<CR>", desc = "Dismiss Noice" },
  { "<leader>tt", ":Twilight<CR>", desc = "Toggle Twilight" },
  { "<leader>tg", ":Gitsigns toggle_signs<CR>", desc = "Toggle Git Signs" },
  { "<leader>tb", function() open_terminal("horizontal", "below") end, desc = "Terminal Below" },
  { "<leader>ta", function() open_terminal("horizontal", "above") end, desc = "Terminal Above" },
  { "<leader>tc", function() open_terminal("float") end, desc = "Floating Terminal" },

  -- Git
  { "<leader>gs", ":Neogit<CR>", desc = "Git Status" },
  { "<leader>gb", ":Telescope git_branches<CR>", desc = "Git Branches" },
  { "<leader>gc", ":Neogit commit<CR>", desc = "Git Commit" },
  { "<leader>gp", ":Neogit push<CR>", desc = "Git Push" },
  { "<leader>gl", ":Neogit pull<CR>", desc = "Git Pull" },

  -- Alternar foco no Neotree
  { "<leader>e", function()
      if vim.bo.filetype == "neo-tree" then
        vim.cmd("wincmd p")
      else
        vim.cmd("Neotree focus")
      end
    end, desc = "Toggle File Explorer" },

  -- Diagnósticos
  { "<leader>dn", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
  { "<leader>dp", vim.diagnostic.goto_prev, desc = "Previous Diagnostic" },
  { "<leader>dl", ":Telescope diagnostics<CR>", desc = "List Diagnostics" },

  -- Pesquisas
  { "<leader>sf", ":Telescope find_files<CR>", desc = "Find Files" },
  { "<leader>sg", ":Telescope live_grep<CR>", desc = "Grep Files" },
  { "<leader>sb", ":Telescope buffers<CR>", desc = "Find Buffers" },
  { "<leader>sh", ":Telescope help_tags<CR>", desc = "Help Tags" },
})
