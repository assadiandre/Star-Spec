local composer = require( "composer" )
local scene = composer.newScene()
local getRidofTimers
local keepChecked
local configureForIpad

function scene:create( event )

	local sceneGroup = self.view
	local iap = require("iap_badger")
	local spinner=nil
	local coinText=nil
	local buyCoins10=nil
	local highscores = require('highscores')
	local totalCoins =  highscores.getCoins()
	local coin = {}
	local screenW = display.contentWidth
	local screenH = display.contentHeight
	local actualHeight = display.actualContentHeight
	local time = {}
	local trans = {}
	local bp1Var = highscores.getBpVar1()
	local bp2Var = highscores.getBpVar2()
	local bp3Var = highscores.getBpVar3()
	local confirm1 = false 
	local confirm2 = false 
	local confirm3 = false
	local buyGroup = display.newGroup()
	local backGroup = display.newGroup()
	local iCbackX = 0
	local iCbackY = 0

  local coinBack = display.newImage("coinTile.png")
  coinBack.x = 240
  coinBack.y = -(screenH - actualHeight)/2 + 465

  local coins = display.newText( "", coinBack.x+15 , coinBack.y , "Future Now", 30 )
  coins.text = totalCoins

  local buyBack = display.newImage("storeTitle.png")
  buyBack.x = screenW/2 
  buyBack.y = 100
  buyGroup:insert(buyBack)

  local buy1Plate = display.newImage("buy1.png")
  buy1Plate.x = 80
  buy1Plate.y = 55
  buy1Plate.product="buy1"
  buyGroup:insert(buy1Plate)

  local buy2Plate = display.newImage("buy2.png")
  buy2Plate.x = 240
  buy2Plate.y = 55
  buy2Plate.product="buy2"
  buyGroup:insert(buy2Plate)

  local buy3Plate = display.newImage("buy3.png")
  buy3Plate.x = 80
  buy3Plate.y = 180
  buy3Plate.product="buy3"
  buyGroup:insert(buy3Plate)

  local buy4Plate = display.newImage("buy4.png")
  buy4Plate.x = 240
  buy4Plate.y = 180
  buy4Plate.product="buy4"
  buyGroup:insert(buy4Plate)

	local backb = display.newImage("back.png")
	backb.x = 55
	backb.y = -(screenH - actualHeight)/2 + 440
	backb.xScale = 0.4
	backb.yScale = 0.4

	local function coinAnimation(coinX,coinY)
		for i = 1,30 do 
			coin[i] = display.newImage("coin.png")
			coin[i].xScale = 0.15
			coin[i].yScale = 0.15
			coin[i].x = coinX 
			coin[i].y = coinY 
			trans[1] = transition.to(coin[i],{time=400,x=math.random(coinX - 100,coinX + 100),y=math.random(coinY - 100,coinY + 100)})
			trans[2] = transition.to(coin[i],{delay = 400,time=math.random(500,1000),x=200,y=510,onComplete=function() coin[i]:removeSelf() coin[i]=nil end})
		end
	end
    
	local catalogue = {
	    products = {	
	        buy1 = {
	                productNames = { apple="Package1", google="0", amazon="0"},
	                productType = "consumable",
	                onPurchase=function() highscores.addCoins(8000)  coinAnimation(buy1Plate.x,buy1Plate.y)
	                time[1] = timer.performWithDelay(5,function() totalCoins = totalCoins + 100 coins.text = totalCoins end,80) end,
	                onRefund=function()  end,
	        },
	        
	        buy2 = {
	                productNames = { apple="Package2", google="0", amazon="0"},
	                productType = "consumable",
	                onPurchase=function() highscores.addCoins(17000) coinAnimation(buy2Plate.x,buy2Plate.y)
	                time[2] = timer.performWithDelay(5,function() totalCoins = totalCoins + 100 coins.text = totalCoins end,170) end,
	                onRefund=function()  end,
	        },

	        buy3 = {
			        productNames = { apple="Package3", google="0", amazon="0"},
			        productType = "consumable",
			        onPurchase=function() highscores.addCoins(25000) coinAnimation(buy3Plate.x,buy3Plate.y)
			        time[3] = timer.performWithDelay(5,function() totalCoins = totalCoins + 100 coins.text = totalCoins end,250) end,
			        onRefund=function()  end,
	        },

		     buy4 = {
			        productNames = { apple="Package4", google="0", amazon="0"},
			        productType = "consumable",
			        onPurchase=function() highscores.addCoins(35000) coinAnimation(buy4Plate.x,buy4Plate.y)
			        time[4] = timer.performWithDelay(5,function() totalCoins = totalCoins + 100 coins.text = totalCoins end,350) end,
			        onRefund=function()  end,
	        },
	    },
	}

	getRidofTimers=function()
		for i=1,4 do 
			if time[i] ~= nil then 
				timer.cancel(time[i])
				time[i] = nil
			end
		end
		for i=1,3 do 
			if trans[i] ~= nil then 
				transition.cancel(trans[i])
				trans[i] = nil	
			end
		end
	end

	local function failedListener()
	  if (spinner) then 
	      spinner:removeSelf()
	      spinner=nil
	    end
	  end

	local iapOptions = {
	    catalogue=catalogue,
	    filename="example2.txt",
	    salt = "something tr1cky to gue55!",
	    failedListener=failedListener,
	    cancelledListener=failedListener,
	    --Once the product has been purchased, it will remain in the inventory.  Uncomment the following line
	    --to test the purchase functions again in future.
	    --doNotLoadInventory=true,
	    --debugMode=true,
	}

	iap.init(iapOptions)

	local function purchaseListener(product)
	    spinner:removeSelf()
	    spinner=nil
		highscores.saveHighscore()
	    native.showAlert("Info", "Your purchase was successful", {"Okay"})
	end

buyCoins=function(event)
    
    --Place a progress spinner on screen and tell the user the app is contating the store
    local spinnerBackground = display.newRect(160,240,360,600)
    spinnerBackground:setFillColor(1,1,1,0.75)
    --Spinner consumes all taps so the user cannot tap the purchase button twice
    spinnerBackground:addEventListener("tap", function() return true end)
    local spinnerText = display.newText("Contacting " .. iap.getStoreName() .. "...", 160,180, native.systemFont, 18)
    spinnerText:setFillColor(0,0,0)
    --Add a little spinning rectangle
    local spinnerImg = display.newImage("loading.png")
    spinnerImg.x = 160
    spinnerImg.y = 260
    spinnerImg.xScale = 0.1
    spinnerImg.yScale = 0.1
    spinnerImg:setFillColor(0.25,0.25,0.25)
    trans[3] = transition.to(spinnerImg, { time=4000, rotation=360, iterations=0, transition=easing.inOutQuad})
    --Create a group and add all these objects to it
    spinner=display.newGroup()
    spinner:insert(spinnerBackground)
    spinner:insert(spinnerText)
    spinner:insert(spinnerImg)
    
    --Tell IAP to initiate a purchase - the product name will be stored in target.product
    iap.purchase(event.target.product, purchaseListener)
    
end
  buy1Plate:addEventListener("tap", buyCoins)
  buy2Plate:addEventListener("tap", buyCoins)
  buy3Plate:addEventListener("tap", buyCoins)
  buy4Plate:addEventListener("tap", buyCoins)

	sceneGroup:insert(buyGroup)

	local function backBalpha()
		backb.alpha = 1
		end

	local titleBar = display.newImage("titleBar.png")
	titleBar.x = screenW/2
	titleBar.y = 380
	backGroup:insert(titleBar)

	local check = display.newImage("bpCheck.png")
	check.x = 500
	check.y = 0

	local bP1 = display.newImage("bp1.png")
	bP1.x = 55
	bP1.y = 400
	bP1.kind = "bP1"
	backGroup:insert(bP1)
	local bpurchased1 = display.newImage("bp1Bought.png",bP1.x,bP1.y) 
	bpurchased1.isVisible = false 
	backGroup:insert(bpurchased1)

	local bP2 = display.newImage("bp2.png")
	bP2.x = 160
	bP2.y = 400
	bP2.kind = "bP2"
	backGroup:insert(bP2)
	local bpurchased2 = display.newImage("bp2Bought.png",bP2.x,bP2.y) 
	bpurchased2.isVisible = false
	backGroup:insert(bpurchased2)

	local bP3 = display.newImage("bp3.png")
	bP3.x = 265
	bP3.y = 400
	bP3.kind = "bP3"
	backGroup:insert(bP3)
	local bpurchased3 = display.newImage("bp3Bought.png",bP3.x,bP3.y) 
	bpurchased3.isVisible = false
	backGroup:insert(bpurchased3)

	local function minus500()
		timer.performWithDelay(20,function()
			totalCoins = totalCoins - 10
			coins.text = totalCoins
		end,50)
		highscores.addCoins(-500)
		highscores.saveHighscore()
	end

	 keepChecked = function()
		if bp1Var == true then 
			bpurchased1.isVisible = true
		end
		if bp2Var == true then 
			bpurchased2.isVisible = true
		end
		if bp3Var == true then 
			bpurchased3.isVisible = true
		end
		if backgroundString == "bkg/galaxy2.png" then
			check.x = bP1.x - iCbackX
			check.y = bP1.y - iCbackY
		elseif backgroundString == "bkg/galaxy3.png" then 
			check.x = bP2.x 
			check.y = bP2.y - iCbackY
		elseif backgroundString == "bkg/galaxy4.png" then
			check.x = bP3.x + iCbackX
			check.y = bP3.y - iCbackY
		end
	end
	
	local tapCheck1 = true
	local tapCheck2 = true 
	local tapCheck3 = true 

	local function youBought()
		local boughtText = display.newText( "$$Item Bought!$$", screenW/2 , 200 , "Stark", 40 )
		boughtText:setFillColor(0,1,0.2)
		transition.to(boughtText,{time=3000,alpha=0,y=boughtText.y - 30,onComplete= 
		function() boughtText:removeSelf() boughtText = nil end})

		sceneGroup:insert(boughtText)
		return boughtText
	end

	local function insuff()
		local insuffText = display.newText( "Insufficent Funds", screenW/2 , 200 , "Stark", 30 )
		insuffText:setFillColor(1,0,0)
		transition.to(insuffText,{time=3000,alpha=0,y=insuffText.y - 30,onComplete= 
		function() insuffText:removeSelf() insuffText = nil end})
		sceneGroup:insert(insuffText)
		return insuffText
	end

	local askGroup = display.newGroup()
	local yes2 = display.newImage("yes2.png",screenW/2 - 70, screenH/2 + 70)
	local no2 = display.newImage("no2.png",screenW/2 + 70, screenH/2 + 70)
	local ask = display.newImage("sure.png",screenW/2, screenH/2 - 50)
	ask.xScale, ask.yScale = 0.8, 0.8
	askGroup:insert(yes2) askGroup:insert(no2) askGroup:insert(ask)
	askGroup.alpha = 0
	local b = 0 

	local function tapYes(event)
		if event.phase == "began" then 
			if b == 1 then
				highscores.BpVar1()
				minus500()
				confirm1 = true
				bpurchased1.isVisible = true 
				youBought() 
				b = 0
			elseif b == 2 then 
				highscores.BpVar2()
				minus500()
				confirm2 = true 
				bpurchased2.isVisible = true 
				youBought()
				b = 0
			elseif b == 3 then 
				highscores.BpVar3()
				minus500()
				confirm3 = true
				bpurchased3.isVisible = true 
				youBought()
				b = 0
			end
		end
		playPress()
		transition.to(yes2,{time=100,xScale=1.2,yScale=1.2,transition=easing.continuousLoop})
		transition.to(askGroup,{time=100,alpha=0})
		return true 
	end

	local function tapNo(event)
		if event.phase == "began" then 
			playPress()
			transition.to(no2,{time=100,xScale=1.2,yScale=1.2,transition=easing.continuousLoop})
			transition.to(askGroup,{time=300,alpha=0})
		end
		return true 
	end

	local function askYN()
		transition.to(askGroup,{time=100,alpha=1})
		no2:addEventListener("touch",tapNo)
		yes2:addEventListener("touch",tapYes)
	end

	local function tapBp(event)
		if event.phase == "began" then
			if totalCoins >= 500 then 
				if event.target.kind == "bP1" and bp1Var == false and confirm1 == false then
					b = 1 
					askYN()
				elseif event.target.kind == "bP2" and bp2Var == false and confirm2 == false then
					b = 2 
					askYN()
				elseif event.target.kind == "bP3" and bp3Var == false and confirm3 == false then
					b = 3 
					askYN()
				end
			end
		end
		if event.phase == "began" then
			if tapCheck1 == false and event.target.kind == "bP1"  then 
				check.x = 600 
				bkgSelect = false
				tapCheck1 = true 
			elseif tapCheck2 == false and event.target.kind == "bP2" then 
				check.x = 600 
				bkgSelect = false
				tapCheck2 = true 
			elseif tapCheck3 == false and event.target.kind == "bP3" then 
				check.x = 600 
				bkgSelect = false
				tapCheck3 = true
			elseif event.target.kind == "bP1" and bp1Var == true and tapCheck1 == true 
				or event.target.kind == "bP1" and confirm1 == true and tapCheck1 == true then
				check.x = bP1.x - iCbackX
				check.y = bP1.y - iCbackY
				backgroundString = "bkg/galaxy2.png"
				bkgSelect = true 
				tapCheck1 = false
				tapCheck2 = true 
				tapCheck3 = true 
			elseif event.target.kind == "bP2" and bp2Var == true and tapCheck2 == true or
			event.target.kind == "bP2" and confirm2 == true and tapCheck2 == true then 
				check.x = bP2.x 
				check.y = bP2.y - iCbackY
				backgroundString = "bkg/galaxy3.png"
				bkgSelect = true
				tapCheck2 = false
				tapCheck3 = true 
 				tapCheck1 = true 
			elseif event.target.kind == "bP3" and bp3Var == true and tapCheck3 == true or 
			event.target.kind == "bP3" and confirm3 == true and tapCheck3 == true then
				check.x = bP3.x + iCbackX
				check.y = bP3.y - iCbackY
				backgroundString = "bkg/galaxy4.png"
				bkgSelect = true
				tapCheck3 = false 
				tapCheck2 = true
 				tapCheck1 = true 
 			elseif totalCoins < 500 then
 				insuff()
			end
		end	
		playPress()
		return false
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
	backb:addEventListener("touch",tapBackb)

	bP3:addEventListener("touch",tapBp)
	bP2:addEventListener("touch",tapBp)
	bP1:addEventListener("touch",tapBp)


	configureForIpad = function()
		if system.getInfo("model") == "iPad" then
			buyGroup.xScale = 0.88
			buyGroup.yScale = 0.88
			buyGroup.x = 15
			buyGroup.y = 35

			backGroup.xScale = 0.9
			backGroup.yScale = 0.9
			backGroup.x = 15
			backGroup.y = 25		

			check.xScale = 0.9
			check.yScale = 0.9
			iCbackX = -11
			iCbackY = 15
		end
	end


	sceneGroup:insert(backGroup)
	sceneGroup:insert(check)
	sceneGroup:insert(backb)
	sceneGroup:insert(coinBack)
	sceneGroup:insert(coins)
	sceneGroup:insert(askGroup)
	
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		configureForIpad()
		keepChecked()
			-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		--updateCoins()
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
		getRidofTimers()


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