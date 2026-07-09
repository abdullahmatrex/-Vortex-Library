--//==================================================================--
--        VORTEX PRESTIGE FRAMEWORK - ULTRA MASTER OMNI SUITE v800.0
--        DEVELOPER IDE & COMPONENT ENGINE - PRO EDITION
--        DESIGNED & ENGINEERED BY: ABDULLAH ALI (© ALL RIGHTS RESERVED 2026)
--//==================================================================--

local Vortex = {}
Vortex.__index = Vortex

--// [إعداد الجداول والبيانات الأساسية للمحرك العملاق]
Vortex.Info = { Name = "Vortex Prestige UI", Version = "800.0.0", Developer = "Abdullah Ali" }
Vortex.Name = Vortex.Info.Name
Vortex.Version = Vortex.Info.Version
Vortex.SelectedLanguage = "EN"
Vortex.UIMode = "Dark"
Vortex.KeyVerified = false

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
Vortex.Pages = {}
Vortex.Button = {}
Vortex.Favorites = {}
Vortex.Security = { UserKey = "VORTEX_FREE_2026", UserProfiles = {} }
Vortex.Animation = { Speed = 0.3, Enabled = true, CurrentStyle = "ZoomFade" }
Vortex.Sound = { Volume = 0.4, Cache = {} }

--// [الأدوات البرمجية الجديدة للمطورين - Developer Tools Modules]
Vortex.Component = {}
Vortex.API = { Registry = {} }
Vortex.Docs = { Database = {} }

Vortex.Theme = {
	ActiveTheme = "Neon Blue",
	ThemesList = {
		["Neon Blue"] = { Primary = Color3.fromRGB(0, 140, 255), Background = Color3.fromRGB(11, 11, 16), Sidebar = Color3.fromRGB(16, 17, 24), LightBg = Color3.fromRGB(240, 244, 255) },
		["Cyber Purple"] = { Primary = Color3.fromRGB(180, 0, 255), Background = Color3.fromRGB(12, 8, 18), Sidebar = Color3.fromRGB(20, 12, 28), LightBg = Color3.fromRGB(245, 235, 255) },
		["Fire Red"] = { Primary = Color3.fromRGB(255, 40, 40), Background = Color3.fromRGB(16, 8, 8), Sidebar = Color3.fromRGB(26, 12, 12), LightBg = Color3.fromRGB(255, 235, 235) },
		["Toxic Green"] = { Primary = Color3.fromRGB(40, 255, 40), Background = Color3.fromRGB(8, 16, 8), Sidebar = Color3.fromRGB(12, 26, 12), LightBg = Color3.fromRGB(235, 255, 235) },
	}
}

--// [استدعاء خدمات روبلوكس الأساسية]
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer
if CoreGui:FindFirstChild("VortexPrestigeUI") then CoreGui:FindFirstChild("VortexPrestigeUI"):Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "VortexPrestigeUI"
ScreenGui.ResetOnSpawn = false

--//==================================================================--
--  [10) نظام إدارة الدوال المنظم - API MANAGER]
--//==================================================================--
function Vortex.API:Register(Name, Func, Args, Desc)
	if self.Registry[Name] then return end
	self.Registry[Name] = Func
	-- تسجيلها تلقائياً داخل نظام مولد الشروحات (Documentation Generator)
	Vortex.Docs.Database[Name] = {
		Arguments = Args or "None",
		Description = Desc or "No description provided."
	}
end

--//==================================================================--
--  [نظام التحكم بالصوتيات الشامل - SOUND MANAGER]
--//==================================================================--
function Vortex.Sound:SetVolume(Vol)
	self.Volume = Vol
	for _, Snd in pairs(self.Cache) do if Snd then Snd.Volume = Vol end end
end
local function InitSound(Name, Id)
	local Snd = Instance.new("Sound", SoundService); Snd.Name = Name; Snd.SoundId = "rbxassetid://"..tostring(Id); Snd.Volume = Vortex.Sound.Volume; Vortex.Sound.Cache[Name] = Snd
end
InitSound("Click", 9118828562); InitSound("Hover", 9114223167); InitSound("Notify", 9114227447); InitSound("Open", 9114221327); InitSound("Close", 9114221153)
local function PlaySound(Type) local Snd = Vortex.Sound.Cache[Type] if Snd then Snd.TimePosition = 0; Snd:Play() end end
function Vortex:KeyClick() PlaySound("Click") end

--//==================================================================--
--  [تطوير محرك الحركات المتقدم التراكمي - ANIMATION ENGINE]
--//==================================================================--
function Vortex.Animation:Open(Frame)
	Frame.Size = UDim2.fromScale(0, 0); Frame.BackgroundTransparency = 1; Frame.Visible = true; PlaySound("Open")
	TweenService:Create(Frame, TweenInfo.new(self.Speed, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(630, 430), BackgroundTransparency = 0}):Play()
end
function Vortex.Animation:Close(Frame, Callback)
	PlaySound("Close")
	local CloseTween = TweenService:Create(Frame, TweenInfo.new(self.Speed, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.fromScale(0, 0), BackgroundTransparency = 1})
	CloseTween:Play(); CloseTween.Completed:Connect(function() Frame.Visible = false; if Callback then Callback() end end)
end
function Vortex.Animation:PageChange(OldPage, NewPage)
	if OldPage then OldPage.Visible = false end; NewPage.Visible = true
end

--//==================================================================--
--  [محرك المؤثرات البصرية الفخمة المتقدمة - PREMIUM VFX ENGINE]
--//==================================================================--
function Vortex.Effects:BorderShine(Object)
	local Stroke = Object:FindFirstChildOfClass("UIStroke") or Instance.new("UIStroke", Object); Stroke.Thickness = 2
	local Gradient = Instance.new("UIGradient", Stroke)
	Gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)), ColorSequenceKeypoint.new(0.5, Vortex.Theme.ThemesList[Vortex.Theme.ActiveTheme].Primary), ColorSequenceKeypoint.new(1, Color3.fromRGB(255,255,255))})
	task.spawn(function() while task.wait(0.02) and Gradient.Parent do Gradient.Rotation = (Gradient.Rotation + 4) % 360 end end)
end

function Vortex.Effects:EnergyWave(Object)
	local Wave = Instance.new("Frame", Object); Wave.Size = UDim2.new(2, 0, 2, 0); Wave.Position = UDim2.new(-0.5, 0, -0.5, 0); Wave.BackgroundTransparency = 0.95; Wave.ZIndex = 0
	local Gradient = Instance.new("UIGradient", Wave); Gradient.Color = ColorSequence.new(Vortex.Theme.ThemesList[Vortex.Theme.ActiveTheme].Primary, Color3.fromRGB(0,0,0))
	task.spawn(function() local t = 0 while task.wait(1/30) and Wave.Parent do t = t + 0.05; Gradient.Rotation = (math.sin(t) * 45) + 180; Wave.Position = UDim2.new(-0.5 + math.sin(t)*0.05, 0, -0.5 + math.cos(t)*0.05, 0) end end)
end

function Vortex.Effects:Pulse(Object)
	task.spawn(function() while task.wait(0.1) and Object.Parent do local Stroke = Object:FindFirstChildOfClass("UIStroke") if Stroke then TweenService:Create(Stroke, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Thickness = 1.5 + math.sin(tick()*5)*0.8}):Play() end end end)
end

function Vortex.Effects:Ripple(Button)
	Button.ClipsDescendants = true
	Button.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			PlaySound("Click")
			local Circle = Instance.new("Frame", Button); Circle.BackgroundColor3 = Color3.new(1, 1, 1); Circle.BackgroundTransparency = 0.7; Circle.ZIndex = Button.ZIndex + 1; Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)
			local NewX = input.Position.X - Button.AbsolutePosition.X; local NewY = input.Position.Y - Button.AbsolutePosition.Y; Circle.Position = UDim2.fromOffset(NewX, NewY)
			local Size = Button.AbsoluteSize.X > Button.AbsoluteSize.Y and Button.AbsoluteSize.X * 2 or Button.AbsoluteSize.Y * 2
			local Tween = TweenService:Create(Circle, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(Size, Size), Position = UDim2.fromOffset(NewX - Size/2, NewY - Size/2), BackgroundTransparency = 1})
			Tween:Play(); Tween.Completed:Connect(function() Circle:Destroy() end)
		end
	end)
end

function Vortex.Theme:Rainbow(Object)
	task.spawn(function() while task.wait(1/30) and Object.Parent do local currentTheme = Vortex.Theme.ThemesList[Vortex.Theme.ActiveTheme] if currentTheme then if Object:IsA("UIStroke") then Object.Color = currentTheme.Primary else Object.BackgroundColor3 = currentTheme.Primary end end end end)
end

--//==================================================================--
--  [شاشة الترحيب الـ 3D ونظام التحقق من المفاتيح]
--//==================================================================--
local SplashFrame = Instance.new("Frame", ScreenGui); SplashFrame.Size = UDim2.fromScale(1, 1); SplashFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 14); SplashFrame.ZIndex = 999999
local ClockLabel = Instance.new("TextLabel", SplashFrame); ClockLabel.Size = UDim2.fromOffset(200, 30); ClockLabel.Position = UDim2.new(0.5, -100, 0, 40); ClockLabel.BackgroundTransparency = 1; ClockLabel.Font = Enum.Font.Code; ClockLabel.TextSize = 18; ClockLabel.TextColor3 = Color3.fromRGB(140, 140, 160)
task.spawn(function() while task.wait(1) and ClockLabel.Parent do ClockLabel.Text = os.date("%X") end end)

local LogoFrame = Instance.new("Frame", SplashFrame); LogoFrame.Size = UDim2.fromOffset(80, 80); LogoFrame.Position = UDim2.new(0.5, -40, 0.4, -40); LogoFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 24); Instance.new("UICorner", LogoFrame).CornerRadius = UDim.new(1, 0); local LogoStroke = Instance.new("UIStroke", LogoFrame); LogoStroke.Color = Color3.fromRGB(0, 140, 255); LogoStroke.Thickness = 2
local LogoLabel = Instance.new("TextLabel", LogoFrame); LogoLabel.Size = UDim2.fromScale(1, 1); LogoLabel.BackgroundTransparency = 1; LogoLabel.Text = "V"; LogoLabel.Font = Enum.Font.GothamBold; LogoLabel.TextSize = 38; LogoLabel.TextColor3 = Color3.new(1,1,1)
task.spawn(function() while task.wait(0.02) and LogoFrame.Parent do LogoFrame.Rotation = (LogoFrame.Rotation + 3) % 360 end end)

local ProgressCircleBg = Instance.new("Frame", SplashFrame); ProgressCircleBg.Size = UDim2.fromOffset(120, 6); ProgressCircleBg.Position = UDim2.new(0.5, -60, 0.6, 20); ProgressCircleBg.BackgroundColor3 = Color3.fromRGB(24, 24, 32); Instance.new("UICorner", ProgressCircleBg)
local ProgressCircle = Instance.new("Frame", ProgressCircleBg); ProgressCircle.Size = UDim2.fromScale(0, 1); ProgressCircle.BackgroundColor3 = Color3.fromRGB(0, 140, 255); Instance.new("UICorner", ProgressCircle)

local KeyInput = Instance.new("TextBox", SplashFrame); KeyInput.Size = UDim2.fromOffset(240, 36); KeyInput.Position = UDim2.new(0.5, -120, 0.7, 10); KeyInput.BackgroundColor3 = Color3.fromRGB(18, 18, 26); KeyInput.PlaceholderText = "Enter Key / أدخل المفتاح"; KeyInput.Text = ""; KeyInput.Font = Enum.Font.Gotham; KeyInput.TextColor3 = Color3.new(1,1,1); KeyInput.TextSize = 12; Instance.new("UICorner", KeyInput).CornerRadius = UDim.new(0, 6); local Kis = Instance.new("UIStroke", KeyInput); Kis.Color = Color3.fromRGB(40, 40, 50)
local VerifyBtn = Instance.new("TextButton", SplashFrame); VerifyBtn.Size = UDim2.fromOffset(120, 32); VerifyBtn.Position = UDim2.new(0.5, -60, 0.8, 15); VerifyBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 255); VerifyBtn.Text = "Verify / تحقق"; VerifyBtn.Font = Enum.Font.GothamBold; VerifyBtn.TextColor3 = Color3.new(1,1,1); VerifyBtn.TextSize = 12; Instance.new("UICorner", VerifyBtn).CornerRadius = UDim.new(0, 6)

--//==================================================================--
--  [إنشاء نافذة القائمة الرئيسية التراكمية المطورة بالكامل]
--//==================================================================--
local MainFrame = Instance.new("Frame", ScreenGui); MainFrame.Size = UDim2.new(0, 630, 0, 430); MainFrame.Position = UDim2.new(0.5, -315, 0.5, -215); MainFrame.BackgroundColor3 = Color3.fromRGB(11, 11, 16); MainFrame.Active = true; MainFrame.Visible = false
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14)
Vortex.Effects:BorderShine(MainFrame); Vortex.Effects:EnergyWave(MainFrame)

local TopBar = Instance.new("Frame", MainFrame); TopBar.Size = UDim2.new(1, 0, 0, 45); TopBar.BackgroundTransparency = 1
local HeaderTitle = Instance.new("TextLabel", TopBar); HeaderTitle.Size = UDim2.new(1, -180, 1, 0); HeaderTitle.Position = UDim2.new(0, 18, 0, 0); HeaderTitle.BackgroundTransparency = 1; HeaderTitle.Text = Vortex.Name; HeaderTitle.Font = Enum.Font.GothamBold; HeaderTitle.TextSize = 15; HeaderTitle.TextColor3 = Color3.new(1, 1, 1); HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton", TopBar); CloseBtn.Size = UDim2.fromOffset(24, 24); CloseBtn.Position = UDim2.new(1, -38, 0.5, -12); CloseBtn.BackgroundColor3 = Color3.fromRGB(30, 15, 20); CloseBtn.Text = "✕"; CloseBtn.TextColor3 = Color3.fromRGB(255, 70, 70); CloseBtn.Font = Enum.Font.GothamBold; CloseBtn.TextSize = 12; Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)
local MinimizeBtn = Instance.new("TextButton", TopBar); MinimizeBtn.Size = UDim2.fromOffset(24, 24); MinimizeBtn.Position = UDim2.new(1, -68, 0.5, -12); MinimizeBtn.BackgroundColor3 = Color3.fromRGB(15, 22, 35); MinimizeBtn.Text = "—"; MinimizeBtn.TextColor3 = Color3.fromRGB(0, 180, 255); MinimizeBtn.Font = Enum.Font.GothamBold; MinimizeBtn.TextSize = 10; Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(1, 0)

-- دعم السحب باللمس على شاشات الموبايل
local dragToggle, dragStart, startPos
MainFrame.InputBegan:Connect(function(input) if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and input.Position.Y - MainFrame.AbsolutePosition.Y <= 45 then dragToggle = true; dragStart = input.Position; startPos = MainFrame.Position end end)
UIS.InputChanged:Connect(function(input) if dragToggle and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then local delta = input.Position - dragStart; MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) end end)
UIS.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragToggle = false end end)

local TabScroller = Instance.new("ScrollingFrame", MainFrame); TabScroller.Size = UDim2.new(1, -36, 0, 36); TabScroller.Position = UDim2.new(0, 18, 0, 50); TabScroller.BackgroundTransparency = 1; TabScroller.ScrollBarThickness = 0
local TabListLayout = Instance.new("UIListLayout", TabScroller); TabListLayout.FillDirection = Enum.FillDirection.Horizontal; TabListLayout.Padding = UDim.new(0, 8)
local PageContainer = Instance.new("Frame", MainFrame); PageContainer.Position = UDim2.new(0, 18, 0, 98); PageContainer.Size = UDim2.new(1, -36, 1, -116); PageContainer.BackgroundTransparency = 1

local WindowMethods = {TabCount = 0, ActivePage = nil, ActiveTabButton = nil}
function WindowMethods:CreateTab(TabName)
	self.TabCount = self.TabCount + 1; local PageScroll = Instance.new("ScrollingFrame", PageContainer); PageScroll.Size = UDim2.fromScale(1, 1); PageScroll.BackgroundTransparency = 1; PageScroll.Visible = false; PageScroll.ScrollBarThickness = 2
	local PageLayout = Instance.new("UIListLayout", PageScroll); PageLayout.Padding = UDim.new(0, 8); PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() PageScroll.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 15) end)
	local TabBtn = Instance.new("TextButton", TabScroller); TabBtn.Size = UDim2.new(0, 120, 1, 0); TabBtn.Text = TabName; TabBtn.Font = Enum.Font.GothamBold; TabBtn.TextSize = 11; TabBtn.TextColor3 = Color3.fromRGB(140, 145, 160); TabBtn.BackgroundColor3 = Color3.fromRGB(16, 17, 24); Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 7); local TabStroke = Instance.new("UIStroke", TabBtn); TabStroke.Color = Color3.fromRGB(35, 35, 50)
	
	TabBtn.MouseButton1Click:Connect(function() 
		Vortex:KeyClick()
		if WindowMethods.ActivePage then Vortex.Animation:PageChange(WindowMethods.ActivePage, PageScroll) end
		if WindowMethods.ActiveTabButton then WindowMethods.ActiveTabButton.TextColor3 = Color3.fromRGB(140, 145, 160) end
		WindowMethods.ActivePage = PageScroll; WindowMethods.ActiveTabButton = TabBtn; TabBtn.TextColor3 = Vortex.Theme.ThemesList[Vortex.Theme.ActiveTheme].Primary
	end)
	if self.TabCount == 1 then PageScroll.Visible = true; WindowMethods.ActivePage = PageScroll; WindowMethods.ActiveTabButton = TabBtn end
	return PageScroll
end

--//==================================================================--
--  [1) نظام الـ COMPONENTS الجاهزة الذكي للمطور - COMPONENT ENGINE]
--//==================================================================--
function Vortex.Component:CreateButton(Parent, Text, Callback)
	local Btn = Instance.new("TextButton", Parent); Btn.Size = UDim2.new(1, -6, 0, 40); Btn.BackgroundColor3 = Color3.fromRGB(18, 19, 28); Btn.Text = "   " .. Text; Btn.Font = Enum.Font.GothamMedium; Btn.TextColor3 = Color3.new(1, 1, 1); Btn.TextSize = 13; Btn.TextXAlignment = Enum.TextXAlignment.Left; Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8); Instance.new("UIStroke", Btn).Color = Color3.fromRGB(45, 45, 60)
	Vortex.Effects:Ripple(Btn); Vortex.Effects:Pulse(Btn)
	Btn.MouseButton1Click:Connect(function() if Callback then Callback() end end)
	return Btn
end

function Vortex.Component:CreateToggle(Parent, Text, Default, Callback)
	local ToggleFrame = Instance.new("Frame", Parent); ToggleFrame.Size = UDim2.new(1, -6, 0, 40); ToggleFrame.BackgroundColor3 = Color3.fromRGB(18, 19, 28); Instance.new("UICorner", ToggleFrame).CornerRadius = UDim.new(0, 8); local Ts = Instance.new("UIStroke", ToggleFrame); Ts.Color = Color3.fromRGB(45, 45, 60)
	local Txt = Instance.new("TextLabel", ToggleFrame); Txt.Size = UDim2.new(1, -60, 1, 0); Txt.Position = UDim2.new(0, 14, 0, 0); Txt.BackgroundTransparency = 1; Txt.Text = Text; Txt.Font = Enum.Font.GothamMedium; Txt.TextColor3 = Color3.new(1,1,1); Txt.TextSize = 13; Txt.TextXAlignment = Enum.TextXAlignment.Left
	local Switch = Instance.new("TextButton", ToggleFrame); Switch.Size = UDim2.fromOffset(36, 20); Switch.Position = UDim2.new(1, -50, 0.5, -10); Switch.BackgroundColor3 = Default and Color3.fromRGB(0, 140, 255) or Color3.fromRGB(40, 40, 50); Switch.Text = ""; Instance.new("UICorner", Switch).CornerRadius = UDim.new(1, 0)
	local State = Default
	Switch.MouseButton1Click:Connect(function()
		State = not State; Switch.BackgroundColor3 = State and Color3.fromRGB(0, 140, 255) or Color3.fromRGB(40, 40, 50)
		Vortex:KeyClick(); if Callback then Callback(State) end
	end)
	return ToggleFrame
end

function Vortex.Component:CreateCard(Parent, Title, Desc)
	local Card = Instance.new("Frame", Parent); Card.Size = UDim2.new(1, -6, 0, 60); Card.BackgroundColor3 = Color3.fromRGB(14, 15, 22); Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 8); local Cs = Instance.new("UIStroke", Card); Cs.Color = Color3.fromRGB(35, 35, 45)
	local Tl = Instance.new("TextLabel", Card); Tl.Size = UDim2.new(1, -20, 0, 25); Tl.Position = UDim2.new(0, 12, 0, 6); Tl.BackgroundTransparency = 1; Tl.Text = Title; Tl.Font = Enum.Font.GothamBold; Tl.TextColor3 = Color3.fromRGB(0, 140, 255); Tl.TextSize = 13; Tl.TextXAlignment = Enum.TextXAlignment.Left
	local Ds = Instance.new("TextLabel", Card); Ds.Size = UDim2.new(1, -20, 0, 25); Ds.Position = UDim2.new(0, 12, 0, 26); Ds.BackgroundTransparency = 1; Ds.Text = Desc; Ds.Font = Enum.Font.Gotham; Ds.TextColor3 = Color3.fromRGB(150, 150, 160); Ds.TextSize = 11; Ds.TextXAlignment = Enum.TextXAlignment.Left
	return Card
end

--//==================================================================--
--  [15) محرك توليد قوالب الأكواد الجاهزة - CODE TEMPLATES]
--//==================================================================--
function Vortex:Create(TemplateType)
	if TemplateType == "Button" then
		return [[Vortex.Component:CreateButton(Parent, "Click Me", function() print("Button Clicked!") end)]]
	elseif TemplateType == "Toggle" then
		return [[Vortex.Component:CreateToggle(Parent, "Toggle Option", false, function(State) print("Toggle State:", State) end)]]
	elseif TemplateType == "Card" then
		return [[Vortex.Component:CreateCard(Parent, "Card Title", "Card Description text goes here.")]]
	end
	return "-- Template not found"
end

--//==================================================================--
--  [11) نظام حقن وشحن الإضافات الخارجية للمطورين - PLUGIN SDK]
--//==================================================================--
function Vortex.Plugin:Load(PluginData)
	if not PluginData or not PluginData.Name then return end
	table.insert(self.PluginsList, PluginData)
	local PlugTab = WindowMethods:CreateTab("🔌 " .. PluginData.Name)
	Vortex.Component:CreateCard(PlugTab, PluginData.Name .. " v" .. (PluginData.Version or "1.0"), "Plugin loaded successfully into SDK.")
	if PluginData.Init then PluginData.Init(PlugTab) end
end

--//==================================================================--
--  [تسجيل الدوال الرسمية وتفعيل مولد الشروحات تلقائياً]
--//==================================================================--
Vortex.API:Register("CreateButton", Vortex.Component.CreateButton, "Parent, Text, Callback", "Creates an elite button with ripple and pulse effect.")
Vortex.API:Register("CreateToggle", Vortex.Component.CreateToggle, "Parent, Text, Default, Callback", "Creates an advanced modern toggle switch.")
Vortex.API:Register("CreateCard", Vortex.Component.CreateCard, "Parent, Title, Desc", "Creates a clean informational presentation card.")

--//==================================================================--
--  [بناء الصفحات والتبويبات الرئسية وعرض الأدوات الجديدة]
--//==================================================================--
local DevToolsTab = WindowMethods:CreateTab("Developer Kits")

-- 5) نافذة شروحات ومستندات الدوال التفاعلية (Documentation Generator)
Vortex.Component:CreateButton(DevToolsTab, "📜 Generate System Docs", function()
	local DocsWindow = WindowMethods:CreateTab("📜 System API Docs")
	for Name, Data in pairs(Vortex.Docs.Database) do
		Vortex.Component:CreateCard(DocsWindow, "D和服务: Vortex.API: " .. Name, "Arguments: (" .. Data.Arguments .. ")\nDescription: " .. Data.Description)
	end
end)

-- 15) توليد قوالب الأكواد (Code Templates Output Showcase)
local CodeOutputCard = Vortex.Component:CreateCard(DevToolsTab, "Code Output Terminal", "Click a template below to view generated script.")
Vortex.Component:CreateButton(DevToolsTab, "🧠 Generate Button Template", function()
	local code = Vortex:Create("Button")
	CodeOutputCard:FindFirstChildOfClass("TextLabel").Text = "Generated!"
	print("[VORTEX CODES]:\n" .. code)
end)

-- 9) المحرر البصري التفاعلي المتكامل للمطور (Visual Editor Showcase)
local VisualTab = WindowMethods:CreateTab("🎨 Visual Editor")
local SampleObject = Instance.new("Frame", VisualTab); SampleObject.Size = UDim2.fromOffset(140, 40); SampleObject.BackgroundColor3 = Color3.fromRGB(0, 140, 255); Instance.new("UICorner", SampleObject)
local VisualCodeOutput = Vortex.Component:CreateCard(VisualTab, "Live Generated Layout Code", "Change attributes to generate script.")

Vortex.Component:CreateButton(VisualTab, "🎨 Shift Color to Purple", function()
	SampleObject.BackgroundColor3 = Color3.fromRGB(180, 0, 255)
	VisualCodeOutput:FindFirstChildOfClass("TextLabel").Text = "Code: Object.BackgroundColor3 = Color3.fromRGB(180, 0, 255)"
end)
Vortex.Component:CreateButton(VisualTab, "📐 Expand Component Size", function()
	SampleObject.Size = UDim2.fromOffset(200, 45)
	VisualCodeOutput:FindFirstChildOfClass("TextLabel").Text = "Code: Object.Size = UDim2.fromOffset(200, 45)"
end)

--//==================================================================--
--  [تأكيد تفعيل نظام المفاتيح وبدء تشغيل شاشة الترحيب السريعة]
--//==================================================================--
VerifyBtn.MouseButton1Click:Connect(function()
	if KeyInput.Text == Vortex.Security.UserKey then
		KeyInput.Visible = false; VerifyBtn.Visible = false
		local Tw = TweenService:Create(ProgressCircle, TweenInfo.new(1, Enum.EasingStyle.Linear), {Size = UDim2.fromScale(1, 1)}); Tw:Play()
		Tw.Completed:Connect(function()
			TweenService:Create(SplashFrame, TweenInfo.new(0.4), {Position = UDim2.fromScale(0, -1)}):Play()
			task.wait(0.4); SplashFrame:Destroy(); MainFrame.Visible = true; Vortex.Animation:Open(MainFrame)
		end)
	end
end)

local FloatingBtn = Instance.new("TextButton", ScreenGui); FloatingBtn.Size = UDim2.fromOffset(46, 46); FloatingBtn.Position = UDim2.new(0.05, 0, 0.2, 0); FloatingBtn.BackgroundColor3 = Color3.fromRGB(11, 11, 18); FloatingBtn.Text = "V"; FloatingBtn.Font = Enum.Font.GothamBold; FloatingBtn.TextColor3 = Color3.fromRGB(0, 150, 255); FloatingBtn.TextSize = 20; FloatingBtn.Visible = false; FloatingBtn.ZIndex = 1000000; local FloatStroke = Instance.new("UIStroke", FloatingBtn); FloatStroke.Thickness = 2; Vortex.Theme:Rainbow(FloatStroke)
FloatingBtn.MouseButton1Click:Connect(function() FloatingBtn.Visible = false; Vortex.Animation:Open(MainFrame) end)
MinimizeBtn.MouseButton1Click:Connect(function() Vortex.Animation:Close(MainFrame, function() FloatingBtn.Visible = true end) end)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

return Vortex
