require("src/modelos/mundo")
require("src/modelos/jogador")
require("src/modelos/inimigo")
require("lib/colisao")
require("lib/animacao")

function jogo_load()
	mundo_load()
	jogador_load()
	inimigo_load()

	textoJogo = {}
	textoJogo.fonte = love.graphics.newFont("assets/fontes/fonte.otf", 25)

	pontuacaoJogo = 0
end

function jogo_update(dt)
	mundo_update(dt)
	jogador_update(dt)
	inimigo_update(dt)

	pontuacaoJogo = pontuacaoJogo + 1
	salvarPontuacao(pontuacaoJogo)

	if detectarColisao(jogador.x, jogador.y, jogador.base.largura, jogador.base.altura, chao.x1, chao.y, chao.largura, chao.altura) or
		detectarColisao(jogador.x, jogador.y, jogador.base.largura, jogador.base.altura, chao.x2, chao.y, chao.largura, chao.altura) then
		jogador.velocidadeY = 0
		jogador.y = chao.y - jogador.base.altura
		jogador.base.estado = "correndo"
	end

	if love.keyboard.isDown("space") and jogador.velocidadeY == 0 and (jogador.y + jogador.base.altura) >= chao.y then
		jogador.velocidadeY = -jogador.pulo
		jogador.base.estado = "pulando"
	end

	for i, flechaInimigo in ipairs(flechasInimigas) do
		if flechaInimigo.x + flechaInimigo_largura < 0 or flechaInimigo.y > chao.y then
			table.remove(flechasInimigas, i)
		end
		for i, flechaJogador in ipairs(flechasJogador) do
			if detectarColisao(flechaJogador.x, flechaJogador.y, flechaJogador_largura, flechaJogador_altura,
				flechaInimigo.x, flechaInimigo.y, flechaInimigo_largura, flechaInimigo_altura) then
				table.remove(flechasJogador, i)
				table.remove(flechasInimigas, i)
			end
		end
	end
end

function jogo_draw()
	mundo_draw()
	jogador_draw()
	inimigo_draw()

	love.graphics.setColor(0, 0, 0)
	love.graphics.setFont(textoJogo.fonte)
	love.graphics.print("Pontos: " .. pontuacaoJogo, 800, 30)

	if jogador.topo.estado == "carga" then
		love.graphics.print("Carga: " .. math.ceil(jogador.duracaoCarga), 100, 30)
	elseif jogador.intervaloCarga <= 0 then
		love.graphics.print("Pronto para carga!", 100, 30)
	end
	love.graphics.reset()
end

function jogo_detectarFimDeJogo()
	for i, flechaInimigo in ipairs(flechasInimigas) do
		if (detectarColisao(jogador.hitbox.cavaloCorpo.x, jogador.hitbox.cavaloCorpo.y, 
						jogador.hitbox.cavaloCorpo.largura, jogador.hitbox.cavaloCorpo.altura,
						flechaInimigo.x, flechaInimigo.y, flechaInimigo_largura, flechaInimigo_altura) or
			detectarColisao(jogador.hitbox.cavaloCabeca.x, jogador.hitbox.cavaloCabeca.y, 
						jogador.hitbox.cavaloCabeca.largura, jogador.hitbox.cavaloCabeca.altura,
						flechaInimigo.x, flechaInimigo.y, flechaInimigo_largura, flechaInimigo_altura) or
			detectarColisao(jogador.hitbox.cavaleiro.x, jogador.hitbox.cavaleiro.y, 
						jogador.hitbox.cavaleiro.largura, jogador.hitbox.cavaleiro.altura,
						flechaInimigo.x, flechaInimigo.y, flechaInimigo_largura, flechaInimigo_altura)) and
						jogador.topo.estado ~= "carga" then
			salvarPontuacao(pontuacaoJogo)
			return true
		end
	end

	for i, inimigo in ipairs(inimigos) do
		if detectarColisao(jogador.hitbox.cavaloCorpo.x, jogador.hitbox.cavaloCorpo.y, 
						jogador.hitbox.cavaloCorpo.largura, jogador.hitbox.cavaloCorpo.altura,
						inimigo.hitbox_x, inimigo.hitbox_y, inimigo_hitbox_largura, inimigo_hitbox_altura) then
			if jogador.topo.estado == "carga" then
				inimigo.modo = "caido"
				inimigo_grito:play()
				return false
			else
				return true
			end
		end
	end
	return false
end