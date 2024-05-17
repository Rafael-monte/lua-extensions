require("itertools.itertools")
describe("Iterator's Filter method tests", function()
	it("Should filter multiple times, and return just one value", function()
		local ten_elements = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }
		local iterator = Iterable.New(ten_elements)
		local leftover = iterator
			:Filter(function(el)
				return el > 1
			end)
			:Filter(function(el)
				return el > 5
			end)
			:Filter(function(el)
				return el > 8
			end)
			:Filter(function(el)
				return el > 9
			end)
			:ToList()
		assert.is_true(#leftover == 1)
	end)

	it("Should return no value", function()
		local iterator = Iterable.New({ "🍇", "🍈", "🍉", "🍊", "🍋", "🍋" })
		local bananas = iterator
			:Filter(function(el)
				return el == "🍌"
			end)
			:ToList()
		assert.is_true(#bananas == 0)
	end)
end)
