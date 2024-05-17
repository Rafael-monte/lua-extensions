require("itertools.itertools")

describe("Iterator's Map method tests", function()
	it("Should Map a list of integers to string", function()
		local elements = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }
		local iterator = Iterable.New(elements)
		local as_string = iterator
			:Map(function(el)
				return "" .. el
			end)
			:ToList()
		for _, element in ipairs(as_string) do
			assert.is_true(type(element) == "string")
		end
	end)
	it("Should Map a list of tables into a single string list", function()
		local tables = {
			{ name = "Foo", age = 20 },
			{ name = "Zoo", age = 30 },
			{ name = "Loo", age = 60 },
		}

		local expected = {
			"Name: Foo, age: 20",
			"Name: Zoo, age: 30",
			"Name: Loo, age: 60",
		}

		local iterator = Iterable.New(tables)
		local string_list = iterator
			:Map(function(el)
				return string.format("Name: %s, age: %d", el.name, el.age)
			end)
			:ToList()
		for i = 1, #expected do
			assert.are.equals(string_list[i], expected[i])
		end
	end)
end)
