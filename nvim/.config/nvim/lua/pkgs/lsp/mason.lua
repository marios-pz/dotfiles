local status_ok, mason = pcall(require, "mason")
if not status_ok then
    return
end

local settings = {
    ui = {
        icons = {
            package_installed = "✝",
            package_pending = "✓",
            package_uninstalled = "✗",
        },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 10,
}

mason.setup(settings)

local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
    return
end

mason_lspconfig.setup({
    ensure_installed = {},
    automatic_installation = true,
})
