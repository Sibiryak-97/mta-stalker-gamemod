
--//class image
uiButton = inherit(uiBaseElement)


function uiButton:constructor(texture, text, x, y, w, h, parent)
	--// call base constructor
	uiBaseElement.constructor(self, x, y, w, h, nil)
	--// set params
	self.image = uiImage:new(texture..'_e', x, y, w, h, nil)
	self.text = uiText:new(text, x, y, w, h, nil)
	self.text:setVerticalAlign('center')
	self.text:setHorizontalAlign('center')
	
	self.texture = texture
	self.isEnabled = true
	self.isHover = false
	
	if parent then
		self:attachTo(parent)
	end
	
	self.moveEvent = function(_, _, aX, aY)
		self:moveHandler(aX, aY)
	end
	
	self.clickEvent = function(button, press)
		self:clickHandler(button, press)
	end
	
end

function uiButton:draw()
	self.image:draw()
	self.text:draw()
end

function uiButton:setEnabled(param)
	if param == self.isEnabled then return end
	if param then
		self.image:setTexture(self.texture..'_e')
		addEventHandler('onClientCursorMove', getRootElement(), self.moveEvent)
		addEventHandler('onClientKey', getRootElement(), self.clickEvent)
	else
		self.image:setTexture(self.texture..'_d')
		removeEventHandler('onClientCursorMove', getRootElement(), self.moveEvent)
		removeEventHandler('onClientKey', getRootElement(), self.clickEvent)
	end
	self.isEnabled = param
end

function uiButton:moveHandler(aX, aY)
	local l, t, r, b = self:getRect()
	if aX > l and aX < r and aY > t and aY < b then
		--self.static:SetTextColor(self.hiddenTextColor.r, self.hiddenTextColor.g, self.hiddenTextColor.b)
		if not self.isHover then
			self.image:setTexture(self.texture..'_h')
		end
		self.isHover = true
	else
		--self.static:SetTextColor(255, 255, 255)
		if self.isHover then
			self.image:setTexture(self.texture..'_e')
		end
		self.isHover = false
	end
end

function uiButton:clickHandler(button, press)
	if button == 'mouse1' and not press and self.isHover and self.onClick then
		--outputChatBox('click2')
		self:onClick()
	end
end

--// parent
function uiButton:attachTo(parent)
	uiBaseElement.attachTo(self, parent)
	--//
	self.image:attachTo(parent)
	self.text:attachTo(parent)
end

function uiButton:deattach()
	uiBaseElement.deattach(self)
	--//
	self.image:deattach()
	self.text:deattach()
end

--// show and hide
function uiButton:show()
	uiBaseElement.show(self)
	--//
	if self.isEnabled then
		addEventHandler('onClientCursorMove', getRootElement(), self.moveEvent)
		addEventHandler('onClientKey', getRootElement(), self.clickEvent)
	end
end

function uiButton:hide()
	uiBaseElement.hide(self)
	--//
	if self.isEnabled then
		removeEventHandler('onClientCursorMove', getRootElement(), self.moveEvent)
		removeEventHandler('onClientKey', getRootElement(), self.clickEvent)
	end
end


