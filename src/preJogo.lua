function preJogo_load()
	fundoPreJogo = {}
	fundoPreJogo.imagem = love.graphics.newImage("assets/imagem_preJogo.jpg")
	fundoPreJogo.largura = fundoPreJogo.imagem:getWidth()
	fundoPreJogo.altura = fundoPreJogo.imagem:getHeight()
	fundoPreJogo.x =  0
	fundoPreJogo.y = 0

	pergaminhoPreJogo = {}
	pergaminhoPreJogo.imagem = love.graphics.newImage("assets/pergaminho_preJogo.png")
	pergaminhoPreJogo.largura = pergaminhoPreJogo.imagem:getWidth()
	pergaminhoPreJogo.altura = pergaminhoPreJogo.imagem:getHeight()
	pergaminhoPreJogo.x =  0 + (tela_largura - pergaminhoPreJogo.largura) / 2
	pergaminhoPreJogo.y = 0

	fontePreJogo = love.graphics.newFont("assets/fonte.otf", 25)

	mensagemPreJogo = {}
	mensagemPreJogo.texto = "Guerra! Os exércitos cristãos uniram-se e estão marchando ".. 
					"\n"..
					"em direção a Jerusalém, a cidade sagrada. É a Primeira Cruzada. "..
					"\n"..
					"Você é um turco Seljúcida, povo que habita a Anatólia, portal de "..
					"\n"..
					"entrada dos cruzados. O sultão ordenou que os invasores sejam "..
					"\n"..
					"derrotados pela graça do Islã. Você marcha contra o inimigo que "..
					"\n"..
					"desrespeita seu povo, cujo nome, para eles, é meramente Sarraceno. "..
					"\n"..
					"Começa a guerra entre o Cristianismo e o Islã. "..
					"\n"..
					"Clique com o botão esquerdo do mouse para jogar."..
					"\n"..
					"Espaço: pular    Botão esquerdo do mouse: atirar   X: carga"
		mensagemPreJogo.x = pergaminhoPreJogo.x + 65
		mensagemPreJogo.y = pergaminhoPreJogo.y + 140
end

function preJogo_update()
	
end

function preJogo_draw()
	love.graphics.draw(fundoPreJogo.imagem, fundoPreJogo.x, fundoPreJogo.y)
	
	love.graphics.draw(pergaminhoPreJogo.imagem, pergaminhoPreJogo.x, pergaminhoPreJogo.y)
	
	love.graphics.setColor(0, 0, 0)
	
	love.graphics.setFont(fontePreJogo)
	love.graphics.print(mensagemPreJogo.texto, mensagemPreJogo.x, mensagemPreJogo.y)

	love.graphics.reset()
end