local _local_file = debug.getinfo(1).short_src
local _n, _n, _current_directory = string.find(debug.getinfo(1).short_src, "^(.+/)[^/]+$")
__directory = _current_directory

package.cpath = "/opt/glink/?.so;" .. package.cpath
package.path = "/opt/glink/?.lua;" .. package.path

local glinkLocal =  io.open (".glinkDirectory", "r")
if glinkLocal then 
	__directory = glinkLocal:read() 
end

dofile(__directory .. "/glinkBase.lua")

