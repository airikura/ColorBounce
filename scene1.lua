local composer = require( "composer" )
local gameNetwork = require( "gameNetwork" )
local scene = composer.newScene()
composer.removeOnSceneChange = true
physics.start(true);
local ads = require("ads")
local sfx = require("sfx")
local physics = require("physics")
local bannerAppID
local interstitialAppID
local publisherID
local score1 = require( "score" )
local scoreBox
local startingBlock
local block
local block2
local block3
local blockGuyY
local block4
local sceneGroup1
local newColorWarningText
local myTransition
local blinkText
local hasDisplayedWarning = false
local red
local blue
local green
local purple
local redColors = {225/255, 105/255, 97/255 } 
local greenColors = {119/255, 190/255, 119/255 } 
local blueColors = {119/255, 158/255, 203/255 }
local purpleColors = {150/255, 111/255, 214/255 }
local goldColors = {255/255, 204/255, 0/255}
local guy
local rightWall
local topWall
local powerUp
local timers
local isPoweredUp
local wasPoweredUp 
local canJump 
local b1c
local b2c 
local b3c 
local b4c  --- ************** ---
local gc 
local score
local speed
local holding 
local jumpSpeed
local rLength
local hasCollided 

local gradient = graphics.newGradient(
	{ 1, 0, 0 },
	{ 0, 0, 1 },
	"down" ) 
local pUpRandom 
local rainbowHappening 
local canSpawn 
local r 
local t
local i
local firsttouch 
local bcolor 
local ecolor
local backgroundMusic
local playBackgroundMusic
local newColorCalled = false
profiler = require "Profiler"; 
profiler.startProfiler({mode = 2, time = 10000, delay = 1000});




--[[
local function screenshot()	

	--I set the filename to be "widthxheight_time.png"
	--e.g. "1920x1080_20140923151732.png"
	local date = os.date( "*t" )
	local timeStamp = table.concat({date.year .. date.month .. date.day .. date.hour .. date.min .. date.sec})
	local fname = display.pixelWidth.."x"..display.pixelHeight.."_"..timeStamp..".png"
	
	--capture screen
	local capture = display.captureScreen(false)

	--make sure image is right in the center of the screen
	capture.x, capture.y = display.contentWidth * 0.5, display.contentHeight * 0.5

	--save the image and then remove
	local function save()
		display.save( capture, { filename=fname, baseDir=system.DocumentsDirectory, isFullResolution=true } )    
		capture:removeSelf()
		capture = nil
	end
	timer.performWithDelay( 100, save, 1)
	       	
	return true               
end


--works in simulator too
local function onKeyEvent(event)
	if event.phase == "up" then
		--press s key to take screenshot which matches resolution of the device
    	    if event.keyName == "s" then
    		screenshot()
    	    end
        end
end

Runtime:addEventListener("key", onKeyEvent) 
--]]







local options =
{
	effect = "fade",
	time = 400,
	params =
	{
}
}

local function adListener( event )
	if ( event.isError ) then
        --Failed to receive an ad

    end
end

local function checkMemory()
	collectgarbage( "collect" )
	local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
	print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
end

timer.performWithDelay( 1000, checkMemory, 0 )




local function after(event)
	if (rLength<8) then
		r[rLength] = display.newRect( (display.contentWidth/7) * rLength -display.contentWidth/ 14 , display.contentHeight/2 , display.contentWidth/7 , display.contentHeight)
		sceneGroup1:insert(r[rLength])
		r[rLength]:toBack( )
		r[rLength]:setFillColor( 1,0,0 )

		if (rLength == 1) then
			r[rLength]:setFillColor( 1,0,0 )
		elseif (rLength == 2) then
			r[rLength]:setFillColor( 1, .5,0 )
		elseif (rLength == 3) then
			r[rLength]:setFillColor( 1, 1,0 )
		elseif (rLength == 4) then
			r[rLength]:setFillColor( 0, 1,0 )
		elseif (rLength == 5) then
			r[rLength]:setFillColor( 0, 0, 1 )
		elseif (rLength == 6) then
			r[rLength]:setFillColor( .5, 0,1 )
		elseif (rLength == 7) then
			r[rLength]:setFillColor( 1, 0,.5 )
		end
	end


	if (rLength>10) then
		r[rLength - 10]:removeSelf()
		r[rLength - 10] = nil 
	end
	rLength = rLength + 1
	rainbowHappening = false
end


local function rainbow(event)
	if rainbowHappening == false then
		rainbowHappening = true
		rLength = 1
		timer.performWithDelay(100, after, 17)
	end
end

						local function onComplete( event )
							if event.action == "clicked" then
								local i = event.index
								local options = 
								{
								effect = "fade",
								time = 400,
								params =
								{
							}
						}
						if i == 1 then 
			--native.cancelAlert(mAlert)
			if (number == 1) then 
				composer.gotoScene("scene2", options)
				return true

			else 
				composer.gotoScene("scene2", options)
				return true
			end
		end
	end
end

local function endGame() 
	print(score1.load())
	gameNetwork.request( "setHighScore",
    {
        localPlayerScore = { category="com.HueHopper.HighScore", value=score },
        listener = requestCallback
    })
if ((score1.load() == nil ) or (score > score1.load()))then
	score1.set(score)
	score1.save()
		native.showAlert("High Score!", "Congratulations, you scored " .. tostring(score1.load()), {"Continue"}, onComplete)
else
	native.showAlert("Score", "You scored " .. score .. "... Better luck next time!", {"Continue"}, onComplete)
		--composer.gotoScene("scene2", options)
	end
end


local function changeColor(event)
	if (isPoweredUp == true) then 
		bcolor[0] = goldColors[1]
		bcolor[1] = goldColors[2]
		bcolor[2] = goldColors[3]
		if (event.target == red) then 
			gc = 1; 
		elseif (event.target == green) then 
			gc = 3; 
		elseif (event.target == blue) then 
			gc = 2; 
		end
		return
	end
	if (event.target == red) then
		gc = 1
		guy:setFillColor(225/255,105/225,97/225)
		bcolor[0] = 225/255
		bcolor[1] = 105/225
		bcolor[2] = 97/225
	--	tapSound = audio.loadSound("tapRed.mp3" )

	elseif (event.target == green) then
		gc = 3
		guy:setFillColor(119/255,190/255,119/255)
		bcolor[0] = 119/255
		bcolor[1] = 190/255
		bcolor[2] = 119/255
		--	tapSound = audio.loadSound("tapGreen.mp3" )

	elseif (event.target == blue) then
		gc = 2
		guy:setFillColor(119/255,158/255,203/255)
		bcolor[0] = 119/255
		bcolor[1] = 158/255
		bcolor[2] = 203/255
		--		tapSound = audio.loadSound("tapBlue.mp3")
	end

			--playTapSound = audio.play(tapSound)
		
	end

	--called when there are 4 colors on the screen
local function changeColor4(event)
	if (isPoweredUp == true) then 
		bcolor[0] = goldColors[1]
		bcolor[1] = goldColors[2]
		bcolor[2] = goldColors[3]
		if (event.target.id == 'red') then 
			gc = 1; 
		elseif (event.target.id == 'green') then 
			gc = 3; 
		elseif (event.target.id == 'blue') then 
			gc = 2; 
		elseif (event.target.id == 'purple') then 
			gc = 4
		end
		return
	end
	if (event.target.id == 'red') then
		gc = 1
		guy:setFillColor(225/255,105/225,97/225)
		bcolor[0] = 225/255
		bcolor[1] = 105/225
		bcolor[2] = 97/225

	elseif (event.target.id == 'green') then
		gc = 3
		guy:setFillColor(119/255,190/255,119/255)
		bcolor[0] = 119/255
		bcolor[1] = 190/255
		bcolor[2] = 119/255

	elseif (event.target.id == 'blue') then
		gc = 2
		guy:setFillColor(119/255,158/255,203/255)
		bcolor[0] = 119/255
		bcolor[1] = 158/255
		bcolor[2] = 203/255
	elseif (event.target.id == 'purple') then
		gc = 4 
		guy:setFillColor(purpleColors[1], purpleColors[2], purpleColors[3])
		bcolor[0] = purpleColors[1] 
		bcolor[1] = purpleColors[2] 
		bcolor[2] = purpleColors[3]
	end
end

local function touchHandler( event )
	print(hasCollided)
	if event.phase == "began" then
		if (canJump and hasCollided and guy.y < blockGuyY + 4) then
			--display.getCurrentStage():setFocus(event.target)
			--event.target.isFocus = true
			--event.target.isFocus = true
			--Runtime:addEventListener( "enterFrame", playerGo)
			jumpSpeed = -175
			holding = true
			firsttouch = true
			canJump = false
			hasCollided = false
			guy:setLinearVelocity(0, -235)
			
			--guy:applyForce(0, -800, guy.x, guy.y)
		--[[	while (holding) do 
				linearVelocityX, linearVelocityY = guy:getLinearVelocity()
				print(linearVelocityY)
				if (event.phase == "ended") then
					print("ended")
					holding = false
				elseif (linearVelocityY < -400) then
					guy:applyLinearImpulse(0, jumpSpeed, guy.x, guy.y)
					jumpSpeed = jumpSpeed - 12
				else
					holding = false
				end
				end--]]
				if (score < 30) then 
					changeColor(event)
				else 
					changeColor4(event)
				end
			end	


			elseif event.target.isFocus then 
				if event.phase == "moved" then
				elseif (event.phase == "ended" or event.phase == "cancelled") then
					holding = false
					jumpSpeed = -125
					canJump = true
				--Runtime:removeEventListener( "enterFrame", playerGo)		
				--display.getCurrentStage():setFocus( nil )
				--event.target.isFocus = false
			end

		end
		return true
	end

local function newColor() 
	display:remove(red)
	display:remove(blue)
	display:remove(green)
	sceneGroup1:remove(red)
	sceneGroup1:remove(blue)
	sceneGroup1:remove(green)
	red = display.newRect(display.contentWidth/8, display.contentHeight * .93, display.contentWidth / 4, 80)
	red:setFillColor(225/255, 105/225, 97/225)
	blue = display.newRect(3 * display.contentWidth / 8, display.contentHeight * .93, display.contentWidth / 4, 80)
	blue:setFillColor(119/255,158/255,203/255)
	green = display.newRect(5 * display.contentWidth / 8,  display.contentHeight * .93, display.contentWidth / 4, 80)
	green:setFillColor(119/255,190/255,119/255)
	purple = display.newRect(7 * display.contentWidth / 8,  display.contentHeight * .93, display.contentWidth / 4, 80)
	purple:setFillColor(purpleColors[1],purpleColors[2],purpleColors[3])
	red.id = 'red'
	blue.id = 'blue'
	green.id = 'green'
	purple.id = 'purple'
	sceneGroup1:insert(red)
	sceneGroup1:insert(blue)
	sceneGroup1:insert(green)
	sceneGroup1:insert(purple)
	red:addEventListener( "touch", touchHandler )
	green:addEventListener( "touch", touchHandler )
	blue:addEventListener( "touch", touchHandler )
	purple:addEventListener( "touch", touchHandler )
end

--and not(shouldEnd))
local function isAlive( event )
	if ((guy.y > display.contentHeight or guy.x < -25)) then
		Runtime:removeEventListener("enterFrame", isAlive)
		endGame()
	end
end

local function movepup (event)
	powerUp.y =  block.y - math.random(125,197)
	guy:setLinearVelocity( 0  , guy.y < Velocity )
end


local function spawnPowerUp (event)
	pUpRandom = math.random(1,5)
	if (pUpRandom  == 1 ) then
		if (canSpawn == 1) then
			canSpawn = 0
			powerUp.x = 700
			powerUp.y =  block.y - math.random(125, 197); 
		end
	end
end

local function pUpGo (event)
	powerUp.x = powerUp.x - (speed/2)
	if (powerUp.x < -500) then
		canSpawn = 1
	end
end




--Set block color to random value
local function setBlockColor(block)
	local randomNumber = math.random(1,3)
	if (randomNumber == 1) then
		block:setFillColor(225/255,105/255,97/255 )
	elseif (randomNumber == 2) then
		block:setFillColor( 119/255,158/255,203/255)
	elseif (randomNumber == 3) then
		block:setFillColor( 119/255,190/255,119/255)
	end
	return randomNumber;
end

--Called when there are 4 colors, set block color to random value
local function setBlockColor4(block) 
	local randomNumber = math.random(1,4)
	if (randomNumber == 1) then
		block:setFillColor(225/255,105/255,97/255 )
	elseif (randomNumber == 2) then
		block:setFillColor( 119/255,158/255,203/255)
	elseif (randomNumber == 3) then
		block:setFillColor( 119/255,190/255,119/255)
	elseif (randomNumber == 4) then 
		block:setFillColor(purpleColors[1], purpleColors[2], purpleColors[3])
	end
	return randomNumber;
end

--Make ball rotate 
local function ballRotate(  )
	guy:rotate(speed/2)
end


local function playerGo(event)
	--linearVelocityX, linearVelocityY = guy:getLinearVelocity()
	--guy:setLinearVelocity(0, linearVelocityY)
	if holding then
		linearVelocityX, linearVelocityY = guy:getLinearVelocity()
		if linearVelocityY > -200 then
			guy:setLinearVelocity(linearVelocityX,jumpSpeed)
			jumpSpeed = jumpSpeed - 12
		else
			holding = false
		end
	end
end





--Raises speed based on current value of score, called in updateScore()
local function raiseSpeed(newScore)
	if (newScore > 5) then
		speed = speed + (2 / (newScore))
	end
end

--Updates score, called in onCollision(event)
local function updateScore()
	score = score + 1
	scoreBox.text = score
	raiseSpeed(score)
	--Warn user when new color is coming soon
	if ((score == 25 or score == 26) and (hasDisplayedWarning == false)) then 
		hasDisplayedWarning = true
		newColorWarningText = display.newText("New color appearing soon!",display.contentWidth/2, 30, "Arial", 36)
		newColorWarningText:setTextColor( 0, 0, 0 )
		sceneGroup1:insert(newColorWarningText)
		local function flashText() 
			if newColorWarningText.alpha < 1 then 
				myTransition = transition.to(newColorWarningText, {time = 490, alpha = 1})
			else 
				myTransition = transition.to(newColorWarningText, {time = 490, alpha = 0.1})
			end
		end
		blinkText = timer.performWithDelay( 500, flashText, 6)
		timers[3] = blinkText
	end
	--if score is greater than 29, and newColor() hasn't been called yet, call newColor
	if ((score > 29) and (newColorCalled == false)) then
		newColorWarningText.text= "hello"
		newColorWarningText.alpha = 0
		timer.cancel(blinkText)
		blinkText = nil
		display.remove(newColorWarningText)
		sceneGroup1:remove(newColorWarningText)
		newColorCalled = true 
		newColor()
	end
end


--Move function for block
local function go( event )
	block.x = block.x - (speed/2)
	if (block.x < -200) then
		block.x = block4.x + math.random(115 + 20* speed, 185 + 21* speed)
		if (score > 20) then
			block.y = display.contentHeight - 100 - math.random(0, 27 + ((5/4) * speed))
		end
		if (score < 30) then 
			b1c = setBlockColor(block)
		else 
			b1c = setBlockColor4(block)
		end
	end
end

--Move function for block2
local function go2( event )
	block2.x = block2.x - (speed/2)
	if (block2.x < -200) then
		block2.x = block.x + math.random(120 + 20* speed,185 + 21* speed)
		if (score > 20) then 
			block2.y = display.contentHeight - 100 - math.random(0, 27 + ((5/4) *speed))
		end
		if (score < 30) then 
			b2c = setBlockColor(block2)
		else
			b2c = setBlockColor4(block2)
		end
	end
end

--Move function for block3
local function go3( event )
	block3.x = block3.x - (speed/2)  
	if (block3.x < -200) then
		block3.x = block2.x + math.random(120 + 20 * speed,185+ 21* speed)
		if (score > 20) then 
			block3.y = display.contentHeight - 100 - math.random(0, 27 + ((5/4)*speed))
		end
		if (score < 30) then 
			b3c = setBlockColor(block3)
		else 
			b3c = setBlockColor4(block3) 
		end
	end
end

--Move function for block4
local function go4( event )
	block4.x = block4.x - (speed/2)
	if (block4.x < -200) then 
		block4.x = block3.x + math.random(120 + 20* speed,185 + 21* speed)
		if (score > 20) then
			block4.y = display.contentHeight - 100 - math.random(0, 27 + ((5/4) *speed))
		end
		if (score < 30) then 
			b4c = setBlockColor(block4)
		else 
			b4c = setBlockColor4(block4) 
		end
	end
end

--Move function for startingBlock
local function startBlockGo( event )
	if (startingBlock == nil) then 
		Runtime:removeEventListener( "enterFrame", startBlockGo)
		return false
	end

	startingBlock.x = startingBlock.x - (speed/2)
	if (startingBlock.x < -1000) then
		Runtime:removeEventListener( "enterFrame", startBlockGo)
		startingBlock:removeSelf()
		startingBlock = nil
	end
end

--Called to remove explosion animation from screen
function afterTimer()
	t[i]:removeSelf()
	t[i] = nil 
end

--Function to create explosion animation
local function explode (event)
	i = i + 1
	t[i] = display.newCircle( guy.x, guy.y, 25 + i *50 )
	t[i]:setFillColor( ecolor[0],ecolor[1],ecolor[2],.5  )
	t[i]:toBack()
	if (i>2) then
		t[i-1]:removeSelf( )
		t[i-1] = nil 
	end
	if (i == 16) then
		timer.performWithDelay(100, afterTimer, 1)
	end

end

--Function to end powerup effects
local function endPowerUp( event )
isPoweredUp = false
wasPoweredUp = true
	--SET COLOR BACK
	if (gc == 1) then 
		--set red
		if (guy == nil) then
			return
		end
		guy:setFillColor(225/255,105/225,97/225)
		elseif (gc == 2) then 
		--set blue
		guy:setFillColor(119/255,158/255,203/255)
		elseif (gc == 3) then
		--set green
			guy:setFillColor(119/255,190/255,119/255)
		elseif (gc == 4) then 
			guy:setFillColor(purpleColors[1], purpleColors[2], purpleColors[2])
		end
end

--Function to respawn power up in new location after it disappears from screen
local function respawnPowerUp( event ) 
	powerUp.x = 5000 + math.random(speed,  10 * speed); 
	powerUp.y = block.y - math.random(125,197)
end

--Computes the distance between two object coordinates
local function distance(obj1X, obj1Y, obj2X, obj2Y) 
	local dist = math.sqrt((obj1X - obj2X)^2 + (obj1Y - obj2Y)^2)
	return dist
end

--Function to give guy effects of power up
local function getPowerup (event)
	rainbow()
	--SET COLOR OF BLOCK HERE 
	guy:setFillColor(255,255,255)
	isPoweredUp = true
	wasPoweredUp = true
	timers[0] = timer.performWithDelay(50, respawnPowerUp, 1)
	timers[1] = timer.performWithDelay(7000, endPowerUp, 1)

end

--Function to make guy jump 
local function speedUp() 
	linearVelocityX, linearVelocityY = guy:getLinearVelocity()
	while (linearVelocityX < 0) do
		linearVelocityX, linearVelocityY = guy:getLinearVelocity()
		guy:setLinearVelocity(linearVelocityX + .01, linearVelocityY)
	end
	--[[while (guy.x < 100) do 
		if (guy.y  > display.contentHeight*.87) then
			return
		end
		guy.x = guy.x + .001
		end--]]
	end

--Called on any collision on block
local function onCollision( event )
	print("Colliding")
	local shouldEnd = false
	blockGuyY = guy.y
	if ( event.phase == "began" ) then
		if (event.other.myName == "powerUp") then
			getPowerup()
			return
		end
		hasCollided = true
		canJump = true
		timers[2] = timer.performWithDelay(350, speedUp, 1)
		if (firsttouch) then
			ecolor[0] = bcolor[0]
			ecolor[1] = bcolor[1]
			ecolor[2] = bcolor[2]
			if (event.other.myName == "block") then
				if (b1c == gc or wasPoweredUp) then
					timer.performWithDelay(10, explode, 15)
					i = 1
					updateScore()
					firsttouch = false
					if (isPoweredUp == false) then
						wasPoweredUp = false
					else
						updateScore()
					end
				else 
					shouldEnd = true
				end
			elseif (event.other.myName == "block2") then
				if (b2c == gc or wasPoweredUp) then
					timer.performWithDelay(10, explode, 15)
					i = 1
					updateScore()
					firsttouch = false
					if (isPoweredUp == false) then
						wasPoweredUp = false

					--If isPoweredUp, updateScore twice
					else 
						updateScore()
					end
				else 
					shouldEnd = true
				end

			elseif (event.other.myName == "block3") then
				if (b3c == gc or wasPoweredUp) then
					timer.performWithDelay(10, explode, 15)
					i = 1
					updateScore()
					firsttouch = false	
					if (isPoweredUp == false) then
						wasPoweredUp = false
					--If isPoweredUp, updateScore twice
					else 
						updateScore()
					end
				else 
					shouldEnd = true
				end
			elseif (event.other.myName == "block4") then 
				if (b4c == gc or wasPoweredUp) then 
					timer.performWithDelay(10, explode, 15)
					i = 1
					updateScore()
					firsttouch = false
					if (isPoweredUp == false) then
						wasPoweredUp = false
					--If isPoweredUp, updateScore twice
					else 
						updateScore()
					end
				else 
					shouldEnd = true
				end
			end
		end
		if (shouldEnd and (guy.y <= display.contentHeight - 95 or guy.x < -25)) then
			Runtime:removeEventListener("enterFrame", isAlive)
			endGame()
		end
	elseif ( event.phase == "ended" ) then  

	end
end

--Clear timers from memory 
local function cancelTimers() 
	for timerCount = 1, 4 do 
		if (timers[timerCount - 1] ~= nil) then 
			timer.cancel(timers[timerCount - 1])
			timers[timerCount - 1] = nil
		end
	end
end


--local function colorTouch(event)
--	if (event.phase == "began") then 
--		if (canJump) then
--			canJump = false
--			firsttouch = true
--			guy:setLinearVelocity( 0, -250 )
--			changeColor(event);
--		end
--	end
--	return true;
--end




--Called when scene is first loaded into memory
function scene:create( event )
	
	local sceneGroup = self.view
	sceneGroup1 = sceneGroup
	publisherID = "pub-8667480018293512"
	bannerAppID = "ca-app-pub-8667480018293512/2536023388"
	interstitialAppID = "ca-app-pub-8667480018293512/5806900586"
	ads.init("admob", "pub-8667480018293512", adListener)
	timers = {}
	
	--score1.init()
	scoreBox = display.newText(0, 450,50, "Helvetica", 36)
	guy = display.newImage("ball.png", 100, 150, true)
	guy:scale(.25,.25)
	block = display.newRoundedRect(700 , display.contentHeight - 100, 150, 50,4)
	block.myName ="block"
	b1c = setBlockColor(block)

	physics.addBody(block, "static", {density = 1, friction = 0, bounce = 0});
	block2 = display.newRoundedRect(1000 , display.contentHeight - 100, 150, 50,4)
	physics.addBody(block2, "static", {density = 1, friction = 0, bounce = 0});
	block2.myName= "block2"
	block3 = display.newRoundedRect(1300 , display.contentHeight - 100, 150, 50,4)
	b2c = setBlockColor(block2)
	physics.addBody(block3, "static", {density = 1, friction = 0, bounce = 0});
	block3.myName= "block3" 
	b3c = setBlockColor(block3)
	block4= display.newRoundedRect(1600, display.contentHeight - 100, 150, 50,4)
	physics.addBody(block4, "static", {density = 1, friction = 0, bounce = 0});
	block4.myName= "block4"
	b4c = setBlockColor(block4);
	--[[red = display.newCircle(display.contentWidth/6, display.contentHeight * .87, 25 )
	red:setFillColor(225/255, 105/225, 97/225)
	blue = display.newCircle(display.contentWidth/ 2, display.contentHeight * .87, 25 )
	blue:setFillColor(119/255,158/255,203/255)
	green = display.newCircle((display.contentWidth * 5)/6, display.contentHeight * .87, 25 )
	green:setFillColor(119/255,190/255,119/255)--]]
	--guy = display.newCircle( 100, 150, 25 )
	--guy:setFillColor( math.random(0,255)/255,math.random(0,255)/255,math.random(0,255)/255)

	red = display.newRect(display.contentWidth/6, display.contentHeight * .93, display.contentWidth / 3, 65)
	red:setFillColor(225/255, 105/225, 97/225)
	blue = display.newRect(3 * display.contentWidth / 6, display.contentHeight * .93, display.contentWidth / 3, 65)
	blue:setFillColor(119/255,158/255,203/255)
	green = display.newRect(5 * display.contentWidth / 6,  display.contentHeight * .93, display.contentWidth / 3, 65)
	green:setFillColor(119/255,190/255,119/255)

	red.id = 'red'
	blue.id = 'blue'
	green.id = 'green'

	guy.isSleepingAllowed = false
	physics.addBody(guy, {density=1, friction=0, bounce=0 , radius = 25 } );
	

	if (settings.shouldPlayMusic) then
		backgroundMusic = audio.loadSound("ColorBounceSoundtrack2.mp3")
	end


	startingBlock = display.newRoundedRect(0 , display.contentHeight - 100, 1025, 50,4)
	physics.addBody(startingBlock, "static", {density = 1, friction = 0, bounce = 0});
	startingBlock:setFillColor( math.random(0,255)/255,math.random(0,255)/255,math.random(0,255)/255)

	sceneGroup:insert( scoreBox )
	sceneGroup:insert( block )
	sceneGroup:insert( block2 )
	sceneGroup:insert( block3 )
	sceneGroup:insert( block4 )
	sceneGroup:insert( red )
	sceneGroup:insert( blue )
	sceneGroup:insert( green )
	sceneGroup:insert( guy )
	sceneGroup:insert( startingBlock )

end


--Called when scene appears on screne
function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		if (number >= 4) then 
			ads.load("interstitial", {appId=interstitialAppID, testMode = false})
		end
		--ads.show( "banner", { x=0, y=-10000, appId = bannerAppID } )

		if (settings.shouldPlayMusic ) then
			playBackgroundMusic = audio.play(backgroundMusic, {loops = -1, fadein = 500, fadeout = 500, channel = 1})
		end
		
		guy.x = 100
		guy.y = 75
		startingBlock.x = 0
		block.x = 700
		block2.x = 950
		block3.x = 1200
		block4.x = 1450

		isPoweredUp = false 
		wasPoweredUp = false
		hasCollided = false
		canJump = false
		gc = -1
		score = 0
		scoreBox.text = 0
		scoreBox:setTextColor(0.2,0.2,0.2)
		speed = 5
		holding = false
		jumpSpeed = -125
		rLength = 1

									--[[	local gradient = graphics.newGradient(
											{ 1, 0, 0 },
											{ 0, 0, 1 },
											"down" ) --]]
		pUpRandom = 1
		rainbowHappening = false
		canSpawn = 1
		r = {}
		t = {} 
		i = 1
		firsttouch = true
		bcolor = {1,1,1}
		ecolor= {1,1,1}

		powerUp = display.newImage("powerUpImage.png", math.random(1500, 2200), block.y - 125, true)
		--display.newRect( math.random(1500, 2200), block.y - 125, 50, 50 )
		powerUp:scale(.25,.25)
		physics.addBody( powerUp, "dynamic" , {density=0, friction=0, bounce=0, radius = 25} )

		powerUp.gravityScale = 0

		powerUp.myName = "powerUp"
		powerUp.isSensor = true
		sceneGroup:insert( powerUp )

		spawnPowerUp(); 
		red:addEventListener( "touch", touchHandler)
		blue:addEventListener( "touch", touchHandler)
		green:addEventListener("touch" , touchHandler) 
		guy:addEventListener( "collision",  onCollision)
		powerUp:addEventListener("touch", getPowerup)

		--Runtime:addEventListener("enterFrame", playerGo)
		Runtime:addEventListener("enterFrame", isAlive)
		Runtime:addEventListener( "enterFrame", pUpGo );
		Runtime:addEventListener("enterFrame", go)
		Runtime:addEventListener("enterFrame", go2)
		Runtime:addEventListener("enterFrame",  go3)
		Runtime:addEventListener("enterFrame", go4)
		Runtime:addEventListener("enterFrame", startBlockGo)
		Runtime:addEventListener("enterFrame", ballRotate)
		elseif ( phase == "did" ) then
			--Clear unremoved objects from memory
			composer.removeHidden()
		end
end

--Called when scene deleted from memory
function scene:destroy( event )
	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		
		elseif ( phase == "did" ) then
		--sceneGroup:removeSelf()
		--sceneGroup = nil
		--if (settings.shouldPlayMusic) then
		audio.dispose(backgroundMusic)
		backgroundMusic = nil;
		--end
	end
end


--Called when scene hid from screen
function scene:hide( event )
	cancelTimers()
	local phase = event.phase
	if (phase ==  "will") then 
		physics.pause()
		if (startingBlock ~= nil) then
			Runtime:removeEventListener("enterFrame", startBlockGo)
		end
		Runtime:removeEventListener("enterFrame", isAlive)
		--Runtime:removeEventListener("enterFrame", playerGo)
		Runtime:removeEventListener("enterFrame", go)
		Runtime:removeEventListener("enterFrame", go2)
		Runtime:removeEventListener("enterFrame", go3)
		Runtime:removeEventListener("enterFrame", go4)
		Runtime:removeEventListener("enterFrame", pUpGo); 
		Runtime:removeEventListener("enterFrame", ballRotate); 
		
		--composer.removeScene( "scene1" )
		--if (settings.shouldPlayMusic) then 
		--audio.stop()
		sfx.stop(sfx.longsound)
		--playBackgroundMusic = nil 
		--end
		
		--audio.dispose(backgroundMusic)
		--backgroundMusic = nil
		--sceneGroup:removeSelf()
		--sceneGroup = nil
	elseif ( phase == "did" ) then
   	     -- Called immediately after scene goes off screen.
   	    
   	 end
end

scene:addEventListener( "create", scene)
scene:addEventListener( "hide", scene )	
scene:addEventListener( "show", scene)
scene:addEventListener("destroy", scene)


return scene