require "math/vector"

Rectangle = {}
Rectangle.__index = Rectangle

function Rectangle:new(c, v)
	-- cria um retangulo no centro "c", com metade da diagonal do tamanho do vetor "v"
	-- v.x, v.y eh um canto do retangulo e -v.x, -v.y eh o seu canto oposto
	
	local R = {}
	setmetatable(R, Rectangle)
	
	R.center = Vector:new(c.x, c.y)
	R.size = Vector:new(v.x, v.y)
	
	return R
end

function Rectangle:equal(b)
	self.center:equal(b.center)
	self.size:equal(b.size)
end

function Rectangle:copy(orientation, pos)
	local rectangle = Rectangle:new(Vector:new(0, 0), Vector:new(0, 0))

	rectangle:equal(self)
	rectangle.center.y = rectangle.center.y * orientation.y
	rectangle.center:sum(pos)
	
	return rectangle
end

function Rectangle:intersection(b)
	local PA = Vector:new(self.size.x, self.size.y)
	PA:sum(self.center)
	
	local PB = Vector:new(-self.size.x, -self.size.y)
	PB:sum(self.center)
	
	local PC = Vector:new(b.size.x, b.size.y)
	PC:sum(b.center)
	
	local PD = Vector:new(-b.size.x, -b.size.y)
	PD:sum(b.center)

	if PA.x > PD.x and PB.x < PC.x then
		if PA.y > PD.y and PB.y < PC.y then
			return true
		end
	end
	
	return false
end

function Rectangle:pointInside(p)
	-- verifica se ha o ponto "p" dentro do retangulo
	
	local PA = Vector:new(self.size.x, self.size.y)
	PA:sum(self.center)
	
	local PB = Vector:new(-self.size.x, -self.size.y)
	PB:sum(self.center)
	
	if PA.x > p.x and PB.x < p.x then
		if PA.y > p.y and PB.y < p.y then
			return true
		end
	end
	
	return false
end