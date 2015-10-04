local composer = require ( "composer" )
local scene = composer.newScene()
local score1 = require("score")
local widget = require( "widget" )
local sfx = require("sfx")
local scoreText
local backgroundMusic
local playBackgroundMusic
local backButton
local ads = require("ads")
local bannerAppID
local publisherID
--settings



function scene:create(event)
	local sceneGroup = self.view
	publisherID = "pub-8667480018293512"
	bannerAppID = "ca-app-pub-8667480018293512/1059290188"
	ads.init("admob", publisherID, adListener)
	scoreText = display.newText(display.contentCenterX, display.contentCenterY, 50, "Helvetica", 36)
	scoreText.x = display.contentCenterX
	scoreText.y = display.contentCenterY
	score1.init()
	--[[if (settings.shouldPlayMusic) then
		backgroundMusic = audio.loadSound("ColorBounceMenuMusic3.mp3")
	end--]]
	
	backButton = widget.newButton {
		left = -display.contentWidth * .27,
		top = display.contentHeight * -.27,
		defaultFile = "back_new.png",
	}
	backButton:scale( .16, .16 )
			
	sceneGroup:insert(scoreText)
	sceneGroup:insert(backButton)
end

function scene:show( event )
	local phase = event.phase
	if ( phase == "will" ) then
		ads.show( "banner", { x=0, y=100000, appId = bannerAppID} )
		scoreText:setTextColor(0,0,0)
		--[[if (settings.shouldPlayMusic) then 
			playBackgroundMusic = audio.play(backgroundMusic, {loops = -1})
		end--]]
		scoreText.text = score1.load()
	elseif ( phase == "did" ) then
		composer.removeHidden()
		local sceneGroup = self.view

		local function handleButtonEvent( event )
		    	if ( event.phase == "ended" ) then
		   			local options = {
				    	effect = "slideRight",
				    	time = 250,
				    	params = {}
					}
					print("Button Clicked")
			        composer.gotoScene( "scene2" , options);
			        return true;
		  		 end
		end
		backButton:addEventListener("touch", handleButtonEvent)
	end
end

function scene:hide( event )
	--composer:removeScene( "scene3" )
	ads.hide()
	if (settings.shouldPlayMusic) then
		--audio.stop(playBackgroundMusic)
		playBackgroundMusic = nil;
	end
end

function scene:destroy( event )
	print("destroy")
	--local sceneGroup = self.view
	--sceneGroup:removeSelf()
	--[[if (settings.shouldPlayMusic) then
		audio.dispose(backgroundMusic)
		backgroundMusic = nil;
	end--]]
end


scene:addEventListener( "create", scene)
scene:addEventListener( "hide", scene )	
scene:addEventListener( "show", scene)
scene:addEventListener("destroy", scene)

return scene