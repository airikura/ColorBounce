		local composer = require( "composer" )
		local scene = composer.newScene()
		local widget = require( "widget" )
		local physics = require( "physics" )
		gameSettings = require("gameSettings")
		local score1
		local newGame
		local scoreButton 
		local backgroundMusic
		local playBackgroundMusic
		local settingsButton
		settings = {}
		local ads = require( "ads" )
		local bannerAppID
		local publisherID


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
			number = 0
			local sceneGroup = self.view
			local publisherID = "pub-8667480018293512"
			local bannerAppID = "ca-app-pub-8667480018293512/1059290188"
			ads.init("admob", publisherID, adListener)
			settings = loadTable("gameSettings.json")
			if (settings == nil) then 
				settings = {shouldPlayMusic = false}
				saveTable(settings,"gameSettings.json")
			end
			newGame = widget.newButton
			{
		    	left = 100,
		    	top = 200,
		    	id = "newGame",
		    	label = "New Game",
		    	onPress = handleButtonEvent,
		    	fontSize = 20,
		    	shape = "roundedRect",
		    	fillColor = { default={ 1, 0.4, 0.5, 0.7 }, over={ 1, 0.4, 0.5, 1 } },
		    	labelColor = { default={ 1, 1, 1 }, over={ 0.8, 0.8, 0.8 } }
			}
			settingsButton = widget.newButton
			{
				left = 100,
				top = 200,
				id = "settingsButton",
				label = "Settings",
				onPress = handleSettingsButtonEvent,
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
		    	onPress = handleScoreButtonEvent,
		    	shape = "roundedRect",
		    	fillColor = { default={ 1, 0.4, 0.5, 0.7 }, over={ 1, 0.4, 0.5, 1 } },
		    	fontSize = 20,
		    	labelColor = { default={ 1, 1, 1 }, over={ 0.8, 0.8, 0.8 }}
			}
			scoreButton.x = display.contentCenterX 
			scoreButton.y = display.contentCenterY  
			
			settingsButton.x = display.contentCenterX
			settingsButton.y = display.contentCenterY + 51

			newGame.x = display.contentCenterX
			newGame.y = display.contentCenterY - 51

			sceneGroup:insert(newGame)
			sceneGroup:insert(scoreButton)
			sceneGroup:insert(settingsButton)
			if (settings.shouldPlayMusic) then
				backgroundMusic = audio.loadSound("colorBallMenuMusic.mp3")
			end
		end

		function scene:show( event )
			local sceneGroup = self.view
			local phase = event.phase
			number = number + 1
    	if ( phase == "will" ) then
    		if (settings.shouldPlayMusic) then
				playBackgroundMusic = audio.play(backgroundMusic, {loops = -1})
			end
			ads.show( "banner", { x=0, y=10000, appId = bannerAppID } )
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
			local function handleSettingsButtonEvent ( event ) 
				if (event.phase == "ended" ) then 
				local options = {
				effect = "fade",
				time = 50,
				params = {
				}
				}
				print ("Settings button clicked")
				composer.gotoScene( "scene4" , options)
				return true;
				end
			end
			settingsButton:addEventListener("touch", handleSettingsButtonEvent)
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
			--if (settings.shouldPlayMusic) then
				audio.stop(playBackgroundMusic)
				playBackgroundMusic = nil;
			--end
    		elseif ( phase == "did" ) then
   	     -- Called immediately after scene goes off screen.
   			 end
		end

		function scene:destroy( event ) 
			print("destroy")
			local sceneGroup = self.view
			--sceneGroup:removeSelf()
			--sceneGroup = nil
		--	if (settings.shouldPlayMusic) then
				audio.dispose(backgroundMusic)
				backgroundMusic = nil;
		--	end
		end



		scene:addEventListener( "create", scene )
		scene:addEventListener( "show", scene )
		scene:addEventListener( "hide", scene)
		scene:addEventListener( "destroy", scene )

		return scene