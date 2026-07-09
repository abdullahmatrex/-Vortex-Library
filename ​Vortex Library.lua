--// VORTEX GOLDEN EDITION - PERFECTED PERFORMANCE
local Vortex = {}
local UIS, TweenService, RunService = game:GetService("UserInputService"), game:GetService("TweenService"), game:GetService("RunService")
local Blur = Instance.new("BlurEffect", game.Lighting); Blur.Size = 0

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)

--// [1. نظام تحميل فخم مع وقت ممتد لرؤية الاسم]
local LoadingFrame = Instance.new("Frame", ScreenGui)
LoadingFrame.Size = UDim2.fromScale(1, 1); LoadingFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 12); LoadingFrame.ZIndex = 10
local LoadingText = Instance.new("TextLabel", LoadingFrame)
LoadingText.Size = UDim2.fromScale(1, 1); LoadingText.Text = ""; LoadingText.TextColor3 = Color3.fromRGB(0, 140, 255); LoadingText.Font = Enum.Font.GothamBold; LoadingText.TextSize = 28; LoadingText.BackgroundTransparency = 1; LoadingText.ZIndex = 11

task.spawn(function()
    Blur.Size = 25
    local fullText = "VORTEX OMNI"
    -- ظهور الحروف
    for i = 1, #fullText do
        LoadingText.Text = string.sub(fullText, 1, i)
        task.wait(0.12)
    end
    task.wait(1.5) -- وقت إضافي كافٍ لكي تلحق تقرأ الاسم وتستمتع به
    
    TweenService:Create(LoadingFrame, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
    TweenService:Create(LoadingText, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
    task.wait(0.6)
    LoadingFrame:Destroy()
    Blur.Size = 0
end)

--// [2. القائمة الرئيسية - تصغير الارتفاع وتثبيت السنتر]
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.fromOffset(440, 290) -- تم تصغير الارتفاع لتكون ملمومة ومنسقة
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.fromScale(0.5, 0.5) 
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BackgroundTransparency = 0.15
MainFrame.Visible = false
MainFrame.ClipsDescendants = true
MainFrame.ZIndex = 2

local FrameCorner = Instance.new("UICorner", MainFrame)
FrameCorner.CornerRadius = UDim.new(0, 12)

local FrameStroke = Instance.new("UIStroke", MainFrame)
FrameStroke.Color = Color3.fromRGB(0, 140, 255)
FrameStroke.Thickness = 1.8
FrameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

--// [نظام الفقاعات المحسن - أكبر وأكثر كثافة]
local function CreateBubble()
    local b = Instance.new("Frame", MainFrame)
    local size = math.random(10, 16) -- فقاعات أكبر حجماً
    b.Size = UDim2.fromOffset(size, size)
    b.Position = UDim2.new(math.random(), 0, 1.1, 0)
    b.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
    b.BackgroundTransparency = 0.5
    b.ZIndex = 3
    Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)
    
    TweenService:Create(b, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(math.random(), 0, -0.1, 0), 
        BackgroundTransparency = 1
    }):Play()
    game:GetService("Debris"):AddItem(b, 3)
end
-- زيادة التوليد بكثافة أعلى
task.spawn(function() while task.wait(0.25) do if MainFrame.Visible then CreateBubble() end end end)

--// [نظام سحب القائمة]
local dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragStart = input.Position; startPos = MainFrame.Position; dragInput = true end end)
UIS.InputChanged:Connect(function(input) if dragInput and input.UserInputType == Enum.UserInputType.MouseMovement then local delta = input.Position - dragStart; MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) end end)
UIS.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragInput = false end end)

--// [نظام التبويبات والصفحات]
local TabContainer = Instance.new("ScrollingFrame", MainFrame); TabContainer.Size = UDim2.new(1, -20, 0, 35); TabContainer.Position = UDim2.fromOffset(10, 10); TabContainer.BackgroundTransparency = 1; TabContainer.CanvasSize = UDim2.new(0, 600, 0, 0); TabContainer.ScrollBarThickness = 0; TabContainer.ZIndex = 4
local ListLayout = Instance.new("UIListLayout", TabContainer); ListLayout.FillDirection = Enum.FillDirection.Horizontal; ListLayout.Padding = UDim.new(0, 8)

local PageContainer = Instance.new("Frame", MainFrame); PageContainer.Size = UDim2.new(1, -20, 1, -110); PageContainer.Position = UDim2.fromOffset(10, 50); PageContainer.BackgroundTransparency = 1; PageContainer.ZIndex = 4

local ActivePage = nil

function Vortex:CreateTab(Name)
    local Page = Instance.new("ScrollingFrame", PageContainer); Page.Size = UDim2.fromScale(1, 1); Page.BackgroundTransparency = 1; Page.Visible = false; Page.CanvasSize = UDim2.new(0, 0, 2, 0); Page.ScrollBarThickness = 0; Page.ZIndex = 4
    local PageLayout = Instance.new("UIListLayout", Page); PageLayout.Padding = UDim.new(0, 8)
    
    local Tab = Instance.new("TextButton", TabContainer); Tab.Text = Name; Tab.Size = UDim2.fromOffset(90, 28); Tab.BackgroundColor3 = Color3.fromRGB(30, 30, 40); Tab.TextColor3 = Color3.new(1,1,1); Tab.ZIndex = 4; Instance.new("UICorner", Tab).CornerRadius = UDim.new(0, 6)
    
    Tab.MouseButton1Click:Connect(function()
        for _, p in pairs(PageContainer:GetChildren()) do if p:IsA("ScrollingFrame") then p.Visible = false end end
        Page.Visible = true
        ActivePage = Page
    end)
    
    if ActivePage == nil then 
        Page.Visible = true 
        ActivePage = Page 
    end
    return Page
end

--// [3. نظام الأزرار]
function Vortex:CreateToggle(Arg1, Arg2, Arg3)
    local TargetPage = type(Arg1) == "userdata" and Arg1 or ActivePage
    local Text = type(Arg1) == "string" and Arg1 or Arg2
    local Callback = type(Arg2) == "function" and Arg2 or Arg3
    
    local T = Instance.new("TextButton", TargetPage); T.Text = Text; T.Size = UDim2.new(1, -10, 0, 32); T.BackgroundColor3 = Color3.fromRGB(40, 40, 50); T.TextColor3 = Color3.new(1,1,1); T.ZIndex = 5; Instance.new("UICorner", T)
    T.MouseButton1Click:Connect(function()
        TweenService:Create(T, TweenInfo.new(0.1), {Size = T.Size - UDim2.fromOffset(4, 4)}):Play()
        task.wait(0.1); TweenService:Create(T, TweenInfo.new(0.1), {Size = T.Size + UDim2.fromOffset(4, 4)}):Play()
        Callback()
    end)
    return T
end

--// [4. نظام السلايدر المحمي والمقيد بلمس السلايدر نفسه فقط]
function Vortex:CreateSlider(Arg1, Arg2, Arg3, Arg4, Arg5)
    local TargetPage = type(Arg1) == "userdata" and Arg1 or ActivePage
    local Text = type(Arg1) == "string" and Arg1 or Arg2
    local Min = type(Arg2) == "number" and Arg2 or Arg3
    local Max = type(Arg3) == "number" and Arg3 or Arg4
    local Callback = type(Arg4) == "function" and Arg4 or Arg5
    
    local SliderBg = Instance.new("Frame", TargetPage); SliderBg.Size = UDim2.new(1, -10, 0, 35); SliderBg.BackgroundColor3 = Color3.fromRGB(30, 30, 35); SliderBg.ZIndex = 5; Instance.new("UICorner", SliderBg)
    local Fill = Instance.new("Frame", SliderBg); Fill.Size = UDim2.new(0, 0, 1, 0); Fill.BackgroundColor3 = Color3.fromRGB(0, 140, 255); Fill.ZIndex = 5; Instance.new("UICorner", Fill)
    local Btn = Instance.new("TextButton", SliderBg); Btn.Size = UDim2.new(1, 0, 1, 0); Btn.BackgroundTransparency = 1; Btn.Text = Text .. " : " .. Min; Btn.TextColor3 = Color3.new(1,1,1); Btn.ZIndex = 6
    
    local isSliding = false -- مفتاح الأمان لمنع الحركة العشوائية
    
    Btn.MouseButton1Down:Connect(function()
        isSliding = true
    end)
    
    local moveCon = UIS.InputChanged:Connect(function(input)
        if isSliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local mouseX = input.Position.X - SliderBg.AbsolutePosition.X
            local perc = math.clamp(mouseX / SliderBg.AbsoluteSize.X, 0, 1)
            Fill.Size = UDim2.new(perc, 0, 1, 0)
            local val = math.floor(Min + (Max - Min) * perc)
            Btn.Text = Text .. " : " .. val
            Callback(val)
        end
    end)
    
    local endCon = UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isSliding = false
        end
    end)
    
    return SliderBg
end

--// [5. الزر العائم V الثقيل والمنسق]
local FloatBtn = Instance.new("TextButton", ScreenGui); FloatBtn.Size = UDim2.fromOffset(42, 42); FloatBtn.Position = UDim2.new(0.05, 0, 0.2, 0); FloatBtn.Text = "V"; FloatBtn.TextColor3 = Color3.new(1,1,1); FloatBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30); Instance.new("UICorner", FloatBtn).CornerRadius = UDim.new(1, 0)

local function ToggleUI()
    local isOpen = MainFrame.Visible
    MainFrame.Visible = not isOpen
    TweenService:Create(Blur, TweenInfo.new(0.4), {Size = (isOpen and 0 or 20)}):Play()
end
FloatBtn.MouseButton1Click:Connect(ToggleUI)

local fDragStart, fStartPos, fDragging
FloatBtn.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then fDragStart = input.Position; fStartPos = FloatBtn.Position; fDragging = true end end)
UIS.InputChanged:Connect(function(input)
    if fDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - fDragStart
        local targetPos = UDim2.new(fStartPos.X.Scale, fStartPos.X.Offset + delta.X, fStartPos.Y.Scale, fStartPos.Y.Offset + delta.Y)
        TweenService:Create(FloatBtn, TweenInfo.new(0.25, Enum.EasingStyle.OutQuad), {Position = targetPos}):Play()
    end
end)
UIS.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then fDragging = false end end)

--// [6. لوحة الحقوق الثابتة والمعدلة]
Vortex.Lang = "AR"
Vortex.Data = { 
    Name = { ["AR"] = "المطور: عبدالله 🇮🇶", ["EN"] = "Dev: Abdullah 🇮🇶" }, 
    Account = { ["AR"] = "الحساب: eonsali07807863909", ["EN"] = "Acc: eonsali07807863909" } 
}

local InfoFrame = Instance.new("Frame", MainFrame)
InfoFrame.Size = UDim2.new(1, -20, 0, 45)
InfoFrame.Position = UDim2.new(0, 10, 1, -48) 
InfoFrame.BackgroundTransparency = 1
InfoFrame.ZIndex = 5

local NameLabel = Instance.new("TextLabel", InfoFrame); NameLabel.Size = UDim2.new(1, 0, 0, 18); NameLabel.TextColor3 = Color3.fromRGB(0, 140, 255); NameLabel.BackgroundTransparency = 1; NameLabel.TextXAlignment = Enum.TextXAlignment.Left; NameLabel.Font = Enum.Font.GothamBold; NameLabel.ZIndex = 5; NameLabel.TextSize = 13
local AccLabel = Instance.new("TextLabel", InfoFrame); AccLabel.Size = UDim2.new(1, 0, 0, 18); AccLabel.Position = UDim2.fromOffset(0, 18); AccLabel.TextColor3 = Color3.fromRGB(160, 160, 160); AccLabel.BackgroundTransparency = 1; AccLabel.TextXAlignment = Enum.TextXAlignment.Left; AccLabel.Font = Enum.Font.Gotham; AccLabel.ZIndex = 5; AccLabel.TextSize = 12

function Vortex:UpdateLabels()
    NameLabel.Text = Vortex.Data.Name[Vortex.Lang]
    AccLabel.Text = Vortex.Data.Account[Vortex.Lang]
end
Vortex:UpdateLabels()

return Vortex
