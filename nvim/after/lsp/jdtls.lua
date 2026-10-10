---@type vim.lsp.Config
return {
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
}
