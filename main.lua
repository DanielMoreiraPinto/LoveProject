require("src/mundo")
require("src/jogador")
require("src/inimigo")
require("lib/colisao")

function love.load()
	tela_largura, tela_altura = love.graphics.getDimensions()
	mundo_load()
	jogador_load()
	inimigo_load()
end

function love.update(dt)
	jogador_update(dt)
	inimigo_update(dt)
end

function love.draw()
	mundo_draw()
	jogador_draw()
	inimigo_draw()
end