local composer = require("composer")
local scene = composer.newScene()
local widget = require ( "widget" )
local continueButton
local tutorialSheet
local blinkText
local sequences_flashGreen
local flashGreen
local myTransition
local tapToContinue
local hasBeenPressed = false
composer.removeOnSceneChange = true

function scene:create ( event )
	print("creating")
	--continueButton.alpha = 0.01
end



function scene:show ( event )
	local sceneGroup = self.view
	local options = {
		width = 2270,
		height = 1281,
		numFrames = 2
	}
	
	
	
	tutorialSheet = graphics.newImageSheet("Tutorial1-doublescrnTestCopy.jpg", options)
	sequences_flashGreen = {
		{
		name = "normalFlash",
		start = 1,
		count = 2,
		time = 200,
		loopCount = 0, 
		loopDirection = "forward"
		}
	}
	flashGreen = display.newSprite(tutorialSheet, sequences_flashGreen)
	
	flashGreen.x = display.contentCenterX
	flashGreen.y = display.contentCenterY
	flashGreen:scale(.25,.25)
	flashGreen:play() 

	local tapToContinue = display.newText("Tap anywhere to continue",display.contentWidth/2, 30, "Arial", 36)
	tapToContinue:setTextColor(0,0,0)


	local function flashText() 
		if (hasBeenPressed) then
			return false
		end
		if tapToContinue.alpha < 1 then 
			myTransition = transition.to(tapToContinue, {time = 490, alpha = 1})
		else 
			myTransition = transition.to(tapToContinue, {time = 490, alpha = 0.1})
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

	local mParams = event.params
	local function handleContinueButtonEvent( event ) 
	
			if ( event.phase == "ended" ) then
			if (hasBeenPressed ~= true) then 
				hasBeenPressed = true
			   		local options =
					{
					  	effect = "slideLeft",
					    time = 300,
					    params =
			 		   {
			 		   		fromNewGame = mParams.fromNewGame
			 		   }
					}

			        composer.gotoScene( "scene7" , options);
			  		return true;
		  		end
			end
			return true
		end
	continueButton:addEventListener("touch", handleContinueButtonEvent)
	continueButton.alpha = 0
end

function scene:hide ( event )
	
end

function scene:destroy ( event )
	print("DESTRYONG BLINKTEXT")
	timer.cancel(blinkText)
	blinkText = nil
	continueButton:removeEventListener( "touch", handleContinueButtonEvent )
	tutorialSheet = nil
	display.remove(sequences_flashGreen)
	display.remove(tapToContinue)
	sequences_flashGreen = nil
	transition.cancel(myTransition)
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene