
--//class 
cWeapon = inherit(cInvObject)


function cWeapon:constructor(section)
	--//
	cInvObject.constructor(self, section)
	--//
	self.weapon_id = 0
end

function cWeapon:inHand(ped)
	giveWeapon(ped, self.weapon_id, 2000)
	setPedWeaponSlot(ped, getSlotFromWeapon(self.weapon_id))
	triggerClientEvent(ped, 'se_weaponManager.enable', ped, self)
end

function cWeapon:getActions(action_type)
	if action_type == ACTION_EQUIPMENT then
		if self.state == ITEM_STATE_IN_SLOT then
			return {name = ACTION_TO_HAND, obj = self, icon = false, bind = self.current_slot}
		elseif self.state == ITEM_STATE_IN_HAND then
			return {name = ACTION_TO_SLOT, obj = self, icon = false}
		end
	end
	return {name = nil, obj = nil}
end

function cWeapon:getHudTexture()
	--// добавить проверку на прикрепленный прицел
	return self:get('scope_texture')
end

cWpnAssault = inherit(cWeapon)

function cWpnAssault:constructor(section)
	cWeapon.constructor(self, section)
	--//
	self.weapon_id = 30
end

cWpnSniper = inherit(cWeapon)

function cWpnSniper:constructor(section)
	cWeapon.constructor(self, section)
end

cWpnPistol = inherit(cWeapon)

function cWpnPistol:constructor(section)
	cWeapon.constructor(self, section)
end

cWpnKnife = inherit(cWeapon)

function cWpnKnife:constructor(section)
	cWeapon.constructor(self, section)
end

cWpnShotgun = inherit(cWeapon)

function cWpnShotgun:constructor(section)
	cWeapon.constructor(self, section)
end




