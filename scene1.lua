local composer = require( "composer" )
local scene = composer.newScene()
composer.removeOnSceneChange = true
local physics = require( "physics")
local ads = require("ads")
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

			--[[	local gradient = graphics.newGradient(
					{ 1, 0, 0 },
					{ 0, 0, 1 c},
					"down" ) --]]
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
--timer.performWithDelay( 1000, checkMemory, 0 )




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
		print (i.. "index isss")
		if i == 1 then 
			print("goinggggg")
			--native.cancelAlert(mAlert)
			composer.gotoScene("scene2", options)
		end
	end
end

local function endGame() 
	--Runtime:removeEventListener("enterFrame", isAlive)
	print ("end game called")
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
	--print ("isAlive called")
	if (guy.y > display.contentHeight or guy.x < -25) then
		endGame()
	end
end

local function movepup (event)
		powerUp.y =  block.y -500
		guy:setLinearVelocity( 0  , guy.y < Velocity )
	end

	local function spawnPowerUp (event)
		pUpRandom = math.random(1,5)
		if (pUpRandom  == 1 ) then
			if (canSpawn == 1) then
				canSpawn = 0
				powerUp.x = 700
				powerUp.y =  block.y -50
			end
		end
	end

	local function pUpGo (event)
		powerUp.x = powerUp.x - 5 
		if (powerUp.x < -500) then
			canSpawn = 1
		end

	end

local function playerGo(event)
	if holding then
		linearVelocityX, linearVelocityY = guy:getLinearVelocity()
		--print("linearVelocityX = " .. linearVelocityX)
		--print("linearVelocityY = " .. linearVelocityY)
		if linearVelocityY > -200 then
			guy:setLinearVelocity(0,jumpSpeed)
			jumpSpeed = jumpSpeed - 12
		else
			holding = false
		end
	end
end

local function changeColor(event)
	local tapSound
	local playTapSound
	print(event.myName)

	if (event.target == red) then
		gc = 1
		guy:setFillColor(.8,0,0)
		bcolor[0] = .8
		bcolor[1] = 0
		bcolor[2] = 0
		tapSound = audio.loadSound("tapRed.mp3" )

		elseif (event.target == green) then
			gc = 3
			guy:setFillColor(0,.8,0)
			bcolor[0] = 0
			bcolor[1] = .8
			bcolor[2] = 0
			tapSound = audio.loadSound("tapGreen.mp3" )
		
		elseif (event.target == blue) then
				gc = 2
				guy:setFillColor(0,0,0.8)
				bcolor[0] = 0
				bcolor[1] = 0
				bcolor[2] = .8
				tapSound = audio.loadSound("tapBlue.mp3")
		end

			--playTapSound = audio.play(tapSound)
			audio.dispose(tapSound)
			playtapSound = nil
			tapSound = nil
	end

local function setBlockColor(block)
		randomNumber = math.random(1,3)

		if (randomNumber == 1) then
			block:setFillColor(.7,0,0 )

		elseif (randomNumber == 2) then
			block:setFillColor( 0,0,.7 )

		elseif (randomNumber == 3) then
			block:setFillColor( 0,.7,0 )
		end
	return randomNumber;

end

local function go( event )
	
	block.x = block.x - (speed/2)
	if (block.x < -200) then
		print("block 4")
		print(block4.x)
		block.x = block4.x + math.random(115 + 20* speed, 185 + 21* speed)
		if (score > 20) then
			block.y = display.contentHeight - 100 - math.random(0, 35 + ((3/2) * speed))
		end
		b1c = setBlockColor(block)
	end
end

local function touchHandler( event )
	print("touchHandler")
	print(holding)
	print(canJump)
	print(hasCollided)
	
		if event.phase == "began" then
			if (canJump and hasCollided and guy.y < blockGuyY + 4) then

			display.getCurrentStage():setFocus( event.target )
			event.target.isFocus = true
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
		print("hello")
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
			print(speed)
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


local function onCollision( event )
	local shouldEnd = false
	blockGuyY = guy.y
	if ( event.phase == "began" ) then
		if (event.other.myName == "powerUp") then
			rainbow()
			Runtime:removeEventListener( "enterFrame", pUpGo )
			powerUp:removeSelf()
		end
		--if (Math.guy.x == 100) then
		hasCollided = true
		canJump = true
		--end
		if (firsttouch) then
			ecolor[0] = bcolor[0]
			ecolor[1] = bcolor[1]
			ecolor[2] = bcolor[2]

			if (event.other.myName == "block") then
				if (b1c == gc) then
					timer.performWithDelay(10, explode, 15)
					i = 1
					updateScore()
					firsttouch = false	
				else 
					print("shouldEnd")
					shouldEnd = true
				end

			elseif (event.other.myName == "block2") then
				if (b2c == gc) then
					timer.performWithDelay(10, explode, 15)
					i = 1
					updateScore()
					firsttouch = false	
				
				else 
					print("shouldEnd")
					shouldEnd = true
				end
					
			elseif (event.other.myName == "block3") then
				if (b3c == gc) then
					timer.performWithDelay(10, explode, 15)
					i = 1
					updateScore()
					firsttouch = false	
				else 
					print("shouldEnd")
					shouldEnd = true
				end
			elseif (event.other.myName == "block4") then 
				if (b4c == gc) then 
					timer.performWithDelay(10, explode, 15)
					i = 1
					updateScore()
					firsttouch = false
				else 
					print ("shouldEnd")
					shouldEnd = true
				end
			end
		end
	print("ending")
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
	ads.init("admob", "pub-8667480018293512", adListener)
	physics.setGravity( 0, 17.5)
	print("creating scene")
	score1.init()
	scoreBox = display.newText(0, 450,50, "Helvetica", 36)
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
	red:setFillColor(.8, 0, 0)
	blue = display.newCircle(display.contentWidth/ 2, display.contentHeight * .87, 25 )
	blue:setFillColor(0, 0, .8)
	green = display.newCircle((display.contentWidth * 5)/6, display.contentHeight * .87, 25 )
	green:setFillColor(0, .8, 0)
	guy = display.newCircle( 100, 150, 25 )
	guy:setFillColor( math.random(0,255)/255,math.random(0,255)/255,math.random(0,255)/255)
	physics.addBody(guy, {density=1, friction=0, bounce=0 , radius = 25 } );
	guy.isSleepingAllowed = false

	if (settings.shouldPlayMusic) then 
		backgroundMusic = audio.loadSound("CoronaMusicNew1.mp3")		
	end


	startingBlock = display.newRoundedRect(0 , display.contentHeight - 100, 1000, 50,4)
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
		print("will show")
		if (settings.shouldPlayMusic ) then
			playBackgroundMusic = audio.play(backgroundMusic, {loops = -1, fadein = 500, fadeout = 500, channel = 1})
		end
		ads.show( "banner", { x=display.contentCenterX, y=0 } )
	guy.x = 100
	guy.y = 75
	startingBlock.x = 0
	block.x = 700
	block2.x = 950
	block3.x = 1200
	block4.x = 1450

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
red:addEventListener( "touch", touchHandler)
blue:addEventListener( "touch", touchHandler)
green:addEventListener("touch" , touchHandler) 
guy:addEventListener( "collision",  onCollision)

	Runtime:addEventListener("enterFrame", isAlive)
	--	Runtime:addEventListener( "enterFrame", pUpGo );
	Runtime:addEventListener("enterFrame", go)
	Runtime:addEventListener("enterFrame", go2)
	Runtime:addEventListener("enterFrame",  go3)
	Runtime:addEventListener("enterFrame", go4)
	Runtime:addEventListener("enterFrame", startBlockGo)
	Runtime:addEventListener("enterFrame", playerGo)

	
	
	elseif ( phase == "did" ) then


		print("entering scene")
		composer.removeHidden()



			--	powerUp = display.newRect( 1500, block.y - 50, 50, 50 )
			--	physics.addBody( powerUp, "static" , {density=0, friction=0, bounce=0 } )
		--		powerUp.gravityScale = 0
		--		powerUp:setFillColor( gradient )
			--	powerUp.myName = "powerUp"

			
		--		displayGroup:insert( powerUp )
		
	end
end

function scene:destroy( event )
	print("destroy")
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
	print("exiting")
	
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