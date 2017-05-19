-- waf begin

local ret, waf = pcall(require, "waf")

if ret then
    local c_ret, r_ret = pcall(waf.exec)
    if c_ret and r_ret then 
    -- c_ret success processed, r_ret redirect
        return
    end
end

-- waf end

local uri = ngx.var.uri
-- home page
if uri == "" or uri == "/" then
    local res = ngx.location.capture("/index.html", {})
    ngx.say(res.body)
    return
end

local m, err = ngx.re.match(uri, "([a-zA-Z0-9-]+)/*([a-zA-Z0-9-]+)*")

local is_debug = true      

local moduleName = m[1]     -- module
local method = m[2]         -- method

if not method then
    method = "index"        -- default method index
else
    method = ngx.re.gsub(method, "-", "_")    
end

-- controller is under web
local prefix = "web."       
local path = prefix .. moduleName

-- input the module web.user
local ret, ctrl, err = pcall(require, path)

if ret == false then
    if is_debug then
        ngx.status = 404
        ngx.say("<p style='font-size: 50px'>Error: <span style='color:red'>" .. ctrl .. "</span> module not found !</p>")
    end
    ngx.exit(404)
end

-- method of the module, get, index
local req_method = ctrl[method]

if req_method == nil then
    if is_debug then
        ngx.status = 404
        ngx.say("<p style='font-size: 50px'>Error: <span style='color:red'>" .. method .. "()</span> method not found in <span style='color:red'>" .. moduleName .. "</span> lua module !</p>")
    end
    ngx.exit(404)
end

-- call lua method
ret, err = pcall(req_method)

if ret == false then
    if is_debug then
        ngx.status = 404
        ngx.say("<p style='font-size: 50px'>Error: <span style='color:red'>" .. err .. "</span></p>")
    else
        ngx.exit(500)
    end
end