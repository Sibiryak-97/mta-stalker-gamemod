local staminaCoeff = {
	stand = 0.0005,
	crouch = 0.0007,
	walk = - 0.0001,
	jog = - 0.0005,
	sprint = - 0.005,
	jump = - 0.004,
	crawl = - 0.0008
}
--//
addEvent('se_clientPlayer.enable', true)
addEvent('se_clientPlayer.disable', true)

--//class 
cClientPlayer = inherit(CObject)


function cClientPlayer:constructor()
	
	
	--//параметры для симуляции выносливости
	self.stamina = {
		['default'] = 1.0,		--// показатель выносливости по умолчанию
		['upgrade'] = 0.0,		--// бонус выносливости от тренировок
		['full'] 	= 1.0,		--// максимальная(полная, общая, выносливость)
		['current'] = 1.0,		--// текущий показатель выносливости
		['fatigueTimer'] = 0,	--// усталость таймер
		['fatigue'] = 0,		--// усталость 0..10 чем выше, тем меньше востановление выносливости
		['jump_lock'] = false,
		['sprint_lock'] = false,
		['move_lock'] = false
	}
	
	
	self.updateHandler = function()
		self:staminaUpdate()
		self:controlUpdate()
	end
	
	--//
	self.handlerEnable = function()
		self:enable()
	end
	self.handlerDisable = function()
		self:disable()
	end
	addEventHandler('se_clientPlayer.enable', localPlayer, self.handlerEnable)
	addEventHandler('se_clientPlayer.disable', localPlayer, self.handlerDisable)
	
end


function cClientPlayer:staminaUpdate()
	--//data
	local moveCoeff = staminaCoeff[getPedMoveState(getLocalPlayer())]
	if not moveCoeff then return end
	if moveCoeff > 0 then
		if self.stamina.current < 1 then
			self.stamina.current = self.stamina.current + moveCoeff * (1 - self.stamina.fatigue / 10)
		else
			self.stamina.current = 1
		end
	else
		self.stamina.current = self.stamina.current + self.stamina.default * moveCoeff
	end
	--//locks
	self.stamina.jump_lock = self.stamina.current < 0.1
	self.stamina.sprint_lock = self.stamina.current < 0.2
	self.stamina.move_lock = self.stamina.current < 0.01
	--//
	g_hud:updateBar('stamina', self.stamina.current)
end

function cClientPlayer:controlUpdate()
	local lock = self.stamina.jump_lock
	--//lock = lock || self.outfit.jump_lock --// in the future
	toggleControl('jump', not lock)
	
	lock = self.stamina.move_lock
	toggleControl('forwards', not lock)
	toggleControl('backwards', not lock)
	toggleControl('left', not lock)
	toggleControl('right', not lock)
	
	lock = self.stamina.sprint_lock
	toggleControl('sprint', not lock)
end

function cClientPlayer:enable()
	self.updateTimer = setTimer( self.updateHandler, 100, 0)
	
	
	g_actionManager:enable()
	g_firstView:enable()
	g_hud:show()
end

function cClientPlayer:disable()
	killTimer(self.updateTimer)
	
	g_actionManager:disable()
	g_firstView:disable()
	g_hud:hide()
end
