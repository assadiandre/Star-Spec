
local AudioOff = {}

local function getRidofSounds()
	if soundT.shootSound1 ~= nil then 
    	audio.dispose(soundT.shootSound1)
		soundT.shootSound1 = nil 
	elseif soundT.shootSound2 ~= nil then 
    	audio.dispose(soundT.shootSound2)
		soundT.shootSound2 = nil 
	elseif play.crashP ~= nil then 
		audio.stop(play.crashP)
		play.crashP = nil
	elseif play.coinSoundP ~= nil then 
		audio.stop(play.coinSoundP)
		play.coinSoundP = nil
	elseif play.hoverP ~= nil then 
		audio.stop(play.hoverP)
		play.hoverP = nil
	elseif play.bigEP ~= nil then 
		audio.stop(play.bigEP)
		play.bigEP = nil
	elseif play.bigEP2 ~= nil then 
		audio.stop(play.bigEP2)
		play.bigEP2 = nil
	elseif play.powerUPE ~= nil then 
		audio.stop(play.powerUPE)
		play.powerUPE = nil
	elseif play.powerUPE2 ~= nil then 
		audio.stop(play.powerUPE2)
		play.powerUPE2 = nil
	elseif soundT.sound1 ~= nil then 
		audio.stop(soundT.sound1)
		soundT.sound1 = nil
	elseif soundT.sound2 ~= nil then 
		audio.stop(soundT.sound2)
		soundT.sound2 = nil
	elseif play.astroidCP ~= nil then 
		audio.stop(play.astroidCP)
		play.astroidCP = nil
	elseif play.astroidCP2 ~= nil then 
		audio.stop(play.astroidCP2)
		play.astroidCP2 = nil
	elseif play.astroidCP3 ~= nil then 
		audio.stop(play.astroidCP3)
		play.astroidCP3 = nil
	elseif play.astroidCP4 ~= nil then 
		audio.stop(play.astroidCP4)
		play.astroidCP4 = nil
	elseif play.astroidCP5 ~= nil then 
		audio.stop(play.astroidCP5)
		play.astroidCP5 = nil
	elseif play.astroidCP6 ~= nil then 
		audio.stop(play.astroidCP6)
		play.astroidCP6 = nil
	elseif play.astroidCP7 ~= nil then 
		audio.stop(play.astroidCP7)
		play.astroidCP7 = nil
	elseif play.astroidCP8 ~= nil then 
		audio.stop(play.astroidCP8)
		play.astroidCP8 = nil
  end
  astroidSound = {}
  play = {}
  soundT = {}
end
return AudioOff 




