require("itertools.itertools")

describe("Iterable's first or else tests", function()
	it("Should return 'not found' when filter the original array and returns nothing", function()
		local iterator = Iterable.New({ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 })
		local NOT_FOUND = "not found"
		local negative_ones = iterator:Filter(function(el)
			return el < 0
		end)
		local first_negative = negative_ones:FirstOrElse(NOT_FOUND)
		assert.are.equals(first_negative, NOT_FOUND)
	end)

	it("Should return the first result of filter when finds something", function()
		local iterator = Iterable.New({
			{ name = "Test", id = 1 },
			{ name = "Test2", id = 2 },
			{ name = "Test3", id = 3 },
		})

		local test2 = iterator
			:Filter(function(el)
				return el.id == 2
			end)
			:FirstOrElse("not found")
		assert.are_not.equals(test2, "not found")
	end)

	it("Should execute function when filter doesnt result nothing at all", function()
		local iterator = Iterable.New({
			{ name = "Test", id = 1 },
			{ name = "Test2", id = 2 },
			{ name = "Test3", id = 3 },
		})
		local not_found_str = "The iterator "
		local not_found = iterator
			:Filter(function(el)
				return el.name == "Test4"
			end)
			:FirstOrElse(function()
				return not_found_str .. "doesn't return any results."
			end)

		assert.are.equals(not_found, "The iterator doesn't return any results.")
	end)
end)
