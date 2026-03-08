vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>w", vim.cmd.write)
vim.keymap.set("n", "<leader>q", vim.cmd.quit)

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Mostrar diagnóstico en línea" })

-- Split current file view horizontal
vim.keymap.set("n", "<leader>sh", function()
  vim.cmd("split")
  vim.cmd("wincmd j") -- Mueve el cursor a la nueva ventana
end, { noremap = true, silent = true })

-- Split current file view vertical
vim.keymap.set("n", "<leader>sv", function()
  vim.cmd("vsplit")
  vim.cmd("wincmd l") -- Mueve el cursor a la nueva ventana
end, { noremap = true, silent = true })

-- Test integrations
vim.keymap.set("n", "<leader>tr", function() require("neotest").run.run() end, { desc = "Run nearest test" })
vim.keymap.set("n", "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end,
  { desc = "Run current file" })
vim.keymap.set("n", "<leader>ts", function() require("neotest").summary.toggle() end, { desc = "Toggle test summary" })
vim.keymap.set("n", "<leader>to", function() require("neotest").output.open({ enter = true }) end,
  { desc = "Show test output" })

