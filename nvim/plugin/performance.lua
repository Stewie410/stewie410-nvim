-- limit shared data file(s) for startup time
-- probably don't need this anymore?
vim.o.shada = "'100,<50,s10,:1000,/100,@100,h"

-- enable ft plugins & syntax for better startup time
vim.cmd.filetype("plugin indent on")
if vim.fn.exists("syntax_on") ~= 1 then
	vim.cmd.syntax("enable")
end
