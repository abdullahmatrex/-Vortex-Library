--//==================================================================--
--        VORTEX PRESTIGE FRAMEWORK - ULTRA MASTER OMNI SUITE v400.0
--        DESIGNED & ENGINEERED BY: ABDULLAH ALI (© ALL RIGHTS RESERVED 2026)
--//==================================================================--

local Vortex = {}
Vortex.__index = Vortex

--// [إعداد الجداول والبيانات الأساسية للمحرك]
Vortex.Info = { Name = "Vortex Prestige UI", Version = "400.0.0", Developer = "Abdullah Ali" }
Vortex.Name = Vortex.Info.Name
Vortex.Version = Vortex.Info.Version
Vortex.SelectedLanguage = "EN"

Vortex.About = {}
Vortex.Plugin = { PluginsList = {} }
Vortex.Safe = {}
Vortex.Effects = {}
Vortex.Glass = {}
Vortex.Responsive = { ScaleFactor = 1, MobileMode = false }
Vortex.Window = { State = "Normal" }
Vortex.Notification = { ActiveNotifs = {} }
Vortex.Logger = { Logs = {} }
Vortex.Performance = { StartTime = os.time() }
Vortex.Sidebar = { Items = {}, IsOpen = false }
Vortex.Search = { Database = {} }
Vortex.ConfigSystem = { CurrentProfile = "Default", Config = {} }
Vortex.Theme = { ThemesList = {}, ActiveTheme = "Neon", ColorMap = {} }
Vortex.Animation = { Speed = 0.3, Enabled = true, CurrentStyle = "ZoomFade" }
Vortex.Pages = {}
Vortex.Button = {}

--// [استدعاء خدمات روبلوكس الأساسية]
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer

--// [تنظيف أي واجهات سابقة لمنع التكرار]
if CoreGui:FindFirstChild("VortexPrestigeUI") then 
	CoreGui:FindFirstChild("VortexPrestigeUI"):Destroy() 
end

--// [إنشاء لوحة الرسم الرئيسية]
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "VortexPrestigeUI"
ScreenGui.ResetOnSpawn = false

--// [نظام الصوت ولوحة المفاتيح التناغمية]
local KeySound = Instance.new("Sound", SoundService)
KeySound.Name = "KeyboardClick"
KeySound.SoundId = "rbxassetid://9118828562"
KeySound.Volume = 0.2

function Vortex:KeyClick()
	if KeySound then KeySound.TimePosition = 0; KeySound:Play() end
end

local SoundEffects = {
	Click = Instance.new("Sound", SoundService),
	Hover = Instance.new("Sound", SoundService),
	Notify = Instance.new("Sound", SoundService)
}
SoundEffects.Click.SoundId = "rbxassetid://9118828562"; SoundEffects.Click.Volume = 0.4
SoundEffects.Hover.SoundId = "rbxassetid://9114223167"; SoundEffects.Hover.Volume = 0.15
SoundEffects.Notify.SoundId = "rbxassetid://9114227447"; SoundEffects.Notify.Volume = 0.5

local function PlaySound(Type)
	if SoundEffects[Type] then SoundEffects[Type].TimePosition = 0; SoundEffects[Type]:Play() end
end

--//==================================================================--
--  [تفعيل المنطق البرمجي الكامل لكل وظائف وأفكار الأنظمة]
--//==================================================================--

--// [1. Vortex.About System]
function Vortex.About:Create()
	Vortex.Notification:Add("Vortex About", "Hub: " .. Vortex.Name .. "\nDev: " .. Vortex.Info.Developer .. "\nVersion: " .. Vortex.Info.Version, 5)
end

--// [2. Vortex.Plugin System]
function Vortex.Plugin:Add(Name, PluginTable) self.PluginsList[Name] = PluginTable end

--// [3. Vortex.Safe System]
function Vortex.Safe:Call(Function) local Success, Error = pcall(Function) return Success, Error end

--// [4. Vortex.Logger System]
function Vortex.Logger:Add(Message) table.insert(self.Logs, "[" .. os.date("%X") .. "] " .. tostring(Message)) end

--// [5. Vortex.Performance System]
function Vortex.Performance:GetFPS() local FPS = 60; pcall(function() FPS = math.floor(1 / RunService.RenderStepped:Wait()) end) return FPS end
function Vortex.Performance:GetPing() local Ping = 0; pcall(function() Ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue()) end) return Ping end

--// [6. Vortex.Responsive System]
function Vortex.Responsive:IsMobile() return (UIS.TouchEnabled and not UIS.KeyboardEnabled) end

--// [7. Vortex.Glass System]
function Vortex.Glass:Enable(Object, BlurAmount)
	local Blur = Lighting:FindFirstChild("VortexBlur") or Instance.new("BlurEffect", Lighting)
	Blur.Name = "VortexBlur"; Blur.Size = BlurAmount or 18; Blur.Enabled = true
end
function Vortex.Glass:Disable() if Lighting:FindFirstChild("VortexBlur") then Lighting:FindFirstChild("VortexBlur"):Destroy() end end

--// [8. Vortex.Search Engine System]
function Vortex.Search:AddItem(Name, Object) self.Database[Name] = Object end

--// [9. Vortex.ConfigSystem Engine]
function Vortex.ConfigSystem:Save(Name) if writefile then writefile("Vortex_Profile_"..Name..".json", HttpService:JSONEncode(self.Config)) end end

--// [10. Vortex.Theme Engine]
function Vortex.Theme:Rainbow(Object)
	task.spawn(function()
		while task.wait(1/30) and Object.Parent do
			local hue = (tick() % 5) / 5
			local col = Color3.fromHSV(hue, 1, 1)
			if Object:IsA("UIStroke") then Object.Color = col elseif Object:IsA("TextLabel") then Object.TextColor3 = col else Object.BackgroundColor3 = col end
		end
	end)
end

--// [11. Vortex.Animation System]
function Vortex.Animation:Play(Object, Type, CustomSpeed)
	if not self.Enabled then return end
	local Spd = CustomSpeed or self.Speed
	if Type == "Zoom" then
		Object.Size = UDim2.fromScale(0, 0); TweenService:Create(Object, TweenInfo.new(Spd, Enum.EasingStyle.Back), {Size = UDim2.fromOffset(630, 430)}):Play()
	end
end

--// [13. Vortex.Button Systems]
function Vortex.Button:Hover(ButtonObject)
	local OrigCol = ButtonObject.BackgroundColor3
	ButtonObject.MouseEnter:Connect(function() TweenService:Create(ButtonObject, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 36, 50)}):Play() end)
	ButtonObject.MouseLeave:Connect(function() TweenService:Create(ButtonObject, TweenInfo.new(0.2), {BackgroundColor3 = OrigCol}):Play() end)
end

--// [14. Advanced Effects Engine]
function Vortex.Effects:DynamicGlow(Object) local Stroke = Object:FindFirstChildOfClass("UIStroke") or Instance.new("UIStroke", Object); task.spawn(function() while task.wait(0.05) and Stroke.Parent do Stroke.Thickness = 2 + math.sin(tick() * 4) * 1.2 end end) end
function Vortex.Effects:TypingTitle(LabelObject) local OriginalText = LabelObject.Text; task.spawn(function() while task.wait(6) and LabelObject.Parent do LabelObject.Text = ""; for i = 1, #OriginalText do LabelObject.Text = string.sub(OriginalText, 1, i); task.wait(0.06) end end end) end

--// [15. Elite Notification UI Engine]
local NotifyContainer = Instance.new("Frame", ScreenGui); NotifyContainer.Size = UDim2.new(0, 300, 1, -40); NotifyContainer.Position = UDim2.new(1, -320, 0, 20); NotifyContainer.BackgroundTransparency = 1
local NotifLayout = Instance.new("UIListLayout", NotifyContainer); NotifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom; NotifLayout.Padding = UDim.new(0, 8)
function Vortex.Notification:Add(Title, Description, Time)
	PlaySound("Notify"); local Duration = Time or 4; local Box = Instance.new("Frame", NotifyContainer); Box.Size = UDim2.new(1, 0, 0, 60); Box.BackgroundColor3 = Color3.fromRGB(14, 14, 22); Box.BackgroundTransparency = 0.2; Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 8); local Stroke = Instance.new("UIStroke", Box); Stroke.Color = Color3.fromRGB(0, 140, 255)
	local Tl = Instance.new("TextLabel", Box); Tl.Size = UDim2.new(1, -20, 0, 22); Tl.Position = UDim2.new(0, 12, 0, 6); Tl.BackgroundTransparency = 1; Tl.Text = Title; Tl.Font = Enum.Font.GothamBold; Tl.TextColor3 = Color3.new(1,1,1); Tl.TextSize = 13; Tl.TextXAlignment = Enum.TextXAlignment.Left
	local Dc = Instance.new("TextLabel", Box); Dc.Size = UDim2.new(1, -20, 0, 24); Dc.Position = UDim2.new(0, 12, 0, 26); Dc.BackgroundTransparency = 1; Dc.Text = Description; Dc.Font = Enum.Font.Gotham; Dc.TextColor3 = Color3.fromRGB(180, 185, 200); Dc.TextSize = 11; Dc.TextXAlignment = Enum.TextXAlignment.Left
	task.delay(Duration, function() if Box and Box.Parent then Box:Destroy() end end)
end
function Vortex.Notify(Title, Desc) Vortex.Notification:Add(Title, Desc, 4) end

--//==================================================================--
--  [إنشاء نافذة القائمة الرئيسية - MAIN WINDOW FRAME]
--//==================================================================--
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 630, 0, 430); MainFrame.Position = UDim2.new(0.5, -315, 0.5, -215); MainFrame.BackgroundColor3 = Color3.fromRGB(11, 11, 16); MainFrame.Active = true; MainFrame.Visible = false
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14)
local MainStroke = Instance.new("UIStroke", MainFrame); MainStroke.Color = Color3.fromRGB(45, 45, 60); MainStroke.Thickness = 1.5

-- [16. Vortex.Window Management Engine]
function Vortex.Window:Mini() TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 630, 0, 45)}):Play(); self.State = "Mini" end
function Vortex.Window:Normal() TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 630, 0, 430)}):Play(); self.State = "Normal" end

-- إعداد شريط العنوان العلوي وأزرار التحكم بالنافذة
local TopBar = Instance.new("Frame", MainFrame); TopBar.Size = UDim2.new(1, 0, 0, 45); TopBar.BackgroundTransparency = 1
local HeaderTitle = Instance.new("TextLabel", TopBar); HeaderTitle.Size = UDim2.new(1, -150, 1, 0); HeaderTitle.Position = UDim2.new(0, 18, 0, 0); HeaderTitle.BackgroundTransparency = 1; HeaderTitle.Text = Vortex.Name; HeaderTitle.Font = Enum.Font.GothamBold; HeaderTitle.TextSize = 15; HeaderTitle.TextColor3 = Color3.new(1, 1, 1); HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
Vortex.Effects:TypingTitle(HeaderTitle)

-- زر الإغلاق الذكي والتأكيد قبل حذف السكربت
local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Size = UDim2.fromOffset(24, 24); CloseBtn.Position = UDim2.new(1, -38, 0.5, -12); CloseBtn.BackgroundColor3 = Color3.fromRGB(30, 15, 20); CloseBtn.Text = "✕"; CloseBtn.TextColor3 = Color3.fromRGB(255, 70, 70); CloseBtn.Font = Enum.Font.GothamBold; CloseBtn.TextSize = 12
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0); Instance.new("UIStroke", CloseBtn).Color = Color3.fromRGB(80, 30, 30)

-- زر التصغير الإضافي (إلى الزر العائم V)
local MinimizeBtn = Instance.new("TextButton", TopBar)
MinimizeBtn.Size = UDim2.fromOffset(24, 24); MinimizeBtn.Position = UDim2.new(1, -68, 0.5, -12); MinimizeBtn.BackgroundColor3 = Color3.fromRGB(15, 22, 35); MinimizeBtn.Text = "—"; MinimizeBtn.TextColor3 = Color3.fromRGB(0, 180, 255); MinimizeBtn.Font = Enum.Font.GothamBold; MinimizeBtn.TextSize = 10
Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(1, 0); Instance.new("UIStroke", MinimizeBtn).Color = Color3.fromRGB(30, 45, 70)

-- نظام سحب اللوحة الرئيسية
local dragToggle, dragStart, startPos
MainFrame.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 and input.Position.Y - MainFrame.AbsolutePosition.Y <= 45 then dragToggle = true; dragStart = input.Position; startPos = MainFrame.Position end end)
UIS.InputChanged:Connect(function(input) if dragToggle and input.UserInputType == Enum.UserInputType.MouseMovement then local delta = input.Position - dragStart; MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) end end)
UIS.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragToggle = false end end)

local TabScroller = Instance.new("ScrollingFrame", MainFrame); TabScroller.Size = UDim2.new(1, -36, 0, 36); TabScroller.Position = UDim2.new(0, 18, 0, 50); TabScroller.BackgroundTransparency = 1; TabScroller.ScrollBarThickness = 0
local TabListLayout = Instance.new("UIListLayout", TabScroller); TabListLayout.FillDirection = Enum.FillDirection.Horizontal; TabListLayout.Padding = UDim.new(0, 8)
local PageContainer = Instance.new("Frame", MainFrame); PageContainer.Position = UDim2.new(0, 18, 0, 98); PageContainer.Size = UDim2.new(1, -36, 1, -116); PageContainer.BackgroundTransparency = 1

local WindowMethods = {TabCount = 0, ActivePage = nil, ActiveTabButton = nil}
function WindowMethods:CreateTab(TabName)
	self.TabCount = self.TabCount + 1; local PageScroll = Instance.new("ScrollingFrame", PageContainer); PageScroll.Size = UDim2.fromScale(1, 1); PageScroll.BackgroundTransparency = 1; PageScroll.Visible = false; PageScroll.ScrollBarThickness = 2
	local PageLayout = Instance.new("UIListLayout", PageScroll); PageLayout.Padding = UDim.new(0, 8); PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() PageScroll.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 15) end)
	local TabBtn = Instance.new("TextButton", TabScroller); TabBtn.Size = UDim2.new(0, 110, 1, 0); TabBtn.Text = TabName; TabBtn.Font = Enum.Font.GothamBold; TabBtn.TextSize = 12; TabBtn.TextColor3 = Color3.fromRGB(140, 145, 160); TabBtn.BackgroundColor3 = Color3.fromRGB(16, 17, 24); Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 7); local TabStroke = Instance.new("UIStroke", TabBtn); TabStroke.Color = Color3.fromRGB(35, 35, 50)
	TabBtn.MouseButton1Click:Connect(function() Vortex:KeyClick(); PlaySound("Click"); if WindowMethods.ActivePage then WindowMethods.ActivePage.Visible = false end; if WindowMethods.ActiveTabButton then WindowMethods.ActiveTabButton.BackgroundColor3 = Color3.fromRGB(16, 17, 24); WindowMethods.ActiveTabButton.TextColor3 = Color3.fromRGB(140, 145, 160); WindowMethods.ActiveTabButton:FindFirstChildOfClass("UIStroke").Color = Color3.fromRGB(35, 35, 50) end; WindowMethods.ActivePage = PageScroll; PageScroll.Visible = true; WindowMethods.ActiveTabButton = TabBtn; TabBtn.BackgroundColor3 = Color3.fromRGB(26, 28, 40); TabBtn.TextColor3 = Color3.fromRGB(0, 140, 255); TabStroke.Color = Color3.fromRGB(0, 140, 255) end)
	if self.TabCount == 1 then PageScroll.Visible = true; WindowMethods.ActivePage = PageScroll; WindowMethods.ActiveTabButton = TabBtn end
	local ElementMethods = {Container = PageScroll}
	function ElementMethods:AddButton(Text, Callback)
		local Btn = Instance.new("TextButton", self.Container); Btn.Size = UDim2.new(1, -6, 0, 40); Btn.BackgroundColor3 = Color3.fromRGB(18, 19, 28); Btn.Text = "   " .. Text; Btn.Font = Enum.Font.GothamMedium; Btn.TextColor3 = Color3.new(1, 1, 1); Btn.TextSize = 13; Btn.TextXAlignment = Enum.TextXAlignment.Left; Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8); Instance.new("UIStroke", Btn).Color = Color3.fromRGB(45, 45, 60)
		Btn.MouseButton1Click:Connect(function() Vortex:KeyClick(); PlaySound("Click"); if Callback then Callback() end end); Vortex.Button:Hover(Btn); Vortex.Search:AddItem(Text, Btn)
	end
	return ElementMethods
end

--//==================================================================--
--  [إنشاء الزر العائم المميز الذكي على شكل حرف V]
--//==================================================================--
local FloatingBtn = Instance.new("TextButton", ScreenGui)
FloatingBtn.Name = "VortexFloatingButton"
FloatingBtn.Size = UDim2.fromOffset(46, 46)
FloatingBtn.Position = UDim2.new(0.05, 0, 0.2, 0) -- يظهر في مكان جانبي ذكي وعائم
FloatingBtn.BackgroundColor3 = Color3.fromRGB(11, 11, 18)
FloatingBtn.Text = "V"
FloatingBtn.Font = Enum.Font.GothamBold
FloatingBtn.TextColor3 = Color3.fromRGB(0, 150, 255)
FloatingBtn.TextSize = 20
FloatingBtn.Visible = false -- يظهر فقط بعد اختيار اللغة وتصغير اللوحة
FloatingBtn.ZIndex = 1000000

local FloatCorner = Instance.new("UICorner", FloatingBtn)
FloatCorner.CornerRadius = UDim.new(1, 0) -- دائري بالكامل

local FloatStroke = Instance.new("UIStroke", FloatingBtn)
FloatStroke.Color = Color3.fromRGB(0, 140, 255)
FloatStroke.Thickness = 2
Vortex.Theme:Rainbow(FloatStroke) -- تأثير نيون وقوس قزح رائع على حواف حرف الـ V

-- جعل الزر العائم يدعم السحب والتحريك في أي مكان على الشاشة بسلاسة
local fDragToggle, fDragStart, fStartPos
FloatingBtn.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then fDragToggle = true; fDragStart = input.Position; fStartPos = FloatingBtn.Position end end)
UIS.InputChanged:Connect(function(input) if fDragToggle and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then local delta = input.Position - fDragStart; FloatingBtn.Position = UDim2.new(fStartPos.X.Scale, fStartPos.X.Offset + delta.X, fStartPos.Y.Scale, fStartPos.Y.Offset + delta.Y) end end)
UIS.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then fDragToggle = false end end)

-- وظيفة الضغط على زر V لإظهار اللوحة وإخفاء الزر العائم
FloatingBtn.MouseButton1Click:Connect(function()
	Vortex:KeyClick()
	PlaySound("Click")
	FloatingBtn.Visible = false
	MainFrame.Visible = true
	Vortex.Animation:Play(MainFrame, "Zoom")
end)

-- وظيفة زر التصغير (—)
MinimizeBtn.MouseButton1Click:Connect(function()
	PlaySound("Click")
	MainFrame.Visible = false
	FloatingBtn.Visible = true
end)

--//==================================================================--
--  [نظام نافذة اختيار اللغة المنفصل وقبل كل شيء]
--//==================================================================--
local LangFrame = Instance.new("Frame", ScreenGui)
LangFrame.Size = UDim2.fromOffset(340, 220); LangFrame.Position = UDim2.new(0.5, -170, 0.5, -110); LangFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 18); LangFrame.Active = true
Instance.new("UICorner", LangFrame).CornerRadius = UDim.new(0, 12); local LangStroke = Instance.new("UIStroke", LangFrame); LangStroke.Color = Color3.fromRGB(0, 140, 255); LangStroke.Thickness = 1.5

local LangTitle = Instance.new("TextLabel", LangFrame); LangTitle.Size = UDim2.new(1, 0, 0, 50); LangTitle.BackgroundTransparency = 1; LangTitle.Text = "Select Language / اختر اللغة"; LangTitle.Font = Enum.Font.GothamBold; LangTitle.TextColor3 = Color3.new(1, 1, 1); LangTitle.TextSize = 14
local ArabicBtn = Instance.new("TextButton", LangFrame); ArabicBtn.Size = UDim2.fromOffset(280, 45); ArabicBtn.Position = UDim2.new(0.5, -140, 0, 65); ArabicBtn.BackgroundColor3 = Color3.fromRGB(20, 25, 40); ArabicBtn.Text = "العربية"; ArabicBtn.Font = Enum.Font.GothamBold; ArabicBtn.TextColor3 = Color3.fromRGB(0, 200, 255); ArabicBtn.TextSize = 14; Instance.new("UICorner", ArabicBtn).CornerRadius = UDim.new(0, 8); Instance.new("UIStroke", ArabicBtn).Color = Color3.fromRGB(40, 50, 80)
local EnglishBtn = Instance.new("TextButton", LangFrame); EnglishBtn.Size = UDim2.fromOffset(280, 45); EnglishBtn.Position = UDim2.new(0.5, -140, 0, 125); EnglishBtn.BackgroundColor3 = Color3.fromRGB(20, 25, 40); EnglishBtn.Text = "English"; EnglishBtn.Font = Enum.Font.GothamBold; EnglishBtn.TextColor3 = Color3.new(1,1,1); EnglishBtn.TextSize = 14; Instance.new("UICorner", EnglishBtn).CornerRadius = UDim.new(0, 8); Instance.new("UIStroke", EnglishBtn).Color = Color3.fromRGB(40, 50, 80)

local function OpenMainSuite(Lang)
	Vortex.SelectedLanguage = Lang
	PlaySound("Click")
	LangFrame:Destroy()
	MainFrame.Visible = true
	Vortex.Animation:Play(MainFrame, "Zoom")
	if Lang == "AR" then Vortex.Notify("تم التحميل", "مكتبة فورتكس والزر العائم جاهزان.") else Vortex.Notify("Loaded", "Vortex Suite & Floating Button ready.") end
end
ArabicBtn.MouseButton1Click:Connect(function() OpenMainSuite("AR") end)
EnglishBtn.MouseButton1Click:Connect(function() OpenMainSuite("EN") end)

--//==================================================================--
--  [نظام التنبيه بالحذف المتقدم والتأثير التلقائي للاختفاء]
--//==================================================================--
local ConfirmFrame = Instance.new("Frame", ScreenGui)
ConfirmFrame.Size = UDim2.fromOffset(320, 160); ConfirmFrame.Position = UDim2.new(0.5, -160, 0.5, -80); ConfirmFrame.BackgroundColor3 = Color3.fromRGB(16, 11, 16); ConfirmFrame.Visible = false
Instance.new("UICorner", ConfirmFrame).CornerRadius = UDim.new(0, 10); local CfStroke = Instance.new("UIStroke", ConfirmFrame); CfStroke.Color = Color3.fromRGB(255, 70, 70)

local CfTitle = Instance.new("TextLabel", ConfirmFrame); CfTitle.Size = UDim2.new(1, -20, 0, 50); CfTitle.Position = UDim2.new(0, 10, 0, 10); CfTitle.BackgroundTransparency = 1; CfTitle.Text = "Are you sure you want to exit?\nهل أنت متأكد من رغبتك في الخروج؟"; CfTitle.Font = Enum.Font.GothamMedium; CfTitle.TextColor3 = Color3.new(1,1,1); CfTitle.TextSize = 12
local YesBtn = Instance.new("TextButton", ConfirmFrame); YesBtn.Size = UDim2.fromOffset(120, 36); YesBtn.Position = UDim2.new(0, 30, 1, -55); YesBtn.BackgroundColor3 = Color3.fromRGB(50, 15, 20); YesBtn.Text = "Yes / نعم"; YesBtn.TextColor3 = Color3.fromRGB(255, 80, 80); YesBtn.Font = Enum.Font.GothamBold; YesBtn.TextSize = 12; Instance.new("UICorner", YesBtn).CornerRadius = UDim.new(0, 6)
local NoBtn = Instance.new("TextButton", ConfirmFrame); NoBtn.Size = UDim2.fromOffset(120, 36); NoBtn.Position = UDim2.new(1, -150, 1, -55); NoBtn.BackgroundColor3 = Color3.fromRGB(20, 25, 35); NoBtn.Text = "No / لا"; NoBtn.TextColor3 = Color3.new(1,1,1); NoBtn.Font = Enum.Font.GothamBold; NoBtn.TextSize = 12; Instance.new("UICorner", NoBtn).CornerRadius = UDim.new(0, 6)

CloseBtn.MouseButton1Click:Connect(function() PlaySound("Click"); MainFrame.Active = false; ConfirmFrame.Visible = true end)
NoBtn.MouseButton1Click:Connect(function() PlaySound("Click"); ConfirmFrame.Visible = false; MainFrame.Active = true end)

YesBtn.MouseButton1Click:Connect(function()
	PlaySound("Click"); ConfirmFrame:Destroy(); MainFrame:Destroy(); FloatingBtn:Destroy()
	local UnloadingFrame = Instance.new("Frame", ScreenGui); UnloadingFrame.Size = UDim2.fromOffset(300, 70); UnloadingFrame.Position = UDim2.new(0.5, -150, 0.5, -35); UnloadingFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
	Instance.new("UICorner", UnloadingFrame).CornerRadius = UDim.new(0, 8); local UlStroke = Instance.new("UIStroke", UnloadingFrame); UlStroke.Color = Color3.fromRGB(255, 100, 0)
	local UlLabel = Instance.new("TextLabel", UnloadingFrame); UlLabel.Size = UDim2.new(1, 0, 0, 35); UlLabel.BackgroundTransparency = 1; UlLabel.Text = Vortex.SelectedLanguage == "AR" and "جاري حذف وإزالة السكربت..." or "Uninstalling & Clearing Script..."; UlLabel.Font = Enum.Font.GothamBold; UlLabel.TextColor3 = Color3.new(1,1,1); UlLabel.TextSize = 12
	local ProgressBarBg = Instance.new("Frame", UnloadingFrame); ProgressBarBg.Size = UDim2.new(1, -40, 0, 6); ProgressBarBg.Position = UDim2.new(0, 20, 1, -20); ProgressBarBg.BackgroundColor3 = Color3.fromRGB(25, 25, 30); Instance.new("UICorner", ProgressBarBg).CornerRadius = UDim.new(1,0)
	local ProgressBar = Instance.new("Frame", ProgressBarBg); ProgressBar.Size = UDim2.fromScale(0, 1); ProgressBar.BackgroundColor3 = Color3.fromRGB(255, 60, 60); Instance.new("UICorner", ProgressBar).CornerRadius = UDim.new(1,0)
	local Tween = TweenService:Create(ProgressBar, TweenInfo.new(1.8, Enum.EasingStyle.Linear), {Size = UDim2.fromScale(1, 1)}); Tween:Play()
	Tween.Completed:Connect(function() ScreenGui:Destroy(); Vortex.Glass:Disable() end)
end)

return Vortex
