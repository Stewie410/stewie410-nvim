vim.pack.add({
	{
		src = "https://github.com/JavaHello/spring-boot.nvim",
		version = "218c0c26c14d99feca778e4d13f5ec3e8b1b60f0",
	},
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/mfussenegger/nvim-dap",
	"https://github.com/nvim-java/nvim-java",
})

require("java").setup()
vim.lsp.enable("jdtls")

vim.lsp.config("jdtls", {
	settings = {
		java = {
			configuration = {
				runtimes = {
					{
						name = "SdkmanCurrent",
						path = vim.fs.normalize("~/.sdkman/candidates/java/current"),
						default = true,
					},
					{
						name = "Temurin-25.0.4",
						path = vim.fs.normalize("~/.sdkman/candidates/java/25.0.4-tem"),
						default = false,
					},
					{
						name = "GraalVM-21",
						path = vim.fs.normalize("~/.sdkman/candidates/java/21-graal"),
						default = false,
					},
					{
						name = "Temurin-21.0.6",
						path = vim.fs.normalize("~/.sdkman/candidates/java/21.0.6-tem"),
						default = false,
					},
					{
						name = "Temurin-1.8.302-b08",
						path = vim.fs.normalize("~/.sdkman/candidates/java/1.8.302-b08-tem"),
						default = false,
					},
					{
						name = "Zulu-7.0.352",
						path = vim.fs.normalize("~/.sdkman/candidates/java/7.0.352-zulu"),
						default = false,
					},
				},
			},
		},
	},
})
