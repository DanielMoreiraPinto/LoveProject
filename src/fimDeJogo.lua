function fimDeJogo_load()
	fundo = {}
	fundo.imagem = love.graphics.newImage("assets/imagem_fim.jpg")
	fundo.largura = fundo.imagem:getWidth()
	fundo.altura = fundo.imagem:getHeight()
	fundo.x =  0
	fundo.y = 0

	pergaminho = {}
	pergaminho.imagem = love.graphics.newImage("assets/pergaminho.png")
	pergaminho.largura = pergaminho.imagem:getWidth()
	pergaminho.altura = pergaminho.imagem:getHeight()
	pergaminho.x =  0 + (tela_largura - pergaminho.largura) / 2
	pergaminho.y = 0

	fonteFimMaior = love.graphics.newFont("assets/fonte.otf", 50)
	fonteFimMenor = love.graphics.newFont("assets/fonte.otf", 25)

	mensagem = {}
	mensagem.texto = "Os Seljúcidas lutaram bravamente contra as forças ".. 
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
		mensagem.x = pergaminho.x + 60
		mensagem.y = pergaminho.y + 140
end

function fimDeJogo_update()
	
end

function fimDeJogo_draw()
	love.graphics.draw(fundo.imagem, fundo.x, fundo.y)
	
	love.graphics.draw(pergaminho.imagem, pergaminho.x, pergaminho.y)
	
	love.graphics.setColor(0, 0, 0)

	love.graphics.setFont(fonteFimMaior)
	love.graphics.print("Fim de jogo", 430, 50)
	
	love.graphics.setFont(fonteFimMenor)
	love.graphics.print(mensagem.texto, mensagem.x, mensagem.y)

	love.graphics.reset()
end