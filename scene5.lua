local composer = require("composer")
local scene = composer.newScene()
local interstitialAppID
local publisherID
local ads = require("ads")

function scene:create ( event )
	local sceneGroup = self.view
	publisherID = "pub-8667480018293512"
	interstitialAppID = "ca-app-pub-8667480018293512/5806900586"
	ads.init("admob", publisherID, adListener)
	
	
end

local function adListener ( event )
	if (event.isError) then
		display.setDefault( "background", 1, .9921568627, .8156862745)
		composer.gotoScene( "scene2" )
	elseif (event.phase == "shown") then 
		display.setDefault( "background", 1, .9921568627, .8156862745)
		composer.gotoScene("scene2")
	else
		display.setDefault( "background", 1, .9921568627, .8156862745)
		composer.gotoScene("scene2")
	end
end

function scene:show ( event )
	local sceneGroup = self.view
	display.setDefault("background", 0)
	if (ads.isLoaded("interstitial")) then
		ads.show("interstitial", {x = 0, y = 0, appId = interstitialAppID})
	else 
		composer.gotoScene( "scene2" )
	end
end
	
	--composer.gotoScene( "scene2" )

function scene:hide ( event )
	ads.hide()
end

function scene:destroy ( event )
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene