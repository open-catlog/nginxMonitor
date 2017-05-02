-- statistics.lua

local access = ngx.shared.access
local args = ngx.req.get_uri_args()
-- 获取所有的key值，默认获取1024条
local keys = access:get_keys(0)

for i = 1, #keys do
  local key = keys[i]
  local val = access:get(key) or 0
  ngx.say(key, ":" ,val)
end