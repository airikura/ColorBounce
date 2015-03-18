local composer = require("composer")
local scene = composer.newScene()
local widget = require ("widget")
local highScore = {}
local shouldPlayMusicCheckbox
--local shouldResetHighScore
local shouldPlayMusicText 
local backgroundMusic
local playBackgroundMusic
local confirmButton
local backButton
local ads = require("ads")

--[[local function onPressCheck( event )
    local switch = event.target
    print( "Switch with ID '"..switch.id.."' is on: "..tostring(switch.isOn) )
end--]]

function scene:create(event)
	local sceneGroup = self.view
	ads.init("admob", "pub-8667480018293512", adListener)
	-- Handle press events for the checkbox
-- Create the widget
	shouldPlayMusicCheckbox = widget.newSwitch
	{
   	 	left = 250,
   	 	top = 200,
		style = "checkbox",
		id = "Checkbox",
    	onPress = onSwitchPress
	}

	confirmButton = widget.newButton
	{
		left = display.contentWidth - 100,
		top = display.contentCenter,
		label = "Confirm",
		shape = "roundedRect",
		fillColor = { default={ 1, 0.4, 0.5, 0.7 }, over={ 1, 0.4, 0.5, 1 } },
		fontSize = 20,
		labelColor = { default={ 1, 1, 1 }, over={ 0.8, 0.8, 0.8 }}
	}

	backButton = widget.newButton
	{
		left = 0,
		top = 0,
		label = "back",
		shape = "roundedRect",
		fillColor = { default={ 1, 0.4, 0.5, 0.7 }, over={ 1, 0.4, 0.5, 1 } },
		fontSize = 20,
		labelColor = { default={ 1, 1, 1 }, over={ 0.8, 0.8, 0.8 }}
	}




	shouldPlayMusicText = display.newText("Play ingame music: ", display.contentCenterX - 100, display.contentCenterY, Helvetica, 20)
	shouldPlayMusicText:setFillColor(.2,.2,.2)
	shouldPlayMusicText.text = "Play in-game music: "
	
	if (settings.shouldPlayMusic) then
		backgroundMusic = audio.loadSound("colorBallMenuMusic.mp3")
		shouldPlayMusicCheckbox:setState{
		isOn = true
	}
	end
	
	shouldPlayMusicCheckbox.x = display.contentCenterX + 10
	shouldPlayMusicCheckbox.y = display.contentCenterY
	
	sceneGroup:insert(backButton)
	sceneGroup:insert(shouldPlayMusicCheckbox)
	sceneGroup:insert(shouldPlayMusicText)
	sceneGroup:insert(confirmButton)

end

function scene:show( event ) 
	local phase = event.phase
    	if ( phase == "will" ) then
    		if (settings.shouldPlayMusic) then
				playBackgroundMusic = audio.play(backgroundMusic, {loops = -1})
			end
			ads.show( "banner", { x=display.contentCenterX, y=0 } )
   		elseif ( phase == "did" ) then
   			composer.removeHidden()
   			local function handleCheckboxEvent( event )
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

			local function handleBackButtonEvent ( event ) 
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
			local function handleConfirmButtonEvent ( event ) 
		  	 	if ( event.phase == "ended" ) then
		   			 local options =
				{
				    effect = "fade",
				    time = 50,
				    params =
		 		   {
		 		   }
				}
				if (shouldPlayMusicCheckbox.isOn) then
					settings.shouldPlayMusic = true
					saveTable(settings, "gameSettings.json")
				else
					settings.shouldPlayMusic = false
					saveTable(settings, "gameSettings.json")
				end
		        return true;
				end
			end
			confirmButton:addEventListener("touch",handleConfirmButtonEvent)
			backButton:addEventListener("touch",handleBackButtonEvent)
			shouldPlayMusicCheckbox:addEventListener("touch", handleCheckboxEvent)
		end
end

function scene:hide(event)
	local phase = event.phase
	if (phase == "will") then 
		ads.hide()
--		if (settings.shouldPlayMusic) then
			audio.stop(playBackgroundMusic)
			playBackgroundMusic = nil
--		end
	elseif (phase == "did") then 
	end
end

function scene:destroy(event)
--	if (settings.shouldPlayMusic) then
		audio.dispose(backgroundMusic)
		backgroundMusic = nil
--	end
end

scene:addEventListener("create",scene)
scene:addEventListener("show",scene)
scene:addEventListener("hide",scene)
scene:addEventListener("destroy",scene)

return scene
