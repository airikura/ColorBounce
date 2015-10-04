local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )
gameSettings = require("gameSettings")
local score1 = require( "score" )
local physics = require("physics")
local sfx = require( "sfx" )
sfx.longsound = nil
local newGame
local scoreButton 
local backgroundMusic
local playBackgroundMusic
local settingsButton
local tapToContinue
local tutorialButton
settings = {}
local ads = require( "ads" )
local publisherID
local bannerAppID
local interstitialAppID
composer.removeOnSceneChange = true

function scene:create(event)
	print("create")
	if (number == nil) then
		number = 0
	end

	local sceneGroup = self.view
	--[[Setting up our ad id values
	*************************************]]
	publisherID = "pub-8667480018293512"
	bannerAppID = "ca-app-pub-8667480018293512/1059290188"
	interstitialAppID = "ca-app-pub-8667480018293512/5806900586"
	ads.init("admob", publisherID, adListener)
	--***********************************

	--Loading game settings
	settings = loadTable("gameSettings.json")
	if (settings == nil) then 
		settings = {shouldPlayMusic = false}
		saveTable(settings,"gameSettings.json")
	end



	newGame = widget.newButton {
	left = 100,
	top = 200,
	id = "newGame",
	label = "New Game",
	onPress = handleButtonEvent,
	fontSize = 20,
	shape = "roundedRect",
	--fillColor = { default={ 1, 0.4, 0.5, 0.7 }, over={ 1, 0.4, 0.5, 1 } },
	--labelColor = { default={ 1, 1, 1 }, over={ 0.8, 0.8, 0.8 } },
	fillColor = {default = {0.33333,0.33333,0.33333}, over = {0.33333,0.333333,0.33333}},
	labelColor = { default={ 1, 1, 1 }, over={ 0.8, 0.8, 0.8 }},
	fontSize = 20 }


	settingsButton = widget.newButton {
		left = 100,
		top = 200,
		id = "settingsButton",
		label = "Settings",
		onPress = handleSettingsButtonEvent,
		fontSize = 20,
		shape = "roundedRect",
		--fillColor = { default={ 1, 0.4, 0.5, 0.7 }, over={ 1, 0.4, 0.5, 1 } },
		--labelColor = { default={ 1, 1, 1 }, over={ 0.8, 0.8, 0.8 } }
		fillColor = {default = {0.33333,0.33333,0.33333}, over = {0.33333,0.333333,0.33333}},
		labelColor = { default={ 1, 1, 1 }, over={ 0.8, 0.8, 0.8 }},
		fontSize = 20 }

	scoreButton = widget.newButton {
		left = 100,
		top = 200,
		id = "scoreButton",
		label = "High Score",
		onPress = handleScoreButtonEvent,
		shape = "roundedRect",
		--labelColor = { default={ 0, 0, 0 }, over={ 0.1, 0.1, 0.1 }},
		--fillColor = { default={ 1, 0.4, 0.5, 0.7 }, over={ 1, 0.4, 0.5, 1 } },
		fillColor = {default = {0.33333,0.33333,0.33333}, over = {0.33333,0.333333,0.33333}},
		labelColor = { default={ 1, 1, 1 }, over={ 0.8, 0.8, 0.8 }},
		fontSize = 20 }

	tutorialButton = widget.newButton {
		id = "tutorialButton", 
		label = "?",
		onPress = handleTutorialButtonEvent,
		shape = "circle",
		fillColor = {default = {0.33333,0.33333,0.33333}, over = {0.33333,0.333333,0.33333}},
		labelColor = { default={ 1, 1, 1 }, over={ 0.8, 0.8, 0.8 }},
		fontSize = 24,
		radius = 18, 
		height = 20 }

	tutorialButton.x = display.contentWidth * 1.02
	tutorialButton.y = display.contentHeight * .08

	scoreButton.x = display.contentCenterX 
	scoreButton.y = display.contentCenterY  

	settingsButton.x = display.contentCenterX
	settingsButton.y = display.contentCenterY + 51

	newGame.x = display.contentCenterX
	newGame.y = display.contentCenterY - 51

	sceneGroup:insert(newGame)
	sceneGroup:insert(scoreButton)
	sceneGroup:insert(settingsButton)
	sceneGroup:insert(tutorialButton)

	if (settings.shouldPlayMusic) then
		--backgroundMusic = audio.loadSound("ColorBounceMenuMusic3.mp3")
	end
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		--Loading ads logic
		--****************************
		number = number + 1
		if (ads.isLoaded("interstitial")) then
			ads.show("interstitial", {x = 0, y = 0, appId = interstitialAppID})
		else
			ads.show( "banner", { x=0, y=10000, appId = bannerAppID} )
		end
		--****************************

		sfx.longsound = audio.loadSound("ColorBounceMenuMusic3.mp3")
		sfx.play( sfx.longsound, { 
			onComplete = function()
				audio.dispose(sfx.longsound)
			end,
			loops = -1} )

		--[[if (settings.shouldPlayMusic) then
			playBackgroundMusic = audio.play(backgroundMusic, {loops = -1})
		end--]]

	elseif ( phase == "did" ) then
		print("entering scene")
		composer.removeHidden()
		local sceneGroup = self.view
		--Go to either tutorial scene or to 
		local function handleButtonEvent( event )
			if ( event.phase == "ended" ) then
				sfx.stop(sfx.longsound)
				local options = {
					effect = "fromTop",
					time = 300,
					params = {
					--[[pass in that we clicked the new game button to get to 
					tutorial scene, so we should continue to play game when finished with tutorial.]]
					fromNewGame = true
					}
				}
				--If never played before (no high score), go to tutorial scene
				if (score1.getScore == nil) then
					print("going to scene 6")
					composer.gotoScene( "scene6" , options);
					return true
				else 
					options = {
						effect = "zoomInOutFade",
						time = 300,
						params =
						{}
					}
					print("**********going to scene 1")
				composer.gotoScene( "scene1" , options)
				return true
				end
			end
		end

		--If score button clicked, go to High Score scene
		local function handleScoreButtonEvent ( event ) 
			if ( event.phase == "ended" ) then
				local options = {
				effect = "fade",
				time = 100,
				params = {}
				}
				composer.gotoScene( "scene3" , options);
				return true;
			end
		end
		--If settings button clicked, go to Settings scene
		local function handleSettingsButtonEvent ( event ) 
			if (event.phase == "ended" ) then 
				local options = {
					effect = "fade",
					time = 100,
					params = {}
				}	
				composer.gotoScene( "scene4" , options)
				return true;
			end
		end
		--Go to tutorial scene
		local function handleTutorialButtonEvent ( event ) 
			if (event.phase == "ended") then 
				sfx.stop(sfx.longsound)
				local options = {
					effect = "fromTop",
					time = 300,
					params = {
					--[[Pass in that we don't want to start a new game after, 
					so return back to main menu after tutorial ]]
					fromNewGame = false
					}
				}
				composer.gotoScene( "scene6", options )
				return true
			end
		end
		settingsButton:addEventListener("touch", handleSettingsButtonEvent)
		scoreButton:addEventListener("touch", handleScoreButtonEvent)
		newGame:addEventListener("touch", handleButtonEvent)
		tutorialButton:addEventListener( "touch", handleTutorialButtonEvent)
	end
end


function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	if ( phase == "will" ) then
		ads.hide()
		--audio.stop(playBackgroundMusic)
		playBackgroundMusic = nil;
	elseif ( phase == "did" ) then
     	-- Called immediately after scene goes off screen.
	end
end

function scene:destroy( event ) 
	local sceneGroup = self.view
	--audio.dispose(backgroundMusic)
	backgroundMusic = nil;
end



scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene)
scene:addEventListener( "destroy", scene )

return scene