local composer = require ( "composer" )
local scene = composer.newScene()
local score1 = require("score")
local widget = require( "widget" )
local scoreText;
local backgroundMusic
local playBackgroundMusic
local menuButton


function scene:create(event)
	local sceneGroup = self.view
	scoreText = display.newText(display.contentWidth, display.contentHeight, 50, "Helvetica", 36)
	
	backgroundMusic = audio.loadSound("colorBallMenuMusic.mp3")
	menuButton = widget.newButton
			{
		    left = 100,
		    top = 200,
		    id = "menuButton",
		    label = "Back",
		    onEvent = handleButtonEvent,
		    fontSize = 20,
		    labelColor = { default={ 1, 1, 1 }, over={ 0.8, 0.8, 0.8 } }
			}
	sceneGroup:insert(scoreText)
	sceneGroup:insert(menuButton)
end

function scene:show( event )
	local phase = event.phase
	if ( phase == "will" ) then
		playBackgroundMusic = audio.play(backgroundMusic, {loops = -1})
		scoreText.text = score1.load()
		print("in the event!")
	elseif ( phase == "did" ) then
		local sceneGroup = self.view

		local function handleButtonEvent( event )
			--	print("Button Clicked")
			print("in the event!")
		    	if ( event.phase == "ended" ) then
		   			 local options =
				{
				    effect = "fade",
				    time = 200,
				    params =
		 		   {
		 		   }
				}
				print("Button Clicked")
		        composer.gotoScene( "scene2" , options);
		        return true;
		  	 end
		end
		menuButton:addEventListener("touch", handleButtonEvent)

end
end

function scene:hide( event )
	composer:removeScene( "scene3" )
	audio.stop(playBackgroundMusic)
			playBackgroundMusic = nil;
end

function scene:destroy( event )
	print("destroy")
	local sceneGroup = self.view
	sceneGroup:removeSelf()

	audio.dispose(backgroundMusic)
	backgroundMusic = nil;
end


scene:addEventListener( "create", scene)
scene:addEventListener( "hide", scene )	
scene:addEventListener( "show", scene)
scene:addEventListener("destroy", scene)

return scene