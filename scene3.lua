local composer = require ( "composer" )
local scene = composer.newScene()
local score1 = require("score")
local widget = require( "widget" )
local scoreText
local backgroundMusic
local playBackgroundMusic
local menuButton


function scene:create(event)
	local sceneGroup = self.view
	scoreText = display.newText(display.contentCenterX, display.contentHeight, 50, "Helvetica", 36)
	score1.init()
	backgroundMusic = audio.loadSound("colorBallMenuMusic.mp3")
	menuButton = widget.newButton
			{
		    left = 100,
		    top = 200,
		    id = "menuButton",
		    label = "Back",
		    onEvent = handleButtonEvent,
		    fontSize = 20,
		    shape = "roundedRect",
		    fillColor = { default={ 1, 0.4, 0.5, 0.7 }, over={ 1, 0.4, 0.5, 1 } },
		   	labelColor = { default={ 1, 1, 1 }, over={ 0.8, 0.8, 0.8 } }
			}
			
		sceneGroup:insert(scoreText)
		sceneGroup:insert(menuButton)
end

function scene:show( event )
	local phase = event.phase
	if ( phase == "will" ) then
		scoreText:setTextColor(0,0,0)
		scoreText.x = display.contentCenterX
		scoreText.y = display.contentCenterY -50
		playBackgroundMusic = audio.play(backgroundMusic, {loops = -1})
		print(score1.load())
		scoreText.text = score1.load()
		menuButton.x = display.contentCenterX
		print("in the event!")
	elseif ( phase == "did" ) then
		composer.removeHidden()
		local sceneGroup = self.view

		local function handleButtonEvent( event )
			--	print("Button Clicked")
			print("in the event!")
		    	if ( event.phase == "ended" ) then
		   			 local options =
				{
				    effect = "fade",
				    time = 50,
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
	--composer:removeScene( "scene3" )
	audio.stop(playBackgroundMusic)
	playBackgroundMusic = nil;
end

function scene:destroy( event )
	print("destroy")
	--local sceneGroup = self.view
	--sceneGroup:removeSelf()
	audio.dispose(backgroundMusic)
	backgroundMusic = nil;
end


scene:addEventListener( "create", scene)
scene:addEventListener( "hide", scene )	
scene:addEventListener( "show", scene)
scene:addEventListener("destroy", scene)

return scene