--// VORTEX GOLDEN EDITION - FINAL PERSONALIZED BUILD
local Vortex = {}
local UIS, TweenService, RunService = game:GetService("UserInputService"), game:GetService("TweenService"), game:GetService("RunService")
local Blur = Instance.new("BlurEffect", game.Lighting); Blur.Size = 0

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.fromOffset(450, 350); MainFrame.Position = UDim2.fromScale(0.5, 0.5); MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20); MainFrame.BackgroundTransparency = 0.1; MainFrame.Visible = false; MainFrame.ClipsDescendants = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

--// [نظام اللغات والبيانات الشخصية]
Vortex.Lang = "AR"
Vortex.Data = {
    Name = { ["AR"] = "عبدالله - علم العراق 🇮🇶", ["EN"] = "Abdullah - Iraq Flag 🇮🇶" },
    Account = { ["AR"] = "حساب روبلوكس: eonsali07807863909", ["EN"] = "Roblox Account: eonsali07807863909" }
}

--// [نظام الفقاعات + السحب + الأنميشن] (تم اختصارها للأداء)
local function CreateBubble()
    local b = Instance.new("Frame", MainFrame); b.Size = UDim2.fromOffset(8, 8); b.Position = UDim2.new(math.random(), 0, 1.2, 0); b.BackgroundColor3 = Color3.fromRGB(0, 140, 255); b.ZIndex = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)
    TweenService:Create(b, TweenInfo.new(4), {Position = UDim2.new(math.random(), 0, -0.2, 0), BackgroundTransparency = 1}):Play()
    game:GetService("Debris"):AddItem(b, 4)
end
task.spawn(function() while task.wait(0.6) do if MainFrame.Visible then CreateBubble() end end end)

--// [نظام التبويبات]
local TabContainer = Instance.new("ScrollingFrame", MainFrame); TabContainer.Size = UDim2.new(1, 0, 0, 40); TabContainer.BackgroundTransparency = 1; TabContainer.CanvasSize = UDim2.new(0, 500, 0, 0)
local ListLayout = Instance.new("UIListLayout", TabContainer); ListLayout.FillDirection = Enum.FillDirection.Horizontal; ListLayout.Padding = UDim.new(0, 5)

function Vortex:CreateTab(Name)
    local Tab = Instance.new("TextButton", TabContainer); Tab.Text = Name; Tab.Size = UDim2.new(0, 100, 1, 0); Tab.BackgroundColor3 = Color3.fromRGB(30,30,40); Instance.new("UICorner", Tab)
    return Tab
end

--// [نظام الإعدادات الشخصية]
local SettingsTab = Vortex:CreateTab("Settings")
local NameLabel = Instance.new("TextLabel", MainFrame); NameLabel.Size = UDim2.new(1, 0, 0, 30); NameLabel.Position = UDim2.new(0, 0, 0.5, 0); NameLabel.TextColor3 = Color3.new(1,1,1); NameLabel.BackgroundTransparency = 1
local AccLabel = Instance.new("TextLabel", MainFrame); AccLabel.Size = UDim2.new(1, 0, 0, 30); AccLabel.Position = UDim2.new(0, 0, 0.6, 0); AccLabel.TextColor3 = Color3.new(0.8,0.8,0.8); AccLabel.BackgroundTransparency = 1

function Vortex:UpdateLabels()
    NameLabel.Text = Vortex.Data.Name[Vortex.Lang]
    AccLabel.Text = Vortex.Data.Account[Vortex.Lang]
end
Vortex:UpdateLabels()

--// [نظام السلايدر المحسن]
function Vortex:CreateSlider(Parent, Text, Min, Max, Callback)
    local SliderBg = Instance.new("Frame", Parent); SliderBg.Size = UDim2.new(0.8, 0, 0, 30); SliderBg.BackgroundColor3 = Color3.fromRGB(40,40,50); Instance.new("UICorner", SliderBg)
    local Fill = Instance.new("Frame", SliderBg); Fill.Size = UDim2.new(0, 0, 1, 0); Fill.BackgroundColor3 = Color3.fromRGB(0, 140, 255); Instance.new("UICorner", Fill)
    local Btn = Instance.new("TextButton", SliderBg); Btn.Size = UDim2.new(1, 0, 1, 0); Btn.BackgroundTransparency = 1; Btn.Text = Text
    
    Btn.MouseButton1Down:Connect(function()
        local con
        con = RunService.RenderStepped:Connect(function()
            local mouseX = UIS:GetMouseLocation().X - SliderBg.AbsolutePosition.X
            local perc = math.clamp(mouseX / SliderBg.AbsoluteSize.X, 0, 1)
            Fill.Size = UDim2.new(perc, 0, 1, 0)
            Callback(math.floor(Min + (Max - Min) * perc))
        end)
        UIS.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then con:Disconnect() end end)
    end)
    return SliderBg
end

return Vortex
