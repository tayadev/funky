--[[
Funky - A Library for working with lua tables
Author: Taya Crystals (https://taya.one)
License: MIT

TODO:
- Documentation
- Examples
- Tests
- More Functions
- flatMap
- isEmpty
- zip
- unzip
- slice
- push
- pop
- shift
- unshift
- range
- sort
- clear/empty

All functions should be able to be used standalone, or as methods, and if sensible should return a new FunkyTable so that they can be chained
]]

---@class Funky
---@operator call(table): Funky
local Funky = {}

setmetatable(Funky, {__call = function(_, ...)
  return setmetatable(..., {__index = Funky})
end})

---Creates a new list by applying 'fn' to each element of 'list'
---@param list table
---@param fn fun(element: any, index: number, list: table): any
---@return Funky
function Funky.map(list, fn)
  local mapped = {}
  for index, value in ipairs(list) do
    mapped[index] = fn(value, index, list)
  end
  return Funky(mapped)
end

---TODO: docs
---@param list table
---@param fn fun(accumulator: any, currentValue: any, currentIndex: number, list: table): any
---@param initialValue any?
---@return any
function Funky.reduce(list, fn, initialValue)
  local acc = initialValue or list[1]
  for index, value in ipairs(list) do
    if not(initialValue or index == 1) then
      acc = fn(acc, value, index, list)
    end
  end
  return acc
end

---Creates a new list from all elements of 'list' that pass the test implemented by the provided function 'fn'
---@param list table
---@param fn fun(element: any, index: number, list: table): boolean
---@return Funky
function Funky.filter(list, fn)
  local filtered = {}
  for index, value in ipairs(list) do
    if fn(value, index, list) then
      table.insert(filtered, value)
    end
  end
  return Funky(filtered)
end

---Calls the function 'fn' for every element of 'list'
---@param list table
---@param fn fun(element: any, index: number, list: table)
---@return Funky
function Funky.forEach(list, fn)
  for i, v in ipairs(list) do
    fn(v, i, list)
  end
  return Funky(list)
end

---Finds the first entry of 'list' that satisfies the test implemented by the provided function 'fn'. Returns nil if none could be found
---@param list table
---@param fn fun(element: any, index: number, list: table): boolean
---@return any|nil
function Funky.find(list, fn)
  for i, v in ipairs(list) do
    if fn(v, i, list) then
      return v
    end
  end
  return nil
end

---Returns the first index with the given value (or nil if not found).
---@param list table
---@param value any
---@return integer?
function Funky.indexOf(list, value)
  for i, v in ipairs(list) do
    if v == value then
      return i
    end
  end
  return nil
end

---Returns a list of the keys of 'table'
---@param t table
---@return table
function Funky.keys(t)
  local keys = {}
  for key, _ in pairs(t) do
    table.insert(keys, key)
  end
  return keys
end

---Returns a list of the values of 'table'
---@param t table
---@return table
function Funky.values(t)
  local values = {}
  for _, value in pairs(t) do
    table.insert(values, value)
  end
  return values
end

--- TODO: docs
function Funky.fill(list, value, count)
  for i = 1, count do
    list[i] = value
  end
  return Funky(list)
end

---Determines whether a entry of 'list' satisfies the test implemented by the provided function 'fn'
---@param list table
---@param fn fun(element: any, index: number, list: table): boolean
---@return boolean
function Funky.any(list, fn)
  for i, v in ipairs(list) do
    if fn(v, i, list) then
      return true
    end
  end
  return false
end

---Determines whether all entries of 'list' satisfy the test implemented by the provided function 'fn'
---@param list any
---@param fn fun(element: any, index: number, list: table): boolean
---@return boolean
function Funky.all(list, fn)
  for i, v in ipairs(list) do
    if not fn(v, i, list) then
      return false
    end
  end
  return true
end

---Determines whether 'list' includes a certain value 'value' among its entries
---@param list table
---@param value any
---@return boolean
function Funky.includes(list, value)
  for _, v in ipairs(list) do
    if v == value then
      return true
    end
  end
  return false
end

---Returns a new table with all table entries removed that match 'element'
---@param list table
---@param element any
---@return Funky
function Funky.without(list, element)
  return Funky.filter(list, function(e) return e ~= element end)
end

---Removes all table entries that match 'element' (Modifies table!)
---@param list table
---@param element any
function Funky.remove(list, element)
  local without = Funky.without(list, element)
  for k, v in pairs(list) do table.remove(list) end
  for k, v in pairs(without) do list[k] = v end
end

function Funky.max(list)
  local max = list[1]
  for _, v in ipairs(list) do
    if v > max then max = v end
  end
  return max
end

function Funky.sum(list)
  return Funky.reduce(list, function (accumulator, currentValue, currentIndex, list)
    return accumulator + currentValue
  end)
end

function Funky.min(list)
  local min = math.huge
  for _, v in ipairs(list) do
    if v < min then min = v end
  end
  return min
end

-- FIXME: this don't work with non number keys
function Funky.length(list)
  return #list
end

function Funky.reverse(list)
  local reversed = {}
  for i = #list, 1, -1 do
    table.insert(reversed, list[i])
  end
  return Funky(reversed)
end

--- DANGER: unconventionally uses key instead of index
--- TODO: document and find a better standard for the other fucitons to also allow this
function Funky.partition(list, fn)
  local a = {}
  local b = {}
  for key, value in pairs(list) do
    if fn(value, key) then
      if type(key) == "number" then
        table.insert(a, value)
      else
        a[key] = value
      end
    else
      if type(key) == "number" then
        table.insert(b, value)
      else
        b[key] = value
      end
    end
  end
  return Funky{Funky(a), Funky(b)}
end

return Funky