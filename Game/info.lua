local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
local menu = require('menu')
local highscores = require('highscores')
local sceneGroup = self.view
local screenW = display.contentWidth
local screenH = display.contentHeight
local widget = require( "widget" )
local backgroundIcon = event.params.backgroundIcon
local infoT = {}
local totalCoins = event.params.totalCoins
local spaceship = event.params.spaceship
local actualHeight = display.actualContentHeight

local scrollView = widget.newScrollView(
    {
        top = -(actualHeight - screenH)/2,
        left = 0,
        width = screenW,
        horizontalScrollDisabled = true,
        height = -(screenH - actualHeight)/2 + screenH + 70,
        scrollWidth = 600,
        scrollHeight = 800,
        backgroundColor = { 0, 0.8, 1 }
    }
)

infoT.name = display.newText( "Info/Credits", screenW/2, 50, "Stark", 50 )
scrollView:insert(infoT.name )

infoT.information = display.newText( 
	"Realized by: Andre Assadi and Eli Eccles\nHead of Development: Andre Assadi\nGraphics: Gaetan Pallety and Tamara Nazirova\nHead of Graphics: Andre Assadi\nCompany: NewBGames\nLocation: Berkeley CA"
	, screenW/2, 140, "Arial", 15 )
scrollView:insert(infoT.information )


infoT.information2 = display.newText( 
	"This game was created over the span\nof two months. Developed by 15 year\nold Andre Assadi, and realized with\ncontribution of Eli Eccles. Spaceships\n3,4,5,6,7, and 8 were all created\nby Gaetan Pallety."
	, screenW/2 - 30, 260, "Arial", 15 )
scrollView:insert(infoT.information2 )

infoT.name2 = display.newText( "Special Thanks To:", screenW/2, 335, "Stark", 35 )
scrollView:insert(infoT.name2 )

infoT.information3 = display.newText( 
	"Michael Assadi. My\nbrother, an astounding\nmarketer and app\ndeveloper, responisble\nfor the catalyst of\nmy programming\ncarreer."
	, screenW/2 - 78, 420, "Arial", 15 )
scrollView:insert(infoT.information3 )

infoT.image1 = display.newImage("mikey.jpg")
infoT.image1.x = 230
infoT.image1.y = 420
scrollView:insert(infoT.image1 )

infoT.information4 = display.newText( 
	"Angelo Yazar. An\namazing mentor and\ngreat human being. Go\ncheck out his games on\nthe app store by looking\nup Yazar MediaGroup\nin the search box."
	, screenW/2 - 73, 550, "Arial", 15 )
scrollView:insert(infoT.information4 )

infoT.image2 = display.newImage("angelo.jpg")
infoT.image2.x = 230
infoT.image2.y = 550
scrollView:insert(infoT.image2 )

infoT.information5 = display.newText( 
	"-Gaetan Pallety\n-Brad Stimpson"
	, screenW/2 - 88, 650, "Arial", 15 )
scrollView:insert(infoT.information5 )


infoT.information6 = display.newText( 
	"For More Info Visit:\nhttp://www.newbgamesstudio.com"
	, screenW/2 - 40, 700, "Arial", 15 )
scrollView:insert(infoT.information6 )

infoT.blah = display.newText( 
	"000000000000000000"
	, screenW/2, 800, "Arial", 15 )
scrollView:insert(infoT.blah )
infoT.blah:setFillColor(0,0.8,1)



local backb = display.newImage("back.png")
backb.x = 55
backb.y = -(screenH - actualHeight)/2 + 440
backb.xScale = 0.4
backb.yScale = 0.4

local function backBalpha()
	backb.alpha = 1
	end


local function tapBackb()
	playPress()
	backb.alpha = 0.3
	transition.to(sp,{delay=200,time=300,alpha=1,onComplete=backBalpha})
	composer.gotoScene( "menu","fade",200 )

end
backb:addEventListener("tap",tapBackb)



sceneGroup:insert(scrollView)
sceneGroup:insert(backb)


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
	composer.removeScene( "shop",false)

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