vim.lsp.enable('luals')

local cmp = require('cmp')
local lspkind = require('lspkind')

-- Helper to find root using native Neovim API
local function find_root(markers)
  local cwd = vim.fn.getcwd()
  for _, marker in ipairs(markers) do
    local match = vim.fs.find(marker, { upward = true, path = cwd })[1]
    if match then return vim.fs.dirname(match) end
  end
end

local ts_config = {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
  root_markers = { 'package.json', 'tsconfig.json' },
  single_file_support = false,
}

local deno_config = {
  cmd = { 'deno', 'lsp' },
  filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
  root_markers = { 'deno.json', 'deno.jsonc' },
  single_file_support = false,
}

local ts_root_dir = find_root(ts_config.root_markers)
local deno_root_dir = find_root(deno_config.root_markers)

if deno_root_dir then
  vim.lsp.config('denols', {
    cmd = deno_config.cmd,
    filetypes = deno_config.filetypes,
    root_dir = deno_root_dir,
    single_file_support = deno_config.single_file_support,
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
  })

  vim.lsp.enable('denols')
elseif ts_root_dir then
  vim.lsp.config('ts_ls', {
    cmd = ts_config.cmd,
    filetypes = ts_config.filetypes,
    root_dir = ts_root_dir,
    single_file_support = ts_config.single_file_support,
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
  })

  vim.lsp.enable('ts_ls')
end

-- LSP features

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  end,
})

-- Autocomplete options
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'buffer' },
    { name = 'path' },
  }),
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      maxwidth = 50,
      ellipsis_char = '…',
    }),
  },
})
