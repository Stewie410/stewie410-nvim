return {
  {
    "vim-scripts/vcscommand.vim",
    cmd = {
      "VCSAdd",
      "VCSAnnotate",
      "VCSBlame",
      "VCSCommit",
      "VCSDelete",
      "VCSDiff",
      "VCSGotoOriginal",
      "VCSInfo",
      "VCSLock",
      "VCSLog",
      "VCSRemove",
      "VCSRevert",
      "VCSReview",
      "VCSStatus",
      "VCSUpdate",
      "VCSVimDiff",
    },
    config = function()
      local opts = {
        CommitOnWrite = 0,
        DeleteOnHide = 1,
        DisableMappings = 1,
        DisableExtensionMappings = 1,
      }

      for k, v in pairs(opts) do
        vim.g["VCSCommand" .. k] = v
      end
    end,
  },
}
