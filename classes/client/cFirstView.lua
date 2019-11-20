local CAM = getCamera()--The camera is always the same element, so use this local variable to save cpu power.
function getCameraRotation ()
    return getElementRotation(CAM) --rx, ry, rz
end

--//class 
cFirstView = inherit(CObject)


function cFirstView:constructor()
	self.x = screenWidth / 2
	self.y = screenHeight / 2
	self.rx = 0
	self.ry = 0
	self.rz = 0
	self.cx = 0
	self.cy = 0
	self.cz = 0	
	self.px = 0
	self.py = 0
	self.pz = 0
	self.wx_r = 0
	self.wy_r = 0
	self.wz_r = 0
	self.fov = 70
	self.isEnable = false
	--self.isLock = false
	
	--//
	self.handlerMove = function(_, _, aX, aY)
		self:onMove(aX, aY)
	end
	self.handlerRender = function()
		self:onRender()
	end
end

function cFirstView:onMove(aX, aY)
	--//rotation ped when rotation head
	
	self.cx, self.cy, self.cz = getCameraRotation()
	if self.cx > 60 and self.cx < 180 then 
		if aY < screenHeight / 2 then
			aY = self.y
		end
	elseif self.cx < 300 and self.cx > 180 then	
		if aY > screenHeight / 2 then
			aY = self.y
		end
	end
	
	self.px, self.py, self.pz = getElementRotation(getLocalPlayer())
	if math.abs(self.cz - self.pz) > 45 then
		setElementRotation(getLocalPlayer(), self.px, self.py, self.cz, "default",true)
	end
	
	--//set new mouse position
	self.x = aX
	self.y = aY 
end

function cFirstView:onRender()
	--dxDrawText( string.format('c*: %f|%f|%f', self.cx, self.cy, self.cz), 300, 140, 500, 200, 0xFFFF0000);
	local rx, ry, rz = getWorldFromScreenPosition ( self.x, self.y, 1000 )
	local px, py, pz = self:getCameraPosition()
	--local px, py, pz = getPedBonePosition( localPlayer, 7)
	setCameraMatrix(px, py, pz, rx, ry, rz, 0, 70)
end


function cFirstView:getCameraPosition()
	local x1,y1,z1 = getPedBonePosition(getLocalPlayer(), 7) -- left eye
	local x2,y2,z2 = getPedBonePosition(getLocalPlayer(), 6) -- right eye
	return self:mid(x1, x2), self:mid(y1, y2), self:mid(z1, z2) + 0.1
end

function cFirstView:mid(pnt1, pnt2)
	return (pnt2 + pnt1)/2
end

function cFirstView:enable()
	addEventHandler('onClientCursorMove', getRootElement(), self.handlerMove)
	addEventHandler('onClientRender', getRootElement(), self.handlerRender)
	--addEventHandler('onClientKey', getRootElement(), self.handlerKey)
	self.isEnable = true
end

function cFirstView:disable()
	removeEventHandler('onClientCursorMove', getRootElement(), self.handlerMove)
	removeEventHandler('onClientRender', getRootElement(), self.handlerRender)
	--removeEventHandler('onClientKey', getRootElement(), self.handlerKey)
	setCameraTarget(localPlayer)
	self.isEnable = false
end

