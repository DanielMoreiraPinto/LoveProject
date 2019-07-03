function menu_load()
	menuTexto = {}
	menuTexto.fonteMaior = love.graphics.newFont("assets/fontes/fonte.otf", 100)
	menuTexto.fonteMedia = love.graphics.newFont("assets/fontes/fonte.otf", 50)
	menuTexto.fonteMenor = love.graphics.newFont("assets/fontes/fonte.otf", 25)

	video = love.graphics.newVideo("assets/imagens/tema_menu.Ogg", {false})
	video:play()
	video_tempo = 38

	recorde = carregarRecorde()
end

function menu_update(dt)
	video_tempo = video_tempo - 1 * dt
	if video_tempo <= 0 or not video:isPlaying() then
		video_tempo = 38
		video:seek(0)
		video:play()
	end
end

function menu_draw()
	love.graphics.draw(video, 0 + (tela_largura - video:getWidth()) / 2, 0)

	love.graphics.setFont(menuTexto.fonteMaior)
	love.graphics.print("Sarraceno", 50, 20)
	love.graphics.setFont(menuTexto.fonteMedia)
	love.graphics.print("Pressione Enter para jogar \n Pressione Esc para voltar ao menu", 50, 130)
	love.graphics.setFont(menuTexto.fonteMenor)
	love.graphics.print("Maior pontuação: " .. recorde, 800, 30)

end

function menu_pause()
	video:pause()
	video:seek(0)
	video_tempo = 38
end