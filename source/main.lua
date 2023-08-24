import "CoreLibs/object"
import "CoreLibs/sprites"
import "CoreLibs/timer"

local pd <const> = playdate
local gfx <const> = pd.graphics
local geo <const> = pd.geometry
local point <const> = geo.point
local vector2D <const> = geo.vector2D
local timer <const> = pd.timer

function runSplashScreen()

	class("SplashScreen").extends(gfx.sprite)

	function SplashScreen:init()
		SplashScreen.super.init(self)
		local image <const> = gfx.image.new("images/blue-looking-regal")

		gfx.pushContext(image)
			gfx.setColor(gfx.kColorWhite)
			gfx.fillRoundRect(263, 9, 89, 25, 3)
			gfx.drawRoundRect(259, 5, 97, 33, 7)
			gfx.drawText("Blue's Balls", 267, 12)
		gfx.popContext()	

		self:setImage(image)
		self:setCenter(0, 0)
		self:moveTo(0, 0)
		self:add()
	end

	SplashScreen()

end

function runStandardTimer()
	local callback <const> = function (caller)
		print ("Tick!")
		print(caller)
	end

	local myTimer <const> = timer.new(2000, callback)
	myTimer.repeats = true
end

function runVectorTests()
	local a, b <const> = 50, 75

	local points = {
		a = point.new(a, a),
		b = point.new(a, a),
		c = point.new(a, b)
	}

	printTable("=== Points ===", points)
	print("=== Point Equality ===")
	print(string.format("%s == %s: ", points.a, points.b), points.a == points.b)
	print(string.format("%s == %s: ", points.b, points.c), points.b == points.c)
	print(string.format("%s == %s: ", points.c, points.a), points.c == points.a)
	print(string.format("%s == %s: ", points.b, points.a), points.b == points.a)
	print(string.format("%s == %s: ", points.c, points.b), points.c == points.b)
	print(string.format("%s == %s: ", points.a, points.c), points.a == points.c)

	local vectors = {
		a = vector2D.new(a, a),
		b = vector2D.new(a, a),
		c = vector2D.new(a, b)
	}

	printTable("=== Vectors ===", points)
	print("=== Vectors Equality ===")
	print(string.format("%s == %s: ", vectors.a, vectors.b), vectors.a == vectors.b)
	print(string.format("%s == %s: ", vectors.b, vectors.c), vectors.b == vectors.c)
	print(string.format("%s == %s: ", vectors.c, vectors.a), vectors.c == vectors.a)
	print(string.format("%s == %s: ", vectors.b, vectors.a), vectors.b == vectors.a)
	print(string.format("%s == %s: ", vectors.c, vectors.b), vectors.c == vectors.b)
	print(string.format("%s == %s: ", vectors.a, vectors.c), vectors.a == vectors.c)

	print("=== Vector projection ===")
	local projectedVector <const> = vectors.a:projectedAlong(vectors.c)
	gfx.drawLine(0, 0, vectors.a.x, vectors.a.y)
	gfx.drawText("a", vectors.a.x, vectors.a.y)
	gfx.drawLine(0, 0, vectors.c.x, vectors.c.y)
	gfx.drawText("c", vectors.c.x, vectors.c.y)

	gfx.drawLine(0, 0, projectedVector.x, projectedVector.y)
	gfx.drawText("pv", projectedVector.x, projectedVector.y)

	print(string.format("Vector %s, projected over %s = %s", vectors.a, vectors.c, projectedVector))
end

local EXAMPLES <const> = {
	SplashScreen = runSplashScreen,
	VectorTests = runVectorTests,
	Timers = {
		StandardTimer = runStandardTimer
	}
}

EXAMPLES.VectorTests()

function playdate.update()
	gfx.sprite.update()
	timer.updateTimers()
end