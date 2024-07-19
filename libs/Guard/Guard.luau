export type Check<T> = (Value: unknown | any) -> T

-- Luau Primitive Types

local Any: Check<any> = function(Value)
	return Value
end

local Boolean: Check<boolean> = function(Value)
	assert(type(Value) == "boolean")

	return Value
end

local Thread: Check<thread> = function(Value)
	assert(type(Value) == "thread")

	return Value
end

local Nil: Check<nil> = function(Value)
	assert(Value == nil)

	return Value :: any
end

local Number: Check<number> = function(Value)
	assert(type(Value) == "number")
	assert(Value == Value)

	return Value
end

local String: Check<string> = function(Value)
	assert(type(Value) == "string")

	return Value
end

-- Combination Types

local function Or<T, U>(Left: Check<T>, Right: Check<U>): Check<T | U>
	return function(Value)
		local LeftSuccess = pcall(Left, Value)

		if LeftSuccess then
			return Value :: any
		end

		local RightSuccess = pcall(Right, Value)

		if RightSuccess then
			return Value :: any
		end

		error("Union check failed")
	end
end

local function And<T, U>(Left: Check<T>, Right: Check<U>): Check<T & U>
	return function(Value)
		local LeftSuccess = pcall(Left, Value)

		if not LeftSuccess then
			error("Intersection check failed")
		end

		local RightSuccess = pcall(Right, Value)

		if not RightSuccess then
			error("Intersection check failed")
		end

		return Value :: any
	end
end

-- Complex Types

local function Optional<T>(Check: Check<T>): Check<T | nil>
	return function(Value)
		if Value == nil then
			return nil
		else
			return Check(Value)
		end
	end
end

local function Literal<T>(Literal: T): Check<T>
	return function(Value)
		assert(Value == Literal)

		return Value :: any
	end
end

local function Map<K, V>(KeyCheck: Check<K>, ValueCheck: Check<V>): Check<{ [K]: V }>
	return function(Value)
		assert(type(Value) == "table")

		for k, v in Value :: any do
			KeyCheck(k)
			ValueCheck(v)
		end

		return Value :: any
	end
end

local function Set<T>(Check: Check<T>): Check<{ [T]: boolean }>
	return Map(Check, Literal(true))
end

local function List<T>(Check: Check<T>): Check<{ T }>
	return function(Value)
		assert(type(Value) == "table")

		for i = 1, table.maxn(Value :: any) do
			Check((Value :: any)[i])
		end

		return Value :: any
	end
end

-- Number Types

local Integer: Check<number> = function(Value)
	assert(type(Value) == "number")
	assert(Value % 1 == 0)

	return Value
end

local function NumberMin(Min: number): Check<number>
	return function(Value)
		assert(type(Value) == "number")
		assert(Value >= Min)

		return Value
	end
end

local function NumberMax(Max: number): Check<number>
	return function(Value)
		assert(type(Value) == "number")
		assert(Value <= Max)

		return Value
	end
end

local function NumberMinMax(Min: number, Max: number): Check<number>
	return function(Value)
		assert(type(Value) == "number")
		assert(Value > Min)
		assert(Value < Max)

		return Value
	end
end

-- Roblox Types

local Axes: Check<Axes> = function(Value)
	assert(typeof(Value) == "Axes")

	return Value
end

local BrickColor: Check<BrickColor> = function(Value)
	assert(typeof(Value) == "BrickColor")

	return Value
end

local CatalogSearchParams: Check<CatalogSearchParams> = function(Value)
	assert(typeof(Value) == "CatalogSearchParams")

	return Value
end

local CFrame: Check<CFrame> = function(Value)
	assert(typeof(Value) == "CFrame")
	assert(Value == Value)

	return Value
end

local Color3: Check<Color3> = function(Value)
	assert(typeof(Value) == "Color3")
	assert(Value == Value)

	return Value
end

local ColorSequence: Check<ColorSequence> = function(Value)
	assert(typeof(Value) == "ColorSequence")

	return Value
end

local ColorSequenceKeypoint: Check<ColorSequenceKeypoint> = function(Value)
	assert(typeof(Value) == "ColorSequenceKeypoint")

	return Value
end

local DateTime: Check<DateTime> = function(Value)
	assert(typeof(Value) == "DateTime")

	return Value
end

local DockWidgetPluginGuiInfo: Check<DockWidgetPluginGuiInfo> = function(Value)
	assert(typeof(Value) == "DockWidgetPluginGuiInfo")

	return Value
end

local Enum: Check<Enum> = function(Value)
	assert(typeof(Value) == "Enum")

	return Value
end

local EnumItem: Check<EnumItem> = function(Value)
	assert(typeof(Value) == "EnumItem")

	return Value
end

local Enums: Check<Enums> = function(Value)
	assert(typeof(Value) == "Enums")

	return Value
end

local Faces: Check<Faces> = function(Value)
	assert(typeof(Value) == "Faces")

	return Value
end

local FloatCurveKey: Check<FloatCurveKey> = function(Value)
	assert(typeof(Value) == "FloatCurveKey")

	return Value
end

local Font: Check<Font> = function(Value)
	assert(typeof(Value) == "Font")

	return Value
end

local Instance: Check<Instance> = function(Value)
	assert(typeof(Value) == "Instance")

	return Value
end

local NumberRange: Check<NumberRange> = function(Value)
	assert(typeof(Value) == "NumberRange")

	return Value
end

local NumberSequence: Check<NumberSequence> = function(Value)
	assert(typeof(Value) == "NumberSequence")

	return Value
end

local NumberSequenceKeypoint: Check<NumberSequenceKeypoint> = function(Value)
	assert(typeof(Value) == "NumberSequenceKeypoint")

	return Value
end

local OverlapParams: Check<OverlapParams> = function(Value)
	assert(typeof(Value) == "OverlapParams")

	return Value
end

local Path2DControlPoint: Check<Path2DControlPoint> = function(Value)
	assert(typeof(Value) == "Path2DControlPoint")

	return Value
end

local PathWaypoint: Check<PathWaypoint> = function(Value)
	assert(typeof(Value) == "PathWaypoint")

	return Value
end

local PhysicalProperties: Check<PhysicalProperties> = function(Value)
	assert(typeof(Value) == "PhysicalProperties")

	return Value
end

local Random: Check<Random> = function(Value)
	assert(typeof(Value) == "Random")

	return Value
end

local Ray: Check<Ray> = function(Value)
	assert(typeof(Value) == "Ray")

	return Value
end

local RaycastParams: Check<RaycastParams> = function(Value)
	assert(typeof(Value) == "RaycastParams")

	return Value
end

local RaycastResult: Check<RaycastResult> = function(Value)
	assert(typeof(Value) == "RaycastResult")

	return Value
end

local RBXScriptConnection: Check<RBXScriptConnection> = function(Value)
	assert(typeof(Value) == "RBXScriptConnection")

	return Value
end

local RBXScriptSignal: Check<RBXScriptSignal> = function(Value)
	assert(typeof(Value) == "RBXScriptSignal")

	return Value
end

local Rect: Check<Rect> = function(Value)
	assert(typeof(Value) == "Rect")

	return Value
end

local Region3: Check<Region3> = function(Value)
	assert(typeof(Value) == "Region3")
	assert(Value == Value)

	return Value
end

local Region3int16: Check<Region3int16> = function(Value)
	assert(typeof(Value) == "Region3int16")

	return Value
end

local RotationCurveKey: Check<RotationCurveKey> = function(Value)
	assert(typeof(Value) == "RotationCurveKey")

	return Value
end

local Secret: Check<Secret> = function(Value)
	assert(typeof(Value) == "Secret")

	return Value
end

local SharedTable: Check<SharedTable> = function(Value)
	assert(typeof(Value) == "SharedTable")

	return Value
end

local TweenInfo: Check<TweenInfo> = function(Value)
	assert(typeof(Value) == "TweenInfo")

	return Value
end

local UDim: Check<UDim> = function(Value)
	assert(typeof(Value) == "UDim")

	return Value
end

local UDim2: Check<UDim2> = function(Value)
	assert(typeof(Value) == "UDim2")

	return Value
end

local Vector2: Check<Vector2> = function(Value)
	assert(typeof(Value) == "Vector2")
	assert(Value == Value)

	return Value
end

local Vector2int16: Check<Vector2int16> = function(Value)
	assert(typeof(Value) == "Vector2int16")

	return Value
end

local Vector3: Check<Vector3> = function(Value)
	assert(typeof(Value) == "Vector3")
	assert(Value == Value)

	return Value
end

local Vector3int16: Check<Vector3int16> = function(Value)
	assert(typeof(Value) == "Vector3int16")

	return Value
end

-- Additional Roblox features

local Player: Check<Player> = function(Value)
	assert(Value:IsA("Player"))

	return Value :: Player
end

local Model: Check<Model> = function(Value)
	assert(Value:IsA("Model"))

	return Value :: Model
end

-- Check

local function Check<T>(Check: Check<T>): (Value: unknown | any) -> (boolean, T)
	return function(Value)
		return pcall(Check, Value)
	end
end

return {
	Any = Any,

	Boolean = Boolean,
	Thread = Thread,
	Nil = Nil,
	Number = Number,
	String = String,

	Optional = Optional,
	Literal = Literal,

	Or = Or,
	And = And,

	Map = Map,
	Set = Set,
	List = List,

	Integer = Integer,
	NumberMin = NumberMin,
	NumberMax = NumberMax,
	NumberMinMax = NumberMinMax,

	Axes = Axes,
	BrickColor = BrickColor,
	CatalogSearchParams = CatalogSearchParams,
	CFrame = CFrame,

	Color3 = Color3,
	ColorSequence = ColorSequence,
	ColorSequenceKeypoint = ColorSequenceKeypoint,

	DateTime = DateTime,
	DockWidgetPluginGuiInfo = DockWidgetPluginGuiInfo,

	Enum = Enum,
	EnumItem = EnumItem,
	Enums = Enums,

	Faces = Faces,
	FloatCurveKey = FloatCurveKey,
	Font = Font,

	Instance = Instance,
	NumberRange = NumberRange,
	NumberSequence = NumberSequence,
	NumberSequenceKeypoint = NumberSequenceKeypoint,

	OverlapParams = OverlapParams,
	Path2DControlPoint = Path2DControlPoint,
	PathWaypoint = PathWaypoint,

	PhysicalProperties = PhysicalProperties,
	Random = Random,

	Ray = Ray,
	RaycastParams = RaycastParams,
	RaycastResult = RaycastResult,

	RBXScriptConnection = RBXScriptConnection,
	RBXScriptSignal = RBXScriptSignal,

	Rect = Rect,
	Region3 = Region3,

	Region3int16 = Region3int16,
	RotationCurveKey = RotationCurveKey,

	Secret = Secret,
	SharedTable = SharedTable,

	TweenInfo = TweenInfo,
	UDim = UDim,
	UDim2 = UDim2,

	Vector2 = Vector2,
	Vector2int16 = Vector2int16,
	Vector3 = Vector3,
	Vector3int16 = Vector3int16,

	Player = Player,
	Model = Model,

	Check = Check,
}
