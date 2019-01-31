--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:8d9309afb60f962670394407ecf5e911:b7d8024fc55028135711e181ead3818b:fdbd29f646224657990de2edd3e3fe5e$
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
            -- achiev
            x=1,
            y=1,
            width=300,
            height=100,

        },
        {
            -- achiev1
            x=303,
            y=1,
            width=298,
            height=100,

        },
        {
            -- achiev2
            x=603,
            y=1,
            width=300,
            height=100,

        },
        {
            -- achiev3
            x=1,
            y=103,
            width=300,
            height=100,

        },
        {
            -- achiev4
            x=303,
            y=103,
            width=300,
            height=100,

        },
        {
            -- achiev5
            x=605,
            y=103,
            width=300,
            height=100,

        },
        {
            -- achiev6
            x=1,
            y=205,
            width=300,
            height=100,

        },
        {
            -- achiev7
            x=303,
            y=205,
            width=300,
            height=100,

        },
        {
            -- achiev8
            x=605,
            y=205,
            width=300,
            height=100,

        },
        {
            -- achiev9
            x=1,
            y=307,
            width=300,
            height=100,

        },
        {
            -- achiev10
            x=303,
            y=307,
            width=300,
            height=100,

        },
        {
            -- achiev11
            x=605,
            y=307,
            width=300,
            height=100,

        },
        {
            -- achiev12
            x=1,
            y=409,
            width=300,
            height=100,

        },
        {
            -- inceptor copy
            x=303,
            y=409,
            width=300,
            height=100,

        },
    },
    
    sheetContentWidth = 906,
    sheetContentHeight = 510
}

SheetInfo.frameIndex =
{

    ["achiev"] = 1,
    ["achiev1"] = 2,
    ["achiev2"] = 3,
    ["achiev3"] = 4,
    ["achiev4"] = 5,
    ["achiev5"] = 6,
    ["achiev6"] = 7,
    ["achiev7"] = 8,
    ["achiev8"] = 9,
    ["achiev9"] = 10,
    ["achiev10"] = 11,
    ["achiev11"] = 12,
    ["achiev12"] = 13,
    ["inceptor copy"] = 14,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
