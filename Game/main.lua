-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local highscores = require('highscores')
highscores.loadSaveData();

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- include the Corona "composer" module
local composer = require "composer"

-- load menu screen
composer.gotoScene( "menu" )

local selectAudio =	audio.loadStream("select.wav")
goPlayPress = true  
bkgSelect = false
backgroundString = "0"



function playPress()
if goPlayPress == true then 
	audio.play(selectAudio)
	end
end