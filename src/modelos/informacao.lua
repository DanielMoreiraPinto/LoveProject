function informacao_load()
	informacao = {}
	informacao.fonte = love.graphics.newFont("assets/fonte.otf", 25)
	informacao.recorde = {}
		informacao.recorde.x = 0
		informacao.recorde.y = 0
		informacao.recorde.pontuacao = 0
		informacao.recorde.texto = "Maior pontuação: " .. informacao.recorde.pontuacao
	informacao.carga = {}
		informacao.carga.x = 0
		informacao.carga.y = 0
		informacao.carga.duracao = 0
		informacao.carga.textoPronto = "Carga pronta"
		informacao.carga.textoDuracao = "Carga: " .. informacao.carga.duracao
	informacao.pontos = {}
		informacao.pontos.x = 0
		informacao.pontos.y = 0
		informacao.pontos.pontuacao = 0
		informacao.pontos.texto = "Pontuação: " .. informacao.pontos.pontuacao
end

function informacao_update(dt, duracaoCarga)
	informacao.carga.duracao = duracaoCarga

	informacao.pontos.pontuacao = informacao.pontos.pontuacao + 2*dt
end

function informacao_drawMenu()
	love.graphics.setColor(0, 0, 0)
	love.graphics.setFont(informacao.fonte)

	love.graphics.draw(informacao.recorde.texto, informacao.recorde.x, informacao.recorde.y)

	love.graphics.reset()
end

function informacao_drawJogo()
	love.graphics.setColor(0, 0, 0)
	love.graphics.setFont(informacao.fonte)
	
	if informacao.carga.duracao < 5 and informacao.carga.duracao >= 0 then 
		love.graphics.draw(informacao.carga.textoDuracao, informacao.carga.x, informacao.carga.y)
	elseif informacao.carga.duracao == 5 then
		love.graphics.draw(informacao.carga.textoPronto, informacao.carga.x, informacao.carga.y)
	end
	love.graphics.draw(informacao.pontos.texto, informacao.pontos.x, informacao.pontos.y)


	love.graphics.reset()
end

function informacao_drawFimDeJogo()
	love.graphics.setColor(0, 0, 0)
	love.graphics.setFont(informacao.fonte)

	love.graphics.draw(informacao.pontos.texto, informacao.recorde.x, informacao.recorde.y)
	
	love.graphics.reset()
end