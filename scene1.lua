local composer = require( "composer" )
local scene = composer.newScene()
composer.removeOnSceneChange = true
local physics = require( "physics")
local ads = require("ads")
local ads = require("ads")
local bannerAppID
local publisherID
physics.start(nosleep);
local score1 = require( "score" )
local scoreBox
local block
local block2
local block3
local blockGuyY
local block4
local red
local blue
local green
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






local options =
{
	effect = "fade",
	time = 400,
	params =
	{
}
}

local function adListener( event )
			print("hello")
    if ( event.isError ) then
        --Failed to receive an ad

    end
end

--local function checkMemory()
--	collectgarbage( "collect" )
--	local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
--	print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
--end

timer.performWithDelay( 1000, checkMemory, 0 )




local function after(event)
	if (rLength<8) then
		r[rLength] = display.newRect( (display.contentWidth/7) * rLength -display.contentWidth/ 14 , display.contentHeight/2 , display.contentWidth/7 , display.contentHeight)
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
			r[rLength - 10]:removeSelf( )
		end
							
	rLength = rLength + 1
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
		if i == 1 then 
			--native.cancelAlert(mAlert)
			composer.gotoScene("scene2", options)
		end
	end
end

local function endGame() 
	--Runtime:removeEventListener("enterFrame", isAlive)
	if ((score1.load() == nil ) or (score > score1.load()))then
		score1.set(score)
		score1.save()
		native.showAlert("High Score!", "Congratulations, you scored " .. tostring(score1.load()), {"Continue"}, onComplete)
		
	else
		native.showAlert("Score", "You scored " .. score .. "... Better luck next time!", {"Continue"}, onComplete)
		--composer.gotoScene("scene2", options)
	end
end

local function isAlive( event )
	if (guy.y > display.contentHeight or guy.x < -25) then
		endGame()
	end
end

local function movepup (event)
		powerUp.y =  block.y - 300
		guy:setLinearVelocity( 0  , guy.y < Velocity )
	end


	local function spawnPowerUp (event)
		pUpRandom = math.random(1,5)
		if (pUpRandom  == 1 ) then
			if (canSpawn == 1) then
				canSpawn = 0
				powerUp.x = 700
				powerUp.y =  block.y - 125; 
			end
		end
	end

	local function pUpGo (event)
		powerUp.x = powerUp.x - (speed/2)
		if (powerUp.x < -500) then
			canSpawn = 1
		end
	end

local function playerGo(event)
	linearVelocityX, linearVelocityY = guy:getLinearVelocity()
	guy:setLinearVelocity(0, linearVelocityY)
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

local function changeColor(event)
	local tapSound
	local playTapSound
	if (isPoweredUp == true) then 
		return
	else if (event.target == red) then
		gc = 1
		guy:setFillColor(225/255,105/225,97/225)
		bcolor[0] = 225/255
		bcolor[1] = 105/225
		bcolor[2] = 97/225
		tapSound = audio.loadSound("tapRed.mp3" )

		elseif (event.target == green) then
			gc = 3
			guy:setFillColor(119/255,190/255,119/255)
			bcolor[0] = 119/255
			bcolor[1] = 190/255
			bcolor[2] = 119/255
			tapSound = audio.loadSound("tapGreen.mp3" )
		
		elseif (event.target == blue) then
				gc = 2
				guy:setFillColor(119/255,158/255,203/255)
				bcolor[0] = 119/255
				bcolor[1] = 158/255
				bcolor[2] = 203/255
				tapSound = audio.loadSound("tapBlue.mp3")
		end

			--playTapSound = audio.play(tapSound)
			audio.dispose(tapSound)
			playtapSound = nil
			tapSound = nil
	end
end

local function setBlockColor(block)
		randomNumber = math.random(1,3)

		if (randomNumber == 1) then
			block:setFillColor(225/255,105/255,97/255 )

		elseif (randomNumber == 2) then
			block:setFillColor( 119/255,158/255,203/255)

		elseif (randomNumber == 3) then
			block:setFillColor( 119/255,190/255,119/255)
		end
	return randomNumber;

end
local function ballRotate(  )
	guy:rotate(speed/2)
end
local function go( event )
	
	block.x = block.x - (speed/2)
	if (block.x < -200) then
		block.x = block4.x + math.random(115 + 20* speed, 185 + 21* speed)
		if (score > 20) then
			block.y = display.contentHeight - 100 - math.random(0, 35 + ((3/2) * speed))
		end
		b1c = setBlockColor(block)
	end
end

local function touchHandler( event )
		if event.phase == "began" then
			if (canJump and hasCollided and guy.y < blockGuyY + 4) then
			--display.getCurrentStage():setFocus( event.target )
			--event.target.isFocus = true
			--Runtime:addEventListener( "enterFrame", playerGo)
			jumpSpeed = -125
			holding = true
			firsttouch = true
			canJump = false
			hasCollided = false
			changeColor(event)
		end

		elseif event.target.isFocus then
		if event.phase == "moved" then
		elseif (event.phase == "ended" or event.phase == "cancelled") then
				holding = false
				jumpSpeed = -125
				
				canJump = true
				--Runtime:removeEventListener( "enterFrame", playerGo)		
				display.getCurrentStage():setFocus( nil )
				event.target.isFocus = false
			end
		end

	return true
	
end

	local function raiseSpeed(newScore)
		if (newScore > 5) then
			speed = speed + (2 / (newScore))
		end
	end
	function updateScore()
		score = score + 1
		scoreBox.text = score
		raiseSpeed(score)
	end


	local function go2( event )
		block2.x = block2.x - (speed/2)
		if (block2.x < -200) then
			block2.x = block.x + math.random(120 + 20* speed,185 + 21* speed)
			if (score > 20) then 
				block2.y = display.contentHeight - 100 - math.random(0, 35 + ((3/2) *speed))
			end
			b2c = setBlockColor(block2)

		end
	end

local function go3( event )
	block3.x = block3.x - (speed/2)  
	if (block3.x < -200) then
		block3.x = block2.x + math.random(120 + 20 * speed,185+ 21* speed)
		if (score > 20) then 
			block3.y = display.contentHeight - 100 - math.random(0, 35 + ((3/2)*speed))
		end
		b3c = setBlockColor(block3)
	end
end

local function go4( event )
	block4.x = block4.x - (speed/2)
	if (block4.x < -200) then 
		block4.x = block3.x + math.random(120 + 20* speed,185 + 21* speed)
		if (score > 20) then
			block4.y = display.contentHeight - 100 - math.random(0, 35 + ((3/2) *speed))
		end
		b4c = setBlockColor(block4)
	end
end

local function startBlockGo( event )
		startingBlock.x = startingBlock.x - (speed/2)
		if (startingBlock.x < -1000) then
			Runtime:removeEventListener( "enterFrame", startBlockGo)
			startingBlock:removeSelf()
			startingBlock = nil
		end
end

function afterTimer()
	t[i]:removeSelf()
end

local function explode (event)
	--if (i == 16) then
	--afterTimer()
	--end

	i = i + 1
	t[i] = display.newCircle( guy.x, guy.y, 25 + i *50 )
	t[i]:setFillColor( ecolor[0],ecolor[1],ecolor[2],.5  )
	t[i]:toBack()
		if (i>2) then
		t[i-1]:removeSelf( )
	end
	if (i == 16) then
		timer.performWithDelay(100, afterTimer, 1)
	end
	
end

local function endPowerUp( event )
	isPoweredUp = false
	wasPoweredUp = true
	--SET COLOR BACK
	if (gc == 1) then 
		--set red
		guy:setFillColor(225/255,105/225,97/225)
	elseif (gc == 2) then 
		--set blue
		guy:setFillColor(119/255,158/255,203/255)
	else if (gc == 3) then
		--set green
		guy:setFillColor(119/255,190/255,119/255)
	end
end
end

local function respawnPowerUp( event ) 
	powerUp.x = 5000 + math.random(speed,  10 * speed); 
end

local function distance(obj1X, obj1Y, obj2X, obj2Y) 
	local dist = math.sqrt((obj1X - obj2X)^2 + (obj1Y - obj2Y)^2)
	return dist
end

local function handleSwipe (event)
	print(event.phase)
	if (event.phase == "moved") then 

		--if dX is greater than 10, then we consider it a swipe
		print("DXY EQUALS ====== ")
		print(distance(event.xStart, event.yStart, event.x, event.y))
		if (distance(event.xStart, event.yStart, event.x, event.y) > 10) then 
				print("GUY DISTANCE EQUALS ====")
				print(distance(guy.x, guy.y, event.x, event.y))
				if (distance(guy.x, guy.y, event.x, event.y) < 15) then 

			--SET COLOR OF BLOCK HERE 
				guy:setFillColor(255,255,255)
				isPoweredUp = true
				wasPoweredUp = true
				timer.performWithDelay(50, respawnPowerUp, 1)
				timers[0] = timer.performWithDelay(7000, endPowerUp, 1)
			end
		end
	end
		
end

local function speedUp() 
	linearVelocityX, linearVelocityY = guy:getLinearVelocity()
	while (linearVelocityX < 0) do
		linearVelocityX, linearVelocityY = guy:getLinearVelocity()
		guy:setLinearVelocity(linearVelocityX + .01, linearVelocityY)
	end
	while (guy.x < 100) do 
		if (guy.y > 50) then
			return
		end
		guy.x = guy.x + .1
	end
end


local function onCollision( event )
	print("Colliding")
	local shouldEnd = false
	blockGuyY = guy.y
	if ( event.phase == "began" ) then
		if (event.other.myName == "powerUp") then
			rainbow()
			--SET COLOR OF BLOCK HERE 
			guy:setFillColor(255,255,255)
			isPoweredUp = true
			wasPoweredUp = true
			timer.performWithDelay(50, respawnPowerUp, 1)
			timers[0] = timer.performWithDelay(7000, endPowerUp, 1)
			return
			--Runtime:removeEventListener("enterFrame", pUpGo)
			--powerUp:removeSelf()
		end
		--if (Math.guy.x == 100) then
		hasCollided = true
		canJump = true
		--end
		timer.performWithDelay(600, speedUp, 1)
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
					
					--If isPoweredUp, updateScore twice
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
	if (shouldEnd) then
		endGame()
		end
		elseif ( event.phase == "ended" ) then  

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





function scene:create( event )
	
	local sceneGroup = self.view
	publisherID = "pub-8667480018293512"
	bannerAppID = "ca-app-pub-8667480018293512/2536023388"
	ads.init("admob", "pub-8667480018293512", adListener)
	timers = {}
	physics.setGravity( 0, 17.5)
	score1.init()
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
	red = display.newCircle(display.contentWidth/6, display.contentHeight * .87, 25 )
	red:setFillColor(225/255, 105/225, 97/225)
	blue = display.newCircle(display.contentWidth/ 2, display.contentHeight * .87, 25 )
	blue:setFillColor(119/255,158/255,203/255)
	green = display.newCircle((display.contentWidth * 5)/6, display.contentHeight * .87, 25 )
	green:setFillColor(119/255,190/255,119/255)
	--guy = display.newCircle( 100, 150, 25 )
	--guy:setFillColor( math.random(0,255)/255,math.random(0,255)/255,math.random(0,255)/255)
	physics.addBody(guy, {density=1, friction=0, bounce=0 , radius = 25 } );
	guy.isSleepingAllowed = false

	if (settings.shouldPlayMusic) then
		backgroundMusic = audio.loadSound("CoronaMusicNew1.mp3")
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



function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	if ( phase == "will" ) then
		if (settings.shouldPlayMusic ) then
			playBackgroundMusic = audio.play(backgroundMusic, {loops = -1, fadein = 500, fadeout = 500, channel = 1})
		end
		ads.show( "banner", { x=0, y=-10000, appId = bannerAppID } )
	guy.x = 100
	guy.y = 75
	startingBlock.x = 0
	block.x = 700
	block2.x = 950
	block3.x = 1200
	block4.x = 1450

	isPoweredUp = false 
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

	powerUp = display.newRect( math.random(1500, 2200), block.y - 125, 50, 50 )
				physics.addBody( powerUp, "dynamic" , {density=0, friction=0, bounce=0 } )
				powerUp.gravityScale = 0
				powerUp:setFillColor( gradient )
				powerUp.myName = "powerUp"
				powerUp.isSensor = true
				sceneGroup:insert( powerUp )

spawnPowerUp(); 
red:addEventListener( "touch", touchHandler)
blue:addEventListener( "touch", touchHandler)
green:addEventListener("touch" , touchHandler) 
guy:addEventListener( "collision",  onCollision)
powerUp:addEventListener("touch", handleSwipe)

	Runtime:addEventListener("enterFrame", isAlive)
	Runtime:addEventListener( "enterFrame", pUpGo );
	Runtime:addEventListener("enterFrame", go)
	Runtime:addEventListener("enterFrame", go2)
	Runtime:addEventListener("enterFrame",  go3)
	Runtime:addEventListener("enterFrame", go4)
	Runtime:addEventListener("enterFrame", startBlockGo)
	Runtime:addEventListener("enterFrame", playerGo)
	Runtime:addEventListener("enterFrame", ballRotate)

	
	
	elseif ( phase == "did" ) then
		composer.removeHidden()



			
		
	end
end

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

function scene:hide( event )
	
	local phase = event.phase
	if (phase ==  "will") then 
		--local sceneGroup = self.view
		--sceneGroup:removeSelf()
--[		local sceneGroup = self.view
		ads.hide()
		if (startingBlock ~= nil) then
			Runtime:removeEventListener("enterFrame", startBlockGo)
		end
		Runtime:removeEventListener("enterFrame", isAlive)
		Runtime:removeEventListener("enterFrame", playerGo)
		Runtime:removeEventListener("enterFrame", go)
		Runtime:removeEventListener("enterFrame", go2)
		Runtime:removeEventListener("enterFrame", go3)
		Runtime:removeEventListener("enterFrame", go4)
		Runtime:removeEventListener("enterFrame", pUpGo); 
		Runtime:removeEventListener("enterFrame", ballRotate); 

		if (timers[0] ~= nil) then 
			timer.cancel(timers[0])
		end
		--composer.removeScene( "scene1" )
		--if (settings.shouldPlayMusic) then 
			audio.stop(playBackgroundMusic)
			playBackgroundMusic = nil 
		--end
		
		--audio.dispose(backgroundMusic)
		--backgroundMusic = nil
		--sceneGroup:removeSelf()
		--sceneGroup = nil
	elseif ( phase == "did" ) then
   	     -- Called immediately after scene goes off screen.
   	     physics.stop()
   	end
end
	--composer.removeScene("scene1")

scene:addEventListener( "create", scene)
scene:addEventListener( "hide", scene )	
scene:addEventListener( "show", scene)
scene:addEventListener("destroy", scene)


return scene