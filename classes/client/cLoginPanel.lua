addEvent('se_login.loginSuccess', true)
addEvent('se_login.loginFail', true)

--//class 
cLoginPanel = inherit(CObject)


function cLoginPanel:constructor()
	self.back = uiImage:new('ui_fake_e', 0, 0, screenWidth, screenHeight)
	
	--// handlers
	self.handlerLoginSuccess = function()
		self:hide()
		triggerServerEvent('se_serverData.spawnPlayer', localPlayer)
	end
	self.handlerLoginFail = function(text)
		outputChatBox('fail: '..text)
	end
	addEventHandler('se_login.loginSuccess', localPlayer, self.handlerLoginSuccess)
	addEventHandler('se_login.loginFail', localPlayer, self.handlerLoginFail)
	
	self:initMain()
end

function cLoginPanel:initMain()
	local btn = uiButton:new('ui_button_ordinary', 'Войти', 200, 100, 107, 23, self.back)
	btn.onClick = function()
		local data = {
			login = 'Sibi',
			password = '123'
		}
		triggerServerEvent('se_serverData.loginPlayer', localPlayer, data)
	end
end

function cLoginPanel:show()
	--//
	self.back:show()
	--//
	guiSetInputEnabled(true)
	showCursor(true)
	g_guiIsOpen = true
end

function cLoginPanel:hide()
	self.back:hide()
	--//
	guiSetInputEnabled(false)
	showCursor(false)
	g_guiIsOpen = false
end


