require("src/menu")
require("src/mundo")
require("src/jogador")
require("src/inimigo")
require("lib/colisao")

function love.load()
	tela_largura, tela_altura = love.graphics.getDimensions()
	dsenvolvimento = true
	modo = "menu"
	menu_load()
	reload()
end

function love.update(dt)
	if modo == "menu" then
		menu_update(dt)
	elseif modo == "jogo" then
		mundo_update(dt)
		jogador_update(dt)
		inimigo_update(dt)
	end

	if love.keyboard.isDown("return") then
		modo = "jogo"
	end
	if love.keyboard.isDown("escape") then
		modo = "menu"
		reload()
	end
end

function love.draw()
	if modo == "menu" then
		menu_draw()
	elseif modo == "jogo" then
		mundo_draw()
		jogador_draw()
		inimigo_draw()
	end
end

function reload()
	mundo_load()
	jogador_load()
	inimigo_load()
end