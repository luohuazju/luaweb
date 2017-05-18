local uri = ngx.var.uri
-- 默认首页
if uri == "" or uri == "/" then
    local res = ngx.location.capture("/index.html", {})
    ngx.say(res.body)
    return
end