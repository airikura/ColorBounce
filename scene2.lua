		local composer = require( "composer" )
		local scene = composer.newScene()
		local widget = require( "widget" )
		local physics = require( "physics" )
		local newGame 
		local backgroundMusic
		local playBackgroundMusic
	--	composer.removeOnSceneChange = true
		print("screen")

		function scene:create(event)

			print("create")
			local sceneGroup = self.view
			newGame = widget.newButton
			{
		    left = 100,
		    top = 200,
		    id = "newGame",
		    label = "New Game",
		    onEvent = handleButtonEvent,
		    fontSize = 20,
		    labelColor = { default={ 1, 1, 1 }, over={ 0.8, 0.8, 0.8 } }
			}

			newGame.x = display.contentCenterX
		newGame.y = display.contentCenterY

			sceneGroup:insert(newGame)
			backgroundMusic = audio.loadSound("colorBallMenuMusic.mp3")
		end


		function scene:show( event )
			local sceneGroup = self.view
			local phase = event.phase
    	if ( phase == "will" ) then
			playBackgroundMusic = audio.play(backgroundMusic, {loops = -1})
   		elseif ( phase == "did" ) then
   			print("entering scene")
			local sceneGroup = self.view
			local function handleButtonEvent( event )
			--	print("Button Clicked")
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

		        composer.gotoScene( "scene1" , options);
		        return true;
		      

		  	 end

			
			
   		
			end
			newGame:addEventListener("touch", handleButtonEvent)
	end
		end


		function scene:hide( event )
			   local sceneGroup = self.view
    	local phase = event.phase

   		 if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
       		print("exit")
			local sceneGroup = self.view
			--sceneGroup:removeSelf()
			composer.removeScene("scene2")
			audio.stop(playBackgroundMusic)
			playBackgroundMusic = nil;
    		elseif ( phase == "did" ) then
   	     -- Called immediately after scene goes off screen.
   			 end
			
		end

		function scene:destroy( event ) 
			print("destroy")
			local sceneGroup = self.view
			sceneGroup:removeSelf()
			audio.dispose(backgroundMusic)
			backgroundMusic = nil;
		end



		scene:addEventListener( "create", scene )
		scene:addEventListener( "show", scene )
		scene:addEventListener( "hide", scene)
		scene:addEventListener( "destroy", scene )


		return scene