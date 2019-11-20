--//

--//
addEvent('se_serverData.loginPlayer', true)
addEvent('se_serverData.registerPlayer', true)
addEvent('se_serverData.spawnPlayer', true)

--//class 
cServerData = inherit(CObject)


function cServerData:constructor()
	--// generate free ids
	for i=1,10000 do 
		g_freeItemId[i] = true
	end

	--// handlers
	self.handlerLogin = function(data)
		self:loginPlayer(data)
	end
	self.handlerRegister = function(data)
		self:registerPlayer(data)	
	end
	self.handlerSpawn = function()
		self:spawnPlayer(source)
	end
	addEventHandler('se_serverData.loginPlayer', getRootElement(), self.handlerLogin)
	addEventHandler('se_serverData.registerPlayer', getRootElement(), self.handlerRegister)
	addEventHandler('se_serverData.spawnPlayer', getRootElement(), self.handlerSpawn)
end

--//players
function cServerData:loginPlayer(data)
	if data.login == '' then 
		triggerClientEvent( source, 'se_login.loginFail',  source, 'Введите логин!')
		return
	end
	if data.password == '' then
		triggerClientEvent( source, 'se_login.loginFail',  source, 'Введите пароль!')
		return
	else
		data.password = hash('sha512', data.password)
	end
	local account = getAccount ( data.login, data.password )
	if account ~= false then
		--//вход в аккаунт
		logIn (source, account, data.password)
		triggerClientEvent(source, 'se_login.loginSuccess', source)
	else
		triggerClientEvent(source, 'se_login.loginFail', source, 'Ошибка! Неправильный логин или пароль')
	end
end

function cServerData:registerPlayer(data)

end

function cServerData:spawnPlayer(ped)
	local player = cServerPlayer:new(source)
	--// создадим серверный объект игрока
	g_playerList[getPlayerName( source )] = player
	
	--//получаем данные
	local account = getPlayerAccount(source)
	local gulag = getAccountData(account, 'sd.last_gulag')
	--//при добавлении лагерей - надо получать позицию и спавнить по ней
	if gulag then
		
	else
		
	end
	--// устанавливаем голову
	player.personal.face_id = getAccountData(account, 'sd.head_index')
	player.personal.nick = getAccountData(account, 'sd.nick')
	--// пока спавним просто тут
	spawnPlayer(source, 0 , 0 , 6.5, math.random(0,360), 1)
	fadeCamera (source, true)
	setCameraTarget (source, source)
end

--//items
--// при добавлении класса объекта, добавить аналог в cInvObject!!!
function cServerData:create(section)
	local obj = cInvObject.init(section)
	obj.id = next(g_freeItemId)
	g_freeItemId[obj.id] = nil
	return obj
end












