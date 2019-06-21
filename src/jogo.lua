require("src/modelos/mundo")
require("src/modelos/jogador")
require("src/modelos/inimigo")
require("lib/colisao")
require("lib/animacao")

function jogo_load()
	mundo_load()
	jogador_load()
	inimigo_load()
end

function jogo_update(dt)
	mundo_update(dt)
	jogador_update(dt)
	inimigo_update(dt)

	if detectarColisao(jogador.x, jogador.y, jogador.largura, jogador.altura, chao.x1, chao.y, chao.largura, chao.altura) or
		detectarColisao(jogador.x, jogador.y, jogador.largura, jogador.altura, chao.x2, chao.y, chao.largura, chao.altura) then
		jogador.velocidadeY = 0
		jogador.y = chao.y - jogador.altura
		jogador.estado = "correndo"
	end

	if love.keyboard.isDown("space") and jogador.velocidadeY == 0 and (jogador.y + jogador.altura) >= chao.y then
		jogador.velocidadeY = -jogador.pulo
		jogador.estado = "pulando"
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
end

function jogo_detectarFimDeJogo()
	for i, flechaInimigo in ipairs(flechasInimigas) do
		if detectarColisao(jogador.x, jogador.y, jogador.largura, jogador.altura,
					flechaInimigo.x, flechaInimigo.y, flechaInimigo_largura, flechaInimigo_altura) then return true end
	end

	for i, inimigo in ipairs(inimigos) do
	if detectarColisao(jogador.x, jogador.y, jogador.largura, jogador.altura,
				inimigo.x, inimigo.y, inimigo_largura, inimigo_altura) then return true end
	end

	return false
end