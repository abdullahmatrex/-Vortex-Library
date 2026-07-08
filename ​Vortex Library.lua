-- =================================================================
--  VORTEX UI LIBRARY V6.0 [🇮🇶 MADE IN IRAQ]
--  DEVELOPER: ABDULLAH (THE ULTIMATE 20-FEATURE VERSION)
--  FEATURES: AUTOMATIC JSON CONFIG SAVE, 3D NOTIFICATIONS, EXTERNAL ASSETS
-- =================================================================

local VortexLib = {}
VortexLib.__index = VortexLib

local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local HttpService = game:GetService("HttpService")

local SoundEnabled = true
local ConfigFileName = "Vortex_Config_Save.json"
VortexLib.SavedSettings = {}

-- 📂 نظام حفظ وقراءة الإعدادات تلقائياً بجهاز اللاعب (JSON)
local function LoadConfig()
    if isfile(ConfigFileName) then
        pcall(function()
            local raw = readfile(ConfigFileName)
            VortexLib.SavedSettings = HttpService:JSONDecode(raw)
        end)
    end
end

local function SaveConfig()
    pcall(function()
        local raw = HttpService:JSONEncode(VortexLib.SavedSettings)
        writefile(ConfigFileName, raw)
    end)
end

-- 📥 جلب الملفات الخارجية
local function getExternalAsset(url, fileName)
    if not url or url == "" then return "" end
    if not url:match("^http") then return url end
    local assetId = ""
    pcall(function()
        if not isfile(fileName) then
            local success, content = pcall(function() return game:HttpGet(url) end)
            if success and content then writefile(fileName, content) end
        end
        if isfile(fileName) then assetId = getcustomasset(fileName) end
    end)
    return assetId
end

-- 🔊 نظام الأصوات الميكانيكية
local function playSystemSound(soundUrl)
    if not SoundEnabled then return end
    task.spawn(function()
        pcall(function()
            local customSoundId = getExternalAsset(soundUrl, "vortex_click.mp3")
            if customSoundId and customSoundId ~= "" then
                local s = Instance.new("Sound")
                s.SoundId = customSoundId
                s.Volume = 0.5
                s.Parent = SoundService
                s:Play()
                task.delay(1.5, function() if s and s.Parent then s:Destroy() end end)
            end
        end)
    end)
end

-- 🔔 نظام الإشعارات الـ 3D الجانبي الاحترافي
function VortexLib:Notify(title, desc, duration)
    duration = duration or 3
    task.spawn(function()
        local NotifyGui = CoreGui:FindFirstChild("VortexNotifications")
        if not NotifyGui then
            NotifyGui = Instance.new("ScreenGui", CoreGui)
            NotifyGui.Name = "VortexNotifications"
        end
        
        local NotifHolder = NotifyGui:FindFirstChild("Holder")
        if not NotifHolder then
            NotifHolder = Instance.new("Frame", NotifyGui)
            NotifHolder.Name = "Holder"
            NotifHolder.Size = UDim2.new(0, 260, 1, 0)
            NotifHolder.Position = UDim2.new(1, -280, 0, 20)
            NotifHolder.BackgroundTransparency = 1
            local UIList = Instance.new("UIListLayout", NotifHolder)
            UIList.Padding = UDim.new(0, 10)
            UIList.VerticalAlignment = Enum.VerticalAlignment.Bottom
        end
        
        -- إنشاء الصندوق المجسم للإشعار
        local BoxShadow = Instance.new("Frame", NotifHolder)
        BoxShadow.Size = UDim2.new(1, 0, 0, 65)
        BoxShadow.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
        Instance.new("UICorner", BoxShadow).CornerRadius = UDim.new(0, 6)
        
        local Box = Instance.new("Frame", BoxShadow)
        Box.Size = UDim2.new(1, 0, 1, -4)
        Box.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
        Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 6)
        local Stroke = Instance.new("UIStroke", Box)
        Stroke.Color = Color3.fromRGB(0, 180, 255)
        
        local Tl = Instance.new("TextLabel", Box)
        Tl.Size = UDim2.new(1, -20, 0, 20)
        Tl.Position = UDim2.new(0, 10, 0, 5)
        Tl.Text = "[ " .. string.upper(title) .. " ]"
        Tl.TextColor3 = Color3.fromRGB(0, 180, 255)
        Tl.Font = Enum.Font.GothamBold
        Tl.TextSize = 11
        Tl.BackgroundTransparency = 1
        Tl.TextXAlignment = Enum.TextXAlignment.Left
        
        local Dc = Instance.new("TextLabel", Box)
        Dc.Size = UDim2.new(1, -20, 0, 30)
        Dc.Position = UDim2.new(0, 10, 0, 25)
        Dc.Text = desc
        Dc.TextColor3 = Color3.fromRGB(230, 230, 230)
        Dc.Font = Enum.Font.GothamMedium
        Dc.TextSize = 11
        Dc.BackgroundTransparency = 1
        Dc.TextXAlignment = Enum.TextXAlignment.Left
        Dc.TextWrapped = true
        
        -- أنيميشن دخول من الجانب
        BoxShadow.Position = UDim2.new(1, 300, 0, 0)
        TweenService:Create(BoxShadow, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Position = UDim2.new(0, 0, 0, 0)}):Play()
        playSystemSound(self.SoundUrl)
        
        task.wait(duration)
        
        -- أنيميشن خروج وتدمير الإشعار
        local out = TweenService:Create(BoxShadow, TweenInfo.new(0.2), {BackgroundTransparency = 1})
        TweenService:Create(Box, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        TweenService:Create(Tl, TweenInfo.new(0.2), {TextTransparency = 1}):Play()
        TweenService:Create(Dc, TweenInfo.new(0.2), {TextTransparency = 1}):Play()
        out:Play()
        out.Completed:Connect(function() BoxShadow:Destroy() end)
    end)
end

-- منشئ النافذة الرئيسية
function VortexLib.CreateWindow(cfg)
    LoadConfig() -- تحميل إعدادات السيف تلقائياً
    
    local self = setmetatable({}, VortexLib)
    self.SoundUrl = cfg.SoundUrl or "https://github.com/TopitSinsest/Roblox-Sounds/raw/main/Clicks/Click1.mp3"
    
    self.Gui = Instance.new("ScreenGui", CoreGui)
    self.Gui.Name = "VortexMainUI"
    self.Gui.ResetOnSpawn = false
    
    self.Main = Instance.new("ImageLabel", self.Gui)
    self.Main.Size = UDim2.new(0, 540, 0, 320)
    self.Main.Position = UDim2.new(0.5, -270, 0.5, -160)
    self.Main.BackgroundColor3 = cfg.BgColor or Color3.fromRGB(14, 14, 18)
    self.Main.BackgroundTransparency = cfg.Transparency or 0
    
    if cfg.Image and cfg.Image ~= "" then
        task.spawn(function()
            local customImg = getExternalAsset(cfg.Image, "vortex_bg.png")
            if customImg and customImg ~= "" then self.Main.Image = customImg end
        end)
    end
    
    self.Main.Active = true
    self.Main.Draggable = true
    Instance.new("UICorner", self.Main).CornerRadius = UDim.new(0, 10)
    
    local MainStroke = Instance.new("UIStroke", self.Main)
    MainStroke.Thickness = 2
    if cfg.RGB_Border then
        task.spawn(function()
            while RunService.RenderStepped:Wait() do
                if not self.Gui or not self.Gui.Parent then break end
                MainStroke.Color = Color3.fromHSV(tick()%6/6, 1, 1)
            end
        end)
    else
        MainStroke.Color = cfg.AccentColor or Color3.fromRGB(0, 180, 255)
    end
    
    -- زر الـ ✕ الميكانيكي الفخم للإغلاق مع تأكيد بالكامل
    local CloseBtn = Instance.new("TextButton", self.Main)
    CloseBtn.Size = UDim2.new(0, 26, 0, 26)
    CloseBtn.Position = UDim2.new(1, -38, 0, 10)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(25, 10, 15)
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 50, 70)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 14
    Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", CloseBtn).Color = Color3.fromRGB(255, 50, 70)

    CloseBtn.MouseButton1Click:Connect(function()
        playSystemSound(self.SoundUrl)
        
        local PromptOverlay = Instance.new("Frame", self.Gui)
        PromptOverlay.Size = UDim2.new(1, 0, 1, 0)
        PromptOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        PromptOverlay.BackgroundTransparency = 1
        PromptOverlay.Active = true
        
        local PromptFrame = Instance.new("Frame", PromptOverlay)
        PromptFrame.Size = UDim2.new(0, 300, 0, 140)
        PromptFrame.Position = UDim2.new(0.5, -150, 0.4, -70)
        PromptFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
        Instance.new("UICorner", PromptFrame).CornerRadius = UDim.new(0, 8)
        Instance.new("UIStroke", PromptFrame).Color = Color3.fromRGB(255, 50, 70)
        
        local PromptText = Instance.new("TextLabel", PromptFrame)
        PromptText.Size = UDim2.new(1, 0, 0, 50)
        PromptText.Position = UDim2.new(0, 0, 0, 15)
        PromptText.Text = "هل تريد إطفاء السكربت؟"
        PromptText.TextColor3 = Color3.fromRGB(255, 255, 255)
        PromptText.Font = Enum.Font.GothamBold
        PromptText.TextSize = 14
        PromptText.BackgroundTransparency = 1
        
        local YesBtn = Instance.new("TextButton", PromptFrame)
        YesBtn.Size = UDim2.new(0, 110, 0, 35)
        YesBtn.Position = UDim2.new(0, 25, 0, 80)
        YesBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 70)
        YesBtn.Text = "نعم"
        YesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        YesBtn.Font = Enum.Font.GothamBold
        Instance.new("UICorner", YesBtn).CornerRadius = UDim.new(0, 6)
        
        local NoBtn = Instance.new("TextButton", PromptFrame)
        NoBtn.Size = UDim2.new(0, 110, 0, 35)
        NoBtn.Position = UDim2.new(1, -135, 0, 80)
        NoBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
        NoBtn.Text = "لا"
        NoBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        NoBtn.Font = Enum.Font.GothamBold
        Instance.new("UICorner", NoBtn).CornerRadius = UDim.new(0, 6)
        
        TweenService:Create(PromptOverlay, TweenInfo.new(0.2), {BackgroundTransparency = 0.6}):Play()
        TweenService:Create(PromptFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Position = UDim2.new(0.5, -150, 0.5, -70)}):Play()
        
        NoBtn.MouseButton1Click:Connect(function() PromptOverlay:Destroy() end)
        
        YesBtn.MouseButton1Click:Connect(function()
            YesBtn:Destroy()
            NoBtn:Destroy()
            
            local UnloadBarBg = Instance.new("Frame", PromptFrame)
            UnloadBarBg.Size = UDim2.new(0, 250, 0, 6)
            UnloadBarBg.Position = UDim2.new(0, 25, 0, 100)
            UnloadBarBg.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
            Instance.new("UICorner", UnloadBarBg).CornerRadius = UDim.new(0, 3)
            
            local UnloadBarFill = Instance.new("Frame", UnloadBarBg)
            UnloadBarFill.Size = UDim2.new(0, 0, 1, 0)
            UnloadBarFill.BackgroundColor3 = Color3.fromRGB(255, 50, 70)
            Instance.new("UICorner", UnloadBarFill).CornerRadius = UDim.new(0, 3)
            
            local stages = {
                {pct = 0.25, msg = "جارِ إزالة الأزرار والميزات..."},
                {pct = 0.55, msg = "جارِ تفكيك التبويبات..."},
                {pct = 0.85, msg = "جارِ مسح الذاكرة المؤقتة..."},
                {pct = 1.00, msg = "جارِ إزالة المكتبة بالكامل..."}
            }
            
            for _, stage in ipairs(stages) do
                PromptText.Text = stage.msg
                TweenService:Create(UnloadBarFill, TweenInfo.new(0.4), {Size = UDim2.new(stage.pct, 0, 1, 0)}):Play()
                task.wait(0.4)
            end
            
            pcall(function()
                self.Gui:Destroy()
                if self.ToggleGui then self.ToggleGui:Destroy() end
            end)
        end)
    end)

    -- عنوان اللوحة
    local TitleLabel = Instance.new("TextLabel", self.Main)
    TitleLabel.Size = UDim2.new(0, 200, 0, 30)
    TitleLabel.Position = UDim2.new(0, 20, 0, 10)
    TitleLabel.Text = cfg.Name or "VORTEX HUB"
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 14
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    self.TabContainer = Instance.new("ScrollingFrame", self.Main)
    self.TabContainer.Size = UDim2.new(0, 135, 0, 230)
    self.TabContainer.Position = UDim2.new(0, 15, 0, 50)
    self.TabContainer.BackgroundTransparency = 1
    self.TabContainer.ScrollBarThickness = 0
    local ListLayout = Instance.new("UIListLayout", self.TabContainer)
    ListLayout.Padding = UDim.new(0, 8)
    
    self.Content = Instance.new("Frame", self.Main)
    self.Content.Size = UDim2.new(0, 360, 0, 230)
    self.Content.Position = UDim2.new(0, 165, 0, 50)
    self.Content.BackgroundTransparency = 1
    
    self.Gui.Enabled = true
    return self
end

-- منشئ التبويبات 3D
function VortexLib:CreateTab(tabName)
    local Page = Instance.new("ScrollingFrame", self.Content)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.Visible = false
    Page.BackgroundTransparency = 1
    Page.ScrollBarThickness = 2
    local PageList = Instance.new("UIListLayout", Page)
    PageList.Padding = UDim.new(0, 10)
    
    local TabHolder = Instance.new("Frame", self.TabContainer)
    TabHolder.Size = UDim2.new(1, -5, 0, 36)
    TabHolder.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
    Instance.new("UICorner", TabHolder).CornerRadius = UDim.new(0, 6)
    
    local Btn = Instance.new("TextButton", TabHolder)
    Btn.Size = UDim2.new(1, 0, 1, -3)
    Btn.Text = string.upper(tabName)
    Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    Btn.TextColor3 = Color3.fromRGB(230, 230, 230)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 11
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", Btn).Color = Color3.fromRGB(45, 45, 55)
    
    Btn.MouseButton1Click:Connect(function()
        playSystemSound(self.MainWindow.SoundUrl)
        for _, v in pairs(self.Content:GetChildren()) do 
            if v:IsA("ScrollingFrame") then v.Visible = false end 
        end
        Page.Visible = true
        
        TweenService:Create(Btn, TweenInfo.new(0.05), {Position = UDim2.new(0, 0, 0, 3)}):Play()
        task.delay(0.1, function() TweenService:Create(Btn, TweenInfo.new(0.1), {Position = UDim2.new(0, 0, 0, 0)}):Play() end)
    end)
    
    local TabMethods = {MainWindow = self}
    
    function TabMethods:CreateSection(secName)
        local SecLabel = Instance.new("TextLabel", Page)
        SecLabel.Size = UDim2.new(1, -10, 0, 20)
        SecLabel.Text = "// " .. string.upper(secName) .. " //"
        SecLabel.TextColor3 = Color3.fromRGB(0, 180, 255)
        SecLabel.Font = Enum.Font.Code
        SecLabel.TextSize = 11
        SecLabel.BackgroundTransparency = 1
        SecLabel.TextXAlignment = Enum.TextXAlignment.Left
    end

    -- 🧱 منشئ الأزرار 3D
    function TabMethods:CreateButton(opt, cb)
        local BtnHolder = Instance.new("Frame", Page)
        BtnHolder.Size = UDim2.new(1, -10, 0, 38)
        BtnHolder.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
        Instance.new("UICorner", BtnHolder).CornerRadius = UDim.new(0, 6)
        
        local B = Instance.new("TextButton", BtnHolder)
        B.Size = UDim2.new(1, 0, 1, -4)
        B.Text = string.upper(opt.Name)
        B.BackgroundColor3 = opt.Color or Color3.fromRGB(35, 36, 45)
        B.TextColor3 = Color3.fromRGB(255, 255, 255)
        B.Font = Enum.Font.GothamBold
        B.TextSize = 11
        Instance.new("UICorner", B).CornerRadius = UDim.new(0, 6)
        local BStroke = Instance.new("UIStroke", B)
        BStroke.Color = Color3.fromRGB(60, 62, 75)
        
        B.MouseButton1Click:Connect(function()
            playSystemSound(self.MainWindow.SoundUrl)
            TweenService:Create(B, TweenInfo.new(0.05), {Position = UDim2.new(0, 0, 0, 4)}):Play()
            task.delay(0.08, function() TweenService:Create(B, TweenInfo.new(0.1), {Position = UDim2.new(0, 0, 0, 0)}):Play() end)
            cb()
        end)
    end
    
    -- 🧱 منشئ التوجل ثلاثي الأبعاد مع حفظ تلقائي (Auto-Save JSON)
    function TabMethods:CreateToggle(name, default, cb)
        -- شحن الميزة المحفوظة مسبقاً إن وجدت
        if VortexLib.SavedSettings[name] ~= nil then
            default = VortexLib.SavedSettings[name]
        else
            VortexLib.SavedSettings[name] = default
        end
        
        local TF = Instance.new("Frame", Page)
        TF.Size = UDim2.new(1, -10, 0, 38)
        TF.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
        Instance.new("UICorner", TF).CornerRadius = UDim.new(0, 6)
        
        local Lbl = Instance.new("TextLabel", TF)
        Lbl.Size = UDim2.new(0, 200, 1, 0)
        Lbl.Position = UDim2.new(0, 12, 0, 0)
        Lbl.Text = string.upper(name)
        Lbl.TextColor3 = Color3.fromRGB(220, 220, 220)
        Lbl.Font = Enum.Font.GothamBold
        Lbl.TextSize = 11
        Lbl.TextXAlignment = Enum.TextXAlignment.Left
        Lbl.BackgroundTransparency = 1
        
        local SwitchBox = Instance.new("Frame", TF)
        SwitchBox.Size = UDim2.new(0, 42, 0, 22)
        SwitchBox.Position = UDim2.new(1, -54, 0.5, -11)
        SwitchBox.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
        Instance.new("UICorner", SwitchBox).CornerRadius = UDim.new(0, 5)
        
        local Indicator = Instance.new("TextButton", SwitchBox)
        Indicator.Size = UDim2.new(0, 18, 0, 18)
        Indicator.Position = default and UDim2.new(1, -20, 0, 2) or UDim2.new(0, 2, 0, 2)
        Indicator.BackgroundColor3 = default and Color3.fromRGB(0, 180, 255) or Color3.fromRGB(50, 52, 60)
        Indicator.Text = ""
        Instance.new("UICorner", Indicator).CornerRadius = UDim.new(0, 4)
        
        local s = default
        task.spawn(function() cb(s) end) -- تشغيل الفانكشن الأساسي أول ما يفتح السكربت بناء على الحفظ
        
        Indicator.MouseButton1Click:Connect(function()
            playSystemSound(self.MainWindow.SoundUrl)
            s = not s
            VortexLib.SavedSettings[name] = s
            SaveConfig() -- حفظ فوري في الملف بجهاز اللاعب
            
            if s then
                TweenService:Create(Indicator, TweenInfo.new(0.12), {Position = UDim2.new(1, -20, 0, 2), BackgroundColor3 = Color3.fromRGB(0, 180, 255)}):Play()
                self.MainWindow:Notify("Toggle Activated", name .. " تم تشغيله وحفظ الخيار تلقائياً", 2)
            else
                TweenService:Create(Indicator, TweenInfo.new(0.12), {Position = UDim2.new(0, 2, 0, 2), BackgroundColor3 = Color3.fromRGB(50, 52, 60)}):Play()
                self.MainWindow:Notify("Toggle Deactivated", name .. " تم إيقافه وحفظ الخيار تلقائياً", 2)
            end
            cb(s)
        end)
    end
    
    -- 🧱 منشئ السلايدر الميكانيكي 3D مع حفظ تلقائي (Auto-Save JSON)
    function TabMethods:CreateSlider(name, min, max, default, cb)
        if VortexLib.SavedSettings[name] ~= nil then
            default = VortexLib.SavedSettings[name]
        else
            VortexLib.SavedSettings[name] = default
        end
        
        local SF = Instance.new("Frame", Page)
        SF.Size = UDim2.new(1, -10, 0, 46)
        SF.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
        Instance.new("UICorner", SF).CornerRadius = UDim.new(0, 6)
        
        local Lbl = Instance.new("TextLabel", SF)
        Lbl.Size = UDim2.new(0, 200, 0, 18)
        Lbl.Position = UDim2.new(0, 12, 0, 6)
        Lbl.Text = string.upper(name) .. " : " .. default
        Lbl.TextColor3 = Color3.fromRGB(220, 220, 220)
        Lbl.Font = Enum.Font.GothamBold
        Lbl.TextSize = 11
        Lbl.TextXAlignment = Enum.TextXAlignment.Left
        Lbl.BackgroundTransparency = 1
        
        local SB = Instance.new("TextButton", SF)
        SB.Size = UDim2.new(1, -24, 0, 6)
        SB.Position = UDim2.new(0, 12, 0, 30)
        SB.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
        SB.Text = ""
        Instance.new("UICorner", SB).CornerRadius = UDim.new(1, 0)
        
        local SFill = Instance.new("Frame", SB)
        SFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
        SFill.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
        Instance.new("UICorner", SFill).CornerRadius = UDim.new(1, 0)
        
        task.spawn(function() cb(default) end)
        
        local function update()
            local mPos = UserInputService:GetMouseLocation().X
            local bPos = SB.AbsolutePosition.X
            local bWidth = SB.AbsoluteSize.X
            local pct = math.clamp((mPos - bPos) / bWidth, 0, 1)
            local val = math.floor(min + (max - min) * pct)
            Lbl.Text = string.upper(name) .. " : " .. val
            SFill.Size = UDim2.new(pct, 0, 1, 0)
            VortexLib.SavedSettings[name] = val
            SaveConfig()
            cb(val)
        end
        
        local drag = false
        SB.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = true update() end end)
        UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end end)
        UserInputService.InputChanged:Connect(function(i) if drag and i.UserInputType == Enum.UserInputType.MouseMovement then update() end end)
    end

    return TabMethods
end

function VortexLib:Init()
    self.Gui.Enabled = true
    self:Notify("Vortex Connected", "تم تشغيل النظام الميكانيكي بنجاح واكتشاف ملفات الحفظ تلقائياً! ⚡", 4)
end

return VortexLib
