package.loaded["black"]                     = nil
package.loaded["black.util"]                = nil
package.loaded["black.colors"]              = nil
package.loaded["black.colors.conditionals"] = nil
package.loaded["black.functions"]           = nil
package.loaded["black.highlights"]          = nil
package.loaded["black.highlights.plugins"]  = nil

vim.g.black_style = "deep ocean"

require "lua.black.util.init".load()
