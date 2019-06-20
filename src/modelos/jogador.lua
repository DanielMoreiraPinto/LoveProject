function jogador_load()
	jogador = {}
	jogador.imagem = love.graphics.newImage("assets/jogador.png")
	jogador.largura = jogador.imagem:getWidth() / 4
	jogador.altura = jogador.imagem:getHeight()
	jogador.x = 30
	jogador.y = tela_altura - chao.altura - jogador.altura
	jogador.velocidadeY = 0
	jogador.pulo = 800
	jogador.gravidade = -40

	carregarAnimacao(jogador.imagem, jogador.largura, jogador.altura)

	flechasJogador = {}
	flechaJogador_imagem = love.graphics.newImage("assets/jogador_flecha.png")
	flechaJogador_largura = flechaJogador_imagem:getWidth()
	flechaJogador_altura = flechaJogador_imagem:getHeight()
	flechaJogador_x = jogador.largura/2
	flechaJogador_y = jogador.altura/4
	flechaJogador_velocidade = 1500
	flechaJogador_velocidadeTiro = 60

	intervaloFlechaJogador = flechaJogador_velocidadeTiro
end

function jogador_update(dt)
	atualizarAnimacao(dt)

	jogador.y = jogador.y + jogador.velocidadeY * dt

	jogador.velocidadeY = jogador.velocidadeY - jogador.gravidade

	intervaloFlechaJogador = intervaloFlechaJogador - 1.5

	if love.mouse.isDown(1) and intervaloFlechaJogador <= 0 then
		intervaloFlechaJogador = flechaJogador_velocidadeTiro
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
	end
end

function jogador_draw()
	desenharAnimacao(jogador.x, jogador.y)

	for i, flechaJogador in ipairs(flechasJogador) do
		love.graphics.draw(flechaJogador_imagem, flechaJogador.x, flechaJogador.y, flechaJogador.angulo, 1, sx)
	end
end