function salvaIniciar()
	if not love.filesystem.getInfo("recorde.txt") then
		love.filesystem.write("recorde.txt", 0)
	end
	love.filesystem.write("pontuacao.txt", 0)
end

function salvarRecorde(recorde)
	love.filesystem.write("recorde.txt", recorde)	
end

function carregarRecorde() 
	if love.filesystem.getInfo("recorde.txt") then
		recorde = love.filesystem.read("recorde.txt")
		return tonumber(recorde)
	else
		return 0
	end
end

function salvarPontuacao(pontuacao)
	love.filesystem.write("pontuacao.txt", pontuacao)	
end

function carregarPontuacao()
	if love.filesystem.getInfo("pontuacao.txt") then
		pontuacao = love.filesystem.read("pontuacao.txt")
		return tonumber(pontuacao)
	else
		return 0
	end
end