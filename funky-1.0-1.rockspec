rockspec_format = "3.0"
package = "funky"
version = "1.0-1"
source = {
  url = "git://github.com/tayadev/funky"
}
description = {
  summary = "A Library for working with lua tables",
  detailed = "A Library for working with lua tables",
  homepage = "https://github.com/tayadev/funky",
  license = "MIT"
}
dependencies = {
  "lua >= 5.1, < 5.5"
}
build = {
  type = "builtin",
  modules = {
    funky = "funky.lua"
  }
}
test_dependencies = {
  "luatest >= 1.0-1"
}
test = {
  type = "command",
  script = "funky.spec.lua"
}