function fimDeJogo_load()
	fimDeJogo = {}

	fimDeJogo.fundo = {}
	fimDeJogo.fundo.imagem = love.graphics.newImage("assets/imagens/imagem_fim.jpg")
	fimDeJogo.fundo.largura = fimDeJogo.fundo.imagem:getWidth()
	fimDeJogo.fundo.altura = fimDeJogo.fundo.imagem:getHeight()
	fimDeJogo.fundo.x =  0
	fimDeJogo.fundo.y = 0

	fimDeJogo.pergaminho = {}
	fimDeJogo.pergaminho.imagem = love.graphics.newImage("assets/imagens/pergaminho_fim.png")
	fimDeJogo.pergaminho.largura = fimDeJogo.pergaminho.imagem:getWidth()
	fimDeJogo.pergaminho.altura = fimDeJogo.pergaminho.imagem:getHeight()
	fimDeJogo.pergaminho.x =  0 + (tela_largura - fimDeJogo.pergaminho.largura) / 2
	fimDeJogo.pergaminho.y = 0

	fimDeJogo.fonteMaior = love.graphics.newFont("assets/fontes/fonte.otf", 50)
	fimDeJogo.fonteMenor = love.graphics.newFont("assets/fontes/fonte.otf", 25)

	fimDeJogo.mensagem = {}
	fimDeJogo.mensagem.texto = "Os Seljúcidas lutaram bravamente contra as forças ".. 
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
	fimDeJogo.mensagem.x = fimDeJogo.pergaminho.x + 60
	fimDeJogo.mensagem.y = fimDeJogo.pergaminho.y + 140

	fimDeJogo.pontuacao = carregarPontuacao()
	
	fimDeJogo.recorde = carregarRecorde()

	if fimDeJogo.pontuacao > fimDeJogo.recorde then
		salvarRecorde(fimDeJogo.pontuacao)
		novoRecorde = true
	end
end

function fimDeJogo_update()

end

function fimDeJogo_draw()
	love.graphics.draw(fimDeJogo.fundo.imagem, fimDeJogo.fundo.x, fimDeJogo.fundo.y)
	
	love.graphics.draw(fimDeJogo.pergaminho.imagem, fimDeJogo.pergaminho.x, fimDeJogo.pergaminho.y)
	
	love.graphics.setColor(0, 0, 0)

	love.graphics.setFont(fimDeJogo.fonteMaior)
	love.graphics.print("Fim de jogo", 430, 50)
	
	love.graphics.setFont(fimDeJogo.fonteMenor)
	love.graphics.print("Sua pontuação: " .. fimDeJogo.pontuacao, 800, 30)
	love.graphics.print(fimDeJogo.mensagem.texto, fimDeJogo.mensagem.x, fimDeJogo.mensagem.y)
	if novoRecorde then
		love.graphics.print("NOVO RECORDE!", 800, 60)
	end

	love.graphics.reset()
end

function fimDeJogo_informacao()
	
end