
local platform = vim.loop.os_uname().sysname

local vars {
    MAKE_BIN = (platform == "FreeBSD" and {"gmake"} or {"make"})[1]
}

return exports
