--// ACTION MANAGER
addEvent('se_actionManager.show', true)

--//
local icon = {
	[ACTION_CANCEL] = 'ui_action_cancel',
	[ACTION_TO_HAND] = 'ui_action_take',
	[ACTION_TO_SLOT] = 'ui_action_open_bag',
	[ACTION_DROP] = 'ui_action_drop',
	[ACTION_TAKE] = 'ui_action_take',
	[ACTION_OPEN_BAG] = 'ui_action_open_bag'
}

local translate = {
	[ACTION_CANCEL] = 'Отменить',
	[ACTION_DROP] = 'Выкинуть',
	[ACTION_TAKE] = 'Поднять',
	[ACTION_OPEN_BAG] = 'Открыть',
	[ACTION_TO_HAND] = 'Взять в руки',
	[ACTION_TO_SLOT] = 'Убрать '
}

local function getActionText(action, obj)
	local text = ''
	if obj then 
		text = obj:tostring()
	end
	return string.format('%s %s', translate[action], text)
end

--//class 
cActionManager = inherit(CObject)

function cActionManager:constructor()
	
	self.actions = {}
	self.hintBack = uiImage:new('ui_listline2', screenWidth / 2, 0, screenWidth / 2, 20)
	self.hint = uiText:new('подсказка', 5, 0, screenWidth / 2 - 10, 20, self.hintBack)
	self.hint:setHorizontalAlign('right')
	self.currentIndex = 0
	self.maxIndex = 0
	
	self.isVisible = false
	--//
	self.handlerKey = function(button, press)
		self:onKey(button, press)
	end
	
	self.handlerShowActionList = function(data)
		self.hintBack:show()
		self.maxIndex = #data
		self.currentIndex = 1
		for i, action in ipairs(data) do
			local cell = {}
			
			--// сохраняем объект
			cell.obj = cInvObject.init(action.obj)
			cell.name = action.name
			cell.text = getActionText(cell.name, cell.obj)
			
			--// фон 
			cell.back = uiImage:new('ui_hud_equip_idle', screenWidth - 41, (i - 1) * 41 + 21, 40, 40)
			cell.back:setColor(0xFFFFFFFF)
			
			--// иконка предмета, либо действия
			if action.icon then
				cell.icon = uiImage:new(icon[action.name], 5, 5, 30, 30, cell.back)
			else
				cell.icon = uiImage:new(cell.obj.section, 5, 5, 30, 30, cell.back)
			end
			
			cell.back:show()
			table.insert(self.actions, cell)
		end
		self:enableActionCell(1)
	end
end

function cActionManager:onKey(button, press)
	if press and not g_guiIsOpen then
		if button == 'f' then
			if self.isVisible then
				--// send info to server
				local data = {
					name = self.actions[self.currentIndex].name,
					obj = self.actions[self.currentIndex].obj
				}
				triggerServerEvent('se_serverPlayer.executeAction', localPlayer, data)
				
				--// hide all
				self.maxIndex = 0
				self.hintBack:hide()
				for i, cell in ipairs(self.actions) do
					cell.back:hide()
					cell = nil
				end
				self.actions = {}
				self.isVisible = false
			else
				triggerServerEvent('se_serverPlayer.getActions', localPlayer, ACTION_EQUIPMENT)
				self.isVisible = true
			end
			return
		end
		if self.maxIndex > 0 then 
			if button == 'mouse_wheel_up' then
				self:disableActionCell(self.currentIndex)
				self.currentIndex = self.currentIndex - 1
				if self.currentIndex < 1 then self.currentIndex = self.maxIndex end
				self:enableActionCell(self.currentIndex)
				return
			end
			if button == 'mouse_wheel_down' then
				self:disableActionCell(self.currentIndex)
				self.currentIndex = self.currentIndex + 1
				if self.currentIndex > self.maxIndex then self.currentIndex = 1 end
				self:enableActionCell(self.currentIndex)
				return
			end
		end
	end
end

function cActionManager:enableActionCell(index)
	self.actions[index].back:setColor(0xFF00FF00)
	self.hint:setText(self.actions[index].text)
end

function cActionManager:disableActionCell(index)
	self.actions[index].back:setColor(0xFFFFFFFF)
end

function cActionManager:enable()
	addEventHandler('onClientKey', getRootElement(), self.handlerKey)
	addEventHandler('se_actionManager.show', getRootElement(), self.handlerShowActionList)
end

function cActionManager:disable()
	removeEventHandler('onClientKey', getRootElement(), self.handlerKey)
	removeEventHandler('se_actionManager.show', getRootElement(), self.handlerShowActionList)
end

