		local composer = require( "composer" )
		local scene = composer.newScene()
		local widget = require( "widget" )
		local physics = require( "physics" )
		local score1
		local newGame
		local scoreButton 
		local backgroundMusic
		local playBackgroundMusic
		local ads = require("ads")

	--	ads.init("admob", "pub-8667480018293512", adListener)
	--	ads.show( "banner", { x=0, y=0 } )


		local function adListener( event )
			print("hello")
    if ( event.isError ) then
        --Failed to receive an ad
    end
end






		composer.removeOnSceneChange = true
		print("screen")

		function scene:create(event)
			print("create")
			
			local sceneGroup = self.view
			ads.init("admob", "pub-8667480018293512", adListener)
			newGame = widget.newButton
			{
		    	left = 100,
		    	top = 200,
		    	id = "newGame",
		    	label = "New Game",
		    	onEvent = handleScoreButtonEvent,
		    	fontSize = 20,
		    	shape = "roundedRect",
		    	fillColor = { default={ 1, 0.4, 0.5, 0.7 }, over={ 1, 0.4, 0.5, 1 } },
		    	labelColor = { default={ 1, 1, 1 }, over={ 0.8, 0.8, 0.8 } }
			}
			scoreButton = widget.newButton
			{
				left = 100,
		    	top = 200,
		    	id = "scoreButton",
		    	label = "High Score",
		    	onEvent = handleButtonEvent,
		    	shape = "roundedRect",
		    	fillColor = { default={ 1, 0.4, 0.5, 0.7 }, over={ 1, 0.4, 0.5, 1 } },
		    	fontSize = 20,
		    	labelColor = { default={ 1, 1, 1 }, over={ 0.8, 0.8, 0.8 }}
			}
			scoreButton.x = display.contentCenterX 
			scoreButton.y = display.contentCenterY  + 60

			newGame.x = display.contentCenterX
			newGame.y = display.contentCenterY

			sceneGroup:insert(newGame)
			sceneGroup:insert(scoreButton)
			backgroundMusic = audio.loadSound("colorBallMenuMusic.mp3")
		end

		function scene:show( event )
			local sceneGroup = self.view
			local phase = event.phase
    	if ( phase == "will" ) then
			playBackgroundMusic = audio.play(backgroundMusic, {loops = -1})
			ads.show( "banner", { x=display.contentCenterX, y=0 } )
   		elseif ( phase == "did" ) then
   			print("entering scene")
   			composer.removeHidden()
			local sceneGroup = self.view
			local function handleButtonEvent( event )
			--	print("Button Clicked")
		    	if ( event.phase == "ended" ) then
		   			 local options =
				{
				    effect = "fade",
				    time = 0,
				    params =
		 		   {
		 		   }
				}
				print("Button Clicked")
		        composer.gotoScene( "scene1" , options);
		        return true;
		  		end
			end
		  	local function handleScoreButtonEvent ( event ) 
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
		        composer.gotoScene( "scene3" , options);
		        return true;
		  	
				end
			end
			scoreButton:addEventListener("touch", handleScoreButtonEvent)
			newGame:addEventListener("touch", handleButtonEvent)
		end
		end


		function scene:hide( event )
			   local sceneGroup = self.view
    	local phase = event.phase
   		 if ( phase == "will" ) then
   		 	ads.hide()
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
       		print("exit")
			local sceneGroup = self.view
			--sceneGroup:removeSelf()
			--composer.removeScene("scene2")
			audio.stop(playBackgroundMusic)
			playBackgroundMusic = nil;
    		elseif ( phase == "did" ) then
   	     -- Called immediately after scene goes off screen.
   			 end
		end

		function scene:destroy( event ) 
			print("destroy")
			local sceneGroup = self.view
			--sceneGroup:removeSelf()
			--sceneGroup = nil
			audio.dispose(backgroundMusic)
			backgroundMusic = nil;
		end



		scene:addEventListener( "create", scene )
		scene:addEventListener( "show", scene )
		scene:addEventListener( "hide", scene)
		scene:addEventListener( "destroy", scene )

		return scene