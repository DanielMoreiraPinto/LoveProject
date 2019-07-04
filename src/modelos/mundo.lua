function mundo_load()
	velocidadeIlusaoMundo = 20

	chao = {}
	chao.imagem = love.graphics.newImage("assets/imagens/chao.png")
	chao.largura = chao.imagem:getWidth()
	chao.altura = chao.imagem:getHeight()
	chao.x1 = 0
	chao.x2 = tela_largura
	chao.x = tela_largura
	chao.y = 450 

	fundoPerto = {}
	fundoPerto.imagem = love.graphics.newImage("assets/imagens/fundo_perto.png")
	fundoPerto.largura = fundoPerto.imagem:getWidth()
	fundoPerto.altura = fundoPerto.imagem:getHeight()
	fundoPerto.x1 = 0
	fundoPerto.x2 = tela_largura
	fundoPerto.x = tela_largura
	fundoPerto.y = chao.y - fundoPerto.altura

	fundoLonge = {}
	fundoLonge.imagem = love.graphics.newImage("assets/imagens/fundo_longe.png")
	fundoLonge.largura = fundoLonge.imagem:getWidth()
	fundoLonge.altura = fundoLonge.imagem:getHeight()
	fundoLonge.x1 = 0
	fundoLonge.x2 = fundoLonge.x1 + fundoLonge.largura
	fundoLonge.x = tela_largura
	fundoLonge.y = chao.y - fundoLonge.altura
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

	fundoPerto.x1 = fundoPerto.x1 - velocidadeIlusaoMundo/4
	fundoPerto.x2 = fundoPerto.x2 - velocidadeIlusaoMundo/4
	if fundoPerto.x1 + fundoPerto.largura <= 0 then
		fundoPerto.x1 = fundoPerto.x
	end
	if fundoPerto.x2 + fundoPerto.largura <= 0 then
		fundoPerto.x2 = fundoPerto.x
	end

	fundoLonge.x1 = fundoLonge.x1 - velocidadeIlusaoMundo/14
	fundoLonge.x2 = fundoLonge.x2 - velocidadeIlusaoMundo/14
	if fundoLonge.x1 + fundoLonge.largura <= 0 then
		fundoLonge.x1 = fundoLonge.x2 + fundoLonge.largura
	end
	if fundoLonge.x2 + fundoLonge.largura <= 0 then
		fundoLonge.x2 = fundoLonge.x1 + fundoLonge.largura
	end
end

function mundo_draw()
	love.graphics.draw(fundoLonge.imagem, fundoLonge.x1, fundoLonge.y, 0, 1, sx)
	love.graphics.draw(fundoLonge.imagem, fundoLonge.x2, fundoLonge.y, 0, 1, sx)

	love.graphics.draw(fundoPerto.imagem, fundoPerto.x1, fundoPerto.y, 0, 1, sx)
	love.graphics.draw(fundoPerto.imagem, fundoPerto.x2, fundoPerto.y, 0, 1, sx)

	love.graphics.draw(chao.imagem, chao.x1, chao.y, 0, 1, sx)
	love.graphics.draw(chao.imagem, chao.x2, chao.y, 0, 1, sx)
end