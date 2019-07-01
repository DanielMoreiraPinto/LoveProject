require("lib/recorde")
require("src/menu")
require("src/preJogo")
require("src/jogo")
require("src/fimDeJogo")

function love.load()
	tela_largura, tela_altura = love.graphics.getDimensions()

	salvaIniciar()
	
	desenvolvimento = false
	
	modo = "menu"
	
	reload()
	
	musicaMenu = love.audio.newSource("assets/musica_menu.mp3", "stream")
	musicaMenu:setLooping(true)
	musicaJogo = love.audio.newSource("assets/musica_jogo.mp3", "stream")
	musicaJogo:setLooping(true)
	musicaFim = love.audio.newSource("assets/musica_fim.mp3", "stream")
	musicaFim:setLooping(true)

	musicaMenu:play()
end

function love.update(dt)
	if modo == "menu" then
		menu_update(dt)
	elseif modo == "preJogo" then
		preJogo_update(dt)
	elseif modo == "jogo" then
		jogo_update(dt)
	elseif modo == "fimDeJogo" then
		fimDeJogo_update(dt)
	end

	if modo == "menu" and love.keyboard.isDown("return") then
		menu_pause()
		modo = "preJogo"
	end

	if modo == "preJogo" and love.mouse.isDown(1) then
		musicaMenu:pause()
		musicaMenu:seek(0)
		musicaJogo:play()
		modo = "jogo"
	end

	if modo ~= "menu" and love.keyboard.isDown("escape") then
		musicaFim:pause()
		musicaFim:seek(0)
		musicaJogo:pause()
		musicaJogo:seek(0)
		musicaMenu:play()
		modo = "menu"	
		reload()
	end

	if not desenvolvimento and jogo_detectarFimDeJogo() then
		musicaJogo:pause()
		musicaJogo:seek(0)
		musicaFim:play()
		modo = "fimDeJogo"
		fimDeJogo_load()
	end
end

function love.draw()
	if modo == "menu" then
		menu_draw()
	elseif modo == "preJogo" then
		preJogo_draw()
	elseif modo == "jogo" then
		jogo_draw()
	elseif modo == "fimDeJogo" then
		fimDeJogo_draw()
	end
end

function reload()
	menu_load()
	preJogo_load()
	jogo_load()
	fimDeJogo_load()
end