-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
--------------------------------------------

local onGo

function scene:create( event )

	if audio.supportsSessionProperty == true then
    	audio.setSessionProperty(audio.MixMode, audio.AmbientMixMode)
  	end

	local physics = require "physics"
	local widget = require "widget"
	local highscores = require('highscores')
	local shop = require('shop')
	physics.start()
	local sceneGroup = self.view
	local st
	local screenW = display.contentWidth
	local screenH = display.contentHeight
	local amsize = 0
	local goPlay = true 
	local gameplay = {}
	local sc = {}
	local totalCoins = highscores.getCoins()
	local scores = highscores.getSaveData()
	local a = {}
	local cancelS = false 
	local pressAudio
	local soundIt = highscores.getSoundIt()
	local actualHeight = display.actualContentHeight

	a.achiev1var = highscores.getAchiev1()
	a.achiev2var = highscores.getAchiev2()
	a.achiev3var = highscores.getAchiev3()
	a.achiev4var = highscores.getAchiev4()
	a.achiev5var = highscores.getAchiev5()
	a.achiev6var = highscores.getAchiev6()
	a.achiev7var = highscores.getAchiev7()
	a.achiev8var = highscores.getAchiev8()
	a.achiev9var = highscores.getAchiev9()
	a.achiev10var = highscores.getAchiev10()
	a.achiev11var = highscores.getAchiev11()
	a.achiev12var = highscores.getAchiev12()
	a.achiev13var = highscores.getAchiev13()

	a.unlock1 = highscores.getUnlock1()
	a.unlock2 = highscores.getUnlock2()
	a.unlock3 = highscores.getUnlock3()
	a.unlock4 = highscores.getUnlock4()
	a.unlock5 = highscores.getUnlock5()
	a.unlock6 = highscores.getUnlock6()
	a.unlock7 = highscores.getUnlock7()
	a.unlock8 = highscores.getUnlock8()

	 sc.doubleDistanceT = 70
	 sc.doubleDistanceY = 40
	 sc.doubleDistanceX = 10
	 sc.oneDistanceT = 60
	 sc.oneDistanceY = 30


	function updateAchieves()
		a.achiev1var = highscores.getAchiev1()
		a.achiev2var = highscores.getAchiev2()
		a.achiev3var = highscores.getAchiev3()
		a.achiev4var = highscores.getAchiev4()
		a.achiev5var = highscores.getAchiev5()
		a.achiev6var = highscores.getAchiev6()
		a.achiev7var = highscores.getAchiev7()
		a.achiev8var = highscores.getAchiev8()
		a.achiev9var = highscores.getAchiev9()
		a.achiev10var = highscores.getAchiev10()
		a.achiev11var = highscores.getAchiev11()
		a.achiev12var = highscores.getAchiev12()
		a.achiev13var = highscores.getAchiev13()
	end


	goAnim = true
	spaceshipCollisionFilter = { categoryBits = 32, maskBits = 20 }

	local spaceship1 = display.newImage("sRevised copy.png")
	spaceship1.x = screenW/2
	spaceship1.y = 240
	spaceship1.xScale = 0.65
	spaceship1.yScale = 0.45
	spaceship1isPresent = true
	spaceship1.isLocked = false 

	local spaceship2 = display.newImage( "spaceship2.png")
	spaceship2.x = display.contentWidth/2
	spaceship2.y = 240
	spaceship2.xScale = 0.8
	spaceship2.yScale = 0.7
	spaceship2.isVisible = false
	spaceship2.isPresent = false

	local spaceship3 = display.newImage( "spaceship3.png")
	spaceship3.x = display.contentWidth/2
	spaceship3.y = 250
	spaceship3.xScale = 0.55
	spaceship3.yScale = 0.55
	spaceship3.isVisible = false
	spaceship3.isPresent = false

	local spaceship4 = display.newImage( "spaceship4.png")
	spaceship4.x = display.contentWidth/2 
	spaceship4.y = 240
	spaceship4.xScale = 0.55
	spaceship4.yScale = 0.55
	spaceship4.isVisible = false
	spaceship4.isPresent = false


	local spaceship5 = display.newImage( "spaceship5.png")
	spaceship5.x = display.contentWidth/2
	spaceship5.y = 240
	spaceship5.xScale = 0.57
	spaceship5.yScale = 0.57
	spaceship5.isVisible = false
	spaceship5.isPresent = false

	local spaceship6 = display.newImage( "spaceship7.png")
	spaceship6.x = display.contentWidth/2
	spaceship6.y = 240
	spaceship6.xScale = 0.45
	spaceship6.yScale = 0.45
	spaceship6.isVisible = false
	spaceship6.isPresent = false

	local spaceship7 = display.newImage( "spaceship6.png")
	spaceship7.x = display.contentWidth/2
	spaceship7.y = 240
	spaceship7.xScale = 0.75
	spaceship7.yScale = 0.75
	spaceship7.isVisible = false
	spaceship7.isPresent = false

	local spaceship8 = display.newImage( "spaceship9.png")
	spaceship8.x = screenW/2
	spaceship8.y = 240
	spaceship8.xScale = 1
	spaceship8.yScale = 1
	spaceship8.isVisible = false
	spaceship8.isPresent = false

	local coinIcon = display.newImage("coinStack.png")
	coinIcon.x = 210
	coinIcon.y = -(actualHeight - screenH)/2 + 17
	coinIcon.xScale = 1
	coinIcon.yScale = 1

	local totalCoins2 = display.newText( "", 270 , -(actualHeight - screenH)/2 + 17 , "Future Now", 30 )
	totalCoins2.text = totalCoins 
	sceneGroup:insert(totalCoins2)

	local price1 = display.newImage("price2000.png")
	price1.x = screenW/2 
	price1.y = screenH/2 + 60
	price1.xScale = 0.7
	price1.yScale = 0.7
	price1.isVisible = false 
	sceneGroup:insert(price1)


	local price2 = display.newImage("price5000.png")
	price2.x = screenW/2 
	price2.y = screenH/2 + 60
	price2.xScale = 0.7
	price2.yScale = 0.7
	price2.isVisible = false 
	sceneGroup:insert(price2)


	local price3 = display.newImage("price10000.png")
	price3.x = screenW/2 
	price3.y = screenH/2 + 60
	price3.xScale = 0.7
	price3.yScale = 0.7
	price3.isVisible = false 
	sceneGroup:insert(price3)


	local price4 = display.newImage("price1000.png")
	price4.x = screenW/2 
	price4.y = screenH/2 + 60
	price4.xScale = 0.7
	price4.yScale = 0.7
	price4.isVisible = false 
	sceneGroup:insert(price4)

	local lock = display.newImage("lock.png")
	lock.x = screenW/2 
	lock.y = screenH/2 
	lock.xScale = 0.7
	lock.yScale = 0.7
	lock.alpha = 0
	sceneGroup:insert(lock)

	local stars = display.newImage("option.png")
	stars.x = screenW/2 
	stars.y = screenH/2

	sp = spaceship1
	sc.oneGroup = true 


	local function insuff()
		local insuffText = display.newText( "Complete Achievment\n       to unlock ", screenW/2 , 200 , "Stark", 30 )
		insuffText:setFillColor(1,0,0)
		transition.to(insuffText,{time=3000,alpha=0,y=insuffText.y - 30,onComplete= 
		function() insuffText:removeSelf() insuffText = nil end})
		sceneGroup:insert(insuffText)
		return insuffText
	end
	

-----------------------------
	local spaceship = spaceship1
-----------------------------
	function updateTotalCoins()
		totalCoins = highscores.getCoins()
		totalCoins2.text = totalCoins 
	end
	updateTotalCoins()

	local left = display.newImage("arrow.png")
	left.x = 30
	left.y = display.contentHeight/2
	left.xScale = 0.1
	left.yScale = 0.05
	left.rotation = -90

	local right = display.newImage("arrow.png")
	right.x = 290
	right.y = display.contentHeight/2
	right.xScale = 0.1
	right.yScale = 0.05
	right.rotation = 90

	local starIcon =  display.newImageRect("starB2copy.png",65,60)
	starIcon.x = 50
	starIcon.y =  -(screenH - actualHeight)/2 + 407

	local achievIcon = display.newImageRect("achievB2copy.png",65,60)
	achievIcon.x = 120
	achievIcon.y =  -(screenH - actualHeight)/2 + 407

	local backgroundIcon = display.newImageRect("shopB2copy.png",65,60)
	backgroundIcon.x = 190
	backgroundIcon.y = -(screenH - actualHeight)/2 + 407

	local settingsIcon = display.newImageRect("settingsB2copy.png",65,60)
	settingsIcon.x = 260
	settingsIcon.y =  -(screenH - actualHeight)/2 + 407

	local damgBar = display.newRect(140,100,119,19) damgBar:setFillColor(0,0.7,1)
	damgBar.anchorX = 0
	damgBar.width = 25
	damgBar.alpha = 1

	local ammoBar = display.newRect(140,130,119,19) ammoBar:setFillColor(0,0.7,1)
	ammoBar.anchorX = 0
	ammoBar.width = 25
	ammoBar.alpha = 1

	local speedBar = display.newRect(140,160,119,19) speedBar:setFillColor(0,0.7,1)
	speedBar.anchorX = 0
	speedBar.width = 25
	speedBar.alpha = 1

	local stat1 = display.newImage("statBar.png") 
	local stat1text = display.newText( "Damg", 110, 100, "stark", 20 )
	stat1.x = 200
	stat1.y = 100
	stat1.xScale = 0.6
	stat1.yScale = 0.4


	local stat2 = display.newImage("statBar.png")
	local stat2text = display.newText( "Ammo", 110, 130, "stark", 20 )
	stat2.x = 200
	stat2.y = 130
	stat2.xScale = 0.6
	stat2.yScale = 0.4

	local stat3 = display.newImage("statBar.png")
	local stat3text = display.newText( "Speed", 110, 160, "stark", 20 )
	stat3.x = 200
	stat3.y = 160
	stat3.xScale = 0.6
	stat3.yScale = 0.4


	local sign1 = display.newImage("sign1.png")
	sign1.x = achievIcon.x
	sign1.y = achievIcon.y + 40
	sign1.xScale = 0.7
	sign1.yScale = 0.7
	sign1.alpha = 0
	sceneGroup:insert(sign1)

	local spaceshipName = display.newText( "", screenW/2 + 3, 190, "Future Now", 15 )
	spaceshipName.text = "The Inceptor"
	sceneGroup:insert(spaceshipName)

	local it = 20

	local function showSign1()
		transition.to(sign1,{time=500,alpha=1})
		transition.to(sign1,{time=600,y=-(screenH - actualHeight)/2 + 460,transition=easing.continuousLoop,iterations=it})
		transition.to(sign1,{delay=it*600,alpha=0})
		timer.performWithDelay(40000,showSign1,1)
	end
	timer.performWithDelay(4000,showSign1,1)

--------SPACESHIP CONFIGURATION----------------------------------------------------------

function sc.spaceshipDef()
	lock.alpha=0
	spaceship.alpha=1
	spaceship.isLocked = false
	goAnim = true
	price1.isVisible = false 
	price2.isVisible = false 
	price3.isVisible = false 
	price4.isVisible = false 
	spaceship.nonPlay = false 
end

function sc.spaceshipDef2()
	lock.alpha=1
	spaceship.alpha=0.5
	spaceship.isLocked = true
	goAnim = false
end

function sc.spaceship1Config()
	spaceshipName.text = "The Inceptor"
	sc.spaceshipDef()
	sc.oneGroup = true 
	goPlay = true 
	spaceship = spaceship1
	sp = spaceship1
	damgBar.width = 25
	ammoBar.width = 25
	speedBar.width = 25
	sc.oneDistanceT = 60
	sc.oneDistanceY = 30
end

function sc.spaceship2Config()
	spaceshipName.text = "The Turreter"
	sc.spaceshipDef()
	sc.oneGroup = false
	goPlay = true 
	spaceship = spaceship2
	sp = spaceship2
	damgBar.width = 72
	ammoBar.width = 47
	speedBar.width = 72
	sc.doubleDistanceT = 70
	sc.doubleDistanceY = 40
	sc.doubleDistanceX = 10
if a.achiev5var == false then 
	sc.spaceshipDef2()
	end
if a.unlock2 == false then 
	goAnim = false 
	price1.isVisible = false 
	price2.isVisible = true 
	price3.isVisible = false
	price4.isVisible = false  
	spaceship.nonPlay = true
	end
end

function sc.spaceship3Config()
	spaceshipName.text = "The Wingmaster"
	sc.spaceshipDef()
	sc.oneGroup = false
	goPlay = true 
	spaceship = spaceship3
	sp = spaceship3
	damgBar.width = 95
	ammoBar.width = 72
	speedBar.width = 25
	sc.doubleDistanceT = 70
	sc.doubleDistanceY = 30
	sc.doubleDistanceX = 16
if a.achiev6var == false then 
	sc.spaceshipDef2()
	end
if a.unlock3 == false then 
	goAnim = false 
	price1.isVisible = false 
	price2.isVisible = false 
	price3.isVisible = true 
	price4.isVisible = false 
	spaceship.nonPlay = true
	end
end

function sc.spaceship4Config()
	spaceshipName.text = "Big Slugger"
	sc.spaceshipDef()
	sc.oneGroup = true 
	goPlay = true 
	spaceship = spaceship4
	sp = spaceship4
	damgBar.width = 120
	ammoBar.width = 25
	speedBar.width = 47
	sc.oneDistanceT = 70
	sc.oneDistanceY = 40
if a.achiev4var == false then 
	sc.spaceshipDef2()
	end
if a.unlock4 == false then 
	goAnim = false 
	price1.isVisible = false 
	price2.isVisible = true 
	price3.isVisible = false 
	price4.isVisible = false 
	spaceship.nonPlay = true
	end
end


function sc.spaceship5Config()
	spaceshipName.text = "Lil Stinger"
	sc.spaceshipDef()
	sc.oneGroup = true 
	goPlay = true 
	spaceship = spaceship5
	sp = spaceship5
	damgBar.width = 25
	ammoBar.width = 25
	speedBar.width = 72
	sc.oneDistanceT = 50
	sc.oneDistanceY = 24
if a.achiev2var == false then 
	sc.spaceshipDef2()
	end
if a.unlock5 == false then 
	goAnim = false 
	price1.isVisible = false 
	price2.isVisible = false 
	price3.isVisible = false 
	price4.isVisible = true 
	spaceship.nonPlay = true
	end
end

function sc.spaceship6Config()
	spaceshipName.text = "Lil Slugger"
	sc.spaceshipDef()
	sc.oneGroup = true 
	goPlay = true 
	spaceship = spaceship6
	sp = spaceship6
	damgBar.width = 72
	ammoBar.width = 25
	speedBar.width = 25
	sc.oneDistanceT = 80
	sc.oneDistanceY = 35
if a.achiev3var == false then 
	sc.spaceshipDef2()
	end
if a.unlock6 == false then 
	goAnim = false 
	price1.isVisible = true 
	price2.isVisible = false 
	price3.isVisible = false 
	price4.isVisible = false 
	spaceship.nonPlay = true
	end
end

function sc.spaceship7Config()
	spaceshipName.text = "The Alternator"
	sc.spaceshipDef()
	sc.oneGroup = false 
	goPlay = true 
	spaceship = spaceship7
	sp = spaceship7
	damgBar.width = 96
	ammoBar.width = 72
	speedBar.width = 47
	sc.doubleDistanceT = 70
	sc.doubleDistanceY = 43
	sc.doubleDistanceX = 14
if a.achiev8var == false then 
	sc.spaceshipDef2()
	end
if a.unlock7 == false then
	goAnim = false  
	price1.isVisible = false 
	price2.isVisible = false 
	price4.isVisible = false 
	price3.isVisible = true 
	spaceship.nonPlay = true
	end
end

function sc.spaceship8Config()
	spaceshipName.text = "Michael-Angelo"
	sc.spaceshipDef()
	sc.oneGroup = false 
	goPlay = true 
	spaceship = spaceship8
	sp = spaceship8
	damgBar.width = 25
	ammoBar.width = 72
	speedBar.width = 47
	sc.doubleDistanceT = 70
	sc.doubleDistanceY = 43
	sc.doubleDistanceX = 10
if a.achiev7var == false then 
	sc.spaceshipDef2()
	end
if a.unlock8 == false then 
	goAnim = false 
	price1.isVisible = false 
	price2.isVisible = false 
	price4.isVisible = false 
	price3.isVisible = true 
	spaceship.nonPlay = true
	end
end
sc.spaceship8Config()
sc.spaceship7Config()
sc.spaceship6Config()
sc.spaceship5Config()
sc.spaceship4Config()
sc.spaceship3Config()
sc.spaceship2Config()
sc.spaceship1Config()


local function fiveUnlock()
	local unlockText = display.newText( "Unlocked!", screenW/2 , screenH/2 , "Future Now", 20 )
	transition.to(unlockText,{time=1000,xScale=3,yScale=3,alpha=0})
	timer.performWithDelay(5,function() totalCoins = totalCoins - 100 totalCoins2.text = totalCoins end,10)
	price4.isVisible = false
	highscores.addCoins(-1000) 
end

local function tenUnlock()
	local unlockText = display.newText( "Unlocked!", screenW/2 , screenH/2 , "Future Now", 20 )
	transition.to(unlockText,{time=1000,xScale=3,yScale=3,alpha=0})
	timer.performWithDelay(5,function() totalCoins = totalCoins - 100 totalCoins2.text = totalCoins end,20)
	price1.isVisible = false
	highscores.addCoins(-2000) 
end

local function twoFiveUnlock()
	local unlockText = display.newText( "Unlocked!", screenW/2 , screenH/2 , "Future Now", 20 )
	transition.to(unlockText,{time=1000,xScale=3,yScale=3,alpha=0})
	timer.performWithDelay(5,function() totalCoins = totalCoins - 100 totalCoins2.text = totalCoins end,50)
	price2.isVisible = false 
	highscores.addCoins(-5000) 
end


local function fiftyUnlock()
	local unlockText = display.newText( "Unlocked!", screenW/2 , screenH/2 , "Future Now", 20 )
	transition.to(unlockText,{time=1000,xScale=3,yScale=3,alpha=0})
	timer.performWithDelay(5,function() totalCoins = totalCoins - 100 totalCoins2.text = totalCoins end,100)
	price3.isVisible = false 
	highscores.addCoins(-10000) 
end


	local function tapSpaceship(event)
		if event.target == spaceship5 and spaceship.isLocked == false and totalCoins >= 2000 and spaceship.nonPlay == true then 
			fiveUnlock()
			spaceship.nonPlay = false
			goAnim = true
			a.unlock5 = true 
			highscores.unlock5()
		elseif event.target == spaceship6 and spaceship.isLocked == false and totalCoins >= 2000 and spaceship.nonPlay == true then 
			tenUnlock()
			spaceship.nonPlay = false
			goAnim = true
			a.unlock6 = true 
			highscores.unlock6()
		elseif event.target == spaceship4 and spaceship.isLocked == false and totalCoins >= 5000 and spaceship.nonPlay == true then 
			twoFiveUnlock()
			spaceship.nonPlay = false
			goAnim = true
			a.unlock4 = true 
			highscores.unlock4()
		elseif event.target == spaceship2 and spaceship.isLocked == false and totalCoins >= 5000 and spaceship.nonPlay == true then 
			twoFiveUnlock()
			spaceship.nonPlay = false
			goAnim = true
			a.unlock2 = true 
			highscores.unlock2()
		elseif event.target == spaceship3 and spaceship.isLocked == false and totalCoins >= 10000 and spaceship.nonPlay == true then 
			fiftyUnlock()
			spaceship.nonPlay = false
			goAnim = true
			a.unlock3 = true 
			highscores.unlock3()
		elseif event.target == spaceship8 and spaceship.isLocked == false and totalCoins >= 10000 and spaceship.nonPlay == true then 
			fiftyUnlock()
			spaceship.nonPlay = false
			goAnim = true
			a.unlock8 = true 
			highscores.unlock8()
		elseif event.target == spaceship7 and spaceship.isLocked == false and totalCoins >= 10000 and spaceship.nonPlay == true then 
			fiftyUnlock()
			spaceship.nonPlay = false
			goAnim = true
			a.unlock7 = true 
			highscores.unlock7()
		elseif spaceship.isLocked == true then 	
			insuff()
		end
	end
	spaceship1:addEventListener("tap",tapSpaceship)
	spaceship2:addEventListener("tap",tapSpaceship)
	spaceship3:addEventListener("tap",tapSpaceship)
	spaceship4:addEventListener("tap",tapSpaceship)
	spaceship5:addEventListener("tap",tapSpaceship)
	spaceship6:addEventListener("tap",tapSpaceship)
	spaceship7:addEventListener("tap",tapSpaceship)
	spaceship8:addEventListener("tap",tapSpaceship)



----------------------------------------------------------------------------------------

	local function tapRight()
		playPress()
		right.alpha = 0.5
		timer.performWithDelay(100, function() right.alpha=1 end, 1)
		if spaceship1.isVisible == true then 
			spaceship1.isVisible = false  
			spaceship1.isPresent = false  
			spaceship5.isVisible = true 
			spaceship5.isPresent = true
			sc.spaceship5Config()
		elseif spaceship5.isVisible == true then 
			spaceship5.isVisible = false  
			spaceship5.isPresent = false  
			spaceship6.isVisible = true 
			spaceship6.isPresent = true
			sc.spaceship6Config()
		elseif spaceship6.isVisible == true then 
			spaceship6.isVisible = false  
			spaceship6.isPresent = false  
			spaceship4.isVisible = true 
			spaceship4.isPresent = true
			sc.spaceship4Config()
		elseif spaceship4.isVisible == true then 
			spaceship4.isVisible = false  
			spaceship4.isPresent = false  
			spaceship2.isVisible = true 
			spaceship2.isPresent = true
			sc.spaceship2Config()
		elseif spaceship2.isVisible == true then 
			spaceship2.isVisible = false  
			spaceship2.isPresent = false  
			spaceship3.isVisible = true 
			spaceship3.isPresent = true
			sc.spaceship3Config()
		elseif spaceship3.isVisible == true then 
			spaceship3.isVisible = false  
			spaceship3.isPresent = false  
			spaceship8.isVisible = true 
			spaceship8.isPresent = true
			sc.spaceship8Config()
		elseif spaceship8.isVisible == true then 
			spaceship8.isVisible = false  
			spaceship8.isPresent = false  
			spaceship7.isVisible = true 
			spaceship7.isPresent = true
			sc.spaceship7Config()
		elseif spaceship7.isVisible == true then 
			spaceship7.isVisible = false  
			spaceship7.isPresent = false  
			spaceship1.isVisible = true 
			spaceship1.isPresent = true
			sc.spaceship1Config()
		end
	end
	right:addEventListener("tap",tapRight)

	local function tapLeft()
		playPress()
		left.alpha = 0.5
		timer.performWithDelay(100,function() left.alpha = 1 end,1)
		if 	spaceship1.isVisible == true then 
			spaceship1.isVisible = false 
			spaceship1.isPresent = false 
			spaceship7.isVisible = true 
			spaceship7.isPresent = true
			sc.spaceship7Config()
		elseif spaceship7.isVisible == true then 
			spaceship7.isVisible = false 
			spaceship7.isPresent = false
			spaceship8.isVisible = true  
			spaceship8.isPresent = true 
			sc.spaceship8Config()
		elseif spaceship8.isVisible == true then 
			spaceship8.isVisible = false  
			spaceship8.isPresent = false  
			spaceship3.isVisible = true 
			spaceship3.isPresent = true
			sc.spaceship3Config()
		elseif spaceship3.isVisible == true then 
			spaceship3.isVisible = false  
			spaceship3.isPresent = false  
			spaceship2.isVisible = true 
			spaceship2.isPresent = true
			sc.spaceship2Config()
		elseif spaceship2.isVisible == true then 
			spaceship2.isVisible = false  
			spaceship2.isPresent = false  
			spaceship4.isVisible = true 
			spaceship4.isPresent = true
			sc.spaceship4Config()
		elseif spaceship4.isVisible == true then 
			spaceship4.isVisible = false  
			spaceship4.isPresent = false  
			spaceship6.isVisible = true 
			spaceship6.isPresent = true
			sc.spaceship6Config()
		elseif spaceship6.isVisible == true then 
			spaceship6.isVisible = false  
			spaceship6.isPresent = false  
			spaceship5.isVisible = true 
			spaceship5.isPresent = true
			sc.spaceship5Config()
		elseif spaceship5.isVisible == true then 
			spaceship5.isVisible = false  
			spaceship5.isPresent = false  
			spaceship1.isVisible = true 
			spaceship1.isPresent = true
			sc.spaceship1Config()
		end
	end
	left:addEventListener("tap",tapLeft)

	local function makeAnim()
	 	amsize = math.random(2,9)
	 	if goAnim == true then 
	    		d1 = math.random(1,4)
	     if d1 == 1 then 
	       	d = 0.1
	     elseif d1 == 2 then 
	       	d = 0.2
	     elseif d1 == 3 then 
	      	d = 0.3
	     elseif d1 == 4 then 
	      	d = 0.4
	     end
	    if  goAnim == true and sc.oneGroup == true then
	 	    local am = display.newCircle(spaceship.x,spaceship.y+sc.oneDistanceY,amsize)
	 		am:setFillColor(0.7,d,0.1)
			transition.to(am,{time=150,y=spaceship.y + sc.oneDistanceT,alpha=0})
	 		spaceship:toFront()
	 		timer.performWithDelay(200,function() am:removeSelf() am=nil end,1)
	 	elseif goAnim == true and sc.oneGroup == false then 
	 		local am = display.newCircle(spaceship.x - sc.doubleDistanceX,spaceship.y + sc.doubleDistanceY,amsize)
	 		am:setFillColor(0.7,d,0.1)
	 		transition.to(am,{time=150,y=spaceship.y + sc.doubleDistanceT,alpha=0})
	 		local am2 = display.newCircle(spaceship.x + sc.doubleDistanceX,spaceship.y + sc.doubleDistanceY,amsize)
	 		am2:setFillColor(0.7,d,0.1)
	 		transition.to(am2,{time=150,y=spaceship.y + sc.doubleDistanceT,alpha=0})
	 		timer.performWithDelay(200,function() am:removeSelf() am=nil am2:removeSelf() am2=nil end,1)
	 		end
		 end
		 return am,am2
	end

	onGo = function()
	 	if goAnim == true then
	 	makeAnim()
	 end
	end
	 Runtime:addEventListener("enterFrame",onGo)
	 
	local title = display.newText( "STAR SPEC", screenW/2, -(actualHeight - screenH)/2 + 60, "Future Now", 65 )
	local playBtn = display.newText( "PLAY", display.contentWidth/2, 350, "stark", 50 )


	local function achieveAlpha1()
		achievIcon.alpha = 1
		backgroundIcon.alpha = 1
		end

	local options2 = {
		    effect = "fade",
		    time = 300,
		    params = { 
		    	spaceship1 = spaceship1,
		    	spaceship2 = spaceship2,
		    	spaceship3 = spaceship3,
		    	spaceship3 = spaceship4,
		    	totalCoins = totalCoins,
		    	backgroundIcon = backgroundIcon,
		    	spaceship = spaceship
		    }
		}


	local backBlack = display.newImage("backBlack.png",settingsIcon.x,settingsIcon.y + 50.5)
	backBlack.alpha = 1 

------------------------------------------------------------------
	local settingsGroup = display.newGroup()

	local settingsBar = display.newImageRect("settingsBar.png",51,150)
	settingsBar.x = settingsIcon.x 
	settingsBar.y = settingsIcon.y
	settingsBar.anchorX = 0.5
	settingsBar.anchorY = 0
	settingsGroup:insert(settingsBar)
	settingsGroup:toBack()
	settingsGroup.alpha = 1
	gameplay.sound = display.newImage("sound1.png")
	gameplay.sound.x = settingsIcon.x 
	gameplay.sound.y = settingsIcon.y +80
	gameplay.sound.xScale = 0.4
	gameplay.sound.yScale = 0.4
	gameplay.sound.isHitTestable = true
	settingsGroup:insert(gameplay.sound)
	gameplay.info = display.newImage("info.png")
	gameplay.info.x = settingsIcon.x 
	gameplay.info.y = settingsIcon.y +30
	gameplay.info.xScale = 0.4
	gameplay.info.yScale = 0.4
	gameplay.info.isVisible = false
	settingsGroup:insert(gameplay.info)
	gameplay.sound2 = display.newImage("sound2.png")
	gameplay.sound2.x = settingsIcon.x 
	gameplay.sound2.y = settingsIcon.y +80
	gameplay.sound2.xScale = 0.4
	gameplay.sound2.yScale = 0.4
	gameplay.sound2.isVisible = false
	settingsGroup:insert(gameplay.sound2)

	gameplay.checkSound = true

	function makeInvisible()
		settingsGroup.isVisible = false 
	end

	function makeVisible()
		settingsGroup.isVisible = true 
	end


	function gameplay.tapInfo()
		settingsGroup.y = 0
		transition.to(spaceship,{time=300,alpha=0})
		goAnim = false
		composer.gotoScene( "info",options2)
	end
	gameplay.info:addEventListener("tap",gameplay.tapInfo)

	local function onAchievRelease()
		playPress()
		settingsGroup.y = 0
		achievIcon.alpha = 0.3
		transition.to(spaceship,{time=300,alpha=0,onComplete=achieveAlpha1})
		goAnim = false
		composer.gotoScene( "achievements", options2)
		return true	
	end
	achievIcon:addEventListener("tap",onAchievRelease)


	function gameplay.tapSound()
	if gameplay.checkSound == true then
		highscores.soundIt(1)
		cancelS = true
		gameplay.sound2.isVisible = true
		gameplay.sound.isVisible = false
		gameplay.checkSound = false
		goPlayPress = false  
	elseif gameplay.checkSound == false then
		highscores.soundIt(2)
		cancelS = false 
		gameplay.sound2.isVisible = false
		gameplay.sound.isVisible = true
		gameplay.checkSound = true
		goPlayPress = true  
		end
	end
	gameplay.sound:addEventListener("tap",gameplay.tapSound)


------------------------------------------------------------

local set = true 

function gameplay.infoAlpha()
	gameplay.info.isVisible = false
end


local function tapStar(event)
	playPress()
	starIcon.alpha = 0.3
	transition.to(starIcon,{time=100,alpha=1})
		if event.phase == "ended" then
			local url = "https://itunes.apple.com/us/app/star-spec/viewContentsUserReviews/id1185775000?ls=1&mt=8"
			system.openURL( url )
		end
	end
starIcon:addEventListener("touch", tapStar)

local function tapSettingsButton()
	playPress()
if set == true then 
	gameplay.info.isVisible = true
    settingsGroup.alpha = 1
    transition.to(settingsGroup,{time=400,y=-130})
    set = false 
elseif set == false then 
	set = true 
	transition.to(settingsGroup,{time=400,y=0,onComplete=gameplay.infoAlpha})
	end
return true
end
settingsIcon:addEventListener("tap",tapSettingsButton)

  local function tapShopButton()
  		playPress()
  		settingsGroup.y = 0
		backgroundIcon.alpha = 0.3
		transition.to(spaceship,{time=300,alpha=0,onComplete=achieveAlpha1})
		goAnim = false
		composer.gotoScene( "shop", options2)
		return true	
 end
backgroundIcon:addEventListener("tap",tapShopButton)


	function goanimtrue()
if spaceship.isLocked == true then
	goAnim = false
	spaceship.alpha = 0.5
elseif spaceship.nonPlay == true then 
	goAnim = false
else 
	goAnim = true
	end
end

	local function onPlayBtnRelease()
		if goPlay == true and spaceship.isLocked == false and spaceship.nonPlay == false then 
			playBtn.alpha = 0.3
			transition.to(playBtn,{delay=200,alpha=1})
			transition.to(spaceship,{time=1000,y=390})
			playPress()

			playBtn:removeEventListener("tap", onPlayBtnRelease)
			left:removeEventListener("tap",tapLeft)
			right:removeEventListener("tap",tapRight)
			spaceship1:removeEventListener("tap",tapSpaceship)
			spaceship2:removeEventListener("tap",tapSpaceship)
			spaceship3:removeEventListener("tap",tapSpaceship)
			spaceship4:removeEventListener("tap",tapSpaceship)
			spaceship5:removeEventListener("tap",tapSpaceship)
			spaceship6:removeEventListener("tap",tapSpaceship)
			spaceship7:removeEventListener("tap",tapSpaceship)
			spaceship8:removeEventListener("tap",tapSpaceship)
			backgroundIcon:removeEventListener("tap",tapShopButton)
			settingsIcon:removeEventListener("tap",tapSettingsButton)
			starIcon:removeEventListener("touch", tapStar)
			gameplay.info:removeEventListener("tap",gameplay.tapInfo)
			achievIcon:removeEventListener("tap",onAchievRelease)
			gameplay.sound:removeEventListener("tap",gameplay.tapSound)
			starIcon:removeEventListener("touch", tapStar)
			backgroundIcon:removeEventListener("tap",tapShopButton)

			local options = {
			    effect = "fade",
			    time = 300,
			    params = { 
			    	spaceship1 = spaceship1,
			    	spaceship2 = spaceship2,
			    	spaceship3 = spaceship3,
			    	spaceship4 = spaceship4,
			    	spaceship5 = spaceship5,
			    	spaceship6 = spaceship6,
			    	spaceship7 = spaceship7,
			   		spaceship8 = spaceship8,
			    	spaceship = spaceship,
			    	goAnim = goAnim,
			    	cancelS = cancelS,
			    	onGo = onGo,
			    }
			}
			composer.gotoScene("level1", options)
			composer.removeScene("menu")
			return true	
		end
	end
	playBtn:addEventListener("tap", onPlayBtnRelease)

	local function checkSoundIt()
		if soundIt == 1 then 
			cancelS = true
			gameplay.sound2.isVisible = true
			gameplay.sound.isVisible = false
			gameplay.checkSound = false
		end
	end
	checkSoundIt()

	sceneGroup:insert( stars )
	sceneGroup:insert( settingsGroup )
	sceneGroup:insert( backBlack )
	sceneGroup:insert( starIcon )
	sceneGroup:insert( achievIcon )
	sceneGroup:insert( backgroundIcon )
	sceneGroup:insert( settingsIcon )
	sceneGroup:insert( title )
	sceneGroup:insert( left )
	sceneGroup:insert( right )
	sceneGroup:insert( playBtn )
	sceneGroup:insert( damgBar )
	sceneGroup:insert( ammoBar )
	sceneGroup:insert( speedBar )
	sceneGroup:insert( stat1 )
	sceneGroup:insert( stat2 )
	sceneGroup:insert( stat3 )
	sceneGroup:insert( stat1text )
	sceneGroup:insert( stat2text )
	sceneGroup:insert( stat3text )
	sceneGroup:insert(coinIcon)
	stars:toBack()
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	goanimtrue()
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		makeVisible()
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
		makeInvisible()
				-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	
	if playBtn then
		playBtn:removeSelf()	-- widgets must be manually removed
		playBtn = nil
	end
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene