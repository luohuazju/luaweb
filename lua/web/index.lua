local template = require "resty.template"

local _M = {}

function _M.index()
  local model = {title = "hello template", content = "<h1>content</h1>"}
  template.render('template/index.html', model)
end

return _M