local composer = require( "composer" )
local scene = composer.newScene()
composer.purgeOnSceneChange = true
local physics = require( "physics")
physics.start(nosleep);
local scoreBox
local block
local block2
local block3
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
local gc 
local score
local speed
local holding 
local jumpSpeed
local rLength
			--[[	local gradient = graphics.newGradient(
					{ 1, 0, 0 },
					{ 0, 0, 1 },
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

local function checkMemory()
	collectgarbage( "collect" )
	local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
	print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
end
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

						local function isAlive( event )
							if (guy.y > display.contentHeight) then


								composer.gotoScene("scene2", options)
							end
						end


								--[[		local function movepup (event)
											powerUp.y =  block.y -500
											guy:setLinearVelocity( 0  , guy.yVelocity )
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
										--]]


										local function playerGo(event)
											if holding then
												linearVelocityX, linearVelocityY = guy:getLinearVelocity()
												print(linearVelocityY)
												if linearVelocityY > -225 then
													guy:setLinearVelocity(0,jumpSpeed)
													jumpSpeed = jumpSpeed - 9
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


												local function go( event )
													block.x = block.x - speed
													if (block.x < -200) then
														block.x = 600
														b1c = math.random(1,3)
														if (b1c == 1) then
															block:setFillColor(.7,0,0 )
															elseif (b1c == 2) then
																block:setFillColor( 0,0,.7 )

																elseif (b1c == 3) then
																	block:setFillColor( 0,.7,0 )
																end
															end
														end



														local function touchHandler( event )
															if canJump then
																if event.phase == "began" then
																	display.getCurrentStage():setFocus( event.target )
																	event.target.isFocus = true
																	Runtime:addEventListener( "enterFrame", playerGo)
																	jumpSpeed = -125
																	holding = true
																	changeColor(event)
																	elseif event.target.isFocus then
																		if event.phase == "moved" then
																			elseif event.phase == "ended" then
																			holding = false
																			jumpSpeed = -125
																			firsttouch = true
																			canJump = false
																			--Runtime:removeEventListener( "enterFrame", playerGo)
																			display.getCurrentStage():setFocus( nil )
																			event.target.isFocus = false
																		end
																	end
																	return true
																end
															end

															local function raiseSpeed(newScore)
																if (newScore > 5) then
																	speed = speed + 2/ newScore
																	print(speed)
																end
															end
															function updateScore()
																score = score + 1
																scoreBox.text = score
																raiseSpeed(score)
															end


															local function go2( event )
																block2.x = block2.x - speed  
																if (block2.x < -200) then
																	block2.x = 600
																	b2c = math.random(1,2)
																	if (b2c == 1) then
																		block2:setFillColor(.7,0,0 )
																		elseif (b2c == 2) then
																			block2:setFillColor( 0,0,.7 )
																		end
																	end
																end
																local function go3( event )
																	block3.x = block3.x - speed  
																	if (block3.x < -200) then
																		block3.x = 600
																		b3c = math.random(1,3)
																		if (b3c == 1) then
																			block3:setFillColor(.7,0,0 )
																			elseif (b3c == 2) then
																				block3:setFillColor( 0,0,.7 )
																				elseif (b3c == 3) then
																					block3:setFillColor( 0,.7, 0 )
																				end
																			end
																		end

																		function afterTimer()
																			t[i]:removeSelf( )
																		end


																		local function explode (event)
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
																			if ( event.phase == "began" ) then
																				if (event.other.myName == "powerUp") then
																					rainbow()
																					Runtime:removeEventListener( "enterFrame", pUpGo )
																					powerUp:removeSelf( )
																				end

																				canJump = true
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
																							composer.gotoScene("scene2", options)
																						end

																						elseif (event.other.myName == "block2") then
																							if (b2c == gc) then
																								timer.performWithDelay(10, explode, 15)
																								i = 1
																								updateScore()
																								firsttouch = false	
																							else 
																								composer.gotoScene("scene2", options)
																							end
																							elseif (event.other.myName == "block3") then
																								if (b3c == gc) then
																									timer.performWithDelay(10, explode, 15)
																									i = 1
																									updateScore()
																									firsttouch = false	
																								else 
																									composer.gotoScene("scene2", options)
																								end
																							end
																						end




																						elseif ( event.phase == "ended" ) then  
																					end
																				end

																				local function colorTouch(event)
																					if (event.phase == "began") then 
																						if (canJump) then
																							canJump = false
																							firsttouch = true
																							guy:setLinearVelocity( 0, -250 )
																							changeColor(event);
																						end
																					end
																					return true;
																				end




																				function scene:create( event )
																					local sceneGroup = self.view
																					physics.setGravity( 0, 17.5)
																					print("creating scene")

																					scoreBox = display.newText(0, 450,50, "Helvetica", 36)
																					block = display.newRect(100 , display.contentHeight - 100, 200, 50 )
																					block.myName ="block"
																					block:setFillColor(math.random(0,255)/255,math.random(0,255)/255,math.random(0,255)/255)
																					physics.addBody(block, "static", {density = 1, friction = 0, bounce = 0});
																					block2 = display.newRect(400 , display.contentHeight - 100, 200, 50 )
																					block2:setFillColor(math.random(0,255)/255,math.random(0,255)/255,math.random(0,255)/255)
																					physics.addBody(block2, "static", {density = 1, friction = 0, bounce = 0});
																					block2.myName= "block2"
																					block3 = display.newRect(-100 , display.contentHeight - 100, 200, 50 )
																					block3:setFillColor(math.random(0,255)/255,math.random(0,255)/255,math.random(0,255)/255)
																					physics.addBody(block3, "static", {density = 1, friction = 0, bounce = 0});
																					block3.myName= "block3" 
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
																					backgroundMusic = audio.loadSound("colorBallMusicCorona.mp3")		

																					sceneGroup:insert( scoreBox )
																					sceneGroup:insert( block )
																					sceneGroup:insert( block2 )
																					sceneGroup:insert( block3 )
																					sceneGroup:insert( red )
																					sceneGroup:insert( blue )
																					sceneGroup:insert( green )
																					sceneGroup:insert( guy )



																				end



																				function scene:show( event )
																					local sceneGroup = self.view
																					local phase = event.phase
																					if ( phase == "will" ) then
																						playBackgroundMusic = audio.play(backgroundMusic, {loops = -1, fadein = 500, fadeout = 500, channel = 1})
																						guy.x = 100;
																						guy.y = 150;

																						block.x = 100;

																						block2.x = 400;

																						block3.x = -100;

																						canJump = false
																						b1c = 1
																						b2c = 1
																						b3c = 1
																						gc = 1
																						score = 0
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
									Runtime:addEventListener("enterFrame", playerGo)
									
									
									elseif ( phase == "did" ) then


										print("entering scene")




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
									audio.dispose(backgroundMusic)
									backgroundMusic = nil
									sceneGroup:removeSelf()
									sceneGroup = nil



								end

								function scene:hide( event )
									print("exiting")
									local phase = event.phase
									if (phase ==  "will") then 
										local sceneGroup = self.view
																				--sceneGroup:removeSelf()
																				Runtime:removeEventListener("enterFrame", isAlive)
																			--	Runtime:addEventListener( "enterFrame", pUpGo );
																			Runtime:removeEventListener("enterFrame", go)
																			Runtime:removeEventListener("enterFrame", go2)
																			Runtime:removeEventListener("enterFrame",  go3)
																			Runtime:removeEventListener("enterFrame", playerGo)
																			audio.stop(playBackgroundMusic)
																			playBackgroundMusic = nil;

																		end
																			--composer.removeScene("scene1")
																			
																		end

																		scene:addEventListener( "create", scene)
																		scene:addEventListener( "hide", scene )	
																		scene:addEventListener( "show", scene)
																		scene:addEventListener("destroy", scene)


																		return scene