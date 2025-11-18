local briques = {}
briques.__index = briques

function briques:new()
	local inst = {}
	setmetatable(inst, briques)
	inst.w = 80
	inst.h = 20
	inst.ncols = 10
	inst.nrows = 6


	inst.b = {}
	inst:createAll()
	return  inst
end

function briques:draw()
	for n = 1, #self.b do 
		love.graphics.setColor(0, 1, 1)
		love.graphics.rectangle("fill", self.b[n].x, self.b[n].y, self.w, self.h)
	end
	love.graphics.setColor(1, 1, 1)
end

function briques:createBrick(x, y)
	return {
		x = x, 
		y = y,
		w = 80,
		h = 20
	}
end

function briques:createAll()
	self.b = {}
	local sy = 0
	for y = 1, self.nrows do
		local sx = 0
		for x = 1, self.ncols do

			table.insert( self.b, self:createBrick(x*self.w + sx, y * self.h + sy) )

			sx = sx + 10
		end
		sy = sy + self.h
	end
end

function briques:destroyBrick(b, pos)
	b.isActive = false
	table.remove( self.b, pos )
	score = score + 10
end

return  briques