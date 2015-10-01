local composer = require("composer")
local scene = composer.newScene()
local widget = require ( "widget" )
local onTutorialTwo
local continueButton
local blinkText

function scene:create ( event )
	
	--continueButton.alpha = 0.01
	onTutorialTwo = false 
end



function scene:show ( event )
	local sceneGroup = self.view
	local options = {
	width = 2270,
	height = 1281,
	numFrames = 2

	}
	
	
	
	local tutorialSheet = graphics.newImageSheet("Tutorial1-doublescrnTestCopy.jpg", options)
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
	
	flashGreen.x = display.contentCenterX
	flashGreen.y = display.contentCenterY
	flashGreen:scale(.25,.25)
	flashGreen:play() 

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

	sceneGroup:insert(flashGreen)
	sceneGroup:insert(tapToContinue)
	sceneGroup:insert(continueButton)

	local function handleContinueButtonEvent( event ) 
		if ( event.phase == "ended" ) then
		   		local options =
				{
				  	effect = "slideLeft",
				    time = 300,
				    params =
		 		   {
		 		   }
				}
		        composer.gotoScene( "scene7" , options);
		  		return true;
		end
	end
	continueButton:addEventListener("touch", handleContinueButtonEvent)
	continueButton.alpha = 0
end

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