local puerts_lua = require "puerts_lua"

local suffix  = package.cpath:match("%p[\\|/]?%p(%a+)")

local function endswith(str, ending)
    return ending == "" or str:sub(-#ending) == ending
end

local function basename(str)
	local name = string.gsub(str, "(.*/)(.*)", "%2")
	return name
end

local function dirname(str)
	if str:match(".-/.-") then
		local name = string.gsub(str, "(.*/)(.*)", "%1")
		return name
	else
		return ''
	end
end

local function pathjoin(...)
  local parts = {...}
  local separator = package.config:sub(1,1)
  local result = table.concat(parts, separator)
  result = result:gsub(separator.."+", separator)
  return result
end

local moduleCache = {}

local function load(path)
    if not endswith(path, suffix) then
        local prefix = (suffix ~= "dll") and "lib" or ""
        path = pathjoin(dirname(path), prefix .. basename(path) .. '.' .. suffix)
    end
    
    if moduleCache[path] then return moduleCache[path] end
    
    local module_name = puerts_lua.load(path)

    local module_mt = {
        __index = function(classCache, k)
            local fullname = module_name .. '.' .. k
            
            local cls = puerts_lua.loadType(fullname)
            rawset(classCache, k, cls)
            return cls
        end
    }
    
    local m = {}
    setmetatable(m, module_mt);
    moduleCache[path] = m;
    return m;
end

local function ref(v)
    return {v}
end

local function unref(b)
    return b[1]
end

return {
    ref = ref,
    unref = unref,
    load = load,
}
