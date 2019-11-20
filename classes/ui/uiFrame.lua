
--//class image
uiFrame = inherit(uiBaseElement)


function uiFrame:constructor(texture, x, y, w, h, parent, scale)
	scale = scale or 64	
	--// call base constructor
	uiBaseElement.constructor(self, x, y, w, h, parent)
	--// set uiFrame params
	self.scale = scale
	self.texture = texture
	self.frame = dxCreateRenderTarget(w, h, true)
	
	--//create frame
	local sx = w / scale - 1
	local sy = h / scale - 1
	dxSetRenderTarget(self.frame)
	dxDrawImage(0, 0, scale, scale, g_textureManager:get(texture..'_lt').texture)
	dxDrawImage(sx * scale, 0, scale, scale, g_textureManager:get(texture..'_rt').texture)
	dxDrawImage(0, sy * scale, scale, scale, g_textureManager:get(texture..'_lb').texture)
	dxDrawImage(sx * scale, sy * scale, scale, scale, g_textureManager:get(texture..'_rb').texture)
	for ly=1, sy - 1 do
		dxDrawImage(0, ly * scale, scale, scale, g_textureManager:get(texture..'_l').texture)
		dxDrawImage(sx * scale, ly * scale, scale, scale, g_textureManager:get(texture..'_r').texture)
	end
	for lx=1, sx - 1 do
		dxDrawImage(lx * scale, 0, scale, scale, g_textureManager:get(texture..'_t').texture)
		dxDrawImage(lx * scale, sy * scale, scale, scale, g_textureManager:get(texture..'_b').texture)
	end
	for ly=1, sy - 1 do
		for lx=1, sx - 1 do
			outputChatBox(tostring(lx)..'-'..tostring(ly))
			dxDrawImage(lx * scale, ly * scale, scale, scale, g_textureManager:get(texture..'_back').texture)
		end
	end
	dxSetRenderTarget()
end

function uiFrame:draw()
	dxDrawImage(self.x, self.y, self.w, self.h, self.frame, 0, 0, 0, self.color)
end


