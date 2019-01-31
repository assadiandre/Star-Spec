-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
--------------------------------------------

function scene:create( event )
	local sceneGroup = self.view
	local options = {
	  effect = "fade",
	  time = 300,
	  params = { 
	    spaceship1 = event.params.spaceship1,
	    spaceship2 = event.params.spaceship2,
	   	spaceship3 = event.params.spaceship3,
	   	spaceship4 = event.params.spaceship4,
	   	spaceship5 = event.params.spaceship5,
	   	spaceship6 = event.params.spaceship6,
	   	spaceship7 = event.params.spaceship7,
	   	spaceship8 = event.params.spaceship8,
	    spaceship = event.params.spaceship,
	    cancelS = event.params.cancelS,
	    onGo = event.params.onGo,
	  }
	}
	composer.removeScene("replay",false)

	local function goToScene()
		composer.gotoScene( "level1", options) 
	end

	goToScene()
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
	
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene