--//class text block
uiBaseElement = inherit(CObject)

function uiBaseElement:constructor(x, y, w, h, parent)
	self.originalX = x or 0
	self.originalY = y or 0
	self.x = x
	self.y = y
	self.w = w or 100
	self.h = h or 100
	self.color = 0xFFFFFFFF
	
	--// parent block
	self.parent = nil
	self.childs = {}
	if parent then
		self:attachTo(parent)
	end
	self.isVisible = false
	
	--// renderEvent
	self.renderEvent = function()
		self:draw()
	end
end

--// parent
function uiBaseElement:attachTo(parent)
	self.parent = parent
	table.insert(self.parent.childs, self)
	self:setPosition(self.originalX, self.originalY)
end

function uiBaseElement:deattach()
	local index = -1
	for i, child in ipairs(self.parent.childs) do
		if child == self then
			index = i
		end
	end
	table.remove(self.parent.childs, index)
	self.parent = nil
end

--// position
function uiBaseElement:setPosition(x, y)
	--// set original
	self.originalX = x
	self.originalY = y
	--// set draw position
	local px, py = 0, 0
	if self.parent then
		px, py = self.parent:getPosition()
	end
	self.x = px + x
	self.y = py + y
	--// reset childs position
	for _, child in ipairs(self.childs) do
		child:setPosition(child.originalX, child.originalY)
	end
end

function uiBaseElement:getPosition()
	if self.parent then
		local x, y = self.parent:getPosition()
		return self.x + x, self.y + y
	else
		return self.x, self.y
	end
end

--// size
function uiBaseElement:setSize(w, h)
	self.w = w
	self.h = h
end

function uiBaseElement:getSize()
	return self.w, self.h
end

--// color
function uiBaseElement:setColor(color)
	self.color = color
end

function uiBaseElement:getColor()
	return self.color
end

--//rect
function uiBaseElement:getRect()
	return self.x, self.y, self.x + self.w, self.y + self.h
end

--// show and hide
function uiBaseElement:show()
	if self.isVisible then return end
	self.isVisible = true
	addEventHandler('onClientRender', getRootElement(), self.renderEvent)
	--//childs
	for _, child in ipairs(self.childs) do
		child:show()
	end
end

function uiBaseElement:hide()
	if not self.isVisible then return end
	self.isVisible = false
	removeEventHandler('onClientRender', getRootElement(), self.renderEvent)
	--//childs
	for _, child in ipairs(self.childs) do
		child:hide()
	end
end




