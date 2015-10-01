local composer = require("composer")
local scene = composer.newScene()
local widget = require ( "widget" )
local onTutorialTwo
local continueButton
local tutorialScreen
local blinkText

function scene:create ( event )
	
	--continueButton.alpha = 0.01
end

function scene:show ( event )
	local sceneGroup = self.view
	local options = {
	width = 2270,
	height = 1281,
	numFrames = 1
	}
	tutorialScreen = display.newImageRect("colorBounceTutorial2Copy.jpg", display.contentWidth * 1.20, display.contentHeight)
	tutorialScreen.x = display.contentCenterX
	tutorialScreen.y = display.contentCenterY 
	sceneGroup:insert(tutorialScreen)

	local tapToContinue = display.newText("Tap anywhere to continue",display.contentWidth/2, 30, "Arial", 36)
	tapToContinue:setTextColor(0,0,0)


	local function flashText() 
		if (tapToContinue == nil) then
			return
		elseif tapToContinue.alpha < 1 then 
			transition.to(tapToContinue, {time = 490, alpha = 1})
		else 
			transition.to(tapToContinue, {time = 490, alpha = 0.1})
		end
	end

	blinkText = timer.performWithDelay( 500, flashText, 0 )

	continueButton = widget.newButton{
		left = -50,
		label = "Continue", 
		top = 0,
		id = "continueButton",
		shape = "roundedRect",
		width = display.contentWidth * 2,
		height = display.contentHeight,
		onPress = handleContinueButtonEvent
	}
	continueButton.isHitTestable = true

	sceneGroup:insert(tapToContinue)
	sceneGroup:insert(continueButton)

	local function handleContinueButtonEvent( event ) 
		if ( event.phase == "ended" ) then
		   		local options =
				{
				  	effect = "crossFade",
				    time = 100,
				    params =
		 		   {
		 		   }
				}
		        composer.gotoScene( "scene1" , options);
		  		return true;
		end
	end
	continueButton:addEventListener("touch", handleContinueButtonEvent)
	continueButton.alpha = 0
end

	
	--composer.gotoScene( "scene2" )

function scene:hide ( event )
	timer.cancel(blinkText)
end

function scene:destroy ( event )
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene