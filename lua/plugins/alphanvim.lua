local dashboard = require('alpha.themes.dashboard')

-- Custom Header
dashboard.section.header.val = {
    "=============================================================================",
    "",
    "                  ##           #           #               #",
    "                  ######     #####       #####    #       ##",
    "                  ######### ########   ######## ####    ####",
    "                  ### ##### ###  #### ####  ### #####  #####",
    "                  ###   ### ###   ### ###   ### ############",
    "                  ###   ### ###   ### ###   ### ### #### ###",
    "                  ###   ### ###   ### ###   ### ###  ##  ###",
    "                  ###   ### ###   ### ###   ### ###      ###",
    "                  ###  ###  #### #### #### #### ###      ###",
    "                  ### ###    ######     ######   ##      ###",
    "                  #####        ##         ##      #      ###",
    "                  ###                                    ###",
    "                  #                                        #",
    "                          si vis pacem, para bellum 󰞇 ",
    "",
    "=============================================================================",
}
dashboard.section.header.opts.hl = 'Statement'

-- Footer
dashboard.section.footer.val = function()
    local total_plugins = #vim.tbl_keys(require('lazy').plugins())
    local date = os.date(" %d-%m-%Y")
    local nvim_version = 'v' .. vim.version().major .. '.' .. vim.version().minor .. '.' .. vim.version().patch
    return { date .. "    " .. total_plugins .. " plugins. ⚡Neovim " .. nvim_version }
end
dashboard.section.footer.opts.hl = 'FooterCyberpunk'

-- Buttons
dashboard.section.buttons.val = {
    dashboard.button('f', '  Find File', ':Telescope find_files<CR>'),
    dashboard.button('n', '  New File', ':ene <BAR> startinsert<CR>'),
    dashboard.button('r', '  Recent Files', ':Telescope oldfiles<CR>'),
    dashboard.button('s', '  Settings', ':e $MYVIMRC<CR>'),
    dashboard.button('u', '  Update Plugins', ':Lazy sync<CR>'),
    dashboard.button('m', '  Mason', ':Mason<CR>'),
    dashboard.button('q', '  Quit', ':qa<CR>'),
}
dashboard.section.buttons.opts.hl = 'Title'

-- Layout Centralizado
dashboard.config.opts.noautocmd = true
dashboard.config.layout = {
    { type = 'padding', val = function()
        local total_height = vim.api.nvim_get_option('lines')
        local header_height = #dashboard.section.header.val + 2
        local footer_height = 2
        local buttons_height = #dashboard.section.buttons.val + 2
        local padding = (total_height - (header_height + buttons_height + footer_height)) / 2
        return math.floor(padding)
    end },
    dashboard.section.header,
    { type = 'padding', val = 2 },
    dashboard.section.buttons,
    { type = 'padding', val = 2 },
    dashboard.section.footer,
}

-- Setup Alpha
alpha.setup(dashboard.opts)



