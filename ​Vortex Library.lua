-- =================================================================
--  VORTEX UI LIBRARY [🇮🇶 MADE IN IRAQ]
--  DEVELOPER: ABDULLAH
-- =================================================================

local VortexLib = {}
VortexLib.__index = VortexLib

local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

-- نظام العداد الرقمي الاحترافي
local function startLoading(callback)
    local ScreenGui = Instance.new("ScreenGui", CoreGui)
    ScreenGui.Name = "VortexLoading"
    
    local Frame = Instance.new("Frame", ScreenGui)
    Frame.Size = UDim2.new(0, 400, 0, 120)
    Frame.Position = UDim2.new(0.5, -200, 0.5, -60)
    Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 8)
    
    local BarBg = Instance.new("Frame", Frame)
    BarBg.Size = UDim2.new(0, 360, 0, 10)
    BarBg.Position = UDim2.new(0, 20, 0, 70)
    BarBg.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Instance.new("UICorner", BarBg).CornerRadius = UDim.new(0, 5)
    
    local BarFill = Instance.new("Frame", BarBg)
    BarFill.Size = UDim2.new(0, 0, 1, 0)
    BarFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
    Instance.new("UICorner", BarFill).CornerRadius = UDim.new(0, 5)
    
    local Txt = Instance.new("TextLabel", Frame)
    Txt.Size = UDim2.new(1, 0, 0, 40)
    Txt.Position = UDim2.new(0, 0, 0, 20)
    Txt.Text = "VORTEX LOADING... 0%"
    Txt.TextColor3 = Color3.fromRGB(255, 255, 255)
    Txt.Font = Enum.Font.GothamBold
    Txt.BackgroundTransparency = 1
    
    for i = 1, 100 do
        task.wait(0.015)
        Txt.Text = "VORTEX LOADING... " .. i .. "%"
        BarFill.Size = UDim2.new(i/100, 0, 1, 0)
    end
    ScreenGui:Destroy()
    callback()
end

-- بناء الواجهة
function VortexLib.CreateWindow(cfg)
    local self = setmetatable({}, VortexLib)
    
    self.Gui = Instance.new("ScreenGui", CoreGui)
    self.Gui.Name = "VortexUI"
    self.Gui.Enabled = false
    
    self.Main = Instance.new("ImageLabel", self.Gui)
    self.Main.Size = UDim2.new(0, 700, 0, 450)
    self.Main.Position = UDim2.new(0.5, -350, 0.5, -225)
    self.Main.BackgroundColor3 = cfg.BgColor or Color3.fromRGB(15, 15, 20)
    self.Main.BackgroundTransparency = cfg.Transparency or 0.1
    self.Main.Image = cfg.Image or ""
    self.Main.Active = true
    self.Main.Draggable = true
    Instance.new("UICorner", self.Main).CornerRadius = UDim.new(0, 10)
    
    -- الأيقونة المربعة
    local Icon = Instance.new("TextLabel", self.Main)
    Icon.Size = UDim2.new(0, 70, 0, 40)
    Icon.Position = UDim2.new(0, 15, 0, 15)
    Icon.Text = "abdullah"
    Icon.TextColor3 = Color3.fromRGB(0, 200, 255)
    Icon.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    Instance.new("UICorner", Icon).CornerRadius = UDim.new(0, 6)
    
    -- الحقوق
    local Credits = Instance.new("TextLabel", self.Main)
    Credits.Size = UDim2.new(0, 300, 0, 20)
    Credits.Position = UDim2.new(0, 15, 1, -25)
    Credits.Text = "تم إنشاء في العراق 🇮🇶 بواسطة عبد الله"
    Credits.TextColor3 = Color3.fromRGB(150, 150, 150)
    Credits.BackgroundTransparency = 1
    
    self.TabContainer = Instance.new("ScrollingFrame", self.Main)
    self.TabContainer.Size = UDim2.new(0, 160, 0, 320)
    self.TabContainer.Position = UDim2.new(0, 15, 0, 70)
    self.TabContainer.BackgroundTransparency = 1
    Instance.new("UIListLayout", self.TabContainer).Padding = UDim.new(0, 5)
    
    self.Content = Instance.new("Frame", self.Main)
    self.Content.Size = UDim2.new(0, 490, 0, 320)
    self.Content.Position = UDim2.new(0, 190, 0, 70)
    self.Content.BackgroundTransparency = 1
    
    return self
end

-- تبويبات غير محدودة
function VortexLib:CreateTab(name)
    local Page = Instance.new("ScrollingFrame", self.Content)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.Visible = false
    Page.BackgroundTransparency = 1
    Instance.new("UIListLayout", Page).Padding = UDim.new(0, 5)
    
    local Btn = Instance.new("TextButton", self.TabContainer)
    Btn.Size = UDim2.new(1, 0, 0, 35)
    Btn.Text = name
    Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 5)
    
    Btn.MouseButton1Click:Connect(function()
        for _, v in pairs(self.Content:GetChildren()) do v.Visible = false end
        Page.Visible = true
    end)
    
    local Tab = {}
    function Tab:CreateButton(opt, cb)
        local B = Instance.new("TextButton", Page)
        B.Size = UDim2.new(1, -10, 0, 40)
        B.Text = opt.Name
        B.BackgroundColor3 = opt.Color or Color3.fromRGB(35, 35, 40)
        Instance.new("UICorner", B).CornerRadius = UDim.new(0, 8)
        
        if opt.Rainbow then
            task.spawn(function()
                while RunService.RenderStepped:Wait() do
                    B.BackgroundColor3 = Color3.fromHSV(tick()%5/5, 1, 1)
                end
            end)
        end
        B.MouseButton1Click:Connect(cb)
    end
    return Tab
end

function VortexLib:Init()
    startLoading(function() self.Gui.Enabled = true end)
end

return VortexLib
