local ball = {}
ball.__index = ball

function ball:new(x, y, r)
	local inst = {}
	setmetatable(inst, ball)
	inst.r = r or 10
	inst.x = x or largeur/2
	inst.y = y or hauteur/2

	inst.vx = 250
	inst.vy = 300
	return  inst
end

function ball:update(dt)
	self.x = self.x + self.vx * dt
	self.y = self.y + self.vy * dt

	if (self.x + self.r > largeur) then
		self:setX(largeur - self.r)
		self:changedirX()
	elseif self.x - self.r < 0 then
		self:setX(self.r)
		self:changedirX()
	end

	if (self.y + self.r > hauteur) then
		self:setY(hauteur - self.r )
		nb_vies = nb_vies - 1
		self:setY(hauteur - 100)
		self:setX(largeur/2)
		self:changedirY()
		self:changedirX()
	elseif self.y - self.r < 0 then
		self:setY(self.r) 
		self:changedirY()
	end

end

function ball:draw()
	love.graphics.setColor(0, 1, 0)
	love.graphics.circle("fill", self.x, self.y, self.r)
	love.graphics.setColor(1, 1, 1)
end

function ball:testCollisionRect(r)
	return (
		r.x+r.w >= self.x-self.r  and
		r.x <= self.x + self.r  and
		r.y + r.h >= self.y - self.r and
		r.y <= self.y + self.r
	)
end

function ball:testCollisionLine(r)
	return (
		r.x+r.w-3 >= self.x-self.r  and
		r.x+3 <= self.x + self.r  and
		r.y + r.h/3 >= self.y - self.r and
		r.y <= self.y + self.r
	)
end

function ball:changedirY() self.vy = -self.vy end
function ball:changedirX() self.vx = -self.vx end

function ball:setX(x) self.x = x end
function ball:setY(y) self.y = y end

function ball:getX() return self.x end
function ball:getY() return self.y end
function ball:getR() return self.r end

return  ball