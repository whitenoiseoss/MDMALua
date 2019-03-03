require "./lua_api"

module MDMALua
  VERSION = "0.1.0"

  testvm = LUA_API.lua_newstate
  puts testvm
end
