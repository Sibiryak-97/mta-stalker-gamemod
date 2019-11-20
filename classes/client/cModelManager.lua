
--//class 
cModelManager = inherit(CObject)


function cModelManager:constructor()
	self.models = {}
end

function cModelManager:parse(path)
	local xml = xmlLoadFile(path)				
	if not xml then
		outputChatBox('FILE NOT FOUND: '..path)
	end
	local items = xmlNodeGetChildren(xml)
	for i, item in ipairs(items) do
		if xmlNodeGetName(item) == 'model' then
			local src = xmlNodeGetAttribute(item, 'src')
			local id = xmlNodeGetAttribute(item, 'id')
			local model_id = tonumber(xmlNodeGetAttribute(item, 'model_id'))
			local section = {
				--// may be any more?
				model_id = model_id
			}
			self.models[id] = section
		end
	end
	xmlUnloadFile(xml)
end


