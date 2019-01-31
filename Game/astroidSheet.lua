--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:40bfd37a74faaf3419ba9b4918bdf1a9:e8bf1b9aed0bc73ef1f641696eefea86:d55e114f80c318f99f062d439fd6b6ea$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- astroid copy
            x=1,
            y=1,
            width=506,
            height=402,

        },
        {
            -- astroidIce copy
            x=509,
            y=1,
            width=506,
            height=402,

        },
    },
    
    sheetContentWidth = 1016,
    sheetContentHeight = 404
}

SheetInfo.frameIndex =
{

    ["astroid copy"] = 1,
    ["astroidIce copy"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
