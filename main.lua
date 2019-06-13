function love.load()
	jogador = {}
	jogador.x = 30
	jogador.y = 400
	jogador.largura = 70
	jogador.altura = 50

	chao = {}
	chao.x = 0
	chao.y = 450
	chao.largura = 1000
	chao.altura = 50
end

function love.update()
	
end

function love.draw()
	love.graphics.rectangle("fill", chao.x, chao.y, chao.largura, chao.altura)

	love.graphics.rectangle("fill", jogador.x, jogador.y, jogador.largura, jogador.altura)
end