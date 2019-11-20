--// action manager, типы действий: 
ACTION_EQUIPMENT = 0
ACTION_WEAPON = 1
ACTION_GROUND_EQUIPMENT = 2

--// 
ACTION_CANCEL = 0
ACTION_TO_HAND = 1
ACTION_TO_SLOT = 2
ACTION_DROP = 3
ACTION_TAKE = 4
ACTION_OPEN_BAG = 5

--// items
ITEM_WPN_ASSAULT = 'ITEM_WPN_ASSAULT'
ITEM_WPN_SNIPER = 'ITEM_WPN_SNIPER'
ITEM_WPN_PISTOL = 'ITEM_WPN_PISTOL'
ITEM_WPN_KNIFE = 'ITEM_WPN_KNIFE'
ITEM_WPN_SHOTGUN = 'ITEM_WPN_SHOTGUN'

--//Список глобальных переменных
g_configManager = nil --//объект класса конфигов
g_Objects = {} --//список объектов
g_soundManager = nil --//менеджер звуков

g_Slots = {
	slot_1 = true,
	slot_2 = true, 
	slot_3 = true,
	slot_bag = true,
	slot_outfit = true,
	bag = true,
	pocket_1 = true,
	pocket_2 = true,
	pocket_3 = true,
	pocket_4 = true,
	pocket_5 = true,
	pocket_6 = true,
	pocket_7 = true,
	pocket_8 = true,
	pocket_9 = true,
	pocket_10 = true,
	pocket_11 = true,
	pocket_12 = true,
	pocket_13 = true,
	pocket_14 = true
}

g_SlotGroups = {
	pocket = {
		slots = {
			'pocket_1',
			'pocket_2',
			'pocket_3',
			'pocket_4',
			'pocket_5',
			'pocket_6',
			'pocket_7',
			'pocket_8',
			'pocket_9',
			'pocket_10',
			'pocket_11',
			'pocket_12',
			'pocket_13',
			'pocket_14'
		},
		dropFromHand = true,
		takeInHand = true
	}
}


function strToBoolean(str)
	if str == 'true' then
		return true
	else
		return false
	end
end

function table.length(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function table.copy(obj, seen)
  if type(obj) ~= 'table' then return obj end
  if seen and seen[obj] then return seen[obj] end
  local s = seen or {}
  local res = setmetatable({}, getmetatable(obj))
  s[obj] = res
  for k, v in pairs(obj) do res[table.copy(k, s)] = table.copy(v, s) end
  return res
end


CObject = {}

function CObject:new(...)
        return new(self, ...)
end

function CObject:delete(...)
        return delete(self, ...)
end 
