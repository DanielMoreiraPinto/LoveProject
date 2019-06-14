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

	flechasJogador = {}
	flechaJogador_x = jogador.largura / 2
	flechaJogador_y = jogador.altura / 2
	flechaJogador_largura = 30
	flechaJogador_altura = 5
	flechaJogador_velocidade = 800

	inimigos = {}
	inimigo_x = 1000
	inimigo_y = 400
	inimigo_largura = 30
	inimigo_altura = 50

	flechasInimigas = {}
	flechaInimigo_x = 1000
	flechaInimigo_y = 200
	flechaInimigo_largura = 30
	flechaInimigo_altura = 5
	flechaInimigo_velocidadeY = 0
	flechaInimigo_gravidade = -12

	intervaloInimigo = 200
	intervaloFlechaInimigo = 500
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

	--Criação e atualização das flechas do jogador, controle da movimentação e colisão dessas flechas
	if love.mouse.isDown(1) then
		flechaJogador_x = flechaJogador_x + jogador.x
		flechaJogador_y = flechaJogador_y + jogador.y
		local posicaoMouseX, posicaoMouseY = love.mouse.getPosition()

		local angulo = math.atan2((posicaoMouseY - flechaJogador_y), (posicaoMouseX - flechaJogador_x))

		local novaFlechaJogador = {x = flechaJogador_x, y = flechaJogador_y, angulo = angulo}
		table.insert(flechasJogador, novaFlechaJogador)

		flechaJogador_x = flechaJogador_x - jogador.x
		flechaJogador_y = flechaJogador_y - jogador.y
	end

	for i, flechaJogador in ipairs(flechasJogador) do
		local deltaX = flechaJogador_velocidade * math.cos(flechaJogador.angulo)
		local deltaY = flechaJogador_velocidade * math.sin(flechaJogador.angulo)
		flechaJogador.x = flechaJogador.x + deltaX * dt
		flechaJogador.y = flechaJogador.y + deltaY * dt
		if flechaJogador.x > love.graphics.getWidth() or flechaJogador.x < 0 or
			flechaJogador.y > love.graphics.getHeight() or flechaJogador.y < 0 then
			table.remove(flechasJogador, i)
		end	
		--colisão com flechas inimigas
		for i, flechaInimigo in ipairs(flechasInimigas) do
			if detectarColisao(flechaJogador.x, flechaJogador.y, flechaJogador_largura, flechaJogador_altura,
				flechaInimigo.x, flechaInimigo.y, flechaInimigo_largura, flechaInimigo_altura) then
				table.remove(flechasJogador, i)
				table.remove(flechasInimigas, i)
			end
		end
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

	--Criação e atualização das flechas inimigas, controle da frequência das flechas, trajetória parabólica das flechas
	intervaloFlechaInimigo = intervaloFlechaInimigo - 1.5

	if intervaloFlechaInimigo <= 0 then
		intervaloFlechaInimigo = love.math.random(60, 255)
		novaFlechaInimigo = {x = flechaInimigo_x, y = flechaInimigo_y, velocidadeY = flechaInimigo_velocidadeY}
		table.insert(flechasInimigas, novaFlechaInimigo)
	end

	for i, flechaInimigo in ipairs(flechasInimigas) do
		flechaInimigo.x = flechaInimigo.x - velocidade
		flechaInimigo.y = flechaInimigo.y + flechaInimigo.velocidadeY * dt
		flechaInimigo.velocidadeY = flechaInimigo.velocidadeY - flechaInimigo_gravidade
		if flechaInimigo.x + flechaInimigo_largura < 0 or flechaInimigo.y > chao.y or
			detectarColisao(jogador.x, jogador.y, jogador.largura, jogador.altura, flechaInimigo.x, flechaInimigo.y, flechaInimigo_largura, flechaInimigo_altura) then
			table.remove(flechasInimigas, i)
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

	for i, flechaInimigo in ipairs(flechasInimigas) do
		love.graphics.setColor(0, 1, 0)
		love.graphics.rectangle("fill", flechaInimigo.x, flechaInimigo.y, flechaInimigo_largura, flechaInimigo_altura)
	end

	for i, flechaJogador in ipairs(flechasJogador) do
		love.graphics.setColor(1, 0, 1)
		love.graphics.rectangle("fill", flechaJogador.x, flechaJogador.y, flechaJogador_largura, flechaJogador_altura)
	end
end