-- =================================================================
--  VORTEX UI LIBRARY V8.0 [🇮🇶 MADE IN IRAQ]
--  DEVELOPER: ABDULLAH (THE DEFINITIVE 30-FEATURE MASTERPIECE)
--  WIDGETS: REAL 3D MECHANICAL INTERFACE, AUTO-CONFIG, PERFORMANCE
-- =================================================================

local VortexLib = {}
VortexLib.__index = VortexLib

local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local SoundEnabled = true
local ConfigFileName = "Vortex_Config_Save.json"
VortexLib.SavedSettings = {}

-- 12+13. نظام قراءة وحفظ الـ JSON تلقائياً
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

-- 10. صوت كيبورد ميكانيكي داخلي معتمد ومقبول بروبلوكس
local function playKeyboardClick()
    if not SoundEnabled then return end
    task.spawn(function()
        local s = Instance.new("Sound")
        s.SoundId = "rbxassetid://9114223126"
        s.Volume = 0.6
        s.Parent = SoundService
        s:Play()
        task.delay(1, function() if s and s.Parent then s:Destroy() end end)
    end)
end

-- 14. نظام إشعارات 3D جانبية
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
        
        local BoxShadow = Instance.new("Frame", NotifHolder)
        BoxShadow.Size = UDim2.new(1, 0, 0, 65)
        BoxShadow.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
        Instance.new("UICorner", BoxShadow).CornerRadius = UDim.new(0, 6)
        
        local Box = Instance.new("Frame", BoxShadow)
        Box.Size = UDim2.new(1, 0, 1, -4)
        Box.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
        Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 6)
        Instance.new("UIStroke", Box).Color = Color3.fromRGB(0, 180, 255)
        
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
        
        BoxShadow.Position = UDim2.new(1, 300, 0, 0)
        TweenService:Create(BoxShadow, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Position = UDim2.new(0, 0, 0, 0)}):Play()
        playKeyboardClick()
        
        task.wait(duration)
        
        local out = TweenService:Create(BoxShadow, TweenInfo.new(0.2), {BackgroundTransparency = 1})
        TweenService:Create(Box, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        out:Play()
        out.Completed:Connect(function() BoxShadow:Destroy() end)
    end)
end

-- 1. منشئ النافذة الرئيسية مع دعم السحب والـ RGB والشفافية
function VortexLib.CreateWindow(cfg)
    LoadConfig()
    
    local self = setmetatable({}, VortexLib)
    
    self.Gui = Instance.new("ScreenGui", CoreGui)
    self.Gui.Name = "VortexMainUI"
    self.Gui.ResetOnSpawn = false
    
    -- 21+22. لوحة السحب والتحكم بالشفافية
    self.Main = Instance.new("Frame", self.Gui)
    self.Main.Size = UDim2.new(0, 540, 0, 320)
    self.Main.Position = UDim2.new(0.5, -270, 0.5, -160)
    self.Main.BackgroundColor3 = cfg.BgColor or Color3.fromRGB(14, 14, 18)
    self.Main.BackgroundTransparency = cfg.Transparency or 0
    self.Main.Active = true
    self.Main.Draggable = true -- 21. السحب مفعّل هندسياً
    Instance.new("UICorner", self.Main).CornerRadius = UDim.new(0, 10)
    
    -- 15. تأثير نيون RGB متحرك حول الحواف
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
    
    -- 3. زر الإغلاق ❌ الحقيقي الميكانيكي البارز
    local CloseBtn = Instance.new("TextButton", self.Main)
    CloseBtn.Size = UDim2.new(0, 28, 0, 28)
    CloseBtn.Position = UDim2.new(1, -40, 0, 10)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(35, 12, 18)
    CloseBtn.Text = "❌"
    CloseBtn.TextSize = 13
    Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", CloseBtn).Color = Color3.fromRGB(255, 50, 70)

    -- 4+5+6+7. نافذة التأكيد وبار التحميل وتغيير النصوص الكامل عند الخروج
    CloseBtn.MouseButton1Click:Connect(function()
        playKeyboardClick()
        
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
            
            pcall(function() self.Gui:Destroy() end) -- 7. مسح كامل من الـ CoreGui
        end)
    end)

    local TitleLabel = Instance.new("TextLabel", self.Main)
    TitleLabel.Size = UDim2.new(0, 200, 0, 30)
    TitleLabel.Position = UDim2.new(0, 20, 0, 10)
    TitleLabel.Text = cfg.Name or "VORTEX HUB"
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 14
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- 18+19. عدادات أداء الـ FPS والـ Ping مدمجة تلقائياً بالواجهة العلوي
    local PerfLabel = Instance.new("TextLabel", self.Main)
    PerfLabel.Size = UDim2.new(0, 150, 0, 20)
    PerfLabel.Position = UDim2.new(1, -200, 0, 14)
    PerfLabel.BackgroundTransparency = 1
    PerfLabel.TextColor3 = Color3.fromRGB(150, 150, 160)
    PerfLabel.Font = Enum.Font.Code
    PerfLabel.TextSize = 10
    PerfLabel.TextXAlignment = Enum.TextXAlignment.Right
    
    task.spawn(function()
        local lastIteration = tick()
        local frameHistory = {}
        while RunService.RenderStepped:Wait() do
            if not self.Gui or not self.Gui.Parent then break end
            local currentTime = tick()
            local fps = math.floor(1 / (currentTime - lastIteration))
            lastIteration = currentTime
            
            local ping = math.floor((Players.LocalPlayer and Players.LocalPlayer:GetNetworkPing() or 0) * 1000)
            PerfLabel.Text = "FPS: " .. fps .. " | PING: " .. ping .. "ms"
        end
    end)

    self.TabContainer = Instance.new("ScrollingFrame", self.Main)
    self.TabContainer.Size = UDim2.new(0, 135, 0, 230)
    self.TabContainer.Position = UDim2.new(0, 15, 0, 50)
    self.TabContainer.BackgroundTransparency = 1
    self.TabContainer.ScrollBarThickness = 0
    Instance.new("UIListLayout", self.TabContainer).Padding = UDim.new(0, 8) -- 26. ترتيب تلقائي ببروز دقيق
    
    self.Content = Instance.new("Frame", self.Main)
    self.Content.Size = UDim2.new(0, 360, 0, 230)
    self.Content.Position = UDim2.new(0, 165, 0, 50)
    self.Content.BackgroundTransparency = 1
    
    self.Gui.Enabled = true
    return self
end

-- 2. منشئ التبويبات 3D الميكانيكية
function VortexLib:CreateTab(tabName)
    local Page = Instance.new("ScrollingFrame", self.Content)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.Visible = false -- 29. عزل كامل وتأمين الصفحات من التداخل
    Page.BackgroundTransparency = 1
    Page.ScrollBarThickness = 2
    Instance.new("UIListLayout", Page).Padding = UDim.new(0, 10)
    
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
        playKeyboardClick()
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

    -- 1. منشئ الأزرار الميكانيكية الـ 3D مع تموج النيون عند الضغط
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
        local BS = Instance.new("UIStroke", B)
        BS.Color = Color3.fromRGB(50, 52, 65)
        
        B.MouseButton1Click:Connect(function()
            playKeyboardClick()
            -- 27. تأثير كبسة النيون والاندفاع لأسفل بالكامل
            TweenService:Create(B, TweenInfo.new(0.05), {Position = UDim2.new(0, 0, 0, 4)}):Play()
            TweenService:Create(BS, TweenInfo.new(0.05), {Color = Color3.fromRGB(0, 180, 255)}):Play()
            
            task.delay(0.08, function() 
                TweenService:Create(B, TweenInfo.new(0.1), {Position = UDim2.new(0, 0, 0, 0)}):Play() 
                TweenService:Create(BS, TweenInfo.new(0.1), {Color = Color3.fromRGB(50, 52, 65)}):Play()
            end)
            pcall(cb) -- 25. حماية معالجة الخطأ لمنع كراش السكربت
        end)
    end
    
    -- 17+24. منشئ التوجل الذكي مع حماية التكرار والـ JSON
    function TabMethods:CreateToggle(name, default, cb)
        if VortexLib.SavedSettings[name] ~= nil then default = VortexLib.SavedSettings[name] else VortexLib.SavedSettings[name] = default end
        
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
        task.spawn(function() pcall(cb, s) end)
        
        local db = false -- 24. حماية من السبام والضغط العشوائي التكراري
        Indicator.MouseButton1Click:Connect(function()
            if db then return end
            db = true
            playKeyboardClick()
            s = not s
            VortexLib.SavedSettings[name] = s
            SaveConfig()
            
            if s then
                TweenService:Create(Indicator, TweenInfo.new(0.12), {Position = UDim2.new(1, -20, 0, 2), BackgroundColor3 = Color3.fromRGB(0, 180, 255)}):Play()
            else
                TweenService:Create(Indicator, TweenInfo.new(0.12), {Position = UDim2.new(0, 2, 0, 2), BackgroundColor3 = Color3.fromRGB(50, 52, 60)}):Play()
            end
            pcall(cb, s)
            task.wait(0.1)
            db = false
        end)
    end
    
    -- 16+28. منشئ السلايدر الميكانيكي 3D البارز مع التحديث النصي الفوري
    function TabMethods:CreateSlider(name, min, max, default, cb)
        if VortexLib.SavedSettings[name] ~= nil then default = VortexLib.SavedSettings[name] else VortexLib.SavedSettings[name] = default end
        
        local SF = Instance.new("Frame", Page)
        SF.Size = UDim2.new(1, -10, 0, 46)
        SF.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
        Instance.new("UICorner", SF).CornerRadius = UDim.new(0, 6)
        
        local Lbl = Instance.new("TextLabel", SF)
        Lbl.Size = UDim2.new(0, 200, 0, 18)
        Lbl.Position = UDim2.new(0, 12, 0, 6)
        Lbl.Text = string.upper(name) .. " : " .. default -- 28. التحديث النصي الأولي
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
        
        task.spawn(function() pcall(cb, default) end)
        
        local function update()
            local mPos = UserInputService:GetMouseLocation().X
            local bPos = SB.AbsolutePosition.X
            local bWidth = SB.AbsoluteSize.X
            local pct = math.clamp((mPos - bPos) / bWidth, 0, 1)
            local val = math.floor(min + (max - min) * pct)
            Lbl.Text = string.upper(name) .. " : " .. val -- 28. تحديث نصي مستمر وفوري أثناء السحب
            SFill.Size = UDim2.new(pct, 0, 1, 0)
            VortexLib.SavedSettings[name] = val
            SaveConfig()
            pcall(cb, val)
        end
        
        local drag = false
        SB.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = true update() end end)
        UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end end)
        UserInputService.InputChanged:Connect(function(i) if drag and i.UserInputType == Enum.UserInputType.MouseMovement then update() end end)
    end

    return TabMethods
end

-- 8+9+11+20. حقن تبويب الإعدادات الإجباري والتلقائي بالكامل بكود الـ Init
function VortexLib:Init()
    -- 8. بناء تبويب الإعدادات بشكل تلقائي في نهاية القائمة
    local SettingsTab = self:CreateTab("Settings")
    
    SettingsTab:CreateSection("Developer Credentials")
    -- 9. وضع اسمك الثنائي وموطنك بشكل بارز ومحفور بالكامل داخل الواجهة
    SettingsTab:CreateButton({Name = "DEVELOPER: ABDULLAH [🇮🇶 IRAQ]", Color = Color3.fromRGB(30, 32, 45)}, function()
        -- 23. ميزة نسخ الحافظة التلقائي
        setclipboard("Abdullah - Vortex Developer")
        self:Notify("System Clipboard", "تم نسخ بيانات المطور عبد الله بنجاح تلقائياً! 📋", 3)
    end)
    
    SettingsTab:CreateSection("Audio Configuration")
    -- 11. زر تفعيل وإلغاء كبسات الصوت كيبورد الميكانيكي
    SettingsTab:CreateToggle("Mechanical Click Sounds", true, function(state)
        SoundEnabled = state
    end)
    
    SettingsTab:CreateSection("Performance Booster")
    -- 20. ميزة مكافحة اللاق (Anti-Lag) المدمجة لتنظيف الماب وزيادة الفريمات
    SettingsTab:CreateButton({Name = "Execute Anti-Lag Engine", Color = Color3.fromRGB(25, 35, 45)}, function()
        self:Notify("Booster Activated", "جارِ مسح الماتيريال الثقيلة لتعزيز الفريمات... 🚀", 3)
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v:IsA("MeshPart") then
                v.Material = Enum.Material.SmoothPlastic
            end
        end
    end)
    
    self.Gui.Enabled = true
    self:Notify("Vortex Core", "جميع الـ 30 فكرة مدمجة وتعمل بأقصى استقرار الحين! ⚡", 4)
end

return VortexLib
