-- autohotkey
vim.filetype.add({
	pattern = {
		[".*%.ahk"] = "autohotkey",
		[".*%.autohotkey"] = "autohotkey",
		[".*%.ahk?[12]"] = "autohotkey",
	},
})

-- apache config
vim.filetype.add({
	pattern = {
		[".*/apache2?/.*%.conf"] = "apache",
		[".*/apache2?/.*%.load"] = "apache",

		[".*/httpd/.*%.conf"] = "apache",
		[".*/httpd/.*%.load"] = "apache",
	},
})

-- crontab
vim.filetype.add({
	extension = {
		cron = "crontab",
		crontab = "crontab",
	},
})

-- docker
vim.filetype.add({
	pattern = {
		[".*[Dd]ockerfile"] = "dockerfile",
		["[Dd]ockerfile.*"] = "dockerfile",
	},
})

-- docker compose
vim.filetype.add({
	pattern = {
		[".*[Dd]ocker%-[Cc]ompose%.ya?ml"] = "yaml.docker-compose",
		["[Dd]ocker%-[Cc]ompose.*%.ya?ml"] = "yaml.docker-compose",

		[".*[Cc]ompose%.ya?ml"] = "yaml.docker-compose",
		["[Cc]ompose.*%.ya?ml"] = "yaml.docker-compose",
	},
})

-- fail2ban
vim.filetype.add({
	pattern = {
		[".*/fail2ban/.*%.conf"] = "dosini",
		[".*/fail2ban/.*%.local"] = "dosini",
	},
})

-- fio
vim.filetype.add({
	extension = {
		fio = "dosini",
	},
})

-- groff
vim.filetype.add({
	extension = {
		ms = "groff",
		me = "groff",
		mom = "groff",
		man = "groff",
	},
})

-- groovy
vim.filetype.add({
	extension = {
		groovy = "groovy",
		gsh = "groovy",
		gvy = "groovy",
		gy = "groovy",
	},
})

-- jq
vim.filetype.add({
	extension = {
		jq = "jq",
	},
})

-- logfile
vim.filetype.add({
	extension = {
		log = "log",
	},
})

-- markdown
vim.filetype.add({
	pattern = {
		[".*README.*%.txt"] = "markdown",
		[".*TODO.*%.txt"] = "markdown",
	},
})

-- mysql & mariadb
vim.filetype.add({
	pattern = {
		[".*my%.cnf"] = "dosini",
		["my.*%.cnf"] = "dosini",
		[".*%.dbpwd"] = "dosini",
	},
})

-- powershell
vim.filetype.add({
	extension = {
		ps1 = "powershell",
		psm1 = "powershell",
		psd1 = "powershell",
		pwsh = "powershell",
	},
})

-- robots.txt
vim.filetype.add({
	pattern = {
		[".*[Rr]obots%.txt"] = "robots",
		["[Rr]obots.*%.txt"] = "robots",
	},
})

-- service config
vim.filetype.add({
	pattern = {
		["/etc/default/.*"] = "env",
		[".*/default/.*"] = "env",
	},
})

-- ssh config
vim.filetype.add({
	pattern = {
		["/etc/ssh/ssh_config%.d/.*%.conf"] = "sshconfig",
		[".*/%.ssh/.*%.conf"] = "sshconfig",
	},
})

-- sshd config
vim.filetype.add({
	pattern = {
		["/etc/ssh/sshd_config%.d/.*%.conf"] = "sshdconfig",
	},
})

-- stunnel
vim.filetype.add({
	pattern = {
		[".*[Ss]tunnel%.conf"] = "dosini",
		["[Ss]tunnel.*%.conf"] = "dosini",
	},
})

-- systemd unit
vim.filetype.add({
	extension = {
		service = "systemd",
		socket = "systemd",
		device = "systemd",
		mount = "systemd",
		automount = "systemd",
		swap = "systemd",
		target = "systemd",
		path = "systemd",
		timer = "systemd",
		slice = "systemd",
		scope = "systemd",
	},
})

-- TeX
vim.filetype.add({
	extension = {
		tex = "tex",
	},
})

-- tracwiki
vim.filetype.add({
	pattern = {
		[".*%.trac%.wiki"] = "tracwiki",
	},
	extension = {
		tracwiki = "tracwiki",
		trac = "tracwiki",
		tw = "tracwiki",
	},
})

-- xorg
vim.filetype.add({
	pattern = {
		[".*%.Xresources"] = "xdefaults",
		[".*%.Xdefaults"] = "xdefaults",
		[".*%.Xmodmap"] = "xdefaults",
	},
})
