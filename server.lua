--//2027 from 2037 spawn at 2050
--//1544
--//11


addEventHandler('onResourceStart', getResourceRootElement(),
	function()
		--CFileManager.Init()
		g_configManager = cConfigManager:new()
		g_serverData = cServerData:new()
		
		
		setWeaponProperty(30, "poor", "flags", 0x000004)
		setWeaponProperty(30, "std", "flags", 0x000004)
		setWeaponProperty(30, "pro", "flags", 0x000004)
		
		setWeaponProperty(33, "poor", "flags", 0x000004)
		setWeaponProperty(33, "std", "flags", 0x000004)
		setWeaponProperty(33, "pro", "flags", 0x000004)
	end
)

addEventHandler('onResourceStop', getResourceRootElement(),
	function()		
		
		setWeaponProperty(30, "poor", "flags", 0x000004)
		setWeaponProperty(30, "std", "flags", 0x000004)
		setWeaponProperty(30, "pro", "flags", 0x000004)
		
		setWeaponProperty(33, "poor", "flags", 0x000004)
		setWeaponProperty(33, "std", "flags", 0x000004)
		setWeaponProperty(33, "pro", "flags", 0x000004)
	end
)


addEventHandler ( "onPlayerSpawn", getRootElement(), 
	function()
		setElementPosition(source, 0, 0, 5)
	end
)
