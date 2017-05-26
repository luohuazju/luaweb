local _M = {}

function parse_ip(ip_str)
    local ip_list = {}
    local it, err = ngx.re.gmatch(ip_str, '([0-9]+)[.]([0-9]+)[.]([0-9]+)[.]([0-9]+)')
    while true do
        local m, err = it()
        if err then
            ngx.log(ngx.ERR, "error: ", err)
            return
        end
        if not m then   break   end
        ip_list[m[0]] =  true
    end
    return ip_list
end


local white_list_str = "127.0.0.1,192.168.0.168"
local white_list = parse_ip(white_list_str)

local black_list_str = "127.0.0.1,192.168.0.168,localhost"
local black_list = parse_ip(black_list_str)

function get_client_ip()
    local ip = ngx.req.get_headers()["x_forwarded_for"]
    if not ip then
       ip = ngx.var.remote_addr
    else
       ip = ngx.re.gsub(ip, ",.*", "")
    end
    return ip
end

function _M.exec()
    local ip = get_client_ip()
    ngx.log(ngx.DEBUG, 'the ip I get = ' .. ip)
    -- in the white list, return directly
    if white_list[ip] then
        return false
    end
    -- black list, return 444
    if black_list[ip] then
        ngx.exit(444)
        return true
    end
end

return _M