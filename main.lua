require("colisao")

function love.load()
	velocidade = 20

	chao = {}
	chao.x = 0
	chao.y = 450
	chao.largura = 1000
	chao.altura = 50

	jogador = {}
	jogador.x = 30
	jogador.y = 400
	jogador.largura = 70
	jogador.altura = 50
	jogador.velocidadeY = 0
	jogador.pulo = 800
	jogador.gravidade = -40

	inimigos = {}
	inimigo_x = 1000
	inimigo_y = 400
	inimigo_largura = 30
	inimigo_altura = 50

	intervaloInimigo = 200
end

function love.update(dt)
	--Atualização do jogador
	jogador.y = jogador.y + jogador.velocidadeY * dt

	jogador.velocidadeY = jogador.velocidadeY - jogador.gravidade

	if detectarColisao(jogador.x, jogador.y, jogador.largura, jogador.altura, chao.x, chao.y, chao.largura, chao.altura) then
		jogador.velocidadeY = 0
		jogador.y = chao.y - jogador.altura
	end

	if love.keyboard.isDown("space") and jogador.velocidadeY == 0 and (jogador.y + jogador.altura) >= chao.y then
		jogador.velocidadeY = -jogador.pulo
	end

	--Criação e atualização dos inimigos, controle da frequência dos inimigos
	intervaloInimigo = intervaloInimigo - 1.5
	
	if intervaloInimigo <= 0 then
		intervaloInimigo = love.math.random(60, 255)
		novoInimigo = {x = inimigo_x, y = inimigo_y}
		table.insert(inimigos, novoInimigo)
	end

	for i, inimigo in ipairs(inimigos) do
		inimigo.x = inimigo.x - velocidade
		if inimigo.x + inimigo_largura < 0 then
			table.remove(inimigos, i)
		end
	end
end

function love.draw()
	love.graphics.setColor(1, 1, 1)
	love.graphics.rectangle("fill", chao.x, chao.y, chao.largura, chao.altura)

	love.graphics.setColor(1, 0, 0)
	love.graphics.rectangle("fill", jogador.x, jogador.y, jogador.largura, jogador.altura)

	for i, inimigo in ipairs(inimigos) do
		love.graphics.setColor(0, 0, 1)
		love.graphics.rectangle("fill", inimigo.x, inimigo.y, inimigo_largura, inimigo_altura)
	end
end