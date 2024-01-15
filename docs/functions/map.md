# Map

The map() method of FunkyTable instances creates a new table populated with the results of calling a provided function on every element in the calling table.

```lua
Funky.map(table, fn)
```

## Examples

```lua live
local input = {
  {color = "red"},
  {color = "yellow"},
  {color = "lime"},
  {color = "purple"}
}

local mapped = Funky.map(input, function(e) return e.color end)

print(mapped)
```

```lua live
local input = {1, 4, 9, 16}

local mapped = Funky.map(input, function(e) return e * 2 end)

print(mapped)
```