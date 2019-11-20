--//
ITEM_STATE_IN_SLOT = 0
ITEM_STATE_IN_HAND = 1


--//class 
cInvObject = inherit(CObject)


function cInvObject:constructor(section)
	--// id
	self.id = -1
	self.state = -1	--// нахолится в слоте или нет
	self.current_slot = nil
	self.hand_slot = 'left'

	--// секция предмета
	self.section = section
	
	--// реально существующий объект
	self.model = nil
	
	--//
	self.unique = {}	--//уникальные параметры каждого предмета(по ним может быть объединение)
	self.upgrade = {}	--//уникальные параметры почти каждого предмета(по ним не идет объединение...добавляется иконка)
	
	--//
	for key, value in pairs(g_configManager:section(section)['unique']) do
		self.unique[key] = value
	end
	
end

function cInvObject.init(obj)
	if not obj then return end
	local section = ''
	if type(obj) == "table" then
		section = obj.section
	else
		section = obj
	end
	local class = g_configManager:getValue(section, 'class')
	local item = nil
	if class == ITEM_WPN_ASSAULT then
		item = cWpnAssault:new(section)
	elseif class == ITEM_WPN_SNIPER then
		item = cWpnSniper:new(section)
	elseif class == ITEM_WPN_PISTOL then
		item = cWpnPistol:new(section)
	elseif class == ITEM_WPN_KNIFE then
		item = cWpnKnife:new(section)
	elseif class == ITEM_WPN_SHOTGUN then
		item = cWpnShotgun:new(section)
	end
	if not item then outputChatBox('Не был создан объект: '..tostring(section))	end
	if type(obj) == "table" then
		item.id = obj.id
		item.state = obj.state
		item.current_slot = obj.current_slot
		item.unique = obj.unique
		item.upgrade = obj.upgrade
	end
	return item
end

function cInvObject:general()
	return g_configManager:section(self.section).general
end

function cInvObject:isUpgrade()
	if #self.upgrade > 0 then return true
	else return false 
	end
end

function cInvObject:__eq(obj)
	if self.section == obj.section then
		--outputChatBox('sec is true'..obj.Section)
		if self:isUpgrade() or obj:isUpgrade() then
			return false
		else
			for key, value in pairs(self.unique) do
				--outputChatBox('k-'..key..'|v1-'..tostring(value)..'|v2'..tostring(obj.Unique[key]))
				if value ~= obj.unique[key] then
					return false
				end
			end
			return true
		end
	else
		return false
	end
end

function cInvObject:getValue(key)
	if self.unique[key] then
		return self.unique[key]
	elseif self.upgrade[key] then
		return self.upgrade[key]
	else
		return g_configManager:getValue(self.section, key)
	end
end

function cInvObject:setValue(key, value)
	local k_type = g_configManager:getKeyType(self.section, key)
	if k_type == 'unique' then
		self.unique[key] = value
	elseif k_type == 'upgrade' then
		self.upgrade[key] = value
	else
		outputDebugString(string.format('[STALKER - CInvObject]Try set general param for section \'%s\'. Key is \'%s\', value is \'%s\'', self.section, key, value))
	end
end

function cInvObject:get(key)
	return self:getValue(key)
end

function cInvObject:set(key, value)
	self:setValue(key, value)
end

function cInvObject:getActions(action_type)
	return nil
end

function cInvObject:getHudTexture()
	return nil
end

function cInvObject:tostring()
	return self:get('inv_name')
end