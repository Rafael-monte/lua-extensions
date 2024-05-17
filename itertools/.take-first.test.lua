require("itertools.itertools")

describe("Iterable's take first function tests", function()
	it("Should return the first 2 elements from iterable", function()
		local iterator = Iterable.New({ 1, 2, 3, 4, 5, 6, 7 })

		local two_first = iterator:TakeFirst(2):ToList()

		assert.are.equals(2, #two_first)
	end)

	it(
		"Should return all elements from iterable because the take number is bigger than iterables data length",
		function()
			local iterator = Iterable.New({ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 })
			local twenty_first = iterator:TakeFirst(20):ToList()
			assert.are.equals(10, #twenty_first)
		end
	)
end)
