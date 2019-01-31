local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	local screenW = display.contentWidth
	local screenH = display.contentHeight
	local actualHeight = display.actualContentHeight
	local widget = require( "widget" )
	local highscores = require("highscores")
	local spaceship1 = event.params.spaceship1
	local spaceship2 = event.params.spaceship2
	local spaceship3 = event.params.spaceship3
	local spaceship4 = event.params.spaceship4
	local totalCoins = highscores.getCoins()
	local spaceship = event.params.spaceship
	local a = {}

	local backb = display.newImage("back.png")
	backb.x = 55
	backb.y = -(screenH - actualHeight)/2 + 440
	backb.xScale = 0.4
	backb.yScale = 0.4

	local coinBack = display.newImage("coinTile.png")
	coinBack.x = 240
	coinBack.y =  -(screenH - actualHeight)/2 + 465

	local coins = display.newText( "", coinBack.x+15 , coinBack.y , "Future Now", 30 )
	coins.text = totalCoins

	local function backBalpha()
		backb.alpha = 1
		end

	local function tapBackb()
		playPress()
		backb.alpha = 0.3 
		if sp.isLocked == false then 
			transition.to(sp,{delay=200,time=300,alpha=1,onComplete=backBalpha})
		elseif sp.isLocked == true then 
			transition.to(sp,{delay=200,time=300,alpha=0.5,onComplete=backBalpha})
		end		
		composer.gotoScene( "menu","fade",200 )
		return true
	end
	backb:addEventListener("tap",tapBackb)

	local scrollView = widget.newScrollView(
	    {
	        top = -(actualHeight - screenH)/2 ,
	        left = 0,
	        width = screenW,
	        horizontalScrollDisabled = true,
	        height = -(screenH - actualHeight)/2 + screenH + 70,
	        scrollWidth = 600,
	        scrollHeight = 800,
	        hideBackground = true
	    }
	)

	a.achiev1Group = display.newGroup()
	a.achiev2Group = display.newGroup()
	a.achiev3Group = display.newGroup()
	a.achiev4Group = display.newGroup()
	a.achiev5Group = display.newGroup()
	a.achiev6Group = display.newGroup()
	a.achiev7Group = display.newGroup()
	a.achiev8Group = display.newGroup()
	a.achiev9Group = display.newGroup()
	a.achiev10Group = display.newGroup()
	a.achiev11Group = display.newGroup()
	a.achiev12Group = display.newGroup()

	a.achiev1Var = highscores.getAchiev1()
	a.achiev2Var = highscores.getAchiev2()
	a.achiev3Var = highscores.getAchiev3()
	a.achiev4Var = highscores.getAchiev4()
	a.achiev5Var = highscores.getAchiev5()
	a.achiev6Var = highscores.getAchiev6()
	a.achiev7Var = highscores.getAchiev7()
	a.achiev8Var = highscores.getAchiev8()
	a.achiev9Var = highscores.getAchiev9()
	a.achiev10Var = highscores.getAchiev10()
	a.achiev11Var = highscores.getAchiev11()
	a.achiev12Var = highscores.getAchiev12()
	a.achiev13Var = highscores.getAchiev13()

	a.checkAchiev1 = highscores.getCheck1()
	a.checkAchiev2 = highscores.getCheck2()
	a.checkAchiev3 = highscores.getCheck3()
	a.checkAchiev4 = highscores.getCheck4()
	a.checkAchiev5 = highscores.getCheck5()

	a.check1 = display.newImage("check1.png")
	a.check1.x = screenW/2
	a.check1.y = 805
	a.check1.isVisible = false 

	a.check2 = display.newImage("check1.png")
	a.check2.x = screenW/2
	a.check2.y = 910
	a.check2.isVisible = false 

	a.check3 = display.newImage("check1.png")
	a.check3.x = screenW/2
	a.check3.y = 1015
	a.check3.isVisible = false 

	a.check4 = display.newImage("check1.png")
	a.check4.x = screenW/2
	a.check4.y = 1120
	a.check4.isVisible = false 

	a.check5 = display.newImage("check1.png")
	a.check5.x = screenW/2
	a.check5.y = 1225
	a.check5.isVisible = false 



	-----ACHIEVEMENTS------------------------------------------------------------------------------


	a.achiev1 = display.newImage("achievments/achiev4.png")
	a.achiev1.x = screenW/2
	a.achiev1.y = 70
	a.achiev1Text = display.newText( "Lil Stinger", screenW/2 + 40, 40, "stark", 35 )
	a.achiev1Text2 = display.newText( "Get to score 500 without\nshooting in a single game", screenW/2 + 40, 80, "stark", 15 )
	a.achiev1Group:insert(a.achiev1)
	a.achiev1Group:insert(a.achiev1Text)
	a.achiev1Group:insert(a.achiev1Text2)


	a.achiev2 = display.newImage("achievments/achiev6.png")
	a.achiev2.x = screenW/2
	a.achiev2.y = 175
	a.achiev2Text = display.newText( "Lil Slugger", screenW/2 + 40, 72*2, "stark", 35 )
	a.achiev2Text2 = display.newText( "Destroy 4 big astroids\nin a single game", screenW/2 + 35, 90*2, "stark", 15 )
	a.achiev2Group:insert(a.achiev2)
	a.achiev2Group:insert(a.achiev2Text)
	a.achiev2Group:insert(a.achiev2Text2)

	a.achiev3 = display.newImage("achievments/achiev3.png")
	a.achiev3.x = screenW/2
	a.achiev3.y = 280
	a.achiev3Text = display.newText( "Big Slugger", screenW/2 + 40, 83*3, "stark", 35 )
	a.achiev3Text2 = display.newText( "Destroy 8 big astroids\nin a single game", screenW/2 + 35, 95*3, "stark", 15 )
	a.achiev3Group:insert(a.achiev3)
	a.achiev3Group:insert(a.achiev3Text)
	a.achiev3Group:insert(a.achiev3Text2)

	a.achiev4 = display.newImage("achievments/achiev7.png")
	a.achiev4.x = screenW/2
	a.achiev4.y = 385
	a.achiev4Text = display.newText( "The Turreter", screenW/2 + 47, 89*4, "stark", 35 )
	a.achiev4Text2 = display.newText( "Destroy 100 small astroids\nin a single game", screenW/2 + 43, 98*4, "stark", 15 )
	a.achiev4Group:insert(a.achiev4)
	a.achiev4Group:insert(a.achiev4Text)
	a.achiev4Group:insert(a.achiev4Text2)

	a.achiev5 = display.newImage("achievments/achiev8.png")
	a.achiev5.x = screenW/2
	a.achiev5.y = 490
	a.achiev5Text = display.newText( "The Wingmaster", screenW/2 + 47, 92*5, "stark", 32 )
	a.achiev5Text2 = display.newText( "Get to score 1000 without\nshooting in a single game", screenW/2 + 38, 99*5, "stark", 15 )
	a.achiev5Group:insert(a.achiev5)
	a.achiev5Group:insert(a.achiev5Text)
	a.achiev5Group:insert(a.achiev5Text2)

	a.achiev6 = display.newImage("achievments/achiev9.png")
	a.achiev6.x = screenW/2
	a.achiev6.y = 595
	a.achiev6Text = display.newText( "Michael-Angelo", screenW/2 + 47, 94*6, "stark", 32 )
	a.achiev6Text2 = display.newText( "Get to score 5000 in a\nsingle game", screenW/2 + 28, 100*6, "stark", 15 )
	a.achiev6Group:insert(a.achiev6)
	a.achiev6Group:insert(a.achiev6Text)
	a.achiev6Group:insert(a.achiev6Text2)

	a.achiev7 = display.newImage("achievments/achiev5.png")
	a.achiev7.x = screenW/2
	a.achiev7.y = 700
	a.achiev7Text = display.newText( "The Alternator", screenW/2 + 47, 95.5*7, "stark", 32 )
	a.achiev7Text2 = display.newText( "Destroy the Mega Astroid", screenW/2 + 35, 100*7, "stark", 15 )
	a.achiev7Group:insert(a.achiev7)
	a.achiev7Group:insert(a.achiev7Text)
	a.achiev7Group:insert(a.achiev7Text2)

	a.achiev8 = display.newImage("achievments/coinAchiev.png")
	a.achiev8.x = screenW/2
	a.achiev8.y = 805
	a.achiev8Text = display.newText( "Coin Collector", screenW/2 + 47, 96.5*8, "stark", 32 )
	a.achiev8Text2 = display.newText( "Collect 100 coins\nin one game", screenW/2 + 10, 100.7*8, "stark", 15 )
	a.achiev8Group:insert(a.achiev8)
	a.achiev8Group:insert(a.achiev8Text)
	a.achiev8Group:insert(a.achiev8Text2)

	a.achiev9 = display.newImage("achievments/achievScore1.png")
	a.achiev9.x = screenW/2
	a.achiev9.y = 910
	a.achiev9Text = display.newText( "Cosmonaut Tier1", screenW/2 + 47, 97.4*9, "stark", 32 )
	a.achiev9Text2 = display.newText( "Get to score 2000\nin one game", screenW/2 + 10, 101.5*9, "stark", 15 )
	a.achiev9Group:insert(a.achiev9)
	a.achiev9Group:insert(a.achiev9Text)
	a.achiev9Group:insert(a.achiev9Text2)

	a.achiev10 = display.newImage("achievments/achievScore3.png")
	a.achiev10.x = screenW/2
	a.achiev10.y = 1015
	a.achiev10Text = display.newText( "Cosmonaut Tier2", screenW/2 + 47, 98*10, "stark", 32 )
	a.achiev10Text2 = display.newText( "Get to score 4000\nin one game", screenW/2 + 10, 101.5*10, "stark", 15 )
	a.achiev10Group:insert(a.achiev10)
	a.achiev10Group:insert(a.achiev10Text)
	a.achiev10Group:insert(a.achiev10Text2)

	a.achiev11 = display.newImage("achievments/achievScore2.png")
	a.achiev11.x = screenW/2
	a.achiev11.y = 1120
	a.achiev11Text = display.newText( "Cosmonaut Tier3", screenW/2 + 47, 98.7*11, "stark", 32 )
	a.achiev11Text2 = display.newText( "Get to score 7000\nin one game", screenW/2 + 10, 101.5*11, "stark", 15 )
	a.achiev11Group:insert(a.achiev11)
	a.achiev11Group:insert(a.achiev11Text)
	a.achiev11Group:insert(a.achiev11Text2)

	a.achiev12 = display.newImage("achievments/achiev.png")
	a.achiev12.x = screenW/2
	a.achiev12.y = 1225
	a.achiev12Text = display.newText( "Star Destroyer", screenW/2 + 47, 99.5*12, "stark", 32 )
	a.achiev12Text2 = display.newText( "Destroy 6 big astroids\nin one game", screenW/2 + 20, 102.3*12, "stark", 15 )
	a.achiev12Group:insert(a.achiev12)
	a.achiev12Group:insert(a.achiev12Text)
	a.achiev12Group:insert(a.achiev12Text2)

	a.blahtext = display.newText( "00000000000000", screenW/2, 75, "stark", 15 )
	a.blahtext:setFillColor(0,0,0)
	scrollView:insert(a.blahtext)


	-----------------------------------------------------------------------------------
	local coin = 0

	local function tapAchiev(event)
		if event.target == a.achiev8 and a.achiev9Var == true and a.check1.isVisible == true then
			highscores.check1()
			a.achiev8Group.alpha = 0.3
			a.check1.isVisible = false
			timer.performWithDelay(5,function() coin = coin + 10 coins.text = totalCoins + coin end,100)
	 		highscores.addCoins(1000)  highscores.saveHighscore(amount)
	 	elseif event.target == a.achiev9 and a.achiev10Var == true and a.check2.isVisible == true then 
	 		highscores.check2()
	 		a.achiev9Group.alpha = 0.3
			a.check2.isVisible = false
			timer.performWithDelay(5,function() coin = coin + 10 coins.text = totalCoins + coin end,50)
	 		highscores.addCoins(500)  highscores.saveHighscore(amount)
	 	 elseif event.target == a.achiev10 and a.achiev11Var == true and a.check3.isVisible == true then 
	 	 	highscores.check3()
	 		a.achiev10Group.alpha = 0.3
			a.check3.isVisible = false
			timer.performWithDelay(5,function() coin = coin + 10 coins.text = totalCoins + coin end,100)
	 		highscores.addCoins(1000)  highscores.saveHighscore(amount)
	 	elseif event.target == a.achiev11 and a.achiev12Var == true and a.check4.isVisible == true then 
	 		highscores.check4()
	 		a.achiev11Group.alpha = 0.3
			a.check4.isVisible = false
			timer.performWithDelay(5,function() coin = coin + 10 coins.text = totalCoins + coin end,200)
	 		highscores.addCoins(2000)  highscores.saveHighscore(amount)
	 	 elseif event.target == a.achiev12 and a.achiev13Var == true and a.check5.isVisible == true then 
	 	 	highscores.check5()
	 		a.achiev12Group.alpha = 0.3
			a.check5.isVisible = false
			timer.performWithDelay(5,function() coin = coin + 10 coins.text = totalCoins + coin end,100)
	 		highscores.addCoins(1000)  highscores.saveHighscore(amount)
		end
	end
	a.achiev8:addEventListener("tap",tapAchiev)
	a.achiev9:addEventListener("tap",tapAchiev)
	a.achiev10:addEventListener("tap",tapAchiev)
	a.achiev11:addEventListener("tap",tapAchiev)
	a.achiev12:addEventListener("tap",tapAchiev)


	scrollView:insert( a.achiev1Group )
	scrollView:insert( a.achiev2Group )
	scrollView:insert( a.achiev3Group )
	scrollView:insert( a.achiev4Group )
	scrollView:insert( a.achiev5Group )
	scrollView:insert( a.achiev6Group )
	scrollView:insert( a.achiev7Group )
	scrollView:insert( a.achiev8Group )
	scrollView:insert( a.achiev9Group )
	scrollView:insert( a.achiev10Group )
	scrollView:insert( a.achiev11Group )
	scrollView:insert( a.achiev12Group )
	scrollView:insert(a.check1)
	scrollView:insert(a.check2)
	scrollView:insert(a.check3)
	scrollView:insert(a.check4)
	scrollView:insert(a.check5)


	sceneGroup:insert(scrollView)
	sceneGroup:insert(backb)
	sceneGroup:insert(coinBack)
	sceneGroup:insert(coins)


	local function doAchiev()
	if a.achiev2Var == true then 
		a.achiev1Group.alpha = 0.3
	end
	if a.achiev3Var == true then 
		a.achiev2Group.alpha = 0.3
	end
	if a.achiev4Var == true then 
		a.achiev3Group.alpha = 0.3
	end
	if a.achiev5Var == true then 
		a.achiev4Group.alpha = 0.3
	end
	if a.achiev6Var == true then 
		a.achiev5Group.alpha = 0.3
	end
	if a.achiev7Var == true then 
		a.achiev6Group.alpha = 0.3
	end
	if a.achiev8Var == true  then 
		a.achiev7Group.alpha = 0.3
	end
	if a.achiev9Var == true and a.checkAchiev1 == false  then 
		a.check1.isVisible = true 
	end
	if a.achiev10Var == true and a.checkAchiev2 == false  then 
		a.check2.isVisible = true 
	end
	if a.achiev11Var == true and a.checkAchiev3 == false then 
		a.check3.isVisible = true
	end
	if a.achiev12Var == true and a.checkAchiev4 == false then
		a.check4.isVisible = true 
	end
	if a.achiev13Var == true and a.checkAchiev5 == false then
		a.check5.isVisible = true 
	end
	if a.achiev9Var == true and a.checkAchiev1 == true then 
		a.achiev8Group.alpha = 0.3
	end
	if a.achiev10Var == true and a.checkAchiev2 == true  then 
		a.achiev9Group.alpha = 0.3
	end
	if a.achiev11Var == true and a.checkAchiev3 == true  then 
		a.achiev10Group.alpha = 0.3
	end
	if a.achiev12Var == true and a.checkAchiev4 == true then 
		a.achiev11Group.alpha = 0.3
	end
	if a.achiev13Var == true and a.checkAchiev5 == true then
		a.achiev12Group.alpha = 0.3
		end
	end
	doAchiev()




end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	
	local phase = event.phase
	
	if event.phase == "will" then
	updateTotalCoins()
	composer.removeScene( "achievements",false)

		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)

	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
	
end

function scene:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view

end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene