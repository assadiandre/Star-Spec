local endscreen = {}

function endscreen:createEndScreen()
	local high = require('highscores') 
	local game = {}
	local screenW = display.contentWidth
	local screenH = display.contentHeight
	local screenW = display.contentWidth
	local screenH = display.contentHeight
 	local transTable = {}
 	local dontPop = high.getDontPop()
 	local popChance = 0
 	local getRidofpopGroup
 	local popVar = false 

	game.endGroup = display.newGroup()
	game.endLetter1 = display.newText( "G", screenW/2 - 130, screenH/2 - 20, "Future Now", 70 ) 
	game.endLetter2 = display.newText( "A", screenW/2 - 90, screenH/2 - 40 , "Future Now", 70 ) 
	game.endLetter3 = display.newText( "M", screenW/2 - 60, screenH/2 - 60, "Future Now", 70 ) 
	game.endLetter4 = display.newText( "E", screenW/2 -30, screenH/2 - 80, "Future Now", 70 ) 
	game.endLetter5 = display.newText( "O", screenW/2 + 35, screenH/2 - 100, "Future Now", 70 )
	game.endLetter6 = display.newText( "V", screenW/2 + 70, screenH/2 - 120, "Future Now", 70 ) 
	game.endLetter7 = display.newText( "E", screenW/2 + 110, screenH/2 - 140, "Future Now", 70 ) 
	game.endLetter8 = display.newText( "R", screenW/2 + 140, screenH/2 - 160, "Future Now", 70 ) 
	
	game.endGroup:insert(game.endLetter1)
	game.endGroup:insert(game.endLetter2)
	game.endGroup:insert(game.endLetter3)
	game.endGroup:insert(game.endLetter4)
	game.endGroup:insert(game.endLetter5)
	game.endGroup:insert(game.endLetter6)
	game.endGroup:insert(game.endLetter7)
	game.endGroup:insert(game.endLetter8)
	game.endGroup.x = 400
	game.endGroup.y = -100
	game.endDelay = 300

	game.replayButton = display.newImage("playB.png")
	game.replayButton.x = screenW/2 + 500
	game.replayButton.y = screenH/2 + 250
	game.replayButton.xScale = 0.5
	game.replayButton.yScale = 0.5
	game.endGroup:insert(game.replayButton)

	game.homeButton = display.newImage("menuB.png")
	game.homeButton.x = screenW/2 + 500
	game.homeButton.y = screenH/2 + 250
	game.homeButton.xScale = 0.5
	game.homeButton.yScale = 0.5
	game.endGroup:insert(game.homeButton)

 	game.sPy = screenH/2 +130
 	game.sPy2 = screenH/2 +85


 	local popGroup
	local popUp
	local popY
	local popN

 	local function yesTap()
 		local url = "https://itunes.apple.com/us/app/star-spec/viewContentsUserReviews/id1185775000?ls=1&mt=8"
		system.openURL( url )
		getRidofpopGroup(500)
		popY.alpha = 0.4
		high.dontPop()
		return url
 	end


 	local function noTap()
	 	if popVar == false then 
			transition.to(popGroup,{time=500,alpha=0})
			getRidofpopGroup(1000)
			popN.alpha = 0.4
			popVar = true 
		end
 	end

 	local function popIt()
 		popGroup = display.newGroup()
 		popUp = display.newImage("popUp.png",screenW/2,screenH/2)
 		popY = display.newImage("yesPop.png",popUp.x + 70,popUp.y + 110)
 		popY.xScale = 1.2 popY.yScale = 1.2
 		popN = display.newImage("noPop.png",popUp.x - 70,popUp.y + 110)
 		popN.xScale = 1.2 popN.yScale = 1.2
 		popGroup:insert(popUp)
 		popGroup:insert(popY)
 		popGroup:insert(popN)
 		popGroup.alpha = 0 
 		transition.to(popGroup,{time=700,alpha=1})
 		popY:addEventListener("tap",yesTap)
 		popN:addEventListener("tap",noTap)
 	end

	function game.showEndScreen()
		local highscores = require('highscores')
		local scores = highscores.getSaveData()
 		local totalCoins = highscores.getCoins()
 		popChance = math.random(1,17)

		if popChance == 1 and dontPop == false then 
			popIt()
		elseif popChance ~= 1 or dontPop == true then 

		transTable[1] = transition.to(game.endGroup,{time=500,x=0})
		transTable[2] = transition.to(game.replayButton,{time=500,x=screenW/2 + 65})
		transTable[3] = transition.to(game.homeButton,{time=500,x=screenW/2 - 65})
		transTable[4] = transition.to(game.endLetter1,{delay=game.endDelay,time=50,y=screenH/2,alpha=1})
		transTable[5] = transition.to(game.endLetter2,{delay=game.endDelay,time=100,y=screenH/2,alpha=1})
		transTable[6] = transition.to(game.endLetter3,{delay=game.endDelay,time=150,y=screenH/2,alpha=1})
		transTable[7] = transition.to(game.endLetter4,{delay=game.endDelay,time=200,y=screenH/2,alpha=1})
		transTable[8] = transition.to(game.endLetter5,{delay=game.endDelay,time=250,y=screenH/2,alpha=1})
		transTable[9] = transition.to(game.endLetter6,{delay=game.endDelay,time=300,y=screenH/2,alpha=1})
		transTable[10] = transition.to(game.endLetter7,{delay=game.endDelay,time=350,y=screenH/2,alpha=1})
		transTable[11] = transition.to(game.endLetter8,{delay=game.endDelay,time=400,y=screenH/2,alpha=1})

		game.scoretemp = display.newImage("score.png")
		game.scoretemp.x = screenW/2
		game.scoretemp.y = screenH/2 + 120
		game.endGroup:insert(game.scoretemp)

		game.totalCoins = display.newText( "", screenW/2 - 20 , screenH/2 + 170, "Future Now", 30 )
		game.totalCoins.text = totalCoins
		game.endGroup:insert(game.totalCoins)


		if scores[1] ~= nil and scores[1] < amount then 
			game.hs = display.newText( "", screenW/2 , game.sPy , "Future Now", 30 )
			game.hs.text =  amount - 5
			game.hs:setFillColor(1,0,0)

			game.s = display.newText( "", screenW/2  , game.sPy2 , "Future Now", 30 )
			game.s.text = amount - 5

			game.endGroup:insert(game.hs)
			game.endGroup:insert(game.s)

			transTable[12] = transition.to(game.s,{time=700,xScale=1.2,yScale=1.2,transition=easing.continuousLoop,iterations=0})
			transTable[13] = transition.to(game.hs,{time=700,xScale=1.2,yScale=1.2,transition=easing.continuousLoop,iterations=0})

		else	

			game.hs = display.newText( "", screenW/2 , game.sPy, "Future Now", 30 )
			game.hs.text =  scores[1]

			game.s = display.newText( "", screenW/2  , game.sPy2, "Future Now", 30 )
			game.s.text = amount - 5

			game.endGroup:insert(game.hs)
			game.endGroup:insert(game.s)

			end
		end
	end


 	getRidofpopGroup = function (time)
		timer.performWithDelay(time,function()
			dontPop = true
			popUp:removeSelf() 
			popY:removeSelf()
			popN:removeSelf()
			popUp = nil 
			popY = nil 
			popN = nil 
			popGroup:removeSelf()
			popGroup = nil
			game.showEndScreen() 
		end,1)
	end

	function getRidofGame()
	display.remove(game.endGroup)
		game = nil 
		endscreen = nil
			for i=1,13 do 
		      if transTable[i] ~= nil then
		        transition.cancel(transTable[i]) 
		        transTable[i] = nil 
		      end
		end
	end

	return game
end

return endscreen






