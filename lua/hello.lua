local req = require "req"
local cjson = require "cjson"
local redis = require "redis"

local args = req.getArgs()

-- convert string to JSON object
local json_str = '{"name": "Carl.Luo", "age": 35}'
local json = cjson.decode(json_str)
local key = args['key']

if key == nil or key == "" then
  key = "foo"
end

local red = redis:new()
local value = red:get(key)
red:close()
ngx.say("key = " .. key .. "Value = " .. value .. "<br />")

local json_str2 = cjson.encode(json);
ngx.say(json_str2 .. "<br />");

local name = args['name']

if name == nil or name == "" then
  name = "Guest"
end

ngx.say("Name = " .. json['name'] .. ", Age = " .. tostring(json['age']) .. "\n") 

ngx.say("<p>hello, " .. name .." Welcome to LUA</p>")