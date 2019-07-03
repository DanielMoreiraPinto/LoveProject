function jogador_load()
	jogador = {}
	jogador.base = {}
		jogador.base.corrida = love.graphics.newImage("assets/imagens/jogador/base_corrida.png")
		jogador.base.pulo = love.graphics.newImage("assets/imagens/jogador/base_pulo.png")
		jogador.base.largura = jogador.base.corrida:getWidth() / 4
		jogador.base.altura = jogador.base.corrida:getHeight()
		jogador.base.estado = "correndo"
	jogador.topo = {}
		jogador.topo.mira = love.graphics.newImage("assets/imagens/jogador/topo_mira.png")
		jogador.topo.tiro = love.graphics.newImage("assets/imagens/jogador/topo_tiro.png")
		jogador.topo.carga = love.graphics.newImage("assets/imagens/jogador/topo_carga.png")
		jogador.topo.largura = jogador.topo.mira:getWidth()
		jogador.topo.altura = jogador.topo.mira:getHeight()
		jogador.topo.angulo = 0
		jogador.topo.estado = "mirando"
	jogador.x = 30
	jogador.y = tela_altura - chao.altura - jogador.base.altura
	jogador.hitbox = {}
		jogador.hitbox.cavaloCorpo = {}
			jogador.hitbox.cavaloCorpo.largura = 40*3
			jogador.hitbox.cavaloCorpo.altura = 15*3
			jogador.hitbox.cavaloCorpo.x = jogador.x+43
			jogador.hitbox.cavaloCorpo.y = jogador.y+45
		jogador.hitbox.cavaloCabeca = {}
			jogador.hitbox.cavaloCabeca.largura = 15*3
			jogador.hitbox.cavaloCabeca.altura = 6*3
			jogador.hitbox.cavaloCabeca.x = jogador.x+163
			jogador.hitbox.cavaloCabeca.y = jogador.y+20
		jogador.hitbox.cavaleiro = {}
			jogador.hitbox.cavaleiro.largura = 14*3
			jogador.hitbox.cavaleiro.altura = 22*3
			jogador.hitbox.cavaleiro.x = jogador.x+86
			jogador.hitbox.cavaleiro.y = jogador.y-10
	jogador.velocidadeY = 0
	jogador.pulo = 800
	jogador.gravidade = -40
	jogador.intervaloCarga = 0
	jogador.duracaoCarga = 5

	carregarAnimacao(jogador.base.corrida, jogador.base.largura, jogador.base.altura)

	flechasJogador = {}
	flechaJogador_imagem = love.graphics.newImage("assets/imagens/jogador_flecha.png")
	flechaJogador_largura = flechaJogador_imagem:getWidth() + 30
	flechaJogador_altura = flechaJogador_imagem:getHeight()
	flechaJogador_x = jogador.topo.largura/2
	flechaJogador_y = jogador.topo.altura/4
	flechaJogador_velocidade = 1500
	flechaJogador_velocidadeTiro = 60
	flechaJogador_somTiro = love.audio.newSource("assets/audio/som_tiro.wav", "stream")
	flechaJogador_somTiro:setVolume(0.7)

	intervaloFlechaJogador = flechaJogador_velocidadeTiro
end

function jogador_update(dt)
	atualizarAnimacao(dt)
	posicaoMouseX, posicaoMouseY = love.mouse.getPosition()

	jogador.hitbox.cavaloCorpo.y = jogador.y+45
	jogador.hitbox.cavaloCabeca.y = jogador.y+20
	jogador.hitbox.cavaleiro.y = jogador.y-10

	jogador.y = jogador.y + jogador.velocidadeY * dt
	jogador.velocidadeY = jogador.velocidadeY - jogador.gravidade

	intervaloFlechaJogador = intervaloFlechaJogador - 1.5
	jogador.intervaloCarga = jogador.intervaloCarga - 1 * dt

	if jogador.intervaloCarga <= 0 and love.keyboard.isDown("x") and jogador.topo.modo ~= "carga" then
		jogador.topo.estado = "carga"
	end

	if jogador.topo.estado == "carga" then
		jogador.duracaoCarga = jogador.duracaoCarga - 1 * dt
		
		if jogador.duracaoCarga <= 0 then
			jogador.intervaloCarga = 15
			jogador.duracaoCarga = 5
			jogador.topo.estado = "mirando"
		end
	else
		local anguloTopoParaMouse = math.atan2((posicaoMouseY - jogador.y), (posicaoMouseX - jogador.x))
		if math.cos(anguloTopoParaMouse) > 0 and anguloTopoParaMouse <= 0 then
			jogador.topo.angulo = anguloTopoParaMouse
		end

		if intervaloFlechaJogador <= 0 then
			jogador.topo.estado = "mirando"
			if love.mouse.isDown(1) then
				flechaJogador_somTiro:play()
				jogador.topo.estado = "atirando"
				intervaloFlechaJogador = flechaJogador_velocidadeTiro
				flechaJogador_x = flechaJogador_x + jogador.x
				flechaJogador_y = flechaJogador_y + jogador.y

				local anguloFlecha = jogador.topo.angulo
				local novaFlechaJogador = {x = flechaJogador_x, y = flechaJogador_y, angulo = anguloFlecha}
				table.insert(flechasJogador, novaFlechaJogador)

				flechaJogador_x = flechaJogador_x - jogador.x
				flechaJogador_y = flechaJogador_y - jogador.y
			end
		end
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
	if jogador.base.estado == "correndo" then
		desenharAnimacao(jogador.x, jogador.y)
	else
		love.graphics.draw(jogador.base.pulo, jogador.x, jogador.y, 0, 1, sx)
	end

	if jogador.topo.estado == "mirando" then
		love.graphics.draw(jogador.topo.mira, jogador.x+jogador.base.largura/1.9, 
			jogador.y+50, jogador.topo.angulo, 1, sx, jogador.topo.largura/2.2, jogador.topo.altura)
	elseif jogador.topo.estado == "atirando" then
		love.graphics.draw(jogador.topo.tiro, jogador.x+jogador.base.largura/1.9, 
			jogador.y+50, jogador.topo.angulo, 1, sx, jogador.topo.largura/2.2, jogador.topo.altura)
	else
		love.graphics.draw(jogador.topo.carga, jogador.x+jogador.base.largura/2, 
			jogador.y+45, 0, 1, sx, jogador.topo.largura/2.2, jogador.topo.altura)
	end

	for i, flechaJogador in ipairs(flechasJogador) do
		love.graphics.draw(flechaJogador_imagem, flechaJogador.x, flechaJogador.y, flechaJogador.angulo, 1, sx)
	end
end