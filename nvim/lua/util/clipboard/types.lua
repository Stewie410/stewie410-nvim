---@class util.clipboard.Tool
---@field name string
---@field enable? boolean explicity enable/disable tool, default to 'true' if not provided
---@field detect fun(): boolean are copy/paste tools available
---@field copy util.clipboard.tool.Copy copy functions per register type
---@field paste util.clipboard.tool.Paste paste functions per register type

---@class util.clipboard.tool.Copy
---@field system fun(lines: string[]) copy utility for system clipboard
---@field primary fun(lines: string[]) copy utility for primary clipboard

---@class util.clipboard.tool.Paste
---@field system fun(): string[]|0 paste utility for system clipboard
---@field primary fun(): string[]|0 paste utility for primary clipboard
