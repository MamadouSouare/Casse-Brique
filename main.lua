io.stdout:setvbuf("no")

local Pad = require("pad")
local Ball = require("ball")
local Bricks = require("briques")
local game_stautus = false
score = 0
nb_vies = 3

largeur, hauteur = 1024, 620

local function createPad(w, h)
	local x = (largeur - w)/2
	local y = (hauteur - h*2 )
	return Pad:new(x, y, w, h)
end

local pad = createPad(150, 20)
local ball = Ball:new()
local bricks = Bricks:new()

local font = love.graphics.newFont('font.ttf', 64)
local font2 = love.graphics.newFont('font.ttf', 40)
local font3 = love.graphics.newFont('font.ttf', 25)

local function printText(text, y, p_font)
	love.graphics.setFont(p_font)
	love.graphics.print(text, (largeur-p_font:getWidth(text))/2, y)
end


function love.load(  )
	love.window.setMode(largeur, hauteur)
	love.window.setTitle("BreakOut Game v1")
	love.graphics.setFont(font)
end

function love.update( dt )
  	if game_stautus then
		pad:update()
		ball:update(dt)

		if ball:testCollisionLine(pad) then
		ball:setY(pad.y-ball:getR())
		ball:changedirY()
		end

		for n = #bricks.b, 1, -1 do
			if ball:testCollisionRect(bricks.b[n]) then
				bricks:destroyBrick(bricks.b[n], n)
				ball:changedirY()
			end
		end
		if  #bricks.b == 0 or nb_vies <= 0 then
			game_stautus = false
		end
	end
end

function love.draw()
	if game_stautus then
		love.graphics.setFont(font3)
		love.graphics.print("Score : "..score, 15, hauteur - 25)
		love.graphics.print("vies : "..nb_vies, largeur - 100, hauteur - 25)
		bricks:draw()
		pad:draw()
		ball:draw()
	else
		printText("BREAK-OUT GAME", 100, font) 
		printText("Press 'space/enter' pour commencer", 400, font2)
		printText("Press 'escape' pour quitter", 500, font3)
	end
end

function love.keypressed(key)
	if key == 'escape' then love.event.quit() end

	if key == 'space' and not game_stautus then
		game_stautus = true
		score = 0
		nb_vies = 3
	end
end