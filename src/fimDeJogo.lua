function fimDeJogo_load()
	fundoFim = {}
	fundoFim.imagem = love.graphics.newImage("assets/imagem_fim.jpg")
	fundoFim.largura = fundoFim.imagem:getWidth()
	fundoFim.altura = fundoFim.imagem:getHeight()
	fundoFim.x =  0
	fundoFim.y = 0

	pergaminhoFim = {}
	pergaminhoFim.imagem = love.graphics.newImage("assets/pergaminho_fim.png")
	pergaminhoFim.largura = pergaminhoFim.imagem:getWidth()
	pergaminhoFim.altura = pergaminhoFim.imagem:getHeight()
	pergaminhoFim.x =  0 + (tela_largura - pergaminhoFim.largura) / 2
	pergaminhoFim.y = 0

	fonteFimMaior = love.graphics.newFont("assets/fonte.otf", 50)
	fonteFimMenor = love.graphics.newFont("assets/fonte.otf", 25)

	mensagemFim = {}
	mensagemFim.texto = "Os Seljúcidas lutaram bravamente contra as forças ".. 
					"\n"..
					"cruzadas, mas as disputas internas dos "..
					"\n"..
					"povos islâmicos impediram uma atitude em conjunto, "..
					"\n"..
					"então os cristãos marcharam vitoriosos pela terra santa. "..
					"\n"..
					"Mas essa guerra é apenas a primeira de várias que serão "..
					"\n"..
					"travadas entre essas duas religiões. Esse é apenas "..
					"\n"..
					"o início de uma longa e sangrenta história que moldou "..
					"\n"..
					"os caminhos da humanidade."..
					"\n"..
					"Pressione ESC para ir ao menu."
		mensagemFim.x = pergaminhoFim.x + 60
		mensagemFim.y = pergaminhoFim.y + 140
end

function fimDeJogo_update()
	
end

function fimDeJogo_draw()
	love.graphics.draw(fundoFim.imagem, fundoFim.x, fundoFim.y)
	
	love.graphics.draw(pergaminhoFim.imagem, pergaminhoFim.x, pergaminhoFim.y)
	
	love.graphics.setColor(0, 0, 0)

	love.graphics.setFont(fonteFimMaior)
	love.graphics.print("Fim de jogo", 430, 50)
	
	love.graphics.setFont(fonteFimMenor)
	love.graphics.print(mensagemFim.texto, mensagemFim.x, mensagemFim.y)

	love.graphics.reset()
end