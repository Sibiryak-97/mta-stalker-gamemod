--//class
cHud = inherit(CObject)


function cHud:constructor()
	self.back = uiImage:new('ui_fake_e', 0, 0, screenWidth, screenHeight)
	
	uiImage:new('ui_cursor', screenWidth / 2 - 8, screenHeight / 2 - 8, 16, 16, self.back)
	
	self:initBars()
end

--/////////////////////////////////////////////////////////////////////////////////////////////
--// полоски различных показателей
--/////////////////////////////////////////////////////////////////////////////////////////////
function cHud:initBars()
	local fake_back = uiImage:new('ui_fake_e', 0, screenHeight - 70, 190, 70, self.back)
	uiImage:new('ui_hud_frame_back', 32, 11, 147, 55, fake_back)
	
	self.bars = {}
	self.bars.health = uiProgressBar:new('ui_hud_bar_health', 33, 12, 146, 21, fake_back)
	self.bars.radiation = uiProgressBar:new('ui_hud_bar_radiation', 33, 35, 146, 15, fake_back)
	self.bars.radiation:setProgress(0.0)
	self.bars.temp = uiProgressBar:new('ui_hud_bar_temp', 106, 51, 73, 15, fake_back)
	self.bars.temp:setProgress(-0.5)
	
	uiImage:new('ui_hud_frame_l', 0, 0, 190, 70, fake_back)
	
	fake_back = uiImage:new('ui_fake_e', 190, screenHeight - 70, 190, 70, self.back)
	uiImage:new('ui_hud_frame_back', 9, 11, 147, 55, fake_back)
	
	self.bars.stamina = uiProgressBar:new('ui_hud_bar_stamina', 10, 12, 146, 21, fake_back)
	self.bars.oxygen = uiProgressBar:new('ui_hud_bar_oxygen', 10, 35, 146, 15, fake_back)
	self.bars.fatigue = uiProgressBar:new('ui_hud_bar_temp', 10, 51, 146, 15, fake_back)
	
	uiImage:new('ui_hud_frame_r', 0, 0, 190, 70, fake_back)
end

function cHud:updateBar(name, progress)
	self.bars[name]:setProgress(progress)
end



function cHud:show()
	self.back:show()
end

function cHud:hide()
	self.back:hide()
end


