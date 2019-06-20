function menu_load()
	fonte1 = love.graphics.newFont("assets/fonte.otf", 100)
	fonte2 = love.graphics.newFont("assets/fonte.otf", 50)

	video = love.graphics.newVideo("assets/tema_menu.Ogg", {false})
	video:play()
	video_tempo = 38
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

	love.graphics.setFont(fonte1)
	love.graphics.print("Sarraceno", 50, 20)
	love.graphics.setFont(fonte2)
	love.graphics.print("Pressione Enter para jogar", 50, 130)
	love.graphics.print("Pressione Esc para voltar ao menu", 50, 170)

end

function menu_pause()
	video:pause()
	video:seek(0)
	video_tempo = 38
end