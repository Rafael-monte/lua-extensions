Iterable = {
	__data = {},
}
Iterable.__index = Iterable

--  Creates a new iterable by collection given
--  @param collection - List of items
--  @return An new iterable with collection as data, i.e
--  local list = {1,1,2,3,5,8,13}
--  local iterator = Iterable.New(list) -- Creates a new Iterable object
--  print(iterator:ToString()) -- Iterator { __data = { [0]: 1, [1]: 1, ... } }
function Iterable.New(collection)
	local iterable = { __data = {} }
	if type(collection) ~= "table" then
		error("Couldn't create iterable from given data")
	end
	for _, element in ipairs(collection) do
		table.insert(iterable.__data, element)
	end
	setmetatable(iterable, Iterable)
	return iterable
end

-- Creates an new iterator by filtering current iterator.
-- @param bool_func - Boolean function with a parameter called el.
-- @return new Iterable with internal data as the return of elements from last iterator that fits into the bool_func. I.e:
-- local iterator = Iterable.New({1,2,3,4,5,6})
-- local odds = iterator
--                :Filter(function(el) el % 2 == 1 end)
--                :ToList() -- {1,3,5}
function Iterable:Filter(bool_func)
	if type(bool_func) ~= "function" then
		error("Expected function, got: " .. type(bool_func))
	end
	local iterable = { __data = {} }
	for _, element in ipairs(self.__data) do
		if bool_func(element) then
			table.insert(iterable.__data, element)
		end
	end
	setmetatable(iterable, Iterable)
	return iterable
end

-- Transforms the current iterator into a new iterator by the map_fn
-- @param map_fn - The one-param function that transform the current iterator to a new one
-- @return A new iterator with elements as described by the map_fn, i.e:
-- local iterator = Iterable:New({1,2,3,4,5,6,7,8,9,10})
-- local doubled = iterator
--                  :Map(function(el) return el * 2 end)
--                  :ToList() -- {2,4,6,8,10,12,14,16,18,20}
function Iterable:Map(map_fn)
	if type(map_fn) ~= "function" then
		error("Expected function, got: " .. type(map_fn))
	end
	local iterable = { __data = {} }
	for _, element in ipairs(self.__data) do
		table.insert(iterable.__data, map_fn(element))
	end
	setmetatable(iterable, Iterable)
	return iterable
end

-- Converts the current iterable to an list
-- Be careful: This function deletes the current iterator, i.e
--
-- local iterator = Iterable:New({"I'm an element", "I'm too!"})
-- local as_list = iterator:ToList() -- {"I'm an element", "I'm too!"}
function Iterable:ToList()
	local list = {}
	for idx, element in ipairs(self.__data) do
		list[idx] = element
	end
	self = nil
	return list
end

-- Returns the first element of iterable if it exists, otherwise returns nil
function Iterable:FirstOrNil()
	return self.__data[1] or nil
end

-- Returns the first element of iterable if it exists, otherwise returns the element in param
-- @param other - Element or function that needs to be returned if the first element of iterable doesn't exist
function Iterable:FirstOrElse(other)
	if self.__data[1] ~= nil then
		return self.__data[1]
	end
	if type(other) == "function" then
		return other()
	end
	return other
end

-- Returns a iterable of n first elements from the last iterable
-- @param n - Number of elements that will be taken from the last iterable
-- @return A new iterable with the first n elements of last iterable, i.e
-- local iterator = Iterable.New({1,2,3,4,5,6,7})
-- local first_three_elements = iterator:TakeFirst(3):ToList() -- {1,2,3}
--
-- Be careful: If n is bigger than the length of the data in the iterable, all the elements will returned, i.e
-- local two_elements = Iterable.New({"I'm an element", "Me too! I'm the second one"})
-- local first_three = two_elements:TakeFirst(3):ToList() -- {"I'm an element", "Me too! I'm the second one"}
function Iterable:TakeFirst(n)
	local iterable = { __data = {} }
	for i = 1, n do
		if self.__data[i] ~= nil then
			table.insert(iterable.__data, self.__data[i])
		else
			break
		end
	end
	setmetatable(iterable, Iterable)
	return iterable
end

function Iterable:ToString()
	local str_data = ""
	local el_as_string = ""
	for idx, element in ipairs(self.__data) do
		el_as_string = el_as_string .. "\t[" .. idx .. "]: " .. element .. ",\n"
	end
	str_data = string.format("Iterable {\n __data = {\n %s } \n}", el_as_string)
	return str_data
end
