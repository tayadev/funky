local test = require "luatest"

local Funky = require "funky"

test("map", function(t)
  t:is(Funky.map({1,2,3}, function(x) return x * 2 end), {2,4,6})
end)

test("reduce", function(t)
  t:is(Funky.reduce({1,2,3}, function(acc, x) return acc + x end), 6)
end)

test("filter", function(t)
  t:is(Funky.filter({1,2,3}, function(x) return x % 2 == 0 end), {2})
end)

test("forEach", function(t)
  local sum = 0
  Funky.forEach({1,2,3}, function(x) sum = sum + x end)
  t:is(sum, 6)
end)

test("find", function(t)
  t:is(Funky.find({1,2,3}, function(x) return x == 2 end), 2)
end)

test("findNil", function(t)
  t:is(Funky.find({1,2,3}, function(x) return x == 4 end), nil)
end)

test("indexOf", function(t)
  t:is(Funky.indexOf({1,2,3}, 2), 2)
end)

test("indexOfNil", function(t)
  t:is(Funky.indexOf({1,2,3}, 4), nil)
end)

test("keys", function(t)
  t:is(Funky.keys({a = 1, b = 2}), {"a", "b"})
end)

test("values", function(t)
  t:is(Funky.values({a = 1, b = 2}), {1, 2})
end)

test("fill", function(t)
  t:is(Funky.fill({}, 1, 3), {1, 1, 1})
end)

test("any", function(t)
  t:is(Funky.any({1,2,3}, function(x) return x == 2 end), true)
end)

test("all", function(t)
  t:is(Funky.all({1,2,3}, function(x) return x > 0 end), true)
  t:is(Funky.all({1,2,3}, function(x) return x > 1 end), false)
end)

test("includes", function(t)
  t:is(Funky.includes({1,2,3}, 2), true)
  t:is(Funky.includes({1,2,3}, 4), false)
end)

test("without", function(t)
  t:is(Funky.without({1,2,3}, 2), {1,3})
end)

test("remove", function(t)
  local list = {1,2,3}
  Funky.remove(list, 2)
  t:is(list, {1,3})
end)

test("max", function(t)
  t:is(Funky.max({1,2,3}), 3)
end)

test("min", function(t)
  t:is(Funky.min({1,2,3}), 1)
end)

test("sum", function(t)
  t:is(Funky.sum({1,2,3}), 6)
end)

test("length", function(t)
  t:is(Funky.length({1,2,3}), 3)
end)

test("reverse", function(t)
  t:is(Funky.reverse({1,2,3}), {3,2,1})
end)

test("partition", function(t)
  t:is(Funky.partition({1,2,3}, function(x) return x % 2 == 0 end), {{2}, {1,3}})
end)

test("mixed", function(t)
  local x = Funky({1,2,3})
    :map(function(x) return x * 2 end)
    :filter(function(x) return x % 3 == 0 end)
    :reduce(function(acc, x) return acc + x end)

  t:is(x, 6)
end)

test:run()