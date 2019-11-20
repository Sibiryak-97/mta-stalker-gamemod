
--//class 
cConfigManager = inherit(CObject)


function cConfigManager:constructor()
	self.Items = {}
	self:parse('config/items/weapons.xml')
end

function cConfigManager:parse(path)
	local xml = xmlLoadFile(path)		
	local items = xmlNodeGetChildren(xml)		
	for i, item in ipairs(items) do
		local section = {}
		local parent = xmlNodeGetAttribute(item, 'parent')
		if parent then
			if self.Items[parent] then
				parent = self.Items[parent]
			else
				outputDebugString(string.format('[STALKER - CConfigManager]Uncorrect parent for item \'%s\'.',xmlNodeGetAttribute(item, 'name')))
				break
			end
		end
		local otdels = xmlNodeGetChildren(item)
		for i, param in ipairs(otdels) do
			local otdel = {}
			if parent then
				otdel = table.copy(parent[xmlNodeGetName(param)])
			end
			local params = xmlNodeGetChildren(param)
			
			for i, tag in ipairs(params) do
				if xmlNodeGetAttribute(tag, 'type') == 'list' then
					local list = {}
					for _, list_item in ipairs(xmlNodeGetChildren(tag)) do
						list[xmlNodeGetValue(list_item)] = true
					end
					otdel[xmlNodeGetName(tag)] = list
				else
					otdel[xmlNodeGetName(tag)] = tonumber(xmlNodeGetValue(tag)) or xmlNodeGetValue(tag)
				end
			end
			section[xmlNodeGetName(param)] = otdel
		end
		self.Items[xmlNodeGetAttribute(item, 'name')] = section
	end
end

function cConfigManager:section(section)
	return self.Items[section]
end

function cConfigManager:getValue(section, key)
	local section = self:section(section)
	local value = section['general'][key]
	if value then
		return value
	end
	value = section['unique'][key]
	if value then
		return value
	end
	value = section['upgrade'][key]
	if value then
		return value
	end
end

function cConfigManager:getKeyType(section, key)
	local section = self:section(section)
	local value = section['general'][key]
	if value then
		return 'general'
	end
	value = section['unique'][key]
	if value then
		return 'unique'
	end
	value = section['upgrade'][key]
	if value then
		return 'upgrade'
	end
end








