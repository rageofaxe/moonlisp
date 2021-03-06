
require "moon"

import insert from table
import type, flatten_list, symbol_metatable, is_symbol, pretty_format from require"lisp.types"

export *

__splice = (val, tail) ->
  append val, tail

__S = (name)-> setmetatable { name }, symbol_metatable

consp = (arg) -> type(arg) == "table"
listp = (arg) -> type(arg) == "table" or arg == nil

null = (arg) -> arg == nil
atom = (arg) -> not consp arg

zerop = (arg) -> arg == 0

nth = (n, lst) ->
  while n > 0
    return nil if not lst
    lst = lst[2]
    n -= 1

  lst[1]

-- tests if a,b represent the same thing
equal = (a, b) ->
  t = type a
  return false if t != type b
  if t == "table"
    equal(a[1], b[1]) and equal a[2], b[2]
  else
    a == b

reverse = (lst) ->
  assert listp(lst), "reverse takes one list"
  new = nil
  while lst
    new = {lst[1], new}
    lst = lst[2]
  new

append = (a, b) ->
  assert listp(a) and listp(b), "append takes two lists"
  a = reverse a
  while a
    b = {a[1], b}
    a = a[2]
  b

p = (...) ->
  args = {...} -- ugh fix me
  print if #args == 0
    "nil"
  else
    unpack [pretty_format x for x in *args]

