function inimigo_load()
	inimigos = {}
	inimigo_imagem = love.graphics.newImage("assets/imagens/inimigo.png")
	inimigo_imagem_caido = love.graphics.newImage("assets/imagens/inimigo_caido.png")
	inimigo_largura = inimigo_imagem:getWidth()
	inimigo_altura = inimigo_imagem:getHeight()
	inimigo_x = tela_largura
	inimigo_y = tela_altura - chao.altura - inimigo_altura
	inimigo_hitbox_largura = 48*2
	inimigo_hitbox_altura = 40*2
	inimigo_hitbox_y = inimigo_y + 30
	inimigoVelocidade = velocidadeIlusaoMundo
	inimigo_grito = love.audio.newSource("assets/audio/som_grito.ogg", "stream")
	inimigo_grito:setVolume(0.7)

	flechasInimigas = {}
	flechaInimigo_imagem = love.graphics.newImage("assets/imagens/inimigo_flecha.png")
	flechaInimigo_largura = flechaInimigo_imagem:getWidth()
	flechaInimigo_altura = flechaInimigo_imagem:getHeight()
	flechaInimigo_x = 1000
	flechaInimigo_y = 20
	flechaInimigo_velocidadeY = 30
	flechaInimigo_gravidade = -20
	flechaInimigo_velocidade = 20

	intervaloInimigo = 400
	intervaloFlechaInimigo = 800
end

function inimigo_update(dt)
	intervaloInimigo = intervaloInimigo - 1.5
	
	if intervaloInimigo <= 0 then
		intervaloInimigo = love.math.random(60, 255)
		novoInimigo = {x = inimigo_x, y = inimigo_y, hitbox_x = x, hitbox_y = inimigo_hitbox_y, modo = "guarda"}
		table.insert(inimigos, novoInimigo)
	end

	for i, inimigo in ipairs(inimigos) do
		inimigo.x = inimigo.x - inimigoVelocidade
		inimigo.hitbox_x = inimigo.x
		if inimigo.x + inimigo_largura < 0 then
			table.remove(inimigos, i)
		end
	end

	intervaloFlechaInimigo = intervaloFlechaInimigo - 1.5

	if intervaloFlechaInimigo <= 0 then
		intervaloFlechaInimigo = love.math.random(60, 255)
		novaFlechaInimigo = {x = flechaInimigo_x, y = flechaInimigo_y, velocidadeY = flechaInimigo_velocidadeY, angulo = 0}
		table.insert(flechasInimigas, novaFlechaInimigo)
	end

	for i, flechaInimigo in ipairs(flechasInimigas) do
		flechaInimigo.x = flechaInimigo.x - flechaInimigo_velocidade
		flechaInimigo.y = flechaInimigo.y + flechaInimigo.velocidadeY * dt
		flechaInimigo.angulo = flechaInimigo.angulo - 0.01
		flechaInimigo.velocidadeY = flechaInimigo.velocidadeY - flechaInimigo_gravidade
	end
end

function inimigo_draw()
	for i, inimigo in ipairs(inimigos) do
		if inimigo.modo == "guarda" then
			love.graphics.draw(inimigo_imagem, inimigo.x, inimigo.y, 0, 1, sx)
		else
			love.graphics.draw(inimigo_imagem_caido, inimigo.x, inimigo.y, 0, 1, sx)
		end
	end

	for i, flechaInimigo in ipairs(flechasInimigas) do
		love.graphics.draw(flechaInimigo_imagem, flechaInimigo.x, flechaInimigo.y, flechaInimigo.angulo, 1, sx)
	end
end