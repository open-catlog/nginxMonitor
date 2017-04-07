-- statistics.lua

local access = ngx.shared.access
local args = ngx.req.get_uri_args()
local keys = access:get_keys()

for i = 1, #keys do
  local key = keys[i]
  local val = access:get(key) or 0
  ngx.say(key, ":" ,val)
end