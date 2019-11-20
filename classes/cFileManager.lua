--//events
if SERVER then 
	--//server side
	addEvent('zh_event.getClientFiles', true)
else
	--//client side
	addEvent('zh_event.setDownloadFiles', true)
end

--//class
CFileManager = {}
CFileManager.__index = CFileManager 

function CFileManager.Init()
	local self = setmetatable({}, CFileManager)
	
	if SERVER then 
		addEventHandler( 'zh_event.getClientFiles', getRootElement(), self.getFiles)
	else
		--addEventHandler( 'zh_event.setDownloadFiles', getRootElement(), )
	end
	
	return self
end	

CFileManager.getFiles = function()
	local xml = xmlLoadFile('meta.xml')		
	if xml then
		local result = {}
		local items = xmlNodeGetChildren(xml)		
		for i, item in ipairs(items) do
			if xmlNodeGetName(item) == 'file' and xmlNodeGetAttribute(item, 'download') == 'false' then
				table.insert(result, xmlNodeGetAttribute(item, 'src'))
			end
		end
		triggerClientEvent(source, 'zh_event.setDownloadFiles', source, result)
	else
		outputChatBox('meta not found')
	end
end
