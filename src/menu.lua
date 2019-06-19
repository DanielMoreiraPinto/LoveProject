function menu_load()
	fonte = love.graphics.newFont("assets/fonte.otf", 100)
	love.graphics.setFont(fonte)

	video = love.graphics.newVideo("assets/tema_menu.Ogg", {false})
	video:play()
	video_tempo = 38
end

function menu_update(dt)
	if modo == "menu" then
		video_tempo = video_tempo - 1 * dt
		if video_tempo <= 0 or not video:isPlaying() then
			video_tempo = 38
			video:seek(0)
			video:play()
		end
	else
		video:pause()
		video:seek(0)
	end
end

function menu_draw()
	love.graphics.draw(video, 0 + (tela_largura - video:getWidth()) / 2, 0)

	love.graphics.print("Sarraceno", 50, 50)
end