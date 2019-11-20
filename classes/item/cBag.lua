
--//class 
cInvObject = inherit(CObject)


function cInvObject:constructor(section)
	--// id
	self.id = -1

	--// секция предмета
	self.section = section
	
	--// реально существующий объект
	self.model = nil
	
	--//
	self.unique = {}	--//уникальные параметры каждого предмета(по ним может быть объединение)
	self.upgrade = {}	--//уникальные параметры почти каждого предмета(по ним не идет объединение...добавляется иконка)
end

