local fonts = {
	['default'] = 'default',
	['default-bold'] = 'default-bold'
}

--//class text block
uiText = inherit(uiBaseElement)

function uiText:constructor(text, x, y, w, h, parent)
	--// call base constructor
	uiBaseElement.constructor(self, x, y, w, h, parent)
	--// set uiText params
	self.text = text or ''
	self.drawText = self.text
	self.font = 'default'
	self.scale = 1.0
	self.alignY = 'top'
	self.alignX = 'left'
	
	self.wrap = true
	self.clip = true
	self.mask = false
	
end

function uiText:getContentHeight()
	local line_count = 0
	for str in string.gmatch(self.text..'\n', "(.-)\n") do
		local line_text = ""
		for word in str:gmatch("%S+") do
			
			local temp_line_text = line_text .. " " .. word
			
			local temp_line_width = dxGetTextWidth(temp_line_text, self.scale, self.font)
			if temp_line_width >= self.w then
				--outputChatBox('перенос line:\n'..line_text)
				line_text = word
				line_count = line_count + 1
			else
				line_text = temp_line_text
			end
			
		end
		line_count = line_count + 1
	end
	return line_count  * dxGetFontHeight(self.scale, self.font) + (5*self.scale*(8/9))
end

function uiText:setVerticalAlign(align)
	self.alignY = align
end

function uiText:setHorizontalAlign(align)
	self.alignX = align
end

function uiText:setText(text, resize)
	self.text = text
	if self.mask then
		self.drawText = string.gsub(text, '.', '*')
	else
		self.drawText = text
	end
	if resize then
		self.h = self:getContentHeight()
	end
end

function uiText:setFont(font)
	if fonts[font] then
		self.font = font
	end
end

function uiText:setWrap(param)
	self.wrap = param
end

function uiText:setClip(param)
	self.clip = param
end

function uiText:setMask(param)
	self.mask = param
	if param then
		self.drawText = string.gsub(self.text, '.', '*')
	else
		self.drawText = self.text
	end
end

function uiText:draw()
	dxDrawText(self.drawText, self.x, self.y, self.x + self.w, self.y + self.h, self.color, self.scale, self.font, self.alignX, self.alignY, self.clip, self.wrap)
	--dxDrawText('123', 200, 50, 200, 20)
end



