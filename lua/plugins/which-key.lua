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
  window = {
    border = "rounded",
    position = "bottom",
    margin = { 1, 0, 1, 0 },
    padding = { 2, 2, 2, 2 },
  },
  layout = {
    spacing = 6,
    align = "left",
  },
  ignore_missing = false,
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
  triggers = "auto",
})

-- open terminals
local function open_terminal(direction, position)
  local Terminal = require("toggleterm.terminal").Terminal

  local cwd = vim.fn.expand("%:p:h") -- diretório do arquivo atual
  if cwd == "" or vim.bo.filetype == "" then
    cwd = nil -- diretório padrão caso nenhum arquivo esteja aberto
  end

  local size = (direction == "horizontal" and 10) or nil -- tamanho para horizontais
  local term = Terminal:new({
    direction = direction,
    size = size,
    dir = cwd, -- diretório inicial
    on_open = function(term)
      if position == "above" then
        vim.cmd("wincmd K") -- joga o terminal para cima
      end
    end,
  })

  term:toggle()
end


-- Switch windows
local function switch_to_window(number)
  local windows = vim.api.nvim_list_wins()
  if windows[number] then
    vim.api.nvim_set_current_win(windows[number])
  else
    print("Janela " .. number .. " não encontrada.")
  end
end

wk.register({
  -- Atribui numeros as janelas
  ["1"] = { function() switch_to_window(1) end, "Window 1" },
  ["2"] = { function() switch_to_window(2) end, "Window 2" },
  ["3"] = { function() switch_to_window(3) end, "Window 3" },
  ["4"] = { function() switch_to_window(4) end, "Window 4" },
  ["5"] = { function() switch_to_window(5) end, "Window 5" },
  ["6"] = { function() switch_to_window(6) end, "Window 6" },
  ["7"] = { function() switch_to_window(7) end, "Window 7" },
  ["8"] = { function() switch_to_window(8) end, "Window 8" },
  ["9"] = { function() switch_to_window(9) end, "Window 9" },



  -- Buffers
  b = {
    name = "Buffers",
    n = { ":bnext<CR>", "Next Buffer" },
    p = { ":bprevious<CR>", "Previous Buffer" },
    d = { ":bdelete<CR>", "Delete Buffer" },
    l = { ":Telescope buffers<CR>", "List Buffers" },
  },

  -- Janela e Layouts
  w = {
    name = "Windows",
    s = { function()
      vim.cmd("split")   -- split horizontal
      vim.cmd("enew")    -- novo buffer vazio
    end, "Horizontal Split (Empty)" },
    v = { function()
      vim.cmd("vsplit")  -- split vertical
      vim.cmd("enew")    -- novo buffer vazio
    end, "Vertical Split (Empty)" },
    c = { function()
      local current_buf = vim.api.nvim_get_current_buf() -- buffer atual
      vim.cmd("close")                                  -- fecha a janela
      vim.cmd("bdelete " .. current_buf)                -- fecha o buffer
    end, "Close Window and Buffer" },
    o = { ":only<CR>", "Close Other Windows" },
    q = { ":q<CR>", "Quit Window" },
  },

  -- LSP e Terminal
  l = {
    name = "LSP/Run",
    b = { ":ToggleTermSendCommand build<CR>", "Build Project" },
    r = { ":ToggleTermSendCommand run<CR>", "Run Project" },
    i = { ":LspInfo<CR>", "LSP Info" },
    f = { ":Format<CR>", "Format Code" },
  },

  -- Toggles
  t = {
    name = "Toggles",
    z = { ":ZenMode<CR>", "Toggle Zen Mode" },
    n = { ":Noice dismiss<CR>", "Dismiss Noice" },
    t = { ":Twilight<CR>", "Toggle Twilight" },
    g = { ":Gitsigns toggle_signs<CR>", "Toggle Git Signs" },
    t = {
      name = "Terminals",
      t = { function() open_terminal("horizontal", "below") end, "Terminal Abaixo" },
      a = { function() open_terminal("horizontal", "above") end, "Terminal Acima" },
      c = { function() open_terminal("float") end, "Terminal Flutuante" },
    },
  },

  -- Git
  g = {
    name = "Git",
    s = { ":Neogit<CR>", "Status" },
    b = { ":Telescope git_branches<CR>", "Branches" },
    c = { ":Neogit commit<CR>", "Commit" },
    p = { ":Neogit push<CR>", "Push" },
    l = { ":Neogit pull<CR>", "Pull" },
  },

  -- Alterna o foco entre o buffer atual e o neotree
  e = { function()
    -- buffer atual é do Neotree ?
    if vim.bo.filetype == "neo-tree" then
      -- se for, volta para a janela anterior
      vim.cmd('wincmd p')
    else
      -- se não foca no neotree
      vim.cmd('Neotree focus')
    end
  end, "Toggle File Explorer" },


  -- Diagnósticos e Debugging
  d = {
    name = "Diagnostics",
    n = { vim.diagnostic.goto_next, "Next Diagnostic" },
    p = { vim.diagnostic.goto_prev, "Previous Diagnostic" },
    l = { ":Telescope diagnostics<CR>", "List Diagnostics" },
  },

  -- Pesquisas
  s = {
    name = "Search",
    f = { ":Telescope find_files<CR>", "Find Files" },
    g = { ":Telescope live_grep<CR>", "Grep Files" },
    b = { ":Telescope buffers<CR>", "Find Buffers" },
    h = { ":Telescope help_tags<CR>", "Help Tags" },
  },
}, { prefix = "<leader>" })
 