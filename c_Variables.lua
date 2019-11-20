
--//настройки управления
g_keyControls = {
	['inventory'] = 'i',
	['chat'] = 'tab'
}

--//Список клиентских переменных
g_guiIsOpen = false -- //открыто ли хоть одно окно
--//objects
g_textureManager = nil	--//менеджер текстур
g_hud = nil
g_clientPlayer = nil
g_shaderManager = nil
g_actionManager = nil
g_weaponManager = nil
g_deadRoom = nil
g_firstView = nil


screenWidth, screenHeight = guiGetScreenSize()
crosshairPosX, crosshairPosY = math.floor( screenWidth * 0.5303 + 0.5 ), math.floor( screenHeight * 0.4032 + 0.5 )



