function novaAnimacao(imagem, largura, altura, duracao)
	local animacao = {}
	animacao.spriteSheet = imagem
	animacao.quads = {}

	for y=0, imagem:getHeight() - altura, altura do
		for x=0, imagem:getWidth() - largura, largura do
			table.insert(animacao.quads, love.graphics.newQuad(x, y, largura, altura, imagem:getDimensions()))
		end
	end

	animacao.duracao = duracao or 1
	animacao.tempoAtual = 0

	return animacao
end

function carregarAnimacao(imagem, largura, altura)
	animacao = novaAnimacao(imagem, largura, altura, 0.3)
end

function atualizarAnimacao(dt)
	animacao.tempoAtual = animacao.tempoAtual + dt
	if animacao.tempoAtual >= animacao.duracao then
		animacao.tempoAtual = animacao.tempoAtual - animacao.duracao
	end
end

function desenharAnimacao(x, y)
	local spriteNum = math.floor(animacao.tempoAtual / animacao.duracao * #animacao.quads) + 1
	love.graphics.draw(animacao.spriteSheet, animacao.quads[spriteNum], x, y, 0, 1, sx)
end