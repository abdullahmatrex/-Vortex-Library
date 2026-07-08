-- =================================================================
--  VORTEX UI LIBRARY V4.6 [🇮🇶 MADE IN IRAQ]
--  DEVELOPER: ABDULLAH (MOBILE & PC OPTIMIZED)
--  ANTI-CRASH PROTECTION INTEGRATED (pcall BYPASS FOR SOUNDS/IMAGES)
-- =================================================================

local VortexLib = {}
VortexLib.__index = VortexLib

local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")

local SoundEnabled = true -- ميزة التحكم بصوت الأنيميشن

-- 🛠️ نظام تشغيل الأصوات المحمي من الفشل والتعليق
local function playSystemSound(soundId)
    if not SoundEnabled then return end
    
    -- استخدام pcall لضمان عدم توقف السكربت إذا فشل جلب الصوت
    pcall(function()
        local s = Instance.new("Sound", SoundService)
        s.SoundId = "rbxassetid://" .. (soundId or 12222475114)
        s.Volume = 0.5
        s:Play()
        game:GetService("Debris"):AddItem(s, 1)
    end)
end

-- ميزة تسريع اللعبة ومكافحة اللاق غصب عن المطور
local function ApplyAntiLag()
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("SpecularHighlight") or v:IsA("Smoke") or v:IsA("Sparkles") then
                v:Destroy()
            end
        end
    end)
end

-- شاشة التحميل والعداد الرقمي
local function startLoading(callback)
    local ScreenGui = Instance.new("ScreenGui", CoreGui)
    ScreenGui.Name = "VortexLoading"
    
    local Frame = Instance.new("Frame", ScreenGui)
    Frame.Size = UDim2.new(0, 320, 0, 100)
    Frame.Position = UDim2.new(0.5, -160, 0.5, -50)
    Frame.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 8)
    
    local BarBg = Instance.new("Frame", Frame)
    BarBg.Size = UDim2.new(0, 280, 0, 6)
    BarBg.Position = UDim2.new(0, 20, 0, 60)
    BarBg.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Instance.new("UICorner", BarBg).CornerRadius = UDim.new(0, 3)
    
    local BarFill = Instance.new("Frame", BarBg)
    BarFill.Size = UDim2.new(0, 0, 1, 0)
    BarFill.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
    Instance.new("UICorner", BarFill).CornerRadius = UDim.new(0, 3)
    
    local Txt = Instance.new("TextLabel", Frame)
    Txt.Size = UDim2.new(1, 0, 0, 40)
    Txt.Position = UDim2.new(0, 0, 0, 10)
    Txt.Text = "VORTEX V4.6 • LOADING... 0%"
    Txt.TextColor3 = Color3.fromRGB(255, 255, 255)
    Txt.Font = Enum.Font.GothamBold
    Txt.TextSize = 13
    Txt.BackgroundTransparency = 1
    
    for i = 1, 100 do
        task.wait(0.003)
        Txt.Text = "VORTEX V4.6 • LOADING... " .. i .. "%"
        BarFill.Size = UDim2.new(i/100, 0, 1, 0)
    end
    ScreenGui:Destroy()
    ApplyAntiLag()
    callback()
end

-- منشئ النافذة الرئيسية
function VortexLib.CreateWindow(cfg)
    local self = setmetatable({}, VortexLib)
    
    self.Gui = Instance.new("ScreenGui", CoreGui)
    self.Gui.Name = "VortexMainUI"
    self.Gui.Enabled = false
    self.Gui.ResetOnSpawn = false
    
    self.Main = Instance.new("ImageLabel", self.Gui)
    self.Main.Size = UDim2.new(0, 540, 0, 320)
    self.Main.Position = UDim2.new(0.5, -270, 0.5, -160)
    self.Main.BackgroundColor3 = cfg.BgColor or Color3.fromRGB(12, 12, 15)
    self.Main.BackgroundTransparency = cfg.Transparency or 0.1
    
    -- 🖼️ نظام الحماية من فشل الصور (لو الرابط خربان السكربت يفتح بخلفية سوداء طبيعية)
    pcall(function()
        self.Main.Image = cfg.Image or ""
    end)
    
    self.Main.Active = true
    self.Main.Draggable = true
    Instance.new("UICorner", self.Main).CornerRadius = UDim.new(0, 8)
    
    -- خط نيون متوهج متحرك RGB
    local MainStroke = Instance.new("UIStroke", self.Main)
    MainStroke.Thickness = 1.5
    if cfg.RGB_Border then
        task.spawn(function()
            while RunService.RenderStepped:Wait() do
                MainStroke.Color = Color3.fromHSV(tick()%6/6, 1, 1)
            end
        end)
    else
        MainStroke.Color = cfg.AccentColor or Color3.fromRGB(0, 180, 255)
    end
    
    -- عداد الفريمات والبنج
    if cfg.ShowStats then
        local StatsLabel = Instance.new("TextLabel", self.Main)
        StatsLabel.Size = UDim2.new(0, 180, 0, 20)
        StatsLabel.Position = UDim2.new(1, -195, 0, 12)
        StatsLabel.Text = "FPS: -- | PING: --ms"
        StatsLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
        StatsLabel.Font = Enum.Font.Code
        StatsLabel.TextSize = 10
        StatsLabel.BackgroundTransparency = 1
        StatsLabel.TextXAlignment = Enum.TextXAlignment.Right
        
        task.spawn(function()
            while task.wait(0.5) do
                if self.Gui.Enabled then
                    local fps = math.floor(1/RunService.RenderStepped:Wait())
                    local ping = math.floor(game.Players.LocalPlayer:GetNetworkPing()*1000)
                    StatsLabel.Text = "FPS: " .. fps .. " | PING: " .. ping .. "ms"
                end
            end
        end)
    end

    -- الأيقونة العائمة للهواتف (abdullah)
    local ToggleGui = Instance.new("ScreenGui", CoreGui)
    ToggleGui.Name = "VortexMobileToggle"
    
    local ToggleBtn = Instance.new("TextButton", ToggleGui)
    ToggleBtn.Size = UDim2.new(0, 85, 0, 36)
    ToggleBtn.Position = UDim2.new(0, 15, 0, 15)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    ToggleBtn.Text = "abdullah"
    ToggleBtn.TextColor3 = Color3.fromRGB(0, 180, 255)
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.TextSize = 13
    ToggleBtn.Active = true
    ToggleBtn.Draggable = true
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", ToggleBtn).Color = Color3.fromRGB(0, 180, 255)
    
    local isOpened = true
    ToggleBtn.MouseButton1Click:Connect(function()
        playSystemSound()
        isOpened = not isOpened
        self.Main.Visible = isOpened
    end)
    
    -- الحقوق العراقية
    local Credits = Instance.new("TextLabel", self.Main)
    Credits.Size = UDim2.new(0, 250, 0, 20)
    Credits.Position = UDim2.new(0, 15, 1, -22)
    Credits.Text = "تم إنشاء في العراق 🇮🇶 بواسطة عبد الله"
    Credits.TextColor3 = Color3.fromRGB(140, 140, 140)
    Credits.Font = Enum.Font.GothamMedium
    Credits.TextSize = 11
    Credits.TextXAlignment = Enum.TextXAlignment.Left
    Credits.BackgroundTransparency = 1
    
    self.TabContainer = Instance.new("ScrollingFrame", self.Main)
    self.TabContainer.Size = UDim2.new(0, 130, 0, 230)
    self.TabContainer.Position = UDim2.new(0, 15, 0, 45)
    self.TabContainer.BackgroundTransparency = 1
    self.TabContainer.ScrollBarThickness = 0
    Instance.new("UIListLayout", self.TabContainer).Padding = UDim.new(0, 5)
    
    self.Content = Instance.new("Frame", self.Main)
    self.Content.Size = UDim2.new(0, 370, 0, 230)
    self.Content.Position = UDim2.new(0, 155, 0, 45)
    self.Content.BackgroundTransparency = 1
    
    self:BuildSettingsTab()
    
    return self
end

function VortexLib:BuildSettingsTab()
    local SettingsPage = Instance.new("ScrollingFrame", self.Content)
    SettingsPage.Size = UDim2.new(1, 0, 1, 0)
    SettingsPage.BackgroundTransparency = 1
    SettingsPage.Visible = true
    Instance.new("UIListLayout", SettingsPage).Padding = UDim.new(0, 6)
    
    local SetBtn = Instance.new("TextButton", self.TabContainer)
    SetBtn.Size = UDim2.new(1, 0, 0, 32)
    SetBtn.Text = "⚙️ الاعدادات"
    SetBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    SetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SetBtn.Font = Enum.Font.GothamBold
    SetBtn.TextSize = 12
    Instance.new("UICorner", SetBtn).CornerRadius = UDim.new(0, 5)
    
    SetBtn.MouseButton1Click:Connect(function()
        playSystemSound()
        for _, v in pairs(self.Content:GetChildren()) do v.Visible = false end
        SettingsPage.Visible = true
    end)
    
    local function addInfoText(txt, col)
        local L = Instance.new("TextLabel", SettingsPage)
        L.Size = UDim2.new(1, -10, 0, 25)
        L.Text = txt
        L.TextColor3 = col or Color3.fromRGB(220, 220, 220)
        L.Font = Enum.Font.GothamMedium
        L.TextSize = 12
        L.TextXAlignment = Enum.TextXAlignment.Left
        L.BackgroundTransparency = 1
    end
    
    addInfoText("— معلومات المطور / Developer Info —", Color3.fromRGB(0, 180, 255))
    addInfoText("• Name: Abdullah Ali / الاسم: عبد الله علي")
    addInfoText("• Country: Iraq 🇮🇶 / البلد: العراق")
    addInfoText("• Library Version: V4.6 Anti-Crash", Color3.fromRGB(0, 255, 150))
    addInfoText("— التحكم بالواجهة / UI Control —", Color3.fromRGB(0, 180, 255))
    
    local MuteBtn = Instance.new("TextButton", SettingsPage)
    MuteBtn.Size = UDim2.new(1, -10, 0, 34)
    MuteBtn.Text = "🔊 إزالة صوت الأزرار (صامت)"
    MuteBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    MuteBtn.TextColor3 = Color3.fromRGB(255, 200, 0)
    MuteBtn.Font = Enum.Font.GothamBold
    MuteBtn.TextSize = 11
    Instance.new("UICorner", MuteBtn).CornerRadius = UDim.new(0, 6)
    
    MuteBtn.MouseButton1Click:Connect(function()
        SoundEnabled = not SoundEnabled
        if SoundEnabled then
            MuteBtn.Text = "🔊 إزالة صوت الأزرار (صامت)"
            MuteBtn.TextColor3 = Color3.fromRGB(255, 200, 0)
            playSystemSound()
        else
            MuteBtn.Text = "🔇 الوضع الصامت مفعل الآن"
            MuteBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    end)
end

function VortexLib:CreateTab(tabName)
    local Page = Instance.new("ScrollingFrame", self.Content)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.Visible = false
    Page.BackgroundTransparency = 1
    Page.ScrollBarThickness = 3
    Instance.new("UIListLayout", Page).Padding = UDim.new(0, 5)
    
    local Btn = Instance.new("TextButton", self.TabContainer)
    Btn.Size = UDim2.new(1, 0, 0, 32)
    Btn.Text = tabName
    Btn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    Btn.Font = Enum.Font.GothamMedium
    Btn.TextSize = 12
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 5)
    
    Btn.MouseButton1Click:Connect(function()
        playSystemSound()
        for _, v in pairs(self.Content:GetChildren()) do v.Visible = false end
        Page.Visible = true
    end)
    
    local TabMethods = {}
    
    function TabMethods:CreateSection(secName)
        local SecLabel = Instance.new("TextLabel", Page)
        SecLabel.Size = UDim2.new(1, -10, 0, 20)
        SecLabel.Text = "— " .. secName .. " —"
        SecLabel.TextColor3 = Color3.fromRGB(0, 180, 255)
        SecLabel.Font = Enum.Font.GothamBold
        SecLabel.TextSize = 11
        SecLabel.BackgroundTransparency = 1
        SecLabel.TextXAlignment = Enum.TextXAlignment.Left
    end

    function TabMethods:CreateButton(opt, cb)
        local B = Instance.new("TextButton", Page)
        B.Size = UDim2.new(1, -10, 0, 35)
        B.Text = opt.Name
        B.BackgroundColor3 = opt.Color or Color3.fromRGB(25, 25, 32)
        B.TextColor3 = Color3.fromRGB(255, 255, 255)
        B.Font = Enum.Font.GothamMedium
        B.TextSize = 12
        Instance.new("UICorner", B).CornerRadius = UDim.new(0, 6)
        
        B.MouseButton1Click:Connect(function()
            playSystemSound()
            local Circle = Instance.new("Frame", B)
            Circle.Size = UDim2.new(0, 0, 0, 0)
            Circle.Position = UDim2.new(0.5, 0, 0.5, 0)
            Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Circle.BackgroundTransparency = 0.6
            Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)
            TweenService:Create(Circle, TweenInfo.new(0.3), {Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1}):Play()
            task.delay(0.3, function() Circle:Destroy() end)
            cb()
        end)
        
        if opt.Rainbow then
            task.spawn(function()
                while RunService.RenderStepped:Wait() do
                    B.BackgroundColor3 = Color3.fromHSV(tick()%4/4, 1, 1)
                end
            end)
        end
    end
    
    function TabMethods:CreateToggle(name, default, cb)
        local TF = Instance.new("Frame", Page)
        TF.Size = UDim2.new(1, -10, 0, 35)
        TF.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
        Instance.new("UICorner", TF).CornerRadius = UDim.new(0, 6)
        
        local Lbl = Instance.new("TextLabel", TF)
        Lbl.Size = UDim2.new(0, 200, 1, 0)
        Lbl.Position = UDim2.new(0, 12, 0, 0)
        Lbl.Text = name
        Lbl.TextColor3 = Color3.fromRGB(230, 230, 230)
        Lbl.Font = Enum.Font.Gotham
        Lbl.TextSize = 12
        Lbl.TextXAlignment = Enum.TextXAlignment.Left
        Lbl.BackgroundTransparency = 1
        
        local TB = Instance.new("TextButton", TF)
        TB.Size = UDim2.new(0, 38, 0, 18)
        TB.Position = UDim2.new(1, -50, 0.5, -9)
        TB.Text = ""
        TB.BackgroundColor3 = default and Color3.fromRGB(0, 180, 255) or Color3.fromRGB(50, 50, 55)
        Instance.new("UICorner", TB).CornerRadius = UDim.new(1, 0)
        
        local s = default
        TB.MouseButton1Click:Connect(function()
            playSystemSound()
            s = not s
            TB.BackgroundColor3 = s and Color3.fromRGB(0, 180, 255) or Color3.fromRGB(50, 50, 55)
            cb(s)
        end)
    end
    
    function TabMethods:CreateSlider(name, min, max, default, cb)
        local SF = Instance.new("Frame", Page)
        SF.Size = UDim2.new(1, -10, 0, 42)
        SF.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
        Instance.new("UICorner", SF).CornerRadius = UDim.new(0, 6)
        
        local Lbl = Instance.new("TextLabel", SF)
        Lbl.Size = UDim2.new(0, 200, 0, 18)
        Lbl.Position = UDim2.new(0, 12, 0, 4)
        Lbl.Text = name .. " : " .. default
        Lbl.TextColor3 = Color3.fromRGB(230, 230, 230)
        Lbl.Font = Enum.Font.Gotham
        Lbl.TextSize = 11
        Lbl.TextXAlignment = Enum.TextXAlignment.Left
        Lbl.BackgroundTransparency = 1
        
        local SB = Instance.new("TextButton", SF)
        SB.Size = UDim2.new(1, -24, 0, 4)
        SB.Position = UDim2.new(0, 12, 0, 28)
        SB.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
        SB.Text = ""
        Instance.new("UICorner", SB).CornerRadius = UDim.new(1, 0)
        
        local SFill = Instance.new("Frame", SB)
        SFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
        SFill.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
        Instance.new("UICorner", SFill).CornerRadius = UDim.new(1, 0)
        
        local function update()
            local mPos = UserInputService:GetMouseLocation().X
            local bPos = SB.AbsolutePosition.X
            local bWidth = SB.AbsoluteSize.X
            local pct = math.clamp((mPos - bPos) / bWidth, 0, 1)
            local val = math.floor(min + (max - min) * pct)
            Lbl.Text = name .. " : " .. val
            SFill.Size = UDim2.new(pct, 0, 1, 0)
            cb(val)
        end
        
        local drag = false
        SB.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = true update() end end)
        UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end end)
        UserInputService.InputChanged:Connect(function(i) if drag and i.UserInputType == Enum.UserInputType.MouseMovement then update() end end)
    end

    function TabMethods:CreateDropdown(name, list, cb)
        local DF = Instance.new("Frame", Page)
        DF.Size = UDim2.new(1, -10, 0, 35)
        DF.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
        DF.ClipsDescendants = true
        Instance.new("UICorner", DF).CornerRadius = UDim.new(0, 6)
        
        local DBtn = Instance.new("TextButton", DF)
        DBtn.Size = UDim2.new(1, 0, 0, 35)
        DBtn.Text = name .. " ▼"
        DBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
        DBtn.TextColor3 = Color3.fromRGB(230, 230, 230)
        DBtn.Font = Enum.Font.Gotham
        DBtn.TextSize = 11
        
        local Container = Instance.new("Frame", DF)
        Container.Size = UDim2.new(1, 0, 0, #list * 28)
        Container.Position = UDim2.new(0, 0, 0, 35)
        Container.BackgroundTransparency = 1
        Instance.new("UIListLayout", Container)
        
        for _, item in pairs(list) do
            local ItemBtn = Instance.new("TextButton", Container)
            ItemBtn.Size = UDim2.new(1, 0, 0, 28)
            ItemBtn.Text = tostring(item)
            ItemBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
            ItemBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
            ItemBtn.Font = Enum.Font.Gotham
            ItemBtn.TextSize = 11
            
            ItemBtn.MouseButton1Click:Connect(function()
                playSystemSound()
                DBtn.Text = name .. " (" .. tostring(item) .. ") ▼"
                DF.Size = UDim2.new(1, -10, 0, 35)
                cb(item)
            end)
        end
        
        local exp = false
        DBtn.MouseButton1Click:Connect(function()
            playSystemSound()
            exp = not exp
            DF.Size = exp and UDim2.new(1, -10, 0, 35 + (#list * 28)) or UDim2.new(1, -10, 0, 35)
        end)
    end

    function TabMethods:CreateTextBox(name, placeholder, cb)
        local BF = Instance.new("Frame", Page)
        BF.Size = UDim2.new(1, -10, 0, 36)
        BF.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
        Instance.new("UICorner", BF).CornerRadius = UDim.new(0, 6)
        
        local Lbl = Instance.new("TextLabel", BF)
        Lbl.Size = UDim2.new(0, 150, 1, 0)
        Lbl.Position = UDim2.new(0, 12, 0, 0)
        Lbl.Text = name
        Lbl.TextColor3 = Color3.fromRGB(230, 230, 230)
        Lbl.Font = Enum.Font.Gotham
        Lbl.TextSize = 12
        Lbl.TextXAlignment = Enum.TextXAlignment.Left
        Lbl.BackgroundTransparency = 1
        
        local TBox = Instance.new("TextBox", BF)
        TBox.Size = UDim2.new(0, 140, 0, 24)
        TBox.Position = UDim2.new(1, -155, 0.5, -12)
        TBox.PlaceholderText = placeholder
        TBox.Text = ""
        TBox.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
        TBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        TBox.Font = Enum.Font.Gotham
        TBox.TextSize = 11
        Instance.new("UICorner", TBox).CornerRadius = UDim.new(0, 4)
        
        TBox.FocusLost:Connect(function(ep) if ep then cb(TBox.Text) end end)
    end

    return TabMethods
end

function VortexLib:Init()
    startLoading(function() self.Gui.Enabled = true end)
end

return VortexLib
