function love.load()
	jogador = {}
	jogador.x = 20
	jogador.y = 20
	jogador.largura = 70
	jogador.altura = 50
end

function love.update()
	
end

function love.draw()
	love.graphics.rectangle("fill", jogador.x, jogador.y, jogador.largura, jogador.altura)
end