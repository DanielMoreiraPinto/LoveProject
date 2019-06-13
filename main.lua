require("colisao")

function love.load()
	jogador = {}
	jogador.x = 30
	jogador.y = 400
	jogador.largura = 70
	jogador.altura = 50
	jogador.velocidadeY = 0
	jogador.pulo = 800
	jogador.gravidade = -40

	chao = {}
	chao.x = 0
	chao.y = 450
	chao.largura = 1000
	chao.altura = 50
end

function love.update(dt)
	jogador.y = jogador.y + jogador.velocidadeY * dt

	jogador.velocidadeY = jogador.velocidadeY - jogador.gravidade

	if detectarColisao(jogador.x, jogador.y, jogador.largura, jogador.altura, chao.x, chao.y, chao.largura, chao.altura) then
		jogador.velocidadeY = 0
		jogador.y = chao.y - jogador.altura
	end

	if love.keyboard.isDown("space") and jogador.velocidadeY == 0 and (jogador.y + jogador.altura) >= chao.y then
		jogador.velocidadeY = -jogador.pulo
	end
end

function love.draw()
	love.graphics.setColor(1, 1, 1)
	love.graphics.rectangle("fill", chao.x, chao.y, chao.largura, chao.altura)

	love.graphics.setColor(1, 0, 0)
	love.graphics.rectangle("fill", jogador.x, jogador.y, jogador.largura, jogador.altura)

	love.graphics.print(jogador.velocidadeY, 20, 20)
end