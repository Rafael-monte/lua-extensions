Secure = { __data = {} }
Secure.__index = Secure

function Secure.Wrap(
	data --[[any]]
)
	local sec = { __data = {} }
	sec.__data = data or nil
	setmetatable(sec, Secure)
	return sec
end

function Secure:Unwrap()
	if self.__data == nil then
		error("Unwrapped a nil value")
	end
	return self.__data
end

function Secure:UnwrapOr(
	other --[[any]]
)
	if self.__data ~= nil then
		return self.__data
	end
	if type(other) == "function" then
		return other()
	end
	return other
end

function Secure:IsSome()
	return self.__data ~= nil
end

function Secure:IsNone()
	return self.__data == nil
end

function Some(
	data --[[any]]
)
	if data == nil then
		error("Tried to wrap nil value in 'Some' Secure container")
	end
	local sec = { __data = {} }
	sec.__data = data
	setmetatable(sec, Secure)
	return sec
end

function None()
	local sec = { __data = {} }
	sec.__data = nil
	setmetatable(sec, Secure)
	return sec
end
