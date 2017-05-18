local _M = {}

-- fetch both http get/post params
function _M.getArgs()
    local request_method = ngx.var.request_method
    local args = ngx.req.get_uri_args()
    -- POST args
    if "POST" == request_method then
        ngx.req.read_body()
        local postArgs, err = ngx.req.get_post_args()
        if postArgs then
            for k, v in pairs(postArgs) do
                args[k] = v
            end
        end
    end
    return args
end

return _M