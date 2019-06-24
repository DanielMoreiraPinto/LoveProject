function jogador_load()
	jogador = {}
	
	jogador.base_corrida = love.graphics.newImage("assets/jogador/base_corrida.png")
	jogador.base_pulo = love.graphics.newImage("assets/jogador/base_pulo.png")
	jogador.base_largura = jogador.base_corrida:getWidth() / 4
	jogador.base_altura = jogador.base_corrida:getHeight()
	jogador.topo_direita_mira = love.graphics.newImage("assets/jogador/topo_direita_mira.png")
	jogador.topo_direita_tiro = love.graphics.newImage("assets/jogador/topo_direita_tiro.png")
	jogador.topo_esquerda_mira = love.graphics.newImage("assets/jogador/topo_esquerda_mira.png")
	jogador.topo_esquerda_tiro = love.graphics.newImage("assets/jogador/topo_esquerda_tiro.png")
	jogador.topo_largura = jogador.topo_direita_mira:getWidth()
	jogador.topo_altura = jogador.topo_direita_mira:getHeight()
	
	--jogador.imagem_corrida = love.graphics.newImage("assets/jogador/corrida.png")
	--jogador.imagem_pulo = love.graphics.newImage("assets/jogador/pulo.png")
	--jogador.largura = jogador.imagem_corrida:getWidth() / 4
	--jogador.altura = jogador.imagem_corrida:getHeight()
	--jogador.x = 30
	--jogador.y = tela_altura - chao.altura - jogador.base_altura

	jogador.x = 30
	jogador.y = tela_altura - chao.altura - jogador.base_altura
	
	jogador.velocidadeY = 0
	jogador.pulo = 800
	jogador.gravidade = -40
	jogador.estado = "correndo"

	--carregarAnimacao(jogador.imagem_corrida, jogador.largura, jogador.altura)
	carregarAnimacao(jogador.base_corrida, jogador.base_largura, jogador.base_altura)

	flechasJogador = {}
	flechaJogador_imagem = love.graphics.newImage("assets/jogador_flecha.png")
	flechaJogador_largura = flechaJogador_imagem:getWidth()
	flechaJogador_altura = flechaJogador_imagem:getHeight()
	--flechaJogador_x = jogador.largura/2
	--flechaJogador_y = jogador.altura/4
	flechaJogador_x = jogador.base_largura/2
	flechaJogador_y = jogador.base_altura/4
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
	if jogador.estado == "correndo" then
		desenharAnimacao(jogador.x, jogador.y)
	else
		love.graphics.draw(jogador.base_pulo, jogador.x, jogador.y, 0, 1, sx)
	end

	love.graphics.draw(jogador.topo_direita_mira, jogador.x+jogador.base_largura/3.5, jogador.y-jogador.base_altura+100, 0, 1, sx)

	for i, flechaJogador in ipairs(flechasJogador) do
		love.graphics.draw(flechaJogador_imagem, flechaJogador.x, flechaJogador.y, flechaJogador.angulo, 1, sx)
	end
end