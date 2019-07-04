function preJogo_load()
	preJogo = {}
	
	preJogo.fundo = {}
	preJogo.fundo.imagem = love.graphics.newImage("assets/imagens/imagem_preJogo.jpg")
	preJogo.fundo.largura = preJogo.fundo.imagem:getWidth()
	preJogo.fundo.altura = preJogo.fundo.imagem:getHeight()
	preJogo.fundo.x =  0
	preJogo.fundo.y = 0

	preJogo.pergaminho = {}
	preJogo.pergaminho.imagem = love.graphics.newImage("assets/imagens/pergaminho_preJogo.png")
	preJogo.pergaminho.largura = preJogo.pergaminho.imagem:getWidth()
	preJogo.pergaminho.altura = preJogo.pergaminho.imagem:getHeight()
	preJogo.pergaminho.x =  0 + (tela_largura - preJogo.pergaminho.largura) / 2
	preJogo.pergaminho.y = 0

	preJogo.fonte = love.graphics.newFont("assets/fontes/fonte.otf", 25)

	preJogo.mensagem = {}
	preJogo.mensagem.texto = "Guerra! Os exércitos cristãos uniram-se e estão marchando ".. 
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
		preJogo.mensagem.x = preJogo.pergaminho.x + 65
		preJogo.mensagem.y = preJogo.pergaminho.y + 140
end

function preJogo_update()
	
end

function preJogo_draw()
	love.graphics.draw(preJogo.fundo.imagem, preJogo.fundo.x, preJogo.fundo.y)
	
	love.graphics.draw(preJogo.pergaminho.imagem, preJogo.pergaminho.x, preJogo.pergaminho.y)
	
	love.graphics.setColor(0, 0, 0)
	
	love.graphics.setFont(preJogo.fonte)
	love.graphics.print(preJogo.mensagem.texto, preJogo.mensagem.x, preJogo.mensagem.y)

	love.graphics.reset()
end