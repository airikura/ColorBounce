local composer = require("composer")
local scene = composer.newScene()
local widget = require ("widget")
local sfx = require("sfx")
sfx.longsound = nil
local highScore = {}
local shouldPlayMusicCheckbox
local shouldPlayMusicText 
local backgroundMusic
local playBackgroundMusic
local shouldResetHighScoreBox
local resetHighScoreText
local confirmButton
local backButton
local ads = require("ads")
local publisherID
local bannerAppID


--[[local function onPressCheck( event )
    local switch = event.target
    print( "Switch with ID '"..switch.id.."' is on: "..tostring(switch.isOn) )
    end--]]

function scene:create(event)
	local sceneGroup = self.view
	publisherID = "pub-8667480018293512"
	bannerAppID = "ca-app-pub-8667480018293512/1059290188"
	ads.init("admob", publisherID, adListener)

	-- Handle press events for the checkbox
	-- Create the widget
	shouldPlayMusicCheckbox = widget.newSwitch
	{
		left = 250,
		top = 200,
		style = "checkbox",
		id = "Checkbox",
	}



	confirmButton = widget.newButton
	{
		left = display.contentWidth - 100,
		top = display.contentCenter,
		label = "Confirm",
		shape = "roundedRect",
			--fillColor = { default={ 1, 0.4, 0.5, 0.7 }, over={ 1, 0.4, 0.5, 1 } },
			fontSize = 20,
			font = Helvetica,
			--labelColor = { default={ 1, 1, 1 }, over={ 0.8, 0.8, 0.8 }}
			fillColor = {default = {0.33333,0.33333,0.33333}, over = {0.33333,0.333333,0.33333}},
			labelColor = { default={ 1, 1, 1 }, over={ 0.8, 0.8, 0.8 }}
		}

	backButton = widget.newButton
	{
		left = -display.contentWidth * .27,
		top = display.contentHeight * -.27,
		defaultFile = "back_new.png"
		--label = "back",
		--shape = "roundedRect",
		--fillColor = { default={ 1, 0.4, 0.5, 0.7 }, over={ 1, 0.4, 0.5, 1 } },
		--fontSize = 20,
		--labelColor = { default={ 1, 1, 1 }, over={ 0.8, 0.8, 0.8 }}
	}
	backButton:scale( .16, .16 )



	shouldPlayMusicText = display.newText("Play ingame music: ", display.contentCenterX - 100, display.contentCenterY, Helvetica, 20)
	shouldPlayMusicText:setFillColor(.2,.2,.2)
	shouldPlayMusicText.text = "Play in-game music: "
	
	--backgroundMusic = audio.loadSound("ColorBounceMenuMusic3.mp3")
	if (settings.shouldPlayMusic) then
		shouldPlayMusicCheckbox:setState {
		isOn = true }
	end


	confirmButton.x = display.contentCenterX
	confirmButton.y = display.contentCenterY + 80

	shouldPlayMusicText.x = display.contentCenterX - 15
	shouldPlayMusicText.y = display.contentCenterY

	shouldPlayMusicCheckbox.x = display.contentCenterX + 105
	shouldPlayMusicCheckbox.y = display.contentCenterY

	sceneGroup:insert(backButton)
	sceneGroup:insert(shouldPlayMusicCheckbox)
	sceneGroup:insert(shouldPlayMusicText)
	sceneGroup:insert(confirmButton)

end

function scene:show( event ) 
	local phase = event.phase
	if ( phase == "will" ) then
		--[[if (settings.shouldPlayMusic) then
			playBackgroundMusic = audio.play(backgroundMusic, {loops = -1})
		end]]
		sfx.longsound = audio.loadSound("ColorBounceMenuMusic3.mp3")
		sfx.play( sfx.longsound, { 
			onComplete = function()
				audio.dispose(sfx.longsound)
			end,
			loops = -1 } )
		ads.show( "banner", { x=0, y=10000, appId = bannerAppID} )
	elseif ( phase == "did" ) then
		composer.removeHidden()
		composer.removeScene("scene6")
		composer.removeScene("scene7")
		local function handleCheckboxEvent( event )
		if ( event.phase == "ended" ) then
		local options =
		{
		effect = "fade",
		time = 0,
		params =
		{}
		}
		composer.gotoScene( "scene1" , options);
		return true;
		end
	end

	local function handleBackButtonEvent ( event ) 
		if ( event.phase == "ended" ) then
		local options = 
		{
		effect = "slideRight",
		time = 250,
		params = {}	
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
		effect = "slideRight",
		time = 250,
		params = {}
		}
		if (shouldPlayMusicCheckbox.isOn) then
			settings.shouldPlayMusic = true
			saveTable(settings, "gameSettings.json")
			sfx.play(sfx.longsound, {
				onComplete = function()
					audio.dispose(sfx.longsound)
				end,
				loops = -1 } )
			composer.gotoScene( "scene2" , options);
			if (playBackgroundMusic == nil) then
					--playBackgroundMusic = audio.play(backgroundMusic, {loops = -1})
			end
			else
				settings.shouldPlayMusic = false
				saveTable(settings, "gameSettings.json")
				--audio.stop(playBackgroundMusic)
				sfx.stop(sfx.longsound)
				playBackgroundMusic = nil
				composer.gotoScene( "scene2" , options);
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
		--audio.stop(playBackgroundMusic)
		playBackgroundMusic = nil
--		end
	elseif (phase == "did") then 
	end
end

function scene:destroy(event)
--	if (settings.shouldPlayMusic) then
	--audio.dispose(backgroundMusic)
	backgroundMusic = nil
--	end
end

scene:addEventListener("create",scene)
scene:addEventListener("show",scene)
scene:addEventListener("hide",scene)
scene:addEventListener("destroy",scene)

return scene

