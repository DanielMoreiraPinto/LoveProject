function menu_load()
	menu = {}
	
	menu.fonteMaior = love.graphics.newFont("assets/fontes/fonte.otf", 100)
	menu.fonteMedia = love.graphics.newFont("assets/fontes/fonte.otf", 50)
	menu.fonteMenor = love.graphics.newFont("assets/fontes/fonte.otf", 25)
	
	menu.video = love.graphics.newVideo("assets/imagens/tema_menu.Ogg", {false})
	menu.videoTempo = 38
	
	menu.recorde = carregarRecorde()
	
	menu.video:play()
end

function menu_update(dt)
	menu.videoTempo = menu.videoTempo - 1 * dt
	if menu.videoTempo <= 0 or not menu.video:isPlaying() then
		menu.videoTempo = 38
		menu.video:seek(0)
		menu.video:play()
	end
end

function menu_draw()
	love.graphics.draw(menu.video, 0 + (tela_largura - menu.video:getWidth()) / 2, 0)

	love.graphics.setFont(menu.fonteMaior)
	love.graphics.print("Sarraceno", 50, 20)
	love.graphics.setFont(menu.fonteMedia)
	love.graphics.print("Pressione Enter para jogar \n Pressione Esc para voltar ao menu", 50, 130)
	love.graphics.setFont(menu.fonteMenor)
	love.graphics.print("Maior pontuação: " .. menu.recorde, 800, 30)

end

function menu_pause()
	menu.video:pause()
	menu.video:seek(0)
	menu.videoTempo = 38
end