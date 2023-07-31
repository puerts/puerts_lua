package = "puerts"
version = "0.0.1-1"
source = {
   url = "https://github.com/puerts/puerts_lua.git"
}
description = {
   homepage = "https://github.com/puerts/puerts_lua",
   license = "MIT"
}
dependencies = {
   "lua >= 5.3"
}

build = {
   type = "cmake",
   variables = {
     CMAKE_INSTALL_PREFIX = "$(PREFIX)",
   }
}