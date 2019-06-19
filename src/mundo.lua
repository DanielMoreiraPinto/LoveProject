function mundo_load()
	velocidadeIlusaoMundo = 20

	chao = {}
	chao.imagem = love.graphics.newImage("assets/chao.png")
	chao.largura = chao.imagem:getWidth()
	chao.altura = chao.imagem:getHeight()
	chao.x1 = 0
	chao.x2 = tela_largura
	chao.x = tela_largura
	chao.y = 450 

	chaoAuxiliar1 = chao.imagem
	chaoAuxiliar2 = chao.imagem

	fundo = {}
	fundo.imagem = love.graphics.newImage("assets/fundo.png")
	fundo.largura = fundo.imagem:getWidth()
	fundo.altura = fundo.imagem:getHeight()
	fundo.x1 = 0
	fundo.x2 = tela_largura
	fundo.x = tela_largura
	fundo.y = chao.y - fundo.altura

	fundoAuxiliar1 = fundo.imagem
	fundoAuxiliar2 = fundo.imagem
end

function mundo_update(dt)
	chao.x1 = chao.x1 - velocidadeIlusaoMundo 
	chao.x2 = chao.x2 - velocidadeIlusaoMundo
	if chao.x1 + chao.largura <= 0 then
		chao.x1 = chao.x
	end
	if chao.x2 + chao.largura <= 0 then
		chao.x2 = chao.x
	end

	fundo.x1 = fundo.x1 - velocidadeIlusaoMundo/4
	fundo.x2 = fundo.x2 - velocidadeIlusaoMundo/4
	if fundo.x1 + fundo.largura <= 0 then
		fundo.x1 = fundo.x
	end
	if fundo.x2 + fundo.largura <= 0 then
		fundo.x2 = fundo.x
	end
end

function mundo_draw()
	--love.graphics.rectangle("fill", chao.x, chao.y, chao.largura, chao.altura)
	love.graphics.draw(fundoAuxiliar1, fundo.x1, fundo.y, 0, 1, sx)
	love.graphics.draw(fundoAuxiliar2, fundo.x2, fundo.y, 0, 1, sx)

	love.graphics.draw(chaoAuxiliar1, chao.x1, chao.y, 0, 1, sx)
	love.graphics.draw(chaoAuxiliar2, chao.x2, chao.y, 0, 1, sx)
end