local json = require('json')
local achievements = require('achievements')
local highscores = {}
local ach = {}
local saveData = {
	highscores = {},
	coins = 750,
	achiev1 = false,
	achiev2 = false,
	achiev3 = false,
	achiev4 = false,
	achiev5 = false,
	achiev6 = false,
	achiev7 = false,
	achiev8 = false,
	achiev9 = false,
	achiev10 = false,
	achiev11 = false,
	achiev12 = false,
	achiev13 = false,
	unlock1 = false,
	unlock2 = false,
	unlock3 = false,
	unlock4 = false,
	unlock5 = false, 
	unlock6 = false,
	unlock7 = false,
	unlock8 = false,
	check1 = false,
	check2 = false,
	check3 = false,
	check4 = false,
	check5 = false,
	soundIt = 2,
	bpVar1 = false, 
	bpVar2 = false, 
	bpVar3 = false,
	dontPop = false
}



 function load(default)
	local path = system.pathForFile("savefile.txt", system.DocumentsDirectory)
	local data = false

	local file, errorString = io.open( path, "r" )

	if not file then
	    print( "File error: " .. errorString )
	else
	  local saveText = file:read('*a')
	  data = json.decode(saveText)

	  io.close( file )
	end

	if data then
		return data
	else
		return default
	end
end

 function save(data)
	local path = system.pathForFile("savefile.txt", system.DocumentsDirectory)
	local file, errorString = io.open( path, "w" )

	if not file then
	    print( "File error: " .. errorString )
		return false
	else
	  saveText = json.encode(data)
	  file:write(saveText)
	  io.close( file )
	  return true
	end
end

 function highscores.saveHighscore(score)
	table.insert(saveData.highscores, score)
	table.sort(saveData.highscores, function (a,b) return a > b end)
	save(saveData)
end

function highscores.addCoins(amount)
	if not saveData.coins then
		saveData.coins = 0
	end
	saveData.coins = saveData.coins + amount
end


function highscores.getCoins()
	if not saveData.coins then
		saveData.coins = 0
	end

	return saveData.coins
end


------------------------------------------------------------------------
function highscores.MakeTrue()
	saveData.achiev1 = true 
	save(saveData)
end

function highscores.getAchiev1()
	if not saveData.achiev1 then
		saveData.achiev1 = false
	end
	return saveData.achiev1
end

function highscores.MakeTrue2()
	saveData.achiev2 = true 
	save(saveData)
end

function highscores.getAchiev2()
	if not saveData.achiev2 then
		saveData.achiev2 = false
	end
	return saveData.achiev2
end

function highscores.MakeTrue3()
	saveData.achiev3 = true 
	save(saveData)
end

function highscores.getAchiev3()
	if not saveData.achiev3 then
		saveData.achiev3 = false
	end
	return saveData.achiev3
end

function highscores.MakeTrue4()
	saveData.achiev4 = true 
	save(saveData)
end

function highscores.getAchiev4()
	if not saveData.achiev4 then
		saveData.achiev4 = false
	end
	return saveData.achiev4
end

function highscores.MakeTrue5()
	saveData.achiev5 = true 
	save(saveData)
end

function highscores.getAchiev5()
	if not saveData.achiev5 then
		saveData.achiev5 = false
	end
	return saveData.achiev5
end

function highscores.MakeTrue6()
	saveData.achiev6 = true 
	save(saveData)
end

function highscores.getAchiev6()
	if not saveData.achiev6 then
		saveData.achiev6 = false
	end
	return saveData.achiev6
end

function highscores.MakeTrue7()
	saveData.achiev7 = true 
	save(saveData)
end

function highscores.getAchiev7()
	if not saveData.achiev7 then
		saveData.achiev7 = false
	end
	return saveData.achiev7
end


function highscores.MakeTrue8()
	saveData.achiev8 = true 
	save(saveData)
end

function highscores.getAchiev8()
	if not saveData.achiev8 then
		saveData.achiev8 = false
	end
	return saveData.achiev8
end

function highscores.MakeTrue9()
	saveData.achiev9 = true 
	save(saveData)
end

function highscores.getAchiev9()
	if not saveData.achiev9 then
		saveData.achiev9 = false
	end
	return saveData.achiev9
end

function highscores.MakeTrue10()
	saveData.achiev10 = true 
	save(saveData)
end

function highscores.getAchiev10()
	if not saveData.achiev10 then
		saveData.achiev10 = false
	end
	return saveData.achiev10
end

function highscores.MakeTrue11()
	saveData.achiev11 = true 
	save(saveData)
end

function highscores.getAchiev11()
	if not saveData.achiev11 then
		saveData.achiev11 = false
	end
	return saveData.achiev11
end

function highscores.MakeTrue12()
	saveData.achiev12 = true 
	save(saveData)
end

function highscores.getAchiev12()
	if not saveData.achiev12 then
		saveData.achiev12 = false
	end
	return saveData.achiev12
end

function highscores.MakeTrue13()
	saveData.achiev13 = true 
	save(saveData)
end

function highscores.getAchiev13()
	if not saveData.achiev13 then
		saveData.achiev13 = false
	end
	return saveData.achiev13
end

function highscores.unlock1()
	saveData.unlock1 = true 
	save(saveData)
end

function highscores.getUnlock1()
	if not saveData.unlock1 then
		saveData.unlock1 = false
	end
	return saveData.unlock1
end

function highscores.unlock2()
	saveData.unlock2 = true 
	save(saveData)
end

function highscores.getUnlock2()
	if not saveData.unlock2 then
		saveData.unlock2 = false
	end
	return saveData.unlock2
end


function highscores.unlock3()
	saveData.unlock3 = true 
	save(saveData)
end

function highscores.getUnlock3()
	if not saveData.unlock3 then
		saveData.unlock3 = false
	end
	return saveData.unlock3
end

function highscores.unlock4()
	saveData.unlock4 = true 
	save(saveData)
end

function highscores.getUnlock4()
	if not saveData.unlock4 then
		saveData.unlock4 = false
	end
	return saveData.unlock4
end

function highscores.unlock5()
	saveData.unlock5 = true 
	save(saveData)
end

function highscores.getUnlock5()
	if not saveData.unlock5 then
		saveData.unlock5 = false
	end
	return saveData.unlock5
end

function highscores.unlock6()
	saveData.unlock6 = true 
	save(saveData)
end

function highscores.getUnlock6()
	if not saveData.unlock6 then
		saveData.unlock6 = false
	end
	return saveData.unlock6
end

function highscores.unlock7()
	saveData.unlock7 = true 
	save(saveData)
end

function highscores.getUnlock7()
	if not saveData.unlock7 then
		saveData.unlock7 = false
	end
	return saveData.unlock7
end

function highscores.unlock8()
	saveData.unlock8 = true 
	save(saveData)
end

function highscores.getUnlock8()
	if not saveData.unlock8 then
		saveData.unlock8 = false
	end
	return saveData.unlock8
end

function highscores.check1()
	saveData.check1 = true 
	save(saveData)
end

function highscores.getCheck1()
	if not saveData.check1 then
		saveData.check1 = false
	end
	return saveData.check1
end


function highscores.check2()
	saveData.check2 = true 
	save(saveData)
end

function highscores.getCheck2()
	if not saveData.check2 then
		saveData.check2 = false
	end
	return saveData.check2
end


function highscores.check3()
	saveData.check3 = true 
	save(saveData)
end

function highscores.getCheck3()
	if not saveData.check3 then
		saveData.check3 = false
	end
	return saveData.check3
end


function highscores.check4()
	saveData.check4 = true 
	save(saveData)
end

function highscores.getCheck4()
	if not saveData.check4 then
		saveData.check4 = false
	end
	return saveData.check4
end


function highscores.check5()
	saveData.check5 = true 
	save(saveData)
end

function highscores.getCheck5()
	if not saveData.check5 then
		saveData.check5 = false
	end
	return saveData.check5
end

function highscores.soundIt(var)
	saveData.soundIt = var 
	save(saveData)
end

function highscores.getSoundIt()
	if not saveData.soundIt then
		saveData.soundIt = true
	end
	return saveData.soundIt
end
--------------------------------------------------------------------------

function highscores.getBpVar1()
	if not saveData.bpVar1 then
		saveData.bpVar1 = false
	end
	return saveData.bpVar1
end

function highscores.getBpVar2()
	if not saveData.bpVar2 then
		saveData.bpVar2 = false
	end
	return saveData.bpVar2
end

function highscores.getBpVar3()
	if not saveData.bpVar3 then
		saveData.bpVar3 = false
	end
	return saveData.bpVar3
end

function highscores.BpVar1()
	saveData.bpVar1 = true 
	save(saveData)
end

function highscores.BpVar2()
	saveData.bpVar2 = true 
	save(saveData)
end

function highscores.BpVar3()
	saveData.bpVar3 = true 
	save(saveData)
end
------------------------------------------------------------------------


function highscores.dontPop()
	saveData.dontPop = true  
	save(saveData)
end

function highscores.getDontPop()
	if not saveData.dontPop then
		saveData.dontPop = false
	end
	return saveData.dontPop
end
------------------------------------------------------------------------

 function highscores.getSaveData()
	return saveData.highscores
end


function highscores.loadSaveData() 
	saveData = load(saveData)
end

return highscores