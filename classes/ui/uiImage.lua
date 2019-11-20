
--//class image
uiImage = inherit(uiBaseElement)


function uiImage:constructor(texture, x, y, w, h, parent)
	--// call base constructor
	uiBaseElement.constructor(self, x, y, w, h, parent)
	--// set uiImage params
	texture = texture or ''
	self.texture = g_textureManager:get(texture).texture
	
end

function uiImage:setTexture(texture)
	texture = texture or ''
	self.texture = g_textureManager:get(texture).texture
end

function uiImage:draw()
	dxDrawImage(self.x, self.y, self.w, self.h, self.texture, 0, 0, 0, self.color)
end