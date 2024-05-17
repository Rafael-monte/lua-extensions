-- HACK: Add new tests here, with its paths correctly
local itertools_tests = {
	["FILTER TESTS"] = "./itertools/.filter.test.lua",
	["MAP TESTS"] = "./itertools/.map.test.lua",
	["FIRST OR ELSE TESTS"] = "./itertools/.first-or-else.test.lua",
	["TAKE FIRST TESTS"] = "./itertools/.take-first.test.lua",
}

-- INFO: To run this, just run the following command on terminal
-- lua .main.tests.lua

-- Itertools tests
print("----------------------------------------------------------------------")
print("ITERTOOLS TESTS")
print("----------------------------------------------------------------------")
for testname, test_location in pairs(itertools_tests) do
	print("----------------------- [RUNNING " .. testname .. "] -----------------------")
	os.execute(string.format("busted %s", test_location))
end
