addEvent('se_serverPlayer.getActions', true)
addEvent('se_serverPlayer.executeAction', true)


--//class 
cServerPlayer = inherit(CObject)


function cServerPlayer:constructor(ped)
	--//
	self.ped = ped
	self.canSwitchWeapon = false
	
	--// set stats
	for _, stat in ipairs({ 26, 69, 70, 71, 72, 73, 74, 76, 77, 78, 79 }) do
		setPedStat( self.ped, stat, 1000)
	end
	
	--//
	self.personal = {
		f_name = 'f_name',
		m_name = 'm_name',
		l_name = 'l_name',
		nick = 'nick',
		face_id = 1
	}
	
	--//
	self.hand = {
		left = nil,
		right = nil
	}
	
	--//
	self.equip = {
		slot_1 = nil,
		slot_2 = nil,
		slot_3 = nil,
		slot_outfit = nil,
		slot_bag = nil,
		--slot_fast_1 = nil,
		--slot_fast_2 = nil,
		--slot_fast_3 = nil,
		--slot_fast_4 = nil,
		slot_pocket_1 = nil,
		slot_pocket_2 = nil,
		slot_pocket_3 = nil,
		slot_pocket_4 = nil,
		slot_pocket_5 = nil,
		slot_pocket_6 = nil,
		slot_pocket_7 = nil,
		slot_pocket_8 = nil,
		slot_pocket_9 = nil
	}
	--// inventory handlers
	self.handlerOpenInventory = function()
		self:onOpenInventory()
	end
	self.handlerCloseInventory = function()
		self:onCloseInventory()
	end
	addEventHandler( 'se_serverPlayer.openInventory', self.ped, self.handlerOpenInventory)
	addEventHandler( 'se_serverPlayer.closeInventory', self.ped, self.handlerCloseInventory)	
	
	--// alive handlers
	self.handlerSpawn = function()
		self:onSpawn()
	end
	self.handlerDamage = function(attacker, attackerweapon, bodypart, loss)
		self:onDamage(attacker, attackerweapon, bodypart, loss)
	end
	self.handlerWasted = function()
		self:onWasted()
	end
	self.handlerQuit = function()
		self:onQuit()
	end
	addEventHandler('onPlayerSpawn', self.ped, self.handlerSpawn)
	addEventHandler('onPlayerDamage', self.ped, self.handlerDamage)
	addEventHandler('onPlayerWasted', self.ped, self.handlerWasted)
	addEventHandler('onPlayerQuit', self.ped, self.handlerQuit)
	
	--// actions handlers
	self.handlerGetActions = function(action_type)
		self:getActions(action_type)
	end
	self.handlerExecuteAction = function(data)
		self:executeAction(data.name, data.obj)
	end
	addEventHandler('se_serverPlayer.getActions', self.ped, self.handlerGetActions)
	addEventHandler('se_serverPlayer.executeAction', self.ped, self.handlerExecuteAction)
	
	--// object combine handlers 
	self.handlerCombine = function()
		self:combineItems()
	end
	self.handlerUncombine = function()
		self:uncombineItems()
	end
	bindKey(self.ped, 'mouse1', 'down', self.handlerCombine)
	bindKey(self.ped, 'mouse2', 'down', self.handlerUncombine)
	
	--// weapon handler
	self.handlerFire = function(weapon, endX, endY, endZ, hitElement, startX, startY, startZ)
		self:onFire(weapon, endX, endY, endZ, hitElement, startX, startY, startZ)
	end
	self.handlerSwitch = function(prevID, curID)
		self:onSwitch(prevID, curID)
	end
	addEventHandler('onPlayerWeaponFire', self.ped, self.handlerFire)	
	addEventHandler('onPlayerWeaponSwitch', self.ped, self.handlerSwitch)
end

function cServerPlayer:onOpenInventory()

end

function cServerPlayer:onCloseInventory()

end

function cServerPlayer:onSpawn()
	self.equip.slot_1 = g_serverData:create('wpn_knife')
	self.equip.slot_1.state = ITEM_STATE_IN_SLOT
	self.equip.slot_1.current_slot = 'slot_1'
	self.equip.slot_2 = g_serverData:create('wpn_pm')
	self.equip.slot_2.state = ITEM_STATE_IN_SLOT
	self.equip.slot_2.current_slot = 'slot_2'
	self.equip.slot_3 = g_serverData:create('wpn_ak74')
	self.equip.slot_3.state = ITEM_STATE_IN_SLOT
	self.equip.slot_3.current_slot = 'slot_3'
	--outputChatBox(self.equip.slot_3:tostring())
	triggerClientEvent(self.ped, 'se_clientPlayer.enable', self.ped)
end

function cServerPlayer:onDamage()

end

function cServerPlayer:onWasted()

end

function cServerPlayer:onQuit()

end

function cServerPlayer:getActions(action_type)
	local data = {}
	table.insert(data, {name = ACTION_CANCEL, obj = nil, icon = true}) 
	if action_type == ACTION_EQUIPMENT then
		--//добавляем события для предметов из слотов
		for _, obj in pairs(self.equip) do
			if obj then  
				table.insert(data, obj:getActions(action_type)) 
			end
		end
		triggerClientEvent(self.ped, 'se_actionManager.show', self.ped, data)
		return
	end
	if action_type == ACTION_WEAPON then
		
		return
	end
	if action_type == ACTION_GROUND_EQUIPMENT then
	
		return
	end
end

function cServerPlayer:executeAction(action, obj)
	if action == ACTION_TO_HAND then
		self.equip[obj.current_slot]:inHand(self.ped)
		self.hand[obj.hand_slot] = self.equip[obj.current_slot]
		self.equip[obj.current_slot] = nil
		return
	elseif action == ACTION_TO_SLOT then
		
	end
end

function cServerPlayer:combineItems()

end

function cServerPlayer:uncombineItems()

end

function cServerPlayer:onFire(weapon, endX, endY, endZ, hitElement, startX, startY, startZ)

end

function cServerPlayer:onSwitch(prevID, curID)
	if self.canSwitchWeapon then 
		setPedWeaponSlot(self.ped, getSlotFromWeapon(prevID))
		self.canSwitchWeapon = false
	else
		self.canSwitchWeapon = true
	end
end

















