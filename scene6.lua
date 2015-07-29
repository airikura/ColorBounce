local composer = require("composer")
local scene = composer.newScene()

function scene:create ( event )

end


function scene:show ( event )
	local sceneGroup = self.view
	display.setDefault("background", 0)
	local options = {
	width = 2270,
	height = 1281,
	numFrames = 2,
	sheetContentWidth = 2270,
	sheetContentHeight = 1281
	}
	local tutorialSheet = graphics.newImageSheet("Tutorial1-doublescrn.jpg", options)
	local sequences_flashGreen = {
		{
		name = "normalFlash",
		start = 1,
		count = 2,
		time = 200,
		loopCount = 0, 
		loopDirection = "forward"
		}
	}
	local flashGreen = display.newSprite(tutorialSheet, sequences_flashGreen)
	flashGreen:play()

end
	
	--composer.gotoScene( "scene2" )

function scene:hide ( event )

end

function scene:destroy ( event )
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene