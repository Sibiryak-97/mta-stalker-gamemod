addEvent('se_weaponManager.enable', true)
addEvent('se_weaponManager.disable', true)


cWeaponManager = inherit(CObject)


function cWeaponManager:constructor()
	--//
	self.obj = nil
	self.texture = nil
	self.aimMode = false

	--// handlers
	self.handlerRender = function()
		self:onRender()
	end
	self.handlerKey = function(button, press)
		self:onKey(button, press)
	end
	self.handlerEnable = function(obj)
		self:enable(obj)
	end
	self.handlerDisable = function()
		self:disable()
	end
	addEventHandler('se_weaponManager.enable', getRootElement(), self.handlerEnable)
	addEventHandler('se_weaponManager.disable', getRootElement(), self.handlerDisable)
end

function cWeaponManager:onRender()
	dxDrawImage( (screenWidth - screenHeight) * 0.5, 0, screenHeight, screenHeight, self.texture)
end

function cWeaponManager:onKey(button, press)
	if button == 'mouse2' then
		self.aimMode = press
		if press then
			addEventHandler('onClientRender', getRootElement(), self.handlerRender)
			g_firstView:disable()
		else
			removeEventHandler('onClientRender', getRootElement(), self.handlerRender)
			g_firstView:enable()
		end
		outputChatBox('aimMode: '..tostring(self.aimMode))
	end
end

function cWeaponManager:enable(obj)
	self.obj = cInvObject.init(obj)
	self.texture = self.obj:getHudTexture()
	if self.texture then
		self.texture = g_textureManager:get(self.texture).texture
		addEventHandler('onClientKey', getRootElement(), self.handlerKey)
	end
end

function cWeaponManager:disable()
	if self.texture then
		removeEventHandler('onClientKey', getRootElement(), self.handlerKey)
	end
end

