function inimigo_load()
	inimigos = {}
	inimigo_imagem = love.graphics.newImage("assets/inimigo2.png")
	inimigo_largura = inimigo_imagem:getWidth()
	inimigo_altura = inimigo_imagem:getHeight()
	inimigo_x = tela_largura
	inimigo_y = tela_altura - chao.altura - inimigo_altura
	inimigoVelocidade = 15

	flechasInimigas = {}
	flechaInimigo_x = 1000
	flechaInimigo_y = 200
	flechaInimigo_largura = 30
	flechaInimigo_altura = 30
	flechaInimigo_velocidadeY = 0
	flechaInimigo_gravidade = -12
	flechaInimigo_velocidade = 20

	intervaloInimigo = 200
	intervaloFlechaInimigo = 500
end

function inimigo_update(dt)
	intervaloInimigo = intervaloInimigo - 1.5
	
	if intervaloInimigo <= 0 then
		intervaloInimigo = love.math.random(60, 255)
		novoInimigo = {x = inimigo_x, y = inimigo_y}
		table.insert(inimigos, novoInimigo)
	end

	for i, inimigo in ipairs(inimigos) do
		inimigo.x = inimigo.x - inimigoVelocidade
		if inimigo.x + inimigo_largura < 0 then
			table.remove(inimigos, i)
		end
	end

	intervaloFlechaInimigo = intervaloFlechaInimigo - 1.5

	if intervaloFlechaInimigo <= 0 then
		intervaloFlechaInimigo = love.math.random(60, 255)
		novaFlechaInimigo = {x = flechaInimigo_x, y = flechaInimigo_y, velocidadeY = flechaInimigo_velocidadeY}
		table.insert(flechasInimigas, novaFlechaInimigo)
	end

	for i, flechaInimigo in ipairs(flechasInimigas) do
		flechaInimigo.x = flechaInimigo.x - flechaInimigo_velocidade
		flechaInimigo.y = flechaInimigo.y + flechaInimigo.velocidadeY * dt
		flechaInimigo.velocidadeY = flechaInimigo.velocidadeY - flechaInimigo_gravidade
		if flechaInimigo.x + flechaInimigo_largura < 0 or flechaInimigo.y > chao.y or
			detectarColisao(jogador.x, jogador.y, jogador.largura, jogador.altura, flechaInimigo.x, flechaInimigo.y, flechaInimigo_largura, flechaInimigo_altura) then
			table.remove(flechasInimigas, i)
		end
	end
end

function inimigo_draw()
	for i, inimigo in ipairs(inimigos) do
		--love.graphics.setColor(0, 0, 1)
		--love.graphics.rectangle("fill", inimigo.x, inimigo.y, inimigo_largura, inimigo_altura)
		love.graphics.draw(inimigo_imagem, inimigo.x, inimigo.y, 0, 1, sx)
	end

	for i, flechaInimigo in ipairs(flechasInimigas) do
		--love.graphics.setColor(0, 1, 0)
		love.graphics.rectangle("fill", flechaInimigo.x, flechaInimigo.y, flechaInimigo_largura, flechaInimigo_altura)
	end
end