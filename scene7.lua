local composer = require("composer")
local scene = composer.newScene()
composer.removeOnSceneChange = true
local widget = require ( "widget" )
local continueButton
local tutorialScreen
local blinkText
local myTransition
local tapToContinue
local hasBeenPressed 

function scene:create ( event )
	hasBeenPressed = false
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

	
	local mParams = event.params
	local function handleContinueButtonEvent( event ) 
		if ( event.phase == "ended" ) then
			if (hasBeenPressed ~= true) then 
				hasBeenPressed = true 
		   		local options =
				{
				  	effect = "crossFade",
				    time = 100,
				    params =
		 		   {
		 		   }
				}
				if (mParams.fromNewGame == true)  then 
		        	composer.gotoScene( "scene1" , options);
		        	return true
		  		else
		  			local options =
					{
				  		effect = "crossFade",
				   		time = 300,
				    	params =
		 		   		{
		 		   		}
					}
		  			composer.gotoScene( "scene1" , options )
		  			return true;
				end
			end
			return true
		end
	end
	continueButton.alpha = 0
	continueButton:addEventListener( "touch", handleContinueButtonEvent)
	sceneGroup:insert(tutorialScreen)
	sceneGroup:insert(tapToContinue)
	sceneGroup:insert(continueButton)

end

	
	--composer.gotoScene( "scene2" )

function scene:hide ( event )

end

function scene:destroy ( event )
	print("DESTROY*ING BLINKETXT 7")
	timer.cancel(blinkText)
	display.remove(tapToContinue)
	display.remove(tutorialScreen)
	continueButton:removeEventListener( "touch", handleContinueButtonEvent )
	blinkText = nil
	transition.cancel(myTransition)
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene