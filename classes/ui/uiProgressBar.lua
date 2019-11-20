
--//class image
uiProgressBar = inherit(uiBaseElement)


function uiProgressBar:constructor(texture, x, y, w, h, parent)
	--// call base constructor
	uiBaseElement.constructor(self, x, y, w, h, parent)
	--//
	self.image = uiImage:new(texture, x, y, w, h, parent)
	self.originalW = w
	self.originalH = h
	self.progress = 1.0
	
end

function uiProgressBar:setProgress(progress)
	self.progress = progress
	self.image:setSize(self.originalW * progress, self.originalH)
end

function uiProgressBar:draw()
	self.image:draw()
end
--[[
function uiProgressBar:attachTo(parent)
	uiBaseElement.attachTo(self, parent)
	--//
	--self.image:attachTo(parent)
end

function uiProgressBar:deattach()
	uiBaseElement.deattach(self)
	--//
	--self.image:deattach()
end
]]
--[[

function uiProgressBar:show()
	uiBaseElement.show(self)
	--//
end

function uiProgressBar:hide()
	uiBaseElement.hide(self)
	--//
end

]]

uiProgressCell = inherit(uiBaseElement)

function uiProgressCell:constructor(texture, x, y, w, h, parent)
	--// call base constructor
	uiBaseElement.constructor(self, x, y, w, h, parent)
	--//
	self.progress = 10
end

function uiProgressCell:setProgress(progress)

end

function uiProgressCell:draw()

end



