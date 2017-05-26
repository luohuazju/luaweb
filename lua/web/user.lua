local cjson = require "cjson"
local req = require "lite.req"
local rocks = require "luarocks.loader"
local md5 = require "md5"

local _M = {}

local users = {"Mr Li", "Mr Luo", "Mr Kang"}

function _M.index()
  -- ngx.say(md5.sumhexa("testforfun"));
  ngx.say(cjson.encode(users))
end

function _M.get()
  local args = req.getArgs()
  local index = tonumber(args['index'])
  if not index then
    index = 1
  end
  ngx.say(users[index])
end

return _M