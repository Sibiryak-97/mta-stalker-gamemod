--//class texture manager
cTextureManager = inherit(CObject)


function cTextureManager:constructor()
	self.Textures = {}
	
	self:parseMulti('config/textures/textures_ui.xml')
	self:parseMulti('config/textures/textures_wpn.xml')
	self:parse('config/textures/ui_icon_equipment.xml')
end

function cTextureManager:parse(path)
	--local xml = xmlLoadFile('config/ui/ui_common.xml')		
	local xml = xmlLoadFile(path)				
	if not xml then
		outputChatBox('FILE NOT FOUND: '..path)
	end
	local items = xmlNodeGetChildren(xml)		
	local texture_name = nil
	local texture = nil
	for i, item in ipairs(items) do
		local name = xmlNodeGetName(item)
		if name == 'file_name' then
			texture_name = xmlNodeGetValue(item)
			texture = dxCreateTexture(string.format('textures/%s\.dds', texture_name), 'dxt5')
			--//outputChatBox(tostring(texture)..' - '..texture_name)
		else
			local id = xmlNodeGetAttribute(item, 'id')
			local x = tonumber(xmlNodeGetAttribute(item, 'x'))
			local y = tonumber(xmlNodeGetAttribute(item, 'y'))
			local w = tonumber(xmlNodeGetAttribute(item, 'width'))
			local h = tonumber(xmlNodeGetAttribute(item, 'height'))
			local pixels = dxGetTexturePixels(texture, x, y, w ,h)
			local section = {
				['width'] = w,
				['height'] = h,
				['texture'] = dxCreateTexture(pixels) 
			}
			self.Textures[id] = section
		end
	end
	xmlUnloadFile(xml)
	destroyElement(texture)
end

function cTextureManager:parseMulti(path)
	local xml = xmlLoadFile(path)		
	if not xml then
		outputChatBox('FILE NOT FOUND: '..path)
	end
	local items = xmlNodeGetChildren(xml)	
	for i, item in ipairs(items) do
		local name = xmlNodeGetName(item)
		if name == 'texture' then
			local id = xmlNodeGetAttribute(item, 'id')
			local texture_name = xmlNodeGetValue(item)
			if self.Textures[id] then
				outputDebugString(string.format('[STALKER - CTextureManager]Duplicate texture id \'%s\'.', id))
			end
			local x = tonumber(xmlNodeGetAttribute(item, 'x'))
			local y = tonumber(xmlNodeGetAttribute(item, 'y'))
			local w = tonumber(xmlNodeGetAttribute(item, 'w'))
			local h = tonumber(xmlNodeGetAttribute(item, 'h'))
			local texture = dxCreateTexture(string.format('textures/%s\.dds', texture_name), 'dxt5')
			local section = {}
			if x and y and w and h then
				section = {
					['width'] = w,
					['height'] = h,
					['texture'] = dxCreateTexture(dxGetTexturePixels(texture, x, y, w ,h))
				}
				destroyElement(texture)
			else
				section = {
					['width'] = -1,
					['height'] = -1,
					['texture'] = texture
				}
			end
			self.Textures[id] = section
		end
	end
	xmlUnloadFile(xml)
end

function cTextureManager:Get(id)
	return self.Textures[id]
end

function cTextureManager:get(id)
	return self.Textures[id]
end
