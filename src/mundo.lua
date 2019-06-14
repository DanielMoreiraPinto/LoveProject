function mundo_load()
	--velocidade = 10

	chao = {}
	chao.x = 0
	chao.y = 450
	chao.largura = tela_largura
	chao.altura = 50
end

function mundo_update(dt)
	
end

function mundo_draw()
	--love.graphics.setColor(1, 1, 1)
	love.graphics.rectangle("fill", chao.x, chao.y, chao.largura, chao.altura)
end