-- statistics.lua

local access = ngx.shared.access
local args = ngx.req.get_uri_args()
local host = ngx.var.host
local find = string.find
local uri = args["uri"]

if uri then
  local req_time_key = table.concat({host, ":", uri, ":request_time"})
  local total_req_key = table.concat({host, ":", uri, ":request_count"})
  local average_time_key = table.concat({host, ":", uri, ":average_request_time"})

  local count_req_sum = access:get(total_req_key) or 0
  local time_req_sum = access:get(req_time_key) or 0
  local time_req_ave = access:get(average_time_key) or 0

  ngx.say(count_req_sum, ",", time_req_sum, ",", time_req_ave)
else
  local keys = access:get_keys()
  for i = 1, #keys do
    local key = keys[i]
    if find(key, host) then
      local val = access:get(key) or 0
      ngx.say(key, ":" ,val)
    end
  end
end