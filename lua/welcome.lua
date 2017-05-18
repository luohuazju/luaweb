local mysql = require "mysql"
local cjson = require "cjson"
local req = require "req"

local args = req.getArgs()
local name = args['name']

if name == nil or name == "" then
  name = "root" 
end

name = ngx.quote_sql_str(name) -- pre handle SQL
local db = mysql:new()
local sql = "select User, Host from user where User = " .. name

ngx.say(sql)
ngx.say("<br />")

local res, err, errno, sqlstate = db:query(sql)
db:close()
if not res then
    ngx.say(err)
    return {}
end

ngx.say(cjson.encode(res))
ngx.say("<br />")
ngx.print("welcome to use LUA. That is similar to my name HUA")