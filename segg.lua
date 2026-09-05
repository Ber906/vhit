--// BER.V - FULL FIXED VERSION
--// Place this LocalScript inside:
--// StarterPlayer > StarterPlayerScripts

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local MarketplaceService = game:GetService("MarketplaceService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

--==================================================
-- CONFIG
--==================================================

local RECOVER_TIME = 5

--==================================================
-- COLORS
--==================================================

local COLORS = {
    Background = Color3.fromRGB(15, 17, 24),
    Panel = Color3.fromRGB(24, 27, 36),
    PanelLight = Color3.fromRGB(32, 36, 48),

    Cyan = Color3.fromRGB(0, 210, 255),
    Green = Color3.fromRGB(0, 255, 160),

    White = Color3.fromRGB(245, 248, 255),
    Gray = Color3.fromRGB(160, 170, 185),

    Red = Color3.fromRGB(235, 65, 75),
}

--==================================================
-- HELPERS
--==================================================

local function create(className, properties, parent)
    local object = Instance.new(className)

    for property, value in pairs(properties) do
        object[property] = value
    end

    object.Parent = parent

    return object
end

local function addCorner(object, radius)
    local corner = Instance.new("UICorner")

    corner.CornerRadius =
        UDim.new(0, radius)

    corner.Parent = object

    return corner
end

local function addStroke(
    object,
    color,
    transparency,
    thickness
)
    local stroke = Instance.new("UIStroke")

    stroke.Color = color
    stroke.Transparency =
        transparency or 0

    stroke.Thickness =
        thickness or 1

    stroke.Parent = object

    return stroke
end

--==================================================
-- GAME NAME
--==================================================

local GameName = game.Name

pcall(function()

    local gameInfo =
        MarketplaceService:GetProductInfo(
            game.PlaceId
        )

    if gameInfo and gameInfo.Name then
        GameName = gameInfo.Name
    end

end)

--==================================================
-- CHARACTER
--==================================================

local function getCharacter()

    local character =
        LocalPlayer.Character

    if not character then
        return nil, nil, nil
    end

    local humanoid =
        character:FindFirstChildOfClass(
            "Humanoid"
        )

    local root =
        character:FindFirstChild(
            "HumanoidRootPart"
        )

    return character, humanoid, root
end

--==================================================
-- LEADERSTATS
--==================================================

local function formatStats(player)

    local leaderstats =
        player:FindFirstChild(
            "leaderstats"
        )

    if not leaderstats then
        return "No leaderstats"
    end

    local stats = {}

    for _, stat in ipairs(
        leaderstats:GetChildren()
    ) do

        if stat:IsA("ValueBase") then

            table.insert(
                stats,
                {
                    name = stat.Name,
                    value = tostring(
                        stat.Value
                    )
                }
            )

        end

    end

    table.sort(
        stats,
        function(a, b)

            return string.lower(
                a.name
            ) <
            string.lower(
                b.name
            )

        end
    )

    local formattedStats = {}

    for _, stat in ipairs(stats) do

        table.insert(
            formattedStats,

            stat.name ..
            ": " ..
            stat.value
        )

    end

    if #formattedStats == 0 then
        return "No stats"
    end

    return table.concat(
        formattedStats,
        "  •  "
    )
end

--==================================================
-- GUI
--==================================================

local ScreenGui =
    Instance.new("ScreenGui")

ScreenGui.Name =
    "Ber.V"

ScreenGui.ResetOnSpawn =
    false

ScreenGui.ZIndexBehavior =
    Enum.ZIndexBehavior.Sibling

ScreenGui.Parent =
    LocalPlayer:WaitForChild(
        "PlayerGui"
    )

--==================================================
-- MAIN FRAME
--==================================================

local MainFrame =
    create("Frame", {

        Name = "MainFrame",

        BackgroundColor3 =
            COLORS.Background,

        Position =
            UDim2.new(
                0.5,
                -280,
                0.5,
                -205
            ),

        Size =
            UDim2.new(
                0,
                560,
                0,
                410
            ),

        BorderSizePixel = 0,

        ClipsDescendants = true,

        Active = true,

        ZIndex = 1,

    }, ScreenGui)

addCorner(
    MainFrame,
    14
)

addStroke(
    MainFrame,
    Color3.fromRGB(
        65,
        75,
        95
    ),
    0.25,
    1
)

create("UIGradient", {

    Color =
        ColorSequence.new({

            ColorSequenceKeypoint.new(
                0,
                Color3.fromRGB(
                    18,
                    22,
                    32
                )
            ),

            ColorSequenceKeypoint.new(
                1,
                Color3.fromRGB(
                    10,
                    12,
                    18
                )
            ),

        }),

    Rotation = 45,

}, MainFrame)

--==================================================
-- TOP BAR
--==================================================

local TopBar =
    create("Frame", {

        Name = "TopBar",

        BackgroundColor3 =
            COLORS.Panel,

        Size =
            UDim2.new(
                1,
                0,
                0,
                56
            ),

        BorderSizePixel = 0,

        Active = true,

        ZIndex = 5,

    }, MainFrame)

create("Frame", {

    BackgroundColor3 =
        COLORS.Cyan,

    Position =
        UDim2.new(
            0,
            0,
            1,
            -2
        ),

    Size =
        UDim2.new(
            1,
            0,
            0,
            2
        ),

    BorderSizePixel = 0,

    ZIndex = 6,

}, TopBar)

create("TextLabel", {

    BackgroundTransparency = 1,

    Position =
        UDim2.new(
            0,
            20,
            0,
            7
        ),

    Size =
        UDim2.new(
            0,
            300,
            0,
            26
        ),

    Font =
        Enum.Font.GothamBold,

    Text =
        "BER.V",

    TextColor3 =
        COLORS.Cyan,

    TextSize = 20,

    TextXAlignment =
        Enum.TextXAlignment.Left,

    ZIndex = 7,

}, TopBar)

create("TextLabel", {

    BackgroundTransparency = 1,

    Position =
        UDim2.new(
            0,
            21,
            0,
            32
        ),

    Size =
        UDim2.new(
            0,
            365,
            0,
            16
        ),

    Font =
        Enum.Font.Gotham,

    Text =
        "GAME: " ..
        GameName,

    TextColor3 =
        COLORS.Gray,

    TextSize = 10,

    TextXAlignment =
        Enum.TextXAlignment.Left,

    TextTruncate =
        Enum.TextTruncate.AtEnd,

    ZIndex = 7,

}, TopBar)

local MinimizeButton =
    create("TextButton", {

        Name =
            "MinimizeButton",

        BackgroundColor3 =
            COLORS.PanelLight,

        Position =
            UDim2.new(
                1,
                -80,
                0,
                13
            ),

        Size =
            UDim2.new(
                0,
                28,
                0,
                28
            ),

        Font =
            Enum.Font.GothamBold,

        Text = "—",

        TextColor3 =
            COLORS.White,

        TextSize = 16,

        AutoButtonColor = false,

        Active = true,

        ZIndex = 10,

    }, TopBar)

addCorner(
    MinimizeButton,
    7
)

local CloseButton =
    create("TextButton", {

        Name =
            "CloseButton",

        BackgroundColor3 =
            COLORS.Red,

        Position =
            UDim2.new(
                1,
                -44,
                0,
                13
            ),

        Size =
            UDim2.new(
                0,
                28,
                0,
                28
            ),

        Font =
            Enum.Font.GothamBold,

        Text = "×",

        TextColor3 =
            COLORS.White,

        TextSize = 18,

        AutoButtonColor = false,

        Active = true,

        ZIndex = 10,

    }, TopBar)

addCorner(
    CloseButton,
    7
)

--==================================================
-- PROFILE PANEL
--==================================================

local ProfilePanel =
    create("Frame", {

        Name =
            "ProfilePanel",

        BackgroundColor3 =
            COLORS.Panel,

        Position =
            UDim2.new(
                0,
                16,
                0,
                72
            ),

        Size =
            UDim2.new(
                0,
                190,
                0,
                320
            ),

        BorderSizePixel = 0,

        Active = true,

        ZIndex = 3,

    }, MainFrame)

addCorner(
    ProfilePanel,
    12
)

addStroke(
    ProfilePanel,
    Color3.fromRGB(
        60,
        75,
        95
    ),
    0.5,
    1
)

create("TextLabel", {

    BackgroundTransparency = 1,

    Position =
        UDim2.new(
            0,
            15,
            0,
            12
        ),

    Size =
        UDim2.new(
            1,
            -30,
            0,
            22
        ),

    Font =
        Enum.Font.GothamBold,

    Text =
        "MY PROFILE",

    TextColor3 =
        COLORS.White,

    TextSize = 13,

    TextXAlignment =
        Enum.TextXAlignment.Left,

    ZIndex = 4,

}, ProfilePanel)

local Avatar =
    create("ImageLabel", {

        Name = "Avatar",

        BackgroundColor3 =
            COLORS.PanelLight,

        Position =
            UDim2.new(
                0.5,
                -42,
                0,
                45
            ),

        Size =
            UDim2.new(
                0,
                84,
                0,
                84
            ),

        Image =
            "rbxthumb://type=AvatarHeadShot&id="
            ..
            LocalPlayer.UserId
            ..
            "&w=180&h=180",

        BorderSizePixel = 0,

        ZIndex = 4,

    }, ProfilePanel)

addCorner(
    Avatar,
    42
)

addStroke(
    Avatar,
    COLORS.Cyan,
    0.15,
    2
)

local DisplayName =
    create("TextLabel", {

        BackgroundTransparency = 1,

        Position =
            UDim2.new(
                0,
                10,
                0,
                138
            ),

        Size =
            UDim2.new(
                1,
                -20,
                0,
                23
            ),

        Font =
            Enum.Font.GothamBold,

        Text =
            LocalPlayer.DisplayName,

        TextColor3 =
            COLORS.White,

        TextSize = 17,

        TextTruncate =
            Enum.TextTruncate.AtEnd,

        ZIndex = 4,

    }, ProfilePanel)

local Username =
    create("TextLabel", {

        BackgroundTransparency = 1,

        Position =
            UDim2.new(
                0,
                10,
                0,
                161
            ),

        Size =
            UDim2.new(
                1,
                -20,
                0,
                18
            ),

        Font =
            Enum.Font.Gotham,

        Text =
            "@" ..
            LocalPlayer.Name,

        TextColor3 =
            COLORS.Cyan,

        TextSize = 12,

        ZIndex = 4,

    }, ProfilePanel)

create("Frame", {

    BackgroundColor3 =
        Color3.fromRGB(
            60,
            68,
            82
        ),

    Position =
        UDim2.new(
            0,
            15,
            0,
            193
        ),

    Size =
        UDim2.new(
            1,
            -30,
            0,
            1
        ),

    BorderSizePixel = 0,

    ZIndex = 4,

}, ProfilePanel)

create("TextLabel", {

    BackgroundTransparency = 1,

    Position =
        UDim2.new(
            0,
            15,
            0,
            207
        ),

    Size =
        UDim2.new(
            1,
            -30,
            0,
            20
        ),

    Font =
        Enum.Font.GothamBold,

    Text =
        "YOUR LEADERSTATS",

    TextColor3 =
        COLORS.Green,

    TextSize = 11,

    TextXAlignment =
        Enum.TextXAlignment.Left,

    ZIndex = 4,

}, ProfilePanel)

local MyStats =
    create("TextLabel", {

        BackgroundColor3 =
            COLORS.PanelLight,

        Position =
            UDim2.new(
                0,
                12,
                0,
                233
            ),

        Size =
            UDim2.new(
                1,
                -24,
                0,
                65
            ),

        Font =
            Enum.Font.Gotham,

        Text =
            "Loading stats...",

        TextColor3 =
            COLORS.White,

        TextSize = 11,

        TextWrapped = true,

        TextXAlignment =
            Enum.TextXAlignment.Left,

        TextYAlignment =
            Enum.TextYAlignment.Top,

        ZIndex = 4,

    }, ProfilePanel)

addCorner(
    MyStats,
    8
)

local StandStatus =
    create("TextLabel", {

        BackgroundTransparency = 1,

        Position =
            UDim2.new(
                0,
                12,
                1,
                -73
            ),

        Size =
            UDim2.new(
                1,
                -24,
                0,
                15
            ),

        Font =
            Enum.Font.Gotham,

        Text =
            "No saved position",

        TextColor3 =
            COLORS.Gray,

        TextSize = 9,

        TextXAlignment =
            Enum.TextXAlignment.Center,

        ZIndex = 8,

    }, ProfilePanel)

--==================================================
-- STAND BUTTON
--==================================================

local StandButton =
    create("TextButton", {

        Name =
            "StandButton",

        BackgroundColor3 =
            Color3.fromRGB(
                0,
                130,
                105
            ),

        Position =
            UDim2.new(
                0,
                12,
                1,
                -52
            ),

        Size =
            UDim2.new(
                0,
                79,
                0,
                38
            ),

        Font =
            Enum.Font.GothamBold,

        Text = "STAND",

        TextColor3 =
            COLORS.White,

        TextSize = 11,

        AutoButtonColor = false,

        Active = true,

        Selectable = true,

        ZIndex = 20,

    }, ProfilePanel)

addCorner(
    StandButton,
    8
)

addStroke(
    StandButton,
    COLORS.Green,
    0.25,
    1
)

--==================================================
-- RECOVER BUTTON
--==================================================

local RecoverButton =
    create("TextButton", {

        Name =
            "RecoverButton",

        BackgroundColor3 =
            Color3.fromRGB(
                0,
                90,
                120
            ),

        Position =
            UDim2.new(
                1,
                -91,
                1,
                -52
            ),

        Size =
            UDim2.new(
                0,
                79,
                0,
                38
            ),

        Font =
            Enum.Font.GothamBold,

        Text = "RECOVER",

        TextColor3 =
            COLORS.White,

        TextSize = 10,

        AutoButtonColor = false,

        Active = true,

        Selectable = true,

        ZIndex = 20,

    }, ProfilePanel)

addCorner(
    RecoverButton,
    8
)

addStroke(
    RecoverButton,
    COLORS.Cyan,
    0.25,
    1
)

--==================================================
-- PLAYER PANEL
--==================================================

local PlayersPanel =
    create("Frame", {

        Name =
            "PlayersPanel",

        BackgroundColor3 =
            COLORS.Panel,

        Position =
            UDim2.new(
                0,
                218,
                0,
                72
            ),

        Size =
            UDim2.new(
                0,
                326,
                0,
                320
            ),

        BorderSizePixel = 0,

        Active = true,

        ZIndex = 3,

    }, MainFrame)

addCorner(
    PlayersPanel,
    12
)

addStroke(
    PlayersPanel,
    Color3.fromRGB(
        60,
        75,
        95
    ),
    0.5,
    1
)

create("TextLabel", {

    BackgroundTransparency = 1,

    Position =
        UDim2.new(
            0,
            15,
            0,
            12
        ),

    Size =
        UDim2.new(
            0,
            180,
            0,
            22
        ),

    Font =
        Enum.Font.GothamBold,

    Text =
        "PLAYERS IN SERVER",

    TextColor3 =
        COLORS.White,

    TextSize = 13,

    TextXAlignment =
        Enum.TextXAlignment.Left,

    ZIndex = 4,

}, PlayersPanel)

local PlayerCount =
    create("TextLabel", {

        BackgroundColor3 =
            Color3.fromRGB(
                0,
                105,
                125
            ),

        Position =
            UDim2.new(
                1,
                -82,
                0,
                10
            ),

        Size =
            UDim2.new(
                0,
                67,
                0,
                25
            ),

        Font =
            Enum.Font.GothamBold,

        Text = "0 / 0",

        TextColor3 =
            COLORS.White,

        TextSize = 11,

        ZIndex = 4,

    }, PlayersPanel)

addCorner(
    PlayerCount,
    7
)

local PlayerList =
    create("ScrollingFrame", {

        Name =
            "PlayerList",

        BackgroundTransparency = 1,

        Position =
            UDim2.new(
                0,
                10,
                0,
                57
            ),

        Size =
            UDim2.new(
                1,
                -20,
                1,
                -67
            ),

        CanvasSize =
            UDim2.new(
                0,
                0,
                0,
                0
            ),

        AutomaticCanvasSize =
            Enum.AutomaticSize.Y,

        ScrollBarThickness = 4,

        ScrollBarImageColor3 =
            COLORS.Cyan,

        BorderSizePixel = 0,

        ZIndex = 4,

    }, PlayersPanel)

create("UIListLayout", {

    Padding =
        UDim.new(0, 7),

    SortOrder =
        Enum.SortOrder.LayoutOrder,

}, PlayerList)

--==================================================
-- PLAYER ROW
--==================================================

local function createPlayerRow(
    player,
    index
)

    local row =
        create("Frame", {

            BackgroundColor3 =
                COLORS.PanelLight,

            Size =
                UDim2.new(
                    1,
                    -5,
                    0,
                    64
                ),

            LayoutOrder = index,

            BorderSizePixel = 0,

            ZIndex = 5,

        }, PlayerList)

    addCorner(
        row,
        9
    )

    if player == LocalPlayer then

        addStroke(
            row,
            COLORS.Cyan,
            0.1,
            1.5
        )

    end

    local avatar =
  
