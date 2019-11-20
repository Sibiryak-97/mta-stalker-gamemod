

addEventHandler('onClientResourceStart', getResourceRootElement(),
	function()
		setPlayerHudComponentVisible('all', false)
		
		g_configManager = cConfigManager:new()
		g_textureManager = cTextureManager:new()
		g_weaponManager = cWeaponManager:new()
		g_hud = cHud:new()
		g_actionManager = cActionManager:new()
		g_clientPlayer = cClientPlayer:new()
		g_firstView = cFirstView:new()
		
		local login = cLoginPanel:new()
		login:show()
	end
)

addEventHandler('onClientKey', getRootElement(), 
	function(button, press)
		if button == 'F3' and not press then
			g_canSwitchWeapon = not g_canSwitchWeapon
		end
	end
)

addEventHandler('onClientRender', getRootElement(), 
	function()
	end
)


	
	