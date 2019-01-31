local composer = require( "composer" )
local scene = composer.newScene()
local physics = require "physics"
local achievSignInfo = require("achievSign")

function scene:create( event )

  if audio.supportsSessionProperty == true then
    audio.setSessionProperty(audio.MixMode, audio.AmbientMixMode)
  end

  local sceneGroup = self.view
  system.activate( "multitouch" )
  physics.start()
  physics.pause()

  -- Requring Data 
  local menu = require("menu")
  local highscores = require('highscores')
  local endScreen = require("endScreen")
  local barInfo = require("bar")
  local endScreenInstance = endScreen:createEndScreen()
  local scoreH = highscores.getSaveData()

  -- Declaring local and global variables
  local screenW, screenH, halfW = display.actualContentWidth, display.actualContentHeight, display.contentCenterX
  local cancelS = event.params.cancelS
  local goAnim = event.params.goAnim
  local gameplay = {}
  local bullet
  local bullet2
  local screenW = display.contentWidth
  local screenH = display.contentHeight
  local i = 0
  local wallCollisionFilter = { categoryBits = 32, maskBits = 92 }
  local assetsCollisionFilter = { categoryBits = 16, maskBits = 32 }
  local bulletCollisionFilter = { categoryBits = 8, maskBits = 6 }
  local astroidCollisionFilter = { categoryBits = 4, maskBits = 40 } 
  local boundryCollisionFilter = { categoryBits = 2, maskBits = 8 }
  local propCollisionFilter = { categoryBits = 64, maskBits = 32 }
  local shipGo = false 
  local shipGo2 = false
  local d 
  local d1
  local game = {}
  local g = {}
  local bigA = {}
  local bigAstroid = {}
  local b = 0 
  local a = 0
  local e = 0
  local m = 0
  local brownAstroid = {}
  local astroid = {}
  local trans = {}
  local time = {}
  local astroidNum = 0
  local astroidX = 90
  local asN = 0.7
  local actualHeight = display.actualContentHeight
  local enemy = {}
  local en = 0
  g.shootVar = 0
  g.shipDamage = 1
  g.spaceshipCheck = true
  g.barNum = 56
  g.n1 = 55
  g.n2 = 54
  g.barNumPlus = 15
  g.goCount = true
  g.shipSpeed = 4
  g.genAstroidTime = 500
  g.spamGravity = 0.3
  g.ammoGravity = 0.3
  g.coinGravity = 1
  g.goCollision = true 
  g.goSpaceship = true
  g.goBullets = false 
  g.goSB = true 
  g.as = 0
  goAnim = true
  g.spaceship1 = event.params.spaceship1
  g.spaceship2 = event.params.spaceship2
  g.spaceship3 = event.params.spaceship3
  g.spaceship4 = event.params.spaceship4
  g.spaceship5 = event.params.spaceship5
  g.spaceship6 = event.params.spaceship6
  g.spaceship7 = event.params.spaceship7
  g.spaceship8 = event.params.spaceship8
  g.spaceship = event.params.spaceship
  g.spaceship.kind = "spaceship"
  g.onGo = event.params.onGo
  local checkMove = false
  local allowMove = false 
  local evx = 10
  local disRight = 10
  local disLeft = 10
  local shipS = g.shipSpeed
  local spaceR 
  local spaceR2
  local pcV = true 
  local setSpeed = 4
  local setDamage = 1

----Sounds---------------------------------------------------------
  local play = {}
  play.backgroundMusic = audio.loadStream("Motivated.m4a")  
  play.crash = audio.loadStream("crash.wav")
  play.coinSound1 = audio.loadStream("coin.wav")
  play.coinSound2 = audio.loadStream("coin.wav")
  play.hover = audio.loadStream("hover2.wav")
  play.bigE = audio.loadStream("BigE.wav")
  play.bigE2 = audio.loadStream("BigE.wav")
  play.powerUP = audio.loadStream("powerUP.wav")
  play.powerUP2 = audio.loadStream("powerUP.wav")
  play.shootSound1 = audio.loadStream("shoot2.wav")
  play.shootSound2 = audio.loadStream("shoot2.wav")
  play.shootSound3 = audio.loadStream("shoot2.wav")
  play.shootSound4 = audio.loadStream("shoot2.wav")
  play.astroidS1 = audio.loadStream("astroidC.wav")
  play.astroidS2 = audio.loadStream("astroidC.wav")
  play.astroidS3 = audio.loadStream("astroidC.wav")
  play.astroidS4 = audio.loadStream("astroidC.wav")
  play.astroidS5 = audio.loadStream("astroidC.wav")
  play.astroidS6 = audio.loadStream("astroidC.wav")
  play.astroidS7 = audio.loadStream("astroidC.wav")
  play.astroidS8 = audio.loadStream("astroidC.wav")

    function g.getRidofSounds()
      audio.stop()
      audio.dispose(play.crash)
      audio.dispose(play.coinSound)
      audio.dispose(play.hover)
      audio.dispose(play.bigE )
      audio.dispose(play.bigE2)
      audio.dispose(play.powerUP)
      audio.dispose(play.powerUP2)
      audio.dispose(play.backgroundMusic)
      audio.dispose(play.shootSound1)
      audio.dispose(play.shootSound2)
      audio.dispose(play.shootSound3)
      audio.dispose(play.shootSound4)
      audio.dispose(play.astroidS1)
      audio.dispose(play.astroidS2)
      audio.dispose(play.astroidS3)
      audio.dispose(play.astroidS4)
      audio.dispose(play.astroidS5)
      audio.dispose(play.astroidS6)
      audio.dispose(play.astroidS7)
      audio.dispose(play.astroidS8)

      play.shootSound1 = nil 
      play.shootSound2 = nil 
      play.shootSound3 = nil 
      play.shootSound4 = nil 
      play.crash = nil
      play.coinSound = nil
      play.hover = nil
      play.bigE = nil
      play.bigE2 = nil
      play.powerUP = nil
      play.powerUP2 = nil
      play.backgroundMusic = nil 
      play.astroidS1 = nil 
      play.astroidS2 = nil 
      play.astroidS3 = nil 
      play.astroidS4 = nil 
      play.astroidS5 = nil 
      play.astroidS6 = nil 
      play.astroidS7 = nil 
      play.astroidS8 = nil 

  end

  local function playHover()
    if cancelS == false then
      play.hoverP = audio.play(play.hover,{loops=-1})
    end
    if cancelS == true then 
      g.getRidofSounds()
    end
  end
  playHover()

  local function checkBkg()
    if bkgSelect == false then 
        backgroundString = "option.png"
      end
    end
    checkBkg()

  local function playCoin(sx)
    if pcV == true then 
      audio.play(play.coinSound1)
      pcV = false
    elseif pcV == false then 
      audio.play(play.coinSound2)
      pcV = true
    end
  end
--------------------------------------------------------------

  local stars = display.newImage(backgroundString)
  stars.x = display.contentWidth/2 
  stars.y = display.contentHeight/2 

  local function spawnStars()
   for i=1,math.random(1,2) do 
      local fs = display.newRect(math.random(screenW-screenW,screenW),-100,math.random(1,3),math.random(30,50))
      physics.addBody(fs,"dynamic",{filter=propCollisionFilter})
      fs.gravityScale = 10
      fs.alpha = 0.3
      sceneGroup:insert(fs)
    end
    for i=1,math.random(1,3) do 
      local fs2 = display.newCircle(math.random(screenW-screenW,screenW),-50,1)
      physics.addBody(fs2,"dynamic",{filter=propCollisionFilter})
      fs2.gravityScale = math.random(1,2)/20
      fs2.alpha = (math.random(6,8))/10
      sceneGroup:insert(fs2)
      trans[50] = transition.to(fs2,{time=5000,alpha=0})
    end
    return fs,fs2
  end
  time[35] = timer.performWithDelay(200,spawnStars,0)

--Meat Code:
  time[13] = timer.performWithDelay(100,function()g.goBullets = true end ,1)

    function g.spaceshipBody()
    if g.spaceship == g.spaceship1 then
      physics.addBody(g.spaceship,"static",{ radius=15, density=1,filter=spaceshipCollisionFilter })
    elseif g.spaceship == g.spaceship2 then 
      physics.addBody(g.spaceship,"static",{ radius=8, density=1,filter=spaceshipCollisionFilter })
      g.shipDamage = 1.5
      g.shipSpeed = 5.5
    elseif g.spaceship == g.spaceship3 then 
      physics.addBody(g.spaceship,"static",{ radius=15, density=1,filter=spaceshipCollisionFilter })
      g.shipDamage = 3
    elseif g.spaceship == g.spaceship4 then 
      physics.addBody(g.spaceship,"static",{ radius=10, density=1,filter=spaceshipCollisionFilter })
      g.shipDamage = 2
      g.shipSpeed = 5
    elseif g.spaceship == g.spaceship5 then 
      physics.addBody(g.spaceship,"static",{ radius=5, density=1,filter=spaceshipCollisionFilter })
      g.shipSpeed = 5.5
    elseif g.spaceship == g.spaceship6 then 
      physics.addBody(g.spaceship,"static",{ radius=10, density=1,filter=spaceshipCollisionFilter })
      g.shipDamage = 5.5
    elseif g.spaceship == g.spaceship7 then 
      physics.addBody(g.spaceship,"static",{ radius=13, density=1,filter=spaceshipCollisionFilter })
      g.shipSpeed = 5
      g.shipDamage = 3
    elseif g.spaceship == g.spaceship8 then 
      physics.addBody(g.spaceship,"static",{ radius=13, density=1,filter=spaceshipCollisionFilter })
      g.shipDamage = 1.5
    end
    setSpeed = g.shipSpeed 
    setDamage = g.shipDamage 
  end
  g.spaceshipBody() 


  local pause = display.newImage("pause.png")
  pause.x = 290
  pause.y = -(actualHeight - screenH)/2 + 27
  local pauseVar = false 
  pause.kind = "pause"

  local pausedScreen = display.newImageRect("paused.png",396,660)
  pausedScreen.x = screenW/2
  pausedScreen.y = screenH/2
  pausedScreen.alpha = 0
  pausedScreen.kind = "pausePlay"

  local rCircle = display.newCircle(screenW/2,g.spaceship.y,10)
  rCircle:setFillColor(0.8,0,0.1,0.2)
  rCircle.alpha = 0 

  local rRect = display.newRect(screenW/2,screenH/2,display.actualContentWidth,display.actualContentHeight)
  rRect:setFillColor(0.8,0,0.1,0)
  rRect.stroke = {0.8,0,0}
  rRect.strokeWidth = 6
  rRect.alpha = 0 

  g.purplefilter = display.newCircle(screenW/2,screenH/2,500)
  g.purplefilter:setFillColor(1,0,0)
  g.purplefilter.alpha = 0

  local ammoTime = 3000

   function g.spawnAmmo()
    gameplay.ammo = display.newImage("ammo.png")
    gameplay.ammo.xScale=0.4
    gameplay.ammo.yScale=0.4
    gameplay.ammo.x = math.random(1,300)
    gameplay.ammo.y = -130
    gameplay.ammo.kind = "ammo"
    trans[35] = transition.to(gameplay.ammo,{time=500,xScale=0.5,yScale=0.5,transition=easing.continuousLoop,iterations=0})
    physics.addBody(gameplay.ammo,"dynamic",{radius=20,filter=assetsCollisionFilter,iterations=0})
    gameplay.ammo.gravityScale = g.ammoGravity
    sceneGroup:insert(gameplay.ammo)
  end
  gameplay.astroidTimer = timer.performWithDelay(math.random(ammoTime,ammoTime*3),g.spawnAmmo,0)

  g.barSheet = graphics.newImageSheet( "bar.png", barInfo:getSheet() )

  g.barOrderData = {

  {name = "56", frames={g.n1,g.n2+1},time=500, loopCount = 1},
  {name = "55", frames={g.n1,g.n2},time=500, loopCount = 1},
  {name = "54", frames={g.n1-1,g.n2-1},time=500, loopCount = 1},
  {name = "53", frames={g.n1-2,g.n2-2},time=500, loopCount = 1},
  {name = "52", frames={g.n1-3,g.n2-3},time=500, loopCount = 1},
  {name = "51", frames={g.n1-4,g.n2-4},time=500, loopCount = 1},
  {name = "50", frames={g.n1-5,g.n2-5},time=500, loopCount = 1},
  {name = "49", frames={g.n1-6,g.n2-6},time=500, loopCount = 1},
  {name = "48", frames={g.n1-7,g.n2-7},time=500, loopCount = 1},
  {name = "47", frames={g.n1-8,g.n2-8},time=500, loopCount = 1},
  {name = "46", frames={g.n1-9,g.n2-9},time=500, loopCount = 1},
  {name = "45", frames={g.n1-10,g.n2-10},time=500, loopCount = 1},
  {name = "44", frames={g.n1-11,g.n2-11},time=500, loopCount = 1},
  {name = "43", frames={g.n1-12,g.n2-12},time=500, loopCount = 1},
  {name = "42", frames={g.n1-13,g.n2-13},time=500, loopCount = 1},
  {name = "41", frames={g.n1-14,g.n2-14},time=500, loopCount = 1},
  {name = "40", frames={g.n1-15,g.n2-15},time=500, loopCount = 1},
  {name = "39", frames={g.n1-16,g.n2-16},time=500, loopCount = 1},
  {name = "38", frames={g.n1-17,g.n2-17},time=500, loopCount = 1},
  {name = "37", frames={g.n1-18,g.n2-18},time=500, loopCount = 1},
  {name = "36", frames={g.n1-19,g.n2-19},time=500, loopCount = 1},
  {name = "35", frames={g.n1-20,g.n2-20},time=500, loopCount = 1},
  {name = "34", frames={g.n1-21,g.n2-21},time=500, loopCount = 1},
  {name = "33", frames={g.n1-22,g.n2-22},time=500, loopCount = 1},
  {name = "32", frames={g.n1-23,g.n2-23},time=500, loopCount = 1},
  {name = "31", frames={g.n1-24,g.n2-24},time=500, loopCount = 1},
  {name = "30", frames={g.n1-25,g.n2-25},time=500, loopCount = 1},
  {name = "29", frames={g.n1-26,g.n2-26},time=500, loopCount = 1},
  {name = "28", frames={g.n1-27,g.n2-27},time=500, loopCount = 1},
  {name = "27", frames={g.n1-28,g.n2-28},time=500, loopCount = 1},
  {name = "26", frames={g.n1-29,g.n2-29},time=500, loopCount = 1},
  {name = "25", frames={g.n1-30,g.n2-30},time=500, loopCount = 1},
  {name = "24", frames={g.n1-31,g.n2-31},time=500, loopCount = 1},
  {name = "23", frames={g.n1-32,g.n2-32},time=500, loopCount = 1},
  {name = "22", frames={g.n1-33,g.n2-33},time=500, loopCount = 1},
  {name = "21", frames={g.n1-34,g.n2-34},time=500, loopCount = 1},
  {name = "20", frames={g.n1-35,g.n2-35},time=500, loopCount = 1},
  {name = "19", frames={g.n1-36,g.n2-36},time=500, loopCount = 1},
  {name = "18", frames={g.n1-37,g.n2-37},time=500, loopCount = 1},
  {name = "17", frames={g.n1-38,g.n2-38},time=500, loopCount = 1},
  {name = "16", frames={g.n1-39,g.n2-39},time=500, loopCount = 1},
  {name = "15", frames={g.n1-40,g.n2-40},time=500, loopCount = 1},
  {name = "14", frames={g.n1-41,g.n2-41},time=500, loopCount = 1},
  {name = "13", frames={g.n1-42,g.n2-42},time=500, loopCount = 1},
  {name = "12", frames={g.n1-43,g.n2-43},time=500, loopCount = 1},
  {name = "11", frames={g.n1-44,g.n2-44},time=500, loopCount = 1},
  {name = "10", frames={g.n1-45,g.n2-45},time=500, loopCount = 1},
  {name = "9", frames={g.n1-46,g.n2-46},time=500, loopCount = 1},
  {name = "8", frames={g.n1-47,g.n2-47},time=500, loopCount = 1},
  {name = "7", frames={g.n1-48,g.n2-48},time=500, loopCount = 1},
  {name = "6", frames={g.n1-49,g.n2-49},time=500, loopCount = 1},
  {name = "5", frames={g.n1-50,g.n2-50},time=500, loopCount = 1},
  {name = "4", frames={g.n1-51,g.n2-51},time=500, loopCount = 1},
  {name = "3", frames={g.n1-52,g.n2-52},time=500, loopCount = 1},
  {name = "2", frames={g.n1-53,g.n2-53},time=500, loopCount = 1},
  {name = "1", frames={g.n1-54,g.n2-53},time=500, loopCount = 1},
  {name = "goFull", start=1,count=55,time=500, loopCount = 1},
  }

  local bar = display.newSprite( g.barSheet, g.barOrderData)
  bar.x = 290
  bar.y = -(actualHeight - screenH)/2 + 100
  bar:setSequence("goFull")
  bar:play()
  bar.xScale = 0.6
  bar.yScale = 0.6

  g.coinAnim = display.newImage("coinStack.png")
  g.coinAnim.x = 20 
  g.coinAnim.y = -(actualHeight - screenH)/2 + 33
  sceneGroup:insert(g.coinAnim)

  g.removeBar = display.newRect(screenW/2,750,screenW,10)
  physics.addBody(g.removeBar,"static",{filter=wallCollisionFilter})
  g.removeBar.kind = "removeBar"

  function g.checkRemoveBar(self,event)
    if event.other.kind == "astroid" then
      for i = #astroid,1,-1 do
        table.remove(astroid,i)
      end
      astroid = {}
    elseif event.other.kind == "mediumAstroid" then 
      for i = #bigA,1,-1 do
        table.remove(bigA,i)
      end
      bigA = {}
    elseif event.other.kind == "bigAstroid" then 
      for i = #bigAstroid,1,-1 do
        table.remove(bigAstroid,i)
      end
      bigAstroid = {}
      end
      event.other:removeSelf()
      event.other.body = false
      event.other = nil
  end
  g.removeBar.collision = g.checkRemoveBar
  g.removeBar:addEventListener("collision")

  g.score = display.newText( "0", screenW/2, -(actualHeight - screenH)/2 + 33, "stark", 36 )
  amount = 0
  g.score.text = amount 

  coinAmount = 0
  g.coinCount = display.newText( "0", 65, -(actualHeight - screenH)/2 + 33, "stark", 30 )

  g.add20 = display.newText( "",250, math.random(90,120), "Stark", 20 )
  g.add20.alpha = 0
  sceneGroup:insert(g.add20)

  function g.make20PlusAnim(sx,sy)
    g.add20.x = sx + 20
    g.add20.y = sy
    g.add20.alpha = 1
    g.add20.text = "+20"
    trans[36] = transition.to(g.add20,{time=500,xScale=1.2,yScale=1.2,alpha=0})
  end


  -----------------------------------------------------------------------------------------


  gameplay.achiev1 = highscores.getAchiev1()
  gameplay.achiev2 = highscores.getAchiev2()
  gameplay.achiev3 = highscores.getAchiev3()
  gameplay.achiev4 = highscores.getAchiev4()
  gameplay.achiev5 = highscores.getAchiev5()
  gameplay.achiev6 = highscores.getAchiev6()
  gameplay.achiev7 = highscores.getAchiev7()
  gameplay.achiev8 = highscores.getAchiev8()
  gameplay.achiev9 = highscores.getAchiev9()
  gameplay.achiev10 = highscores.getAchiev10()
  gameplay.achiev11 = highscores.getAchiev11()
  gameplay.achiev12 = highscores.getAchiev12()
  gameplay.achiev13 = highscores.getAchiev13()

  gameplay.achiev1t = false 
  gameplay.achiev2t = false 
  gameplay.achiev3t = 0   gameplay.achiev3t2 = false
  gameplay.achiev4t2 = false
  gameplay.achiev5t = 0   gameplay.achiev5t2 = false
  gameplay.achiev6t = false 
  gameplay.achiev7t = false   
  gameplay.achiev8t = true
  gameplay.achiev9t = false 
  gameplay.achiev10t = false 
  gameplay.achiev11t = false 
  gameplay.achiev12t = false 
  gameplay.achiev13t = false

  g.achievSignAnimSheet = graphics.newImageSheet( "achievments/achievSign.png", achievSignInfo:getSheet() )
  g.achievSignOrderData = {
     { name = "13", start=1, count=1, time=0, loopCount=1 },
     { name = "1", start=2, count=1, time=0, loopCount=1 },
     { name = "2", start=3, count=1, time=0, loopCount=1 },
     { name = "3", start=4, count=1, time=0, loopCount=1 },
     { name = "4", start=5, count=1, time=0, loopCount=1 },
     { name = "5", start=6, count=1, time=0, loopCount=1 },
     { name = "6", start=7, count=1, time=0, loopCount=1 },
     { name = "7", start=8, count=1, time=0, loopCount=1 },
     { name = "8", start=9, count=1, time=0, loopCount=1 },
     { name = "9", start=10, count=1, time=0, loopCount=1 },
     { name = "10", start=11, count=1, time=0, loopCount=1 },
     { name = "11", start=12, count=1, time=0, loopCount=1 },
     { name = "12", start=13, count=1, time=0, loopCount=1 },
     { name = "unlock", start=14, count=1, time=0, loopCount=1 }
  }
   
  local achievSign = display.newSprite( g.achievSignAnimSheet, g.achievSignOrderData )
  achievSign.x = screenW/2
  achievSign.y = -100
  achievSign.xScale = 0.5
  achievSign.yScale = 0.5
  achievSign:setSequence("unlock")
  achievSign:play()

  function g.achievSignPlay(signNum)
    achievSign:setSequence(signNum)
    achievSign:play()
    trans[37] = transition.to(achievSign,{time=1000,y=-10})
    trans[38] = transition.to(achievSign,{delay=4000,time=1500,y=-100})
  end
  
   function g.checkGame()
    if gameplay.achiev2 == false and amount >= 500 and gameplay.achiev2t == false then 
      highscores.MakeTrue2()
      gameplay.achiev2t = true 
      g.achievSignPlay("unlock")
      time[14] = timer.performWithDelay(6000,function() g.achievSignPlay("2") end,1)
    elseif gameplay.achiev3 == false and gameplay.achiev3t >= 4 and gameplay.achiev3t2 == false then 
      highscores.MakeTrue3()
      gameplay.achiev3t2 = true
      g.achievSignPlay("unlock")
      time[15] = timer.performWithDelay(6000,function() g.achievSignPlay("3") end,1)
    elseif gameplay.achiev4 == false and gameplay.achiev3t >= 8 and gameplay.achiev4t2 == false then 
      highscores.MakeTrue4()
      gameplay.achiev4t2 = true
      g.achievSignPlay("unlock")
      time[16] = timer.performWithDelay(6000,function() g.achievSignPlay("4") end,1)
    elseif gameplay.achiev5 == false and gameplay.achiev5t >= 100 and gameplay.achiev5t2 == false then 
      highscores.MakeTrue5()
      gameplay.achiev5t2 = true
      g.achievSignPlay("unlock")
      time[17] = timer.performWithDelay(6000,function() g.achievSignPlay("5") end,1)
    elseif gameplay.achiev6 == false and amount >= 1000 and gameplay.achiev2t == false then
      highscores.MakeTrue6()
      gameplay.achiev6t = true
      g.achievSignPlay("unlock")
      time[18] = timer.performWithDelay(6000,function() g.achievSignPlay("6") end,1)
    elseif gameplay.achiev7 == false and amount >= 5000 and gameplay.achiev7t == false then
      highscores.MakeTrue7()
      gameplay.achiev7t = true
      g.achievSignPlay("unlock")
      time[19] = timer.performWithDelay(6000,function() g.achievSignPlay("7") end,1)
    elseif gameplay.achiev8 == false and gameplay.achiev8t == false then
      highscores.MakeTrue8()
      gameplay.achiev8t = true
      g.achievSignPlay("unlock")
      time[20] = timer.performWithDelay(6000,function() g.achievSignPlay("8") end,1)
    elseif gameplay.achiev9 == false and gameplay.achiev9t == false and coinAmount >= 100 then 
      highscores.MakeTrue9()
      gameplay.achiev9t = true
      g.achievSignPlay("unlock")
      time[21] = timer.performWithDelay(6000,function() g.achievSignPlay("9") end,1)
    elseif gameplay.achiev10 == false and gameplay.achiev10t == false and amount >= 2000 then 
      highscores.MakeTrue10()
      gameplay.achiev10t = true
      g.achievSignPlay("unlock")
      time[22] = timer.performWithDelay(6000,function() g.achievSignPlay("10") end,1)
    elseif gameplay.achiev11 == false and gameplay.achiev11t == false and amount >= 4000 then 
      highscores.MakeTrue11()
      gameplay.achiev11t = true
      g.achievSignPlay("unlock")
      time[23] = timer.performWithDelay(6000,function() g.achievSignPlay("11") end,1)
    elseif gameplay.achiev12 == false and gameplay.achiev12t == false and amount >= 7000 then 
      highscores.MakeTrue12()
      gameplay.achiev12t = true
      g.achievSignPlay("unlock")
      time[24] = timer.performWithDelay(6000,function() g.achievSignPlay("12") end,1)
    elseif gameplay.achiev13 == false and gameplay.achiev13t == false and gameplay.achiev3t >= 6 then 
      highscores.MakeTrue13()
      gameplay.achiev13t = true
      g.achievSignPlay("unlock")
      time[25] = timer.performWithDelay(6000,function() g.achievSignPlay("13") end,1)
    end
  end

---------------------------------------------------------------------------------------------


  local function makeRed()
    if scoreH[1] ~= nil then
      if amount > scoreH[1] then 
        g.score:setTextColor(1,0,0)
      end
    end
  end

  function g.upAmount()
    if g.goCount == true then
      g.score.text = amount 
      amount = amount + 5
      makeRed()
      g.checkGame()
    end
  end
  gameplay.amountTimer = timer.performWithDelay(1000,g.upAmount,0)

  g.boundry = display.newRect(screenW/2,-45,screenW,10)
  physics.addBody(g.boundry,"static",{filter=boundryCollisionFilter})
  g.boundry.isHitTestable = true 
  g.boundry.isVisible = false
  g.boundry.kind = "boundry"

  function g.loadAstroidSound()
    g.as = g.as + 1 
    if cancelS == false then 
      if g.as >= 8 then 
        g.as = 1
        play.astroidCP = audio.play(play.astroidS1)
      elseif g.as == 1 then 
        play.astroidCP = audio.play(play.astroidS1)
      elseif g.as == 2 then 
        play.astroidCP2 = audio.play(play.astroidS2)
      elseif g.as == 3 then 
        play.astroidCP3 = audio.play(play.astroidS3)
      elseif g.as == 4 then 
        play.astroidCP4 = audio.play(play.astroidS4)
      elseif g.as == 5 then 
        play.astroidCP5 = audio.play(play.astroidS5)
      elseif g.as == 6 then 
        play.astroidCP6 = audio.play(play.astroidS6)
      elseif g.as == 7 then 
        play.astroidCP7 = audio.play(play.astroidS7)
      elseif g.as == 8 then 
        play.astroidCP8 = audio.play(play.astroidS8)
      end
    end
  end

  function g.make50PlusAnim(sx,sy)
    g.add50 = display.newText( "+50",sx + 30, sy, "Stark", 30 )
    trans[41] = transition.to(g.add50,{time=600,xScale=1.2,yScale=1.2,alpha=0})
    g.score.text = amount 
    amount = amount + 50
    sceneGroup:insert(g.add50)
    time[1] = timer.performWithDelay(601,function() g.add50:removeSelf() g.add50 = nil end,1)
  end


  function g.make100PlusAnim(sx,sy)
    g.add100 = display.newText( "+100",sx + 30, sy, "Stark", 30 )
    trans[42] = transition.to(g.add100,{time=600,xScale=1.2,yScale=1.2,alpha=0})
    g.score.text = amount 
    amount = amount + 100
    sceneGroup:insert(g.add100)
    time[2] = timer.performWithDelay(601,function() g.add100:removeSelf() g.add100 = nil end,1)
  end

  function g.make200PlusAnim(sx,sy)
    g.add200 = display.newText( "+200",sx + 30, sy, "Stark", 30 )
    trans[43] = transition.to(g.add200,{time=600,xScale=1.2,yScale=1.2,alpha=0})
    g.score.text = amount 
    amount = amount + 50
    sceneGroup:insert(g.add200)
    time[3] = timer.performWithDelay(601,function() g.add200:removeSelf() g.add200 = nil end,1)
  end

  function g.showExplosion(sx,sy)
      local explosion = display.newImage("explosion.png")
      explosion.xScale = 0.1
      explosion.yScale = -0.1
      explosion.x = sx
      explosion.y = sy
      time[4] = timer.performWithDelay(30,function() explosion:removeSelf() explosion = nil end,1)
      sceneGroup:insert(explosion)
      return explosion
  end

  function g.partE(sx,sy)
    for i = #astroid,1,-1 do
        table.remove(astroid,i)
    end

    for i = 1,15 do
      local particle3 = display.newRect(sx,sy,4,4)
      trans[40] = transition.to(particle3,{time=300,x=math.random(sx - 300,sx + 300),y=math.random(sx - 300,sx + 300),alpha=0.5})
      time[5] = timer.performWithDelay(400,function()particle3:removeSelf() particle3 = nil end,1)
      sceneGroup:insert(particle3)
    end

    astroid = {}
    g.loadAstroidSound()
    gameplay.achiev5t = gameplay.achiev5t + 1
    return particle3
  end

  function g.bulletCollision(self,event)
    if event.phase == "began" then
      if event.other.kind == "astroid" then
        g.partE(self.x,self.y)
        g.showExplosion(self.x,self.y)
        g.score.text = amount 
        amount = amount + 20
        g.make20PlusAnim(self.x,self.y)
        event.other:removeSelf()
        event.other = nil 
        self:removeSelf()
        self = nil
      elseif event.other.kind == "boundry" then     
        self:removeSelf()
        self = nil
      else 
        g.showExplosion(self.x,self.y)
        self:removeSelf()
        self = nil
      end
    end
  end

  function g.generateCoins()
    g.coin = display.newImage("coin.png")
    g.coin.xScale = 0.13
    g.coin.yScale = 0.13
    g.coin.x = math.random(1,300)
    g.coin.y = -300
    physics.addBody(g.coin,"dynamic",{radius=20,filter=assetsCollisionFilter})
    g.coin.gravityScale = g.coinGravity
    g.coin.kind = "coin"
    g.coin.body = true 
    sceneGroup:insert(g.coin)
  end
  gameplay.coinTimer = timer.performWithDelay(700,g.generateCoins,0)

  function game.astroid()
    for u = 1,astroidNum do 
      i = i + 1 
      astroid[i] = display.newImage( "astroid.png" )
      astroid[i].x = astroidX * (u - asN)
      astroid[i].y = -300
      astroid[i].xScale = 0.1
      astroid[i].yScale = 0.15
      astroid[i].kind = "astroid"
      physics.addBody(astroid[i],"dynamic",{radius=20,filter=astroidCollisionFilter})
      sceneGroup:insert(astroid[i])
      g.purplefilter:toFront()
      rCircle:toFront()
      rRect:toFront()
    end
    return astroid[i]
  end

  game.astChose1 = 0 
  game.astChose2 = true 
  game.astCon = 20
  game.astCon2 = 20
  game.astChose3 = false

 time[34] = timer.performWithDelay(7000,function() game.astChose3 = true game.astCon = 10 game.astCon2 = 17 end,1)

  function game.generateAstroids()
    game.astChose1 = math.random(1,20)
    game.astChose2 = game.astChose3 
    if game.astChose1 < game.astCon then 
      astroidNum = 1
      astroidX = math.random(10,320)
      asN = 0
      game.astroid()
      game.astChose2 = false 
   elseif game.astChose1 > game.astCon2 then
      astroidNum = 3
      astroidX = 100
      asN = 0.4 
      game.astroid()
      game.astChose2 = false 
    elseif game.astChose1 == 10 then 
      astroidNum = 4
      astroidX = 90
      asN = 0.7
      game.astroid()
      game.astChose2 = false 
    elseif game.astChose2 == true then
      astroidNum = 2
      astroidX = 110
      asN = 0
      game.astroid()
    end
    gameplay.astroidtimer2 = timer.performWithDelay(g.genAstroidTime,game.generateAstroids,1)
  end
  gameplay.astroidtimer1 = timer.performWithDelay(500,game.generateAstroids,1)

  ------Start Group------------------------------------------------------------
  g.startGroup = display.newGroup()

  local maneuver = display.newRect(screenW/2,445,screenW*2,screenH/3)
  maneuver.alpha = 0.2

  local shoot = display.newRect(screenW/2,210,screenW*2,screenH/1.6)
  shoot.alpha = 0.2

  local shootExtension = display.newRect(screenW/2,shoot.y - shoot.height/2,screenW*2,200)
  shootExtension.alpha = 0.2
  shootExtension.anchorY = 1

  local moveText =  display.newText( "Swipe Here",screenW/2, maneuver.y , "stark", 30 )
  local shootText =  display.newText( "SHOOT HERE",shoot.x, shoot.y + 60, "stark", 40 )

  local yourAmmo = display.newImage("yourAmmo.png")
  yourAmmo.x = 200
  yourAmmo.y = 150
  yourAmmo.xScale = 1.5
  yourAmmo.yScale = 1.5

  local gesture1 = display.newImageRect("gesture1.png",80,80)
  gesture1.x = screenW/2 + 100
  gesture1.y = screenH/2 + 70
  gesture1.rotation = -30
  transition.to(gesture1,{time=300,xScale=1.1,yScale=1.1,transition=easing.continuousLoop,iterations=0})
  g.startGroup:insert(gesture1)

  local gesture2 = display.newImageRect("gesture2.png",80,80)
  gesture2.x = screenW/2 
  gesture2.y = -(screenH - actualHeight)/2 + 450
  gesture2.rotation = -30
  transition.to(gesture2,{delay=400,time=700,x=320})
  transition.to(gesture2,{delay=1100,time=2000,x=10,transition=easing.continuousLoop,iterations=0})
  g.startGroup:insert(gesture2)

  local ammoText = display.newText( "Your Ammo",195,140, "stark", 20 )

  g.startGroup:insert(maneuver)
  g.startGroup:insert(shootExtension)
  g.startGroup:insert(shoot)
  g.startGroup:insert(shootText)
  g.startGroup:insert(moveText)
  g.startGroup:insert(yourAmmo)
  g.startGroup:insert(ammoText)
  g.startGroup.isHitTestable = true

------------------------------------------------------------------

  function g.goSpaceShip2()
    disLeft = evx - g.spaceship.x 
    if shipGo2 == true and g.spaceship.x >= evx and allowMove == true  then 
      g.spaceship.x = evx
  	elseif disLeft > shipS and shipGo2 == true and g.goSpaceship == true then 
      shipS = g.shipSpeed
      checkMove = false 
      g.spaceship.x = g.spaceship.x + shipS
  	end
  end
  Runtime:addEventListener("enterFrame",g.goSpaceShip2)

  function g.goSpaceShip()
    disRight = g.spaceship.x - evx
    if shipGo == true and g.spaceship.x <= evx and allowMove == true then 
      g.spaceship.x = evx
    elseif disRight > shipS and shipGo == true and g.goSpaceship == true then
      shipS = g.shipSpeed
      checkMove = false 
      g.spaceship.x = g.spaceship.x - shipS
    end 
  end
  Runtime:addEventListener("enterFrame",g.goSpaceShip)

  function g.checkSpaceship()
    if g.spaceship.x < 10 and g.spaceshipCheck == true then 
  		g.spaceship.x = 10
  	elseif g.spaceship.x > 310 and g.spaceshipCheck == true then 
  		g.spaceship.x = 310
    end
  end
  Runtime:addEventListener("enterFrame",g.checkSpaceship)

   function g.moveSpaceship(event)
    if event.phase == "moved" then 
        allowMove = false 
        evx = event.x
        checkMove = true
      if event.x > g.spaceship.x then
        allowMove = true 
        shipGo = false
        shipGo2 = true
        spaceR = transition.to(g.spaceship,{time=50,rotation=-5})
      elseif event.x < g.spaceship.x then
        allowMove = true 
        shipGo = true
        shipGo2 = false
        spaceR2 = transition.to(g.spaceship,{time=50,rotation=5})
      end
    end
  end
  maneuver:addEventListener("touch",g.moveSpaceship)

  function g.playShoot()
    g.shootVar = g.shootVar + 1 
    if cancelS == false then 
      if g.shootVar >= 4 then 
        g.shootVar = 1
        g.shoot1 = audio.play(play.shootSound1)
      elseif g.shootVar == 1 then 
        g.shoot1 = audio.play(play.shootSound1)
      elseif g.shootVar == 2 then 
        g.shoot2 =  audio.play(play.shootSound2)
      elseif g.shootVar == 3 then 
        g.shoot3 = audio.play(play.shootSound3)
      elseif g.shootVar == 4 then 
        g.shoot4 = audio.play(play.shootSound4)
      end
    end
  end

  local bSpeed1 = -800
  local bSpeed2 = -600
  local bSpeed3 = -1000

  function g.spaceship1Bullets() 
    g.playShoot()
    g.spaceship.rotation = 0
    bullet = display.newRect(g.spaceship.x + 23,g.spaceship.y - 25,5,10)
    physics.addBody(bullet,"dynamic",{filter=bulletCollisionFilter})
    bullet:setLinearVelocity(0,bSpeed1)
    bullet.isBullet = true
    bullet.gravityScale = 0
    bar:setSequence(g.barNum)
    bar:play()
    bullet2 = display.newRect(g.spaceship.x - 23,g.spaceship.y - 25,5,10)
    physics.addBody(bullet2,"dynamic",{filter=bulletCollisionFilter})
    bullet2:setLinearVelocity(0,bSpeed1)
    bullet2.isBullet = true
    bullet2.gravityScale = 0
    bullet.collision = g.bulletCollision
    bullet:addEventListener("collision")
    bullet2.collision = g.bulletCollision
    bullet2:addEventListener("collision")
    sceneGroup:insert(bullet)
    sceneGroup:insert(bullet2)
    return bullet, bullet2
  end

  function g.spaceship2Bullets() 
    if g.spaceship ~= nil then
      g.playShoot()
      g.spaceship.rotation = 0
    	g.spaceship.xScale = 0.9
    	g.spaceship.yScale = 0.8
    	bullet = display.newCircle(g.spaceship.x,g.spaceship.y,4)
    	physics.addBody(bullet,"dynamic",{filter=bulletCollisionFilter})
    	bullet:setLinearVelocity(0,bSpeed1)
    	bullet.isBullet = true
    	bullet.gravityScale = 0
    	bar:setSequence(g.barNum)
    	bar:play()
    	bullet.collision = g.bulletCollision
    	bullet:addEventListener("collision")
    	sceneGroup:insert(bullet)
    	trans[9] = transition.to(g.spaceship,{time=50,xScale=0.8,yScale=0.7})
      return bullet,bullet2
  	end
  end

  function g.spaceship3Bullets()
    g.playShoot() 
    g.spaceship.rotation = 0
    bullet = display.newRect(g.spaceship.x + 9,g.spaceship.y - 3,5,10)
    physics.addBody(bullet,"dynamic",{filter=bulletCollisionFilter})
    bullet:setLinearVelocity(0,bSpeed1)
    bullet.isBullet = true
    bullet.gravityScale = 0
    bar:setSequence(g.barNum)
    bar:play()
    bullet2 = display.newRect(g.spaceship.x - 9,g.spaceship.y - 3,5,10)
    physics.addBody(bullet2,"dynamic",{filter=bulletCollisionFilter})
    bullet2:setLinearVelocity(0,bSpeed1)
    bullet2.isBullet = true
    bullet2.gravityScale = 0
    bullet.collision = g.bulletCollision
    bullet:addEventListener("collision")
    bullet2.collision = g.bulletCollision
    bullet2:addEventListener("collision")
    sceneGroup:insert(bullet)
    sceneGroup:insert(bullet2)
    return bullet, bullet2
  end

  function g.spaceship4Bullets() 
    g.playShoot() 
    g.spaceship.rotation = 0
    bullet = display.newRect(g.spaceship.x,g.spaceship.y - 3,15,20)
    physics.addBody(bullet,"dynamic",{filter=bulletCollisionFilter})
    bullet:setLinearVelocity(0,bSpeed2)
    bullet.isBullet = true
    bullet.gravityScale = 0
    bar:setSequence(g.barNum)
    bar:play()
    bullet.collision = g.bulletCollision
    bullet:addEventListener("collision")
    sceneGroup:insert(bullet)

    for i = 1,7 do
      bullet2 = display.newCircle(g.spaceship.x,g.spaceship.y - 30,2)
      physics.addBody(bullet2,"dynamic",{filter=bulletCollisionFilter})
      bullet2:setLinearVelocity(math.random(-300,300),math.random(bSpeed2 - 900,bSpeed2 - 400))
      bullet2.isBullet = true
      bullet2.gravityScale = 0
      bar:setSequence(g.barNum)
      bar:play()
      bullet2.collision = g.bulletCollision
      bullet2:addEventListener("collision")
      sceneGroup:insert(bullet2)
    end

    return bullet,bullet2
  end

  function g.spaceship5Bullets() 
    g.playShoot() 
    g.spaceship.rotation = 0
    bullet = display.newRect(g.spaceship.x,g.spaceship.y - 3,7,10)
    physics.addBody(bullet,"dynamic",{filter=bulletCollisionFilter})
    bullet:setLinearVelocity(0,bSpeed1)
    bullet.isBullet = true
    bullet.gravityScale = 0
    bar:setSequence(g.barNum)
    bar:play()
    bullet.collision = g.bulletCollision
    bullet:addEventListener("collision")
    sceneGroup:insert(bullet)
    return bullet
  end

  function g.spaceship6Bullets() 
    g.playShoot() 
    g.spaceship.rotation = 0
    bullet = display.newRect(g.spaceship.x,g.spaceship.y - 3,10,15)
    physics.addBody(bullet,"dynamic",{filter=bulletCollisionFilter})
    bullet:setLinearVelocity(0,bSpeed2)
    bullet.isBullet = true
    bullet.gravityScale = 0
    bar:setSequence(g.barNum)
    bar:play()
    bullet.collision = g.bulletCollision
    bullet:addEventListener("collision")
    sceneGroup:insert(bullet)
    for i = 1,4 do
      bullet2 = display.newCircle(g.spaceship.x,g.spaceship.y - 30,2)
      physics.addBody(bullet2,"dynamic",{filter=bulletCollisionFilter})
      bullet2:setLinearVelocity(math.random(-200,200),math.random(bSpeed2 - 900,bSpeed2 - 400))
      bullet2.isBullet = true
      bullet2.gravityScale = 0
      bar:setSequence(g.barNum)
      bar:play()
      bullet2.collision = g.bulletCollision
      bullet2:addEventListener("collision")
      sceneGroup:insert(bullet2)
    end
    return bullet,bullet2
  end

  local sevBullet = true

  function g.spaceship7Bullets() 
    if sevBullet == true then
      g.playShoot() 
      g.spaceship.rotation = 0
      bullet = display.newRect(g.spaceship.x,g.spaceship.y - 3,5,10)
      physics.addBody(bullet,"dynamic",{filter=bulletCollisionFilter})
      bullet:setLinearVelocity(0,bSpeed3)
      bullet.isBullet = true
      bullet.gravityScale = 0
      bar:setSequence(g.barNum)
      bar:play()
      bullet.collision = g.bulletCollision
      bullet:addEventListener("collision")
      sceneGroup:insert(bullet)
      sevBullet = false 
      return bullet
    elseif sevBullet == false then 
      g.playShoot() 
      g.spaceship.rotation = 0
      bullet = display.newRect(g.spaceship.x + 25,g.spaceship.y - 3,7,10)
      physics.addBody(bullet,"dynamic",{filter=bulletCollisionFilter})
      bullet:setLinearVelocity(0,bSpeed3)
      bullet.isBullet = true
      bullet.gravityScale = 0
      bar:setSequence(g.barNum)
      bar:play()
      bullet2 = display.newRect(g.spaceship.x - 25,g.spaceship.y - 3,7,10)
      physics.addBody(bullet2,"dynamic",{filter=bulletCollisionFilter})
      bullet2:setLinearVelocity(0,bSpeed3)
      bullet2.isBullet = true
      bullet2.gravityScale = 0
      bullet.collision = g.bulletCollision
      bullet:addEventListener("collision")
      bullet2.collision = g.bulletCollision
      bullet2:addEventListener("collision")
      sceneGroup:insert(bullet)
      sceneGroup:insert(bullet2)
      sevBullet = true 
      return bullet,bullet2
    end
  end

  function g.spaceship8Bullets()
    g.playShoot()  
    g.spaceship.rotation = 0
    bullet = display.newRect(g.spaceship.x,g.spaceship.y - 3,5,10)
    physics.addBody(bullet,"dynamic",{filter=bulletCollisionFilter})
    bullet:setLinearVelocity(0,bSpeed3)
    bullet.isBullet = true
    bullet.gravityScale = 0
    bar:setSequence(g.barNum)
    bar:play()
    bullet.collision = g.bulletCollision
    bullet:addEventListener("collision")
    sceneGroup:insert(bullet)

    bullet = display.newRect(g.spaceship.x + 25,g.spaceship.y - 3,7,10)
    physics.addBody(bullet,"dynamic",{filter=bulletCollisionFilter})
    bullet:setLinearVelocity(-250,bSpeed3)
    bullet.isBullet = true
    bullet.gravityScale = 0
    bullet.rotation = -10
    bar:setSequence(g.barNum)
    bar:play()
    bullet2 = display.newRect(g.spaceship.x - 25,g.spaceship.y - 3,7,10)
    physics.addBody(bullet2,"dynamic",{filter=bulletCollisionFilter})
    bullet2:setLinearVelocity(250,bSpeed3)
    bullet2.isBullet = true
    bullet2.gravityScale = 0
    bullet2.rotation = 10
    bullet.collision = g.bulletCollision
    bullet:addEventListener("collision")
    bullet2.collision = g.bulletCollision
    bullet2:addEventListener("collision")
    sceneGroup:insert(bullet)
    sceneGroup:insert(bullet2)
    return bullet,bullet2
  end

  function g.tapShoot()
  	if not g.spaceship then 
      return
    end  
    gameplay.achiev2t = true 
    if g.goBullets == true  and g.barNum > 0 then
      if g.spaceship == g.spaceship1 then 
        g.barNum = g.barNum - 2
      	trans[10] = transition.to(g.spaceship,{time=100,xScale=0.75,yScale=0.55,transition=easing.continuousLoop})
      	g.spaceship1Bullets()
      elseif g.spaceship == g.spaceship2 then
        g.barNum = g.barNum - 2
      	g.spaceship2Bullets()
      	time[6] = timer.performWithDelay(100,g.spaceship2Bullets,2)
      elseif g.spaceship == g.spaceship3 then
        g.barNum = g.barNum - 1
        trans[11] = transition.to(g.spaceship,{time=100,xScale=0.6,yScale=0.6,transition=easing.continuousLoop})
        g.spaceship3Bullets()
      elseif g.spaceship == g.spaceship4 then 
        g.barNum = g.barNum - 3
        g.spaceship4Bullets() 
        trans[12] = transition.to(g.spaceship,{time=100,xScale=0.5,yScale=0.5,transition=easing.continuousLoop})
      elseif g.spaceship == g.spaceship5 then 
        g.barNum = g.barNum - 2
        g.spaceship5Bullets() 
        trans[13] = transition.to(g.spaceship,{time=100,xScale=0.75,yScale=0.75,transition=easing.continuousLoop})
      elseif g.spaceship == g.spaceship6 then 
        g.barNum = g.barNum - 3
        g.spaceship6Bullets() 
        trans[14] = transition.to(g.spaceship,{time=100,xScale=0.55,yScale=0.55,transition=easing.continuousLoop})
      elseif g.spaceship == g.spaceship7 then 
        g.barNum = g.barNum - 1
        g.spaceship7Bullets() 
        trans[15] = transition.to(g.spaceship,{time=100,xScale=0.85,yScale=0.85,transition=easing.continuousLoop})
      elseif g.spaceship == g.spaceship8 then 
        g.barNum = g.barNum - 1
        g.spaceship8Bullets() 
        trans[16] = transition.to(g.spaceship,{time=100,xScale=0.85,yScale=0.85,transition=easing.continuousLoop})
    	end
      return true
    end
  end
  shoot:addEventListener("tap",g.tapShoot)
  

  local explodeCoinNum = 0

  function g.addExplodeCoin(self,event)
  	coinAmount = coinAmount + explodeCoinNum
    g.coinCount.text = coinAmount
  	trans[17] = transition.to(self,{time=300,x=20,y=-10,alpha=0})
  	explodeCoinNum = 0
  end

  function g.bigExplode(sx,sy)
    for i=1,50 do 
      local bigParticle = display.newCircle(sx,sy,math.random(1,3))
      trans[18] = transition.to(bigParticle,{time=500,x=math.random(-2000,2000),y=math.random(-2000,2000)})
      time[7] = timer.performWithDelay(600,function() bigParticle:removeSelf() bigParticle = nil end,1)
      sceneGroup:insert(bigParticle)
    end

    for i=1,explodeCoinNum do 
     	g.explodeCoin = display.newImage("coin.png")
     	g.explodeCoin.x = sx 
     	g.explodeCoin.y = sy
   	  g.explodeCoin.xScale = 0.13
    	g.explodeCoin.yScale = 0.13
    	trans[19] = transition.to(g.explodeCoin,{time=300,x=sx + math.random(-100,100),y=sy + math.random(-100,100),onComplete=g.addExplodeCoin})
    	sceneGroup:insert(g.explodeCoin)
    end
    return bigParticle
  end


  function g.mediumAstroidCollision(self)
    self.hitPoints = self.hitPoints + g.shipDamage
    if self.hitPoints > 15 then 
      for i = #bigA,1,-1 do
        table.remove(bigA,i)
      end
      bigA = {}
      explodeCoinNum = math.random(7,15) 
      play.bigEP = audio.play(play.bigE)
      gameplay.achiev3t = gameplay.achiev3t + 1
      g.bigExplode(self.x,self.y)
      g.make50PlusAnim(self.x,self.y)
      self:removeSelf() 
      self = nil   
    end
  end


  function g.mediumAstroid()
    e = e + 1
    bigA[e] = display.newImage("astroid2.png")
    bigA[e].x = math.random(0,300)
    bigA[e].y = -200
    bigA[e].xScale = 0.3
    bigA[e].yScale = 0.3
    physics.addBody(bigA[e],"dynamic",{filter=astroidCollisionFilter,radius=60})
    bigA[e].hitPoints = 0
    bigA[e].gravityScale = 0.1
    bigA[e].collision = g.mediumAstroidCollision
    bigA[e]:addEventListener("collision")
    bigA[e].body = true
    sceneGroup:insert(bigA[e])
    if enemy[en] ~= nil then 
      enemy[en]:toFront()
    end
    bar:toFront()
    g.score:toFront()
    g.coinCount:toFront()
    g.coinAnim:toFront()
    achievSign:toFront()
    rCircle:toFront()
    rRect:toFront()
    pause:toFront()
    pausedScreen:toFront()
    game.astCon = 8
    game.astCon2 = 15
    gameplay.mediumAstroidTimer2 = timer.performWithDelay(math.random(6000,10000),g.mediumAstroid,1)
    return bigA[e]
  end

  gameplay.mediumAstroidTimer = timer.performWithDelay(15000,g.mediumAstroid,1)
  local destroyBA = false 

  function g.bigAstroidCollison(self,event)
    if event.phase == "began" then
      self.hitPoints = self.hitPoints + g.shipDamage
    end
    if self.hitPoints > 25 then
      for i = #bigAstroid,1,-1 do
        table.remove(bigAstroid,i)
      end
      bigAstroid = {}
      play.bigEP2 = audio.play(play.bigE2)
      gameplay.achiev3t = gameplay.achiev3t + 1
      explodeCoinNum = math.random(7,10)
      g.bigExplode(self.x,self.y)
      g.make100PlusAnim(self.x,self.y)
      self:removeSelf()
      self = nil
    end
  end

  local checthing = 0
  function g.brownAstroidCollison(self,event)
    if self.hitPoints > 100 then
      play.bigEP2 = audio.play(play.bigE2)
      explodeCoinNum = math.random(40,50)
      g.bigExplode(self.x,self.y)
      g.make200PlusAnim(self.x,self.y)
      self:removeSelf()
      self = nil
      gameplay.achiev8t = false 
      Runtime:removeEventListener("enterFrame",self)
    elseif event.phase == "began" then
      checthing = checthing + 1 
      self.hitPoints = self.hitPoints + g.shipDamage
    end
  end

  function g.spawnBrownAstroid()
    b = b + 1
    brownAstroid[b] = display.newImage("brownAstroid.png")
    brownAstroid[b].x = math.random(1,300)
    brownAstroid[b].y = -200
    brownAstroid[b].xScale = 0.25
    brownAstroid[b].yScale = 0.3
    brownAstroid[b].hitPoints = 0
    brownAstroid[b].kind = "brownAstroid"
    physics.addBody(brownAstroid[b],"dynamic",{radius = 120,density=300,filter=astroidCollisionFilter})
    brownAstroid[b].gravityScale = 0.02
    sceneGroup:insert(brownAstroid[b])
    brownAstroid[b].collision = g.brownAstroidCollison
    brownAstroid[b]:addEventListener("collision")
    if enemy[en] ~= nil then 
      enemy[en]:toFront()
    end
    rCircle:toFront()
    rRect:toFront()
    pause:toFront()
    pausedScreen:toFront()
  end
  gameplay.brownAstroidTimer = timer.performWithDelay(55000,g.spawnBrownAstroid,0)

  function g.generateBigAstroid()
    m = m + 1
    bigAstroid[m] = display.newImage("astroid.png")
    bigAstroid[m].x = math.random(0,300)
    bigAstroid[m].y = -150
    bigAstroid[m].xScale = 0.4
    bigAstroid[m].yScale = 0.5
    physics.addBody(bigAstroid[m],"dynamic",{radius=90,filter=astroidCollisionFilter})
    bigAstroid[m].gravityScale = 0.07
    bigAstroid[m].kind = "bigAstroid"
    bigAstroid[m].hitPoints = 0
    bigAstroid[m].collision = g.bigAstroidCollison
    bigAstroid[m]:addEventListener("collision")
    gameplay.bigAstroidtimer2 = timer.performWithDelay(math.random(25000,30000),g.generateBigAstroid,1)
  	sceneGroup:insert(bigAstroid[m])
    if enemy[en] ~= nil then 
      enemy[en]:toFront()
    end
    bar:toFront()
    g.score:toFront()
    g.coinCount:toFront()
    g.coinAnim:toFront()
    achievSign:toFront()
    pause:toFront()
    pausedScreen:toFront()
    game.astCon = game.astCon - 1
    game.astCon2 = game.astCon2 - 1 
    return bigAstroid[m]
  end
  gameplay.bigAstroidtimer = timer.performWithDelay(math.random(15000,20000),g.generateBigAstroid,1)


---------------------------------------------------
  local specialRounds = 0

  local shield = display.newCircle(g.spaceship.x,g.spaceship.y,10)
  shield:setFillColor(0,0.5,0.8,0.2)
  shield.stroke = {0,0.3,0.5}
  shield.alpha = 0

  local shieldGo = 0 
  local checkShield = true 
  local pw = {}
  local u = 0 
  local t = 0
  local pwY = 95
  local pos1 = false 
  local pos2 = false 
  local pos3 = false
  local pw1Y = 0
  local pw2Y = 0
  local pw3Y = 0 

  local function moveOFF()
    for i =1,3 do 
      pw[i].y = 700
    end
  end

  pw[1] = display.newImageRect("specialAmmo.png",32,32) 
  pw[1].x = bar.x
  pw[1].y = 700
  pw[1].strokeWidth = 2.5
  pw[1]:setStrokeColor(0.6,0.6,0.6)

  pw[2] = display.newImageRect("shield.png",32,32) 
  pw[2].x = bar.x
  pw[2].y = 700
  pw[2].strokeWidth = 2.5
  pw[2]:setStrokeColor(0.6,0.6,0.6)


  pw[3] = display.newImageRect("rage.png",32,32) 
  pw[3].x = bar.x
  pw[3].y = 700
  pw[3].strokeWidth = 2.5
  pw[3]:setStrokeColor(0.6,0.6,0.6)

  function g.moveUP()
    if pos1 == false and pos2 == true then 
      if pw[1].y == 165  then 
        pw[1].y = 130
        pos1 = true 
        pos2 = false 
      elseif pw[2].y == 165 then 
        pw[2].y = 130
        pos1 = true
        pos2 = false  
      elseif pw[3].y == 165  then 
        pw[3].y = 130
        pos1 = true
        pos2 = false  
      end
    end
    if pos1 == false and pos3 == true then 
      if pw[1].y == 200  then 
        pw[1].y = 130
        pos1 = true 
        pos3 = false 
      elseif pw[2].y == 200 then 
        pw[2].y = 130
        pos1 = true
        pos3 = false  
      elseif pw[3].y == 200  then 
        pw[3].y = 130
        pos1 = true
        pos3 = false  
      end
    end
    if pos2 == false and pos3 == true then 
      if pw[1].y == 200 then 
        pw[1].y = 165
        pos2 = true 
        pos3 = false 
      elseif pw[2].y == 200 then 
        pw[2].y = 165
        pos2 = true
        pos3 = false  
      elseif pw[3].y == 200 then 
        pw[3].y = 165
        pos2 = true
        pos3 = false 
      end
    end
  end

  function g.getRidofPWI(var)
    if var == "specialAmmo" then 
      if pw[1].y == 130 then
        pos1 = false 
      elseif pw[1].y == 165 then
        pos2 = false  
      elseif pw[1].y == 200 then
        pos3 = false  
      end
      pw[1].y = 700
    elseif var == "shield" then
      if pw[2].y == 130 then
        pos1 = false 
      elseif pw[2].y == 165 then
        pos2 = false  
      elseif pw[2].y == 200 then
        pos3 = false  
      end
      pw[2].y = 700
    elseif var == "rage" then
      if pw[3].y == 130 then
        pos1 = false 
      elseif pw[3].y == 165 then
        pos2 = false  
      elseif pw[3].y == 200 then
        pos3 = false  
      end
      pw[3].y = 700
    end
    g.moveUP()
  end

  function g.selectPlacement()
    if pw[1].y == 130 or pw[2].y == 130 or pw[3].y == 130 then 
      pos1 = true 
    elseif pw[1].y == 165 or pw[2].y == 165 or pw[3].y == 165 then 
      pos2 = true 
    elseif pw[1].y == 200 or pw[2].y == 200 or pw[3].y == 200 then 
      pos3 = true 
    end
  end

  function g.placeLeft(place)
    g.selectPlacement()
    if pos1 == false then 
      pwY = 130 
      pos1 = true 
    elseif pos2 == false then 
      pwY = 165 
      pos2 = true 
    elseif pos3 == false then 
      pwY = 200 
      pos3 = true
    end
    if place == 1 then 
      pw[1].y = pwY
    elseif place == 2 then 
      pw[2].y = pwY
    elseif place == 3 then
      pw[3].y = pwY
    end
  end 

  sceneGroup:insert(pw[1])
  sceneGroup:insert(pw[2])
  sceneGroup:insert(pw[3])

  ---------------------------------------------------

  function g.goSpecialBullets()
    if g.goSB == true then 
      if g.spaceship == g.spaceship1 then 
        time[26] = timer.performWithDelay(100,g.spaceship1Bullets,50)
      elseif g.spaceship == g.spaceship2 then 
        time[27] = timer.performWithDelay(50,g.spaceship2Bullets,100)
      elseif g.spaceship == g.spaceship3 then 
        time[28] = timer.performWithDelay(100,g.spaceship3Bullets,50)
      elseif g.spaceship == g.spaceship4 then 
        time[29] = timer.performWithDelay(100,g.spaceship4Bullets,50)
      elseif g.spaceship == g.spaceship5 then 
        time[30] = timer.performWithDelay(100,g.spaceship5Bullets,50)
      elseif g.spaceship == g.spaceship6 then 
        time[31] = timer.performWithDelay(100,g.spaceship6Bullets,50)
      elseif g.spaceship == g.spaceship7 then 
        time[32] = timer.performWithDelay(100,g.spaceship7Bullets,50)
      elseif g.spaceship == g.spaceship8 then 
        time[33] = timer.performWithDelay(50,g.spaceship8Bullets,100)
      end
    end
      g.placeLeft(1)
      time[64] = timer.performWithDelay(5000,function() g.getRidofPWI("specialAmmo") end,1)
      trans[45] = transition.to(g.purplefilter,{time=400,alpha=0.3})
      trans[46] = transition.to(g.purplefilter,{delay=5500,time=400,alpha=0})
  end

  function g.runShield()
      shield.x = g.spaceship.x 
      shield.y = g.spaceship.y
  end

  function g.makeInv()
    if shieldGo == 2 then
      g.getRidofPWI("shield") 
      transition.to(shield,{time=200,xScale=1,yScale=1,alpha=0})
      timer.performWithDelay(20,function() g.goCollision = true end,1)
      Runtime:removeEventListener("enterFrame",g.runShield)
      checkShield = true 
      shieldGo = 0 
    end
  end

  function g.goShield()
    if checkShield == true then 
      transition.to(shield,{time=100,xScale=3,yScale=3,alpha=1})
      g.placeLeft(2)
      shield.strokeWidth = 1
      shieldGo = 1
      checkShield = false 
      Runtime:addEventListener("enterFrame",g.runShield)
      if g.spaceship == g.spaceship6 or g.spaceship == g.spaceship4 
      or g.spaceship == g.spaceship2 or g.spaceship == g.spaceship3 then 
        transition.to(shield,{time=100,xScale=4.2,yScale=4.2,alpha=1})
      elseif g.spaceship == g.spaceship8 or g.spaceship == g.spaceship7 then 
        transition.to(shield,{time=100,xScale=4.5,yScale=4.5,alpha=1})
      end
    end
  end

  function g.goRage()
    g.placeLeft(3)
    rCircle.alpha = 1 
    rRect.alpha = 1 
    g.shipSpeed = 6
    g.shipDamage = 200
    bSpeed1 = -800*1.5
    bSpeed2 = -600*1.5
    bSpeed3 = -1000*1.5

    trans[52] = transition.to(rCircle,{time=500,xScale=50,yScale=50})

    time[36] = timer.performWithDelay(1000,function()
      transition.to(rRect,{time=500,xScale=0.97,yScale=0.97,transition=easing.continuousLoop})
    end,0)

    time[37] = timer.performWithDelay(15000,function()
      g.getRidofPWI("rage")
      transition.to(rCircle,{time=300,xScale=0.2,yScale=0.2,alpha=0})
      transition.to(rRect,{time=500,alpha=0})
      g.shipSpeed = setSpeed
      g.shipDamage = setDamage
      bSpeed1 = -800
      bSpeed2 = -600
      bSpeed3 = -1000
      transition.cancel(trans[52])
      timer.cancel(time[36])
      --timer.cancel(time[37])
      trans[52] = nil 
      time[36] = nil 
      --time[37] = nil
      end,1)
  end

  function g.spawnSpecialAmmo()
    g.SpecialAmmo = display.newImage("specialAmmo.png")
    g.SpecialAmmo.xScale=0.4
    g.SpecialAmmo.yScale=0.4
    g.SpecialAmmo.x = math.random(1,300)
    g.SpecialAmmo.y = -130
    g.SpecialAmmo.kind = "specialAmmo"
    trans[31] = transition.to(g.SpecialAmmo,{time=500,xScale=0.5,yScale=0.5,transition=easing.continuousLoop,iterations=0})
    physics.addBody(g.SpecialAmmo,"dynamic",{radius=20,filter=assetsCollisionFilter})
    g.SpecialAmmo.gravityScale = g.spamGravity
    sceneGroup:insert(g.SpecialAmmo)
    g.goSB = true
    gameplay.specialAmmotimer2 = timer.performWithDelay(math.random(10000,20000),g.spawnSpecialAmmo,1)
  end
  gameplay.specialAmmotimer = timer.performWithDelay( math.random(7000,20000),g.spawnSpecialAmmo,1)


  function g.spawnShield()
    g.shield = display.newImage("shield.png")
    g.shield.xScale=0.4
    g.shield.yScale=0.4
    g.shield.x = math.random(1,300)
    g.shield.y = -130
    g.shield.kind = "shield"
    trans[51] = transition.to(g.shield,{time=500,xScale=0.5,yScale=0.5,transition=easing.continuousLoop,iterations=0})
    physics.addBody(g.shield,"dynamic",{radius=20,filter=assetsCollisionFilter})
    g.shield.gravityScale = g.spamGravity
    sceneGroup:insert(g.shield)
    gameplay.shieldTimer2 = timer.performWithDelay(math.random(10000,50000),g.spawnShield,1)
  end
  gameplay.shieldTimer = timer.performWithDelay( math.random(10000,50000),g.spawnShield,1)

  function g.spawnRage()
    g.rage = display.newImage("rage.png")
    g.rage.xScale=0.46
    g.rage.yScale=0.45
    g.rage.x = math.random(1,300)
    g.rage.y = -130
    g.rage.kind = "rage"
    trans[51] = transition.to(g.rage,{time=500,xScale=0.5,yScale=0.5,transition=easing.continuousLoop,iterations=0})
    physics.addBody(g.rage,"dynamic",{radius=20,filter=assetsCollisionFilter})
    g.rage.gravityScale = g.spamGravity
    sceneGroup:insert(g.rage)
    gameplay.rageTimer2 = timer.performWithDelay(math.random(18000,90000),g.spawnRage,1)
  end
  gameplay.rageTimer = timer.performWithDelay( math.random(10000,20000),g.spawnRage,1)

  function g.getRidofAssets()
    physics.stop()
  end

  function g.spaceshipExplosion()
    g.goCount = false
    g.goSpaceship = false 
    g.spaceshipCheck = false 
    time[8] = timer.performWithDelay(0,function() goAnim = false g.spaceship.x = 1000 end,1)
    
    for i = 1,20 do 
      local particle1 = display.newRect(g.spaceship.x,g.spaceship.y,3,3)
      trans[32] = transition.to(particle1,{time=500,x=math.random(-1000,1000),y=math.random(-1000,1000)})
      time[9] = timer.performWithDelay(700,function() particle1:removeSelf() particle1 = nil end,1)
      sceneGroup:insert(particle1)
    end
    return particle1
  end

  local function coinAnim(sx)
    local coinPlus =  display.newText( "+1",sx + 15,340, "stark", 30 )
    coinPlus:setFillColor(1,0.9,0.1)
    transition.to(coinPlus,{time=300,y=320,alpha=0,onComplete=function()coinPlus:removeSelf() coinPlus=nil end })
    return coinPlus
  end


  -----Enemy Code-----------------------------------------------------------------------------------------------
local enbullet
local enbullet2
local enbullet3
local enS = "enemy.png"
local enX = 0.65
local enY = 0.45
local enHP1 = 15
local enHP2 = 25
local enHP3 = 5
local en1 = true 
local en2 = false 
local en3 = false 
local enGrav = 0.07
local noEBullet = false 
local enPresent1 = false 
local enPresent2 = false 
local enPresent3 = false 

local function Config1()
  enS = "enemy.png"
  enX = 0.65
  enY = 0.45
  en1 = true 
  en2 = false 
  en3 = false
  enGrav = 0.07
end

local function Config2()
  enS = "enemy2.png"
  enX = 0.85
  enY = 0.8
  en2 = true 
  en3 = false 
  en1 = false 
  enGrav = 0.03
end

local function Config3()
  enS = "enemy3.png"
  enX = 0.6
  enY = 0.6
  en3 = true 
  en2 = false 
  en1 = false 
  enGrav = 0.07
end

local function particleEffect(s)
  for i=1,15 do 
    local particle = display.newCircle(s.x,s.y,math.random(2,3))
    particle:setFillColor(1,0,0)
    trans[54] = transition.to(particle,{time=300,x=math.random(s.x - 300,s.x + 300),y=math.random(s.y - 300,s.y + 300),alpha=0.5})
    time[39] = timer.performWithDelay(400,function()particle:removeSelf() particle = nil end,1)
    end
  end

local function enemyFire(self,event)
  if self.isHit == false then 
      local am = display.newCircle(self.x ,self.y - 30,math.random(3,10))
      am:setFillColor(math.random(1,7)/10,0.1,0.5)
      transition.to(am,{time=100,y=self.y - 70,alpha=0.3,onComplete=function() am:removeSelf() am=nil end})
      sceneGroup:insert(am)
      bar:toFront()
      g.score:toFront()
      g.coinCount:toFront()
      g.coinAnim:toFront()
      achievSign:toFront()
    end
  return am
end

local function enemyFire2(self,event)
  if self.isHit == false then 
    local am2 = display.newCircle(self.x - 15 ,self.y - 50,math.random(3,10))
    am2:setFillColor(math.random(1,7)/10,0.1,0.5)
    transition.to(am2,{time=100,y=self.y - 70,alpha=0.3,onComplete=function()am2:removeSelf() am2=nil end})
    sceneGroup:insert(am2)
    local am3 = display.newCircle(self.x + 15 ,self.y - 50,math.random(3,10))
    am3:setFillColor(math.random(1,7)/10,0.1,0.5)
    transition.to(am3,{time=100,y=self.y - 70,alpha=0.3,onComplete=function()am3:removeSelf() am3=nil end})
    sceneGroup:insert(am3)
    bar:toFront()
    g.score:toFront()
    g.coinCount:toFront()
    g.coinAnim:toFront()
    achievSign:toFront()
  end
  return am2,am3
end

local function enemyBullet(enemy)
  if enemy.isHit == false and noEBullet == false then 
    trans[56] = transition.to(enemy,{time=200,xScale=enemy.xScale*1.2,yScale=enemy.yScale*1.2,transition=easing.continuousLoop}) 
    enbullet = display.newRect(enemy.x,enemy.y + 50,9,13)
    physics.addBody(enbullet,"dynamic",{filter=astroidCollisionFilter})
    enbullet:setLinearVelocity(0,400)
    enbullet:setFillColor(1,0,0.1)
    enbullet.isBullet = true
    enbullet.gravityScale = 0 
    sceneGroup:insert(enbullet)
    end
  return enbullet
end

local function enemyBullet2(enemy)
  if enemy.isHit == false and noEBullet == false then 
    trans[56] = transition.to(enemy,{time=200,xScale=enemy.xScale*1.2,yScale=enemy.yScale*1.2,transition=easing.continuousLoop}) 
    enbullet = display.newRect(enemy.x + 23,enemy.y + 25,9,13)
    physics.addBody(enbullet,"dynamic",{filter=astroidCollisionFilter})
    enbullet:setLinearVelocity(0,400)
    enbullet:setFillColor(1,0,0.1)
    enbullet.isBullet = true
    enbullet.gravityScale = 0 
    sceneGroup:insert(enbullet)
    
    enbullet2 = display.newRect(enemy.x - 23,enemy.y + 25,9,13)
    physics.addBody(enbullet2,"dynamic",{filter=astroidCollisionFilter})
    enbullet2:setLinearVelocity(0,400)
    enbullet2:setFillColor(1,0,0.1)
    enbullet2.isBullet = true
    enbullet2.gravityScale = 0 
    sceneGroup:insert(enbullet2)
  end
  return enbullet2,enbullet3
end

local function removeEnemy(s)
  if g.spaceship.x < 350 and enbullet ~= nil then
    display.remove(enbullet)
    enbullet = nil 
  elseif g.spaceship.x < 350 and enbullet2 ~= nil then 
    display.remove(enbullet2)
    enbullet2 = nil 
    end
    particleEffect(s)
    Runtime:removeEventListener("enterFrame",enemyFire)
    s:removeSelf()
    s = nil
  if en2 == false and time[38] ~= nil then
    timer.cancel(time[38])
  end
  if en2 == true and time[42] ~= nil then
    timer.cancel(time[42])
  end
end

local explodeCoin2 = {}

local function enemyCoins(sx,sy)
  g.make100PlusAnim(sx,sy)
  for i=1,10 do 
    explodeCoin2[i] = display.newImage("coin.png")
    explodeCoin2[i].x = sx 
    explodeCoin2[i].y = sy
    explodeCoin2[i].xScale = 0.13
    explodeCoin2[i].yScale = 0.13
    timer.performWithDelay(800,function() explodeCoin2[i]:removeSelf() explodeCoin2[i] = nil end)
    transition.to(explodeCoin2[i],{delay=400,time=400,x=30,y=0,alpha=0.5})
    transition.to(explodeCoin2[i],{ time=300,x=sx + math.random(-100,100),y=sy + math.random(-100,100),onComplete=function() coinAmount = coinAmount + 1 g.coinCount.text = coinAmount end}) 
    sceneGroup:insert(explodeCoin2[i])
  end
  return explodeCoin2[i]
end

local function enemyCollision(self,event)
  if event.phase == "began" then 
    self.hitPoints = self.hitPoints + g.shipDamage
    if self.hitPoints > enHP1 then 
      enPresent1 = false 
      enemyCoins(self.x,self.y)
      removeEnemy(self)
      self.isHit = true 
      audio.play(play.astroidS8)
    elseif event.other.kind == "spaceship" or event.other.kind == "removeBar" then
      enPresent1 = false 
      Runtime:removeEventListener("enterFrame",self) 
      self.isHit = true   
      timer.cancel(time[46])
      timer.cancel(time[47])
      timer.cancel(time[48])
    end
  end
end

local function enemyCollision2(self,event)
  if event.phase == "began" then 
    self.hitPoints = self.hitPoints + g.shipDamage
    if self.hitPoints > enHP2 then
      enPresent2 = false 
      enemyCoins(self.x,self.y)
      removeEnemy(self)
      self.isHit = true 
      audio.play(play.astroidS6)
    elseif event.other.kind == "spaceship" or event.other.kind == "removeBar" then 
      enPresent2 = false 
      Runtime:removeEventListener("enterFrame",self) 
      self.isHit = true  
      for i=1,10 do
        timer.cancel(time[51+i])
      end
    end
  end
end

local function enemyCollision3(self,event)
  if event.phase == "began" then 
    self.hitPoints = self.hitPoints + g.shipDamage
    if self.hitPoints > enHP3 then
      enPresent3 = false 
      enemyCoins(self.x,self.y)
      removeEnemy(self)
      self.isHit = true
      audio.play(play.astroidS7)
    elseif event.other.kind == "spaceship" or event.other.kind == "removeBar" then
      enPresent3 = false 
      Runtime:removeEventListener("enterFrame",self) 
      self.isHit = true
      timer.cancel(time[43])
      timer.cancel(time[44])
      timer.cancel(time[45])
    end
  end
end

local function timeIt(enemy)
  time[43] = timer.performWithDelay(2500,function() enemyBullet(enemy)  end)
  time[44] = timer.performWithDelay(5000,function() enemyBullet(enemy)  end)
  time[45] = timer.performWithDelay(7500,function() enemyBullet(enemy)  end)
end

local function timeIt3(enemy)
  time[46] = timer.performWithDelay(2500,function() enemyBullet2(enemy)  end)
  time[47] = timer.performWithDelay(5000,function() enemyBullet2(enemy)  end)
  time[48] = timer.performWithDelay(7500,function() enemyBullet2(enemy)  end)
end

local function timeIt2(enemy)
  for i=1,10 do 
    time[51+i] = timer.performWithDelay(i*1000,function() enemyBullet(enemy)  end)
  end
end

local function spawnEnemy()
  en = en + 1
  enemy[en] = display.newImage(enS)
  enemy[en].x = math.random(0,300)
  enemy[en].y = -90
  enemy[en].xScale = enX
  enemy[en].yScale = enY
  enemy[en].isHit = false 
  enemy[en].kind = "enemy"
  enemy[en].rotation = -180
  enemy[en].hitPoints = 0
  physics.addBody(enemy[en],"dynamic",{filter=astroidCollisionFilter,density=300,radius=25})
  enemy[en].gravityScale = enGrav
  sceneGroup:insert(enemy[en])
  bar:toFront()
  g.score:toFront()
  g.coinCount:toFront()
  g.coinAnim:toFront()
  achievSign:toFront()
  pause:toFront()
  pausedScreen:toFront()
  if en1 == true then
    enPresent1 = true 
    timeIt3(enemy[en])
    enemy[en].collision = enemyCollision
    enemy[en]:addEventListener("collision")
    enemy[en].enterFrame = enemyFire
    Runtime:addEventListener("enterFrame",enemy[en])
  elseif en2 == true then 
    enPresent2 = true 
    timeIt2(enemy[en])
    enemy[en].collision = enemyCollision2
    enemy[en]:addEventListener("collision")
    enemy[en].enterFrame = enemyFire2
    Runtime:addEventListener("enterFrame",enemy[en])
  elseif en3 == true then 
    enPresent3 = true 
    timeIt(enemy[en])
    enemy[en].collision = enemyCollision3
    enemy[en]:addEventListener("collision")
    enemy[en].enterFrame = enemyFire
    Runtime:addEventListener("enterFrame",enemy[en])
  end
end

local enVar = 0 
local enTime1 = 10000
local enTime2 = 10000
local enTime3 = 8000


local function enemyTimer()
  enVar = math.random(1,4)
  if enVar == 1 or enVar == 2 then 
    Config1()
    spawnEnemy()
    time[49] = timer.performWithDelay(enTime1,enemyTimer,1)
  elseif enVar == 3 then 
    Config2()
    spawnEnemy()
    time[50] = timer.performWithDelay(math.random(enTime2,enTime2*2),enemyTimer,1)
  elseif enVar == 4 then 
    Config3()
    spawnEnemy()
    time[51] = timer.performWithDelay(enTime3,enemyTimer,1)
  end
end
time[41] = timer.performWithDelay(math.random(30000,40000),enemyTimer,1)

----------------------------------------------------------------------------------------------------

  local function timeGame()
    time[62] = timer.performWithDelay(96000,function()
      enTime1 = 6000
      enTime2 = 6000
      enTime3 = 4000  
    end,1)
    time[63] = timer.performWithDelay(30000,function() ammoTime = 2000 end,1)
  end
  timeGame()

----------------------------------------------------------------------------------------------------

  local function goToEnd(e)
    audio.stop()
    audio.play( play.backgroundMusic )
    moveOFF()
    rCircle.alpha = 0
    rRect.alpha = 0
    shipGo = false 
    shipGo2 = false 
    g.spaceshipExplosion()
    e.other:removeSelf()
    e.other.body = false
    e.other = nil 
    trans[44] = transition.to(g.purplefilter,{time=400,alpha=0})
    pause.isVisible = false
    g.score.isVisible = false
    bar.isVisible = false
    g.coinAnim.isVisible = false
    g.coinCount.isVisible = false
    g.goCount = false
    g.goSpaceship = false 
    shoot:removeEventListener("tap",g.tapShoot)
    g.spaceshipCheck = false
    highscores.addCoins(coinAmount)
    highscores.saveHighscore(amount - 5)
    endScreenInstance.showEndScreen()  
    time[10] = timer.performWithDelay(2,function() goAnim = false g.spaceship.x = 1000 end,1)
    if cancelS == false then
      play.crashP = audio.play( play.crash )
    end
  end

  function g.spaceshipCollision(self,event)
    if event.phase == "began" and g.goCollision == true then
        if event.other.kind == "coin" then
          coinAmount = coinAmount + 1
          g.coinCount.text = coinAmount
          g.coin.body = false 
          event.other:removeSelf()
          event.other = nil
          coinAnim(self.x)
            if cancelS == false then 
              playCoin()
            end
        elseif event.other.kind == "ammo" and g.barNum > 56 or event.other.kind == "ammo" and g.barNum > 56 - 15 then
          g.barNum = 56
          bar:setSequence(g.barNum) bar:play() event.other:removeSelf() 
          event.other = nil
          if cancelS == false then 
              play.powerUPE = audio.play( play.powerUP )
            end
        elseif event.other.kind == "ammo" and g.barNum < 0 then
          g.barNum = 15
          bar:setSequence(g.barNum) bar:play() event.other:removeSelf()  
          event.other = nil
          if cancelS == false then 
              play.powerUPE = audio.play( play.powerUP )
            end
        elseif event.other.kind == "ammo" then
          g.barNum = g.barNum + g.barNumPlus
          bar:setSequence(g.barNum) bar:play() event.other:removeSelf() 
          event.other = nil
            if cancelS == false then 
              play.powerUPE = audio.play( play.powerUP )
            end
        elseif event.other.kind == "specialAmmo" then 
          event.other:removeSelf()
          event.other = nil
          g.goSpecialBullets()
            if cancelS == false then 
              play.powerUPE2 = audio.play( play.powerUP2 )
            end
        elseif event.other.kind == "shield" then
          g.goShield() 
          event.other:removeSelf()
          event.other = nil
            if cancelS == false then 
              play.powerUPE2 = audio.play( play.powerUP2 )
            end
        elseif event.other.kind == "rage" then
          g.goRage()
          event.other:removeSelf()
          event.other = nil
            if cancelS == false then 
              play.powerUPE2 = audio.play( play.powerUP2 )
            end
        elseif event.other.kind == "enemy" and shieldGo == 0 then 
          Runtime:removeEventListener("enterFrame",event.other)
          goToEnd(event)
        elseif shieldGo == 0 then 
          goToEnd(event)
        else
          shieldGo = shieldGo + 1
          g.makeInv()
          event.other:removeSelf()
          event.other = nil 
      end
    end
  end
  g.spaceship.collision = g.spaceshipCollision
  g.spaceship:addEventListener("collision")

  local tr = true 

  local options = {
    params = { 
      effect = "fade",
      spaceship1 = g.spaceship1,
      spaceship2 = g.spaceship2,
      spaceship3 = g.spaceship3,
      spaceship4 = g.spaceship4,
      spaceship5 = g.spaceship5,
      spaceship6 = g.spaceship6,
      spaceship7 = g.spaceship7,
      spaceship8 = g.spaceship8,
      spaceship = g.spaceship,
      cancelS = cancelS,
      onGo = g.onGo,
    }
  }

  function g.getRidofTrans()
    for i=1,56 do 
      if trans[i] ~= nil then
        transition.cancel(trans[i]) 
        trans[i] = nil 
      end
    end
  end

  function g.getRidofTimers()
    for i=1,64 do 
      if time[i] ~= nil then
        timer.cancel(time[i]) 
        time[i] = nil 
      end
    end
  end

  function g.pauseTrans()
    for i=1,56 do 
      if trans[i] ~= nil then
        transition.pause(trans[i]) 
      end
    end
  end

  function g.pauseTimers()
    for i=1,64 do 
      if time[i] ~= nil then
        timer.pause(time[i]) 
      end
    end
  end

  function g.resumeTrans()
    for i=1,56 do 
      if trans[i] ~= nil then
        transition.resume(trans[i]) 
      end
    end
  end

  function g.resumeTimers()
    for i=1,64 do 
      if time[i] ~= nil then
        timer.resume(time[i]) 
      end
    end
  end


  gameplay.th = true

--------------------------------------------------------------------

  function g.stopTimers()
    if gameplay.specialAmmotimer2 ~= nil then 
      timer.pause(gameplay.specialAmmotimer2)
    end
    if gameplay.mediumAstroidTimer2 ~= nil then 
      timer.pause(gameplay.mediumAstroidTimer2) 
    end 
    if gameplay.bigAstroidtimer2 ~= nil then 
      timer.pause(gameplay.bigAstroidtimer2)
    end
    if gameplay.astroidtimer2 ~= nil then 
      timer.pause(gameplay.astroidtimer2)
    end
    if gameplay.shieldTimer2 ~= nil then 
      timer.pause(gameplay.shieldTimer2)
    end
    if gameplay.rageTimer2 ~= nil then 
      timer.pause(gameplay.rageTimer2)
    end
    timer.pause(gameplay.coinTimer)
    timer.pause(gameplay.specialAmmotimer)
    timer.pause(gameplay.bigAstroidtimer)
    timer.pause(gameplay.brownAstroidTimer)
    timer.pause(gameplay.mediumAstroidTimer)
    timer.pause(gameplay.astroidtimer1)
    timer.pause(gameplay.amountTimer)
    timer.pause(gameplay.astroidTimer)
    timer.pause(gameplay.shieldTimer)
    timer.pause(gameplay.rageTimer)
    g.pauseTrans()
    g.pauseTimers()
  end


  function g.continueTimers()
    if gameplay.specialAmmotimer2 ~= nil then 
      timer.resume(gameplay.specialAmmotimer2)
    end
    if gameplay.mediumAstroidTimer2 ~= nil then 
      timer.resume(gameplay.mediumAstroidTimer2) 
    end 
    if gameplay.bigAstroidtimer2 ~= nil then 
      timer.resume(gameplay.bigAstroidtimer2)
    end
    if gameplay.astroidtimer2 ~= nil then 
      timer.resume(gameplay.astroidtimer2)
    end
    if gameplay.shieldTimer2 ~= nil then 
      timer.resume(gameplay.shieldTimer2)
    end
    if gameplay.rageTimer2 ~= nil then 
      timer.resume(gameplay.rageTimer2)
    end
    timer.resume(gameplay.coinTimer)
    timer.resume(gameplay.specialAmmotimer)
    timer.resume(gameplay.bigAstroidtimer)
    timer.resume(gameplay.brownAstroidTimer)
    timer.resume(gameplay.mediumAstroidTimer)
    timer.resume(gameplay.astroidtimer1)
    timer.resume(gameplay.amountTimer)
    timer.resume(gameplay.astroidTimer)
    timer.resume(gameplay.shieldTimer)
    timer.resume(gameplay.rageTimer)
    g.resumeTimers()
    g.resumeTrans()
  end


  function g.tapPause(event)
      playPress()
    if pauseVar == false and event.target.kind == "pause" then 
      pauseVar = true 
      pause.alpha = 0.3 
      pausedScreen.alpha = 1
      g.stopTimers()
      timer.performWithDelay(200,function() pause.alpha=1 end,1)
      physics.pause()
      g.goSpaceship = false 
      g.goBullets = false
      g.spaceship.rotation = 0
      shoot:removeEventListener("tap",g.tapShoot)
    elseif pauseVar == true and event.target.kind == "pausePlay" or event.target.kind == "pause" then
      g.continueTimers()
      pauseVar = false 
      pausedScreen.alpha = 0
      physics.start()
      g.goSpaceship = true 
      g.goBullets = true 
      shoot:addEventListener("tap",g.tapShoot)
    end
      return true
  end
  pause:addEventListener("tap",g.tapPause)
  pausedScreen:addEventListener("tap",g.tapPause)

  local tapHomeButton
  local tapReplayButton

  function g.goToReplay()
    time[11] = timer.performWithDelay(300, function()
    if gameplay.specialAmmotimer2 ~= nil then 
      timer.cancel(gameplay.specialAmmotimer2)
      gameplay.specialAmmotimer2 = nil
    end

    if gameplay.mediumAstroidTimer2 ~= nil then 
      timer.cancel(gameplay.mediumAstroidTimer2) 
      gameplay.mediumAstroidTimer2 = nil
    end 

    if gameplay.bigAstroidtimer2 ~= nil then 
      timer.cancel(gameplay.bigAstroidtimer2)
      gameplay.bigAstroidtimer2 = nil
    end
    if gameplay.shieldTimer2 ~= nil then 
      timer.cancel(gameplay.shieldTimer2)
      gameplay.shieldTimer2 = nil
    end
    if gameplay.rageTimer2 ~= nil then 
      timer.cancel(gameplay.rageTimer2)
      gameplay.rageTimer2 = nil
    end
    if enPresent1 == true or enPresent2 == true or enPresent3 == true then 
      enemy[en]:removeEventListener("collision")
      Runtime:removeEventListener("enterFrame",enemyFire)
    end

    g.getRidofTrans()
    g.getRidofSounds()
    g.getRidofTimers()
    timer.cancel(gameplay.coinTimer)
    timer.cancel(gameplay.specialAmmotimer)
    timer.cancel(gameplay.bigAstroidtimer)
    timer.cancel(gameplay.brownAstroidTimer)
    timer.cancel(gameplay.mediumAstroidTimer)
    timer.cancel(gameplay.astroidtimer1)
    timer.cancel(gameplay.amountTimer)
    timer.cancel(gameplay.astroidtimer2)
    timer.cancel(gameplay.astroidTimer)
    timer.cancel(gameplay.shieldTimer)
    timer.cancel(gameplay.rageTimer)

    gameplay.coinTimer = nil
    gameplay.specialAmmotimer = nil
    gameplay.bigAstroidtimer = nil
    gameplay.brownAstroidTimer = nil
    gameplay.mediumAstroidTimer = nil
    gameplay.astroidtimer1 = nil
    gameplay.amountTimer = nil
    gameplay.astroidtimer2 = nil
    gameplay.astroidTimer = nil
    gameplay.shieldTimer = nil 
    gameplay.rageTimer = nil 

    Runtime:removeEventListener("enterFrame",g.runShield)
    maneuver:removeEventListener("touch",g.moveSpaceship)
    Runtime:removeEventListener("enterFrame",g.goSpaceShip)
    Runtime:removeEventListener("enterFrame",g.goSpaceShip2)
    Runtime:removeEventListener("enterFrame",g.checkSpaceship)
    Runtime:removeEventListener( "enterFrame", monitorMem )
    g.spaceship:removeEventListener("collision")
    shoot:removeEventListener("tap",g.tapShoot)
    g.removeBar:removeEventListener("collision")
    Runtime:removeEventListener("enterFrame",onEnterFrame)
    pause:removeEventListener("tap",g.tapPause)
    pausedScreen:removeEventListener("tap",g.tapPause)
    Runtime:removeEventListener("touch",g.firstTap)
    endScreenInstance.homeButton:removeEventListener("tap",tapHomeButton)
    endScreenInstance.replayButton:removeEventListener("tap",tapReplayButton)
    --Missing Bullet1 and Bullet2
    --Missing BigA[e] collision 
    --Missing brownAstroid[b] collision
    --Missing bigAstroid[m] collision 

    package.loaded["bar"] = nil
    barInfo = nil
    package.loaded["menu"] = nil 
    menu = nil 
    package.loaded["endScreen"] = nil
    endScreen = nil 

    g.spaceship.x = screenW/2

    display.remove(g.startGroup)
    display.remove(endScreenInstance.endGroup)

    endScreenInstance.endGroup = nil
    g.startGroup = nil
    gameplay = nil
    game = nil
    bigA = nil
    bigAstroid = nil
    brownAstroid = nil
    astroid = nil
    trans = nil
    time = nil
    play = nil 
    shootSounds = nil
    achievSignOrderData = nil
    wallCollisionFilter = nil
    assetsCollisionFilter = nil
    bulletCollisionFilter = nil
    astroidCollisionFilter = nil 
    boundryCollisionFilter = nil
    noEBullet = true 
    getRidofGame()

    if tr == false then 
      physics.removeBody(g.spaceship)
      g.getRidofAssets()
      composer.removeScene("level1")
      composer.gotoScene("replay", options)
      g.spaceship.rotation = 0
      g = nil
    elseif tr == true then 
      physics.removeBody(g.spaceship)
      goAnim = false
      g.getRidofAssets()
      composer.removeScene("level1")
      composer.gotoScene("menu","fade", 200)
      g.spaceship.x = screenW/2
      g.spaceship.y = 240
      g.spaceship.rotation = 0
      g.spaceship:removeSelf()
      g.spaceship = nil 
      g = nil
    end
  end,1)
end

  tapHomeButton = function()
    playPress()
    if gameplay.th == true then
      Runtime:removeEventListener("enterFrame",g.onGo)
      gameplay.th = false
      trans[34] = transition.to(endScreenInstance.homeButton,{time=250,alpha=0,transition=easing.continuousLoop})
      g.goToReplay()
      audio.pause( play.backgroundMusic )
    end
      return true
  end
  endScreenInstance.homeButton:addEventListener("tap",tapHomeButton)

  tapReplayButton = function()
    playPress()
    if tr == true then 
      tr = false 
      trans[33] = transition.to(endScreenInstance.replayButton,{time=250,alpha=0,transition=easing.continuousLoop})
      g.goToReplay()
      audio.pause( play.backgroundMusic )
      return true 
    end
  end
  endScreenInstance.replayButton:addEventListener("tap",tapReplayButton)


----------------------------------------------------------------------
  g.stopTimers()
  g.firstTapVar = true
  timer.pause(time[13])

  g.firstTap = function()
  if g.firstTapVar == true then
    g.firstTapVar = false
    g.continueTimers()
    timer.resume(time[13])
    trans[1] = transition.to(g.startGroup,{time=500,alpha=0})
    if cancelS == false then
     play.sound = audio.play( play.backgroundMusic,{loops=-1} )
      end
    end
  end
  Runtime:addEventListener("touch",g.firstTap)


-----------------------------------------------------------------------  

  sceneGroup:insert(pause)
  sceneGroup:insert(pausedScreen)
  sceneGroup:insert(bar)
  sceneGroup:insert(g.removeBar)
  sceneGroup:insert(g.score)
  sceneGroup:insert(g.coinCount)
  sceneGroup:insert(g.boundry)
  sceneGroup:insert(achievSign)
  sceneGroup:insert(g.startGroup)
  sceneGroup:insert(stars)
  sceneGroup:insert(g.purplefilter)
  sceneGroup:insert(rCircle)
  sceneGroup:insert(rRect)

  stars:toBack()
  achievSign:toFront()


end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
      composer.removeHidden() 
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	  	physics.start()
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	
	local phase = event.phase
	
	if event.phase == "will" then
     -- package.loaded[physics] = nil

		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
      physics.stop()
	elseif phase == "did" then

		-- Called when the scene is now off screen
	end	
	
end

function scene:destroy( event )
	-- composer.gotoScene( "level1" )  
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.

  updateTotalCoins()
  updateAchieves()
  local sceneGroup = self.view

  
  package.loaded[physics] = nil
  physics = nil

end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene