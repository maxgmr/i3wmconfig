local opts = {
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = {
                command = "clippy",
            }
        }
    }
}
return opts
