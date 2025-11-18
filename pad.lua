local pad = {}
pad.__index = pad

function pad:new(x, y, w, h)
	local inst = {}
	setmetatable(inst, pad)
	inst.w = w or 150
	inst.h = h or 20
	inst.x = x or 0
	inst.y = y or 0

	inst.vx = 0
	inst.vy = 0
	return  inst
end

function pad:update()
	local mouseX, mouseY = love.mouse.getPosition()
	
	self:setX(mouseX - self.w/2)

	if (self.x >= largeur-self.w) then
		self.x = largeur-self.w 
	elseif self.x <= 0 then
		self.x = 0
	end

end

function pad:draw()
	love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end


function pad:setX(x) self.x = x end
function pad:setY(y) self.y = y end



return  pad