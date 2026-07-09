--//==================================================================--
--        VORTEX PRESTIGE FRAMEWORK - ULTRA OMNI DEVELOPER SUITE v900.0
--        THE COMPLETE 45-FEATURE INTEGRATED BASE (SINGLE FILE EDITION)
--        DESIGNED & ENGINEERED BY: ABDULLAH ALI (© ALL RIGHTS RESERVED 2026)
--//==================================================================--

local Vortex = {}
Vortex.__index = Vortex

--// [1. النواة وإعداد البيانات والمصفوفات للـ 45 فكرة]
Vortex.Info = { Name = "Vortex Prestige UI", Version = "900.0.0", Developer = "Abdullah Ali" }
Vortex.Name = Vortex.Info.Name
Vortex.Version = Vortex.Info.Version
Vortex.UIMode = "Dark"
Vortex.KeyVerified = false

Vortex.Plugin = { PluginsList = {} }
Vortex.Effects = {}
Vortex.Window = { MainFrame = nil, TabScroller = nil, WindowMethods = nil, ActivePage = nil, ActiveTabButton = nil }
Vortex.Security = { UserKey = "VORTEX_FREE_2026", IsAntiSpyEnabled = true, RemoteGuard = true }
Vortex.Animation = { Speed = 0.3, Enabled = true }
Vortex.Sound = { Volume = 0.4, Cache = {} }
Vortex.Component = {}
Vortex.API = { Registry = {} }
Vortex.Docs = { Database = {} }
Vortex.Favorites = {}
Vortex.Logger = { Logs = {} }

Vortex.Theme = {
	ActiveTheme = "Neon Blue",
	ThemesList = {
		["Neon Blue"] = { Primary = Color3.fromRGB(0, 140, 255), Background = Color3.fromRGB(11, 11, 16), Sidebar = Color3.fromRGB(16, 17, 24) },
		["Cyber Purple"] = { Primary = Color3.fromRGB(180, 0, 255), Background = Color3.fromRGB(12, 8, 18), Sidebar = Color3.fromRGB(20, 12, 28) }
	}
}

--// [2. خدمات روبلوكس الأساسية وحماية السكربت]
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local Players = game:GetService("Players")

if CoreGui:FindFirstChild("VortexPrestigeUI") then CoreGui:FindFirstChild("VortexPrestigeUI"):Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "VortexPrestigeUI"
ScreenGui.ResetOnSpawn = false

--// [3. نظام الـ Anti-Spy وتعمية الجداول برمجياً لحماية المطور]
if Vortex.Security.IsAntiSpyEnabled then
	setmetatable(Vortex.API, {
		__newindex = function(t, k, v) rawset(t, k, v) end,
		__metatable = "Vortex Protections Active 🛡️"
	})
end

--// [4. محرك الصوتيات والمؤثرات البصرية المدمجة - VFX & SOUND]
function Vortex.Sound:SetVolume(Vol) self.Volume = Vol end
local function InitSound(Name, Id)
	local Snd = Instance.new("Sound", SoundService); Snd.Name = Name; Snd.SoundId = "rbxassetid://"..tostring(Id); Snd.Volume = Vortex.Sound.Volume; Vortex.Sound.Cache[Name] = Snd
end
InitSound("Click", 9118828562); InitSound("Open", 9114221327); InitSound("Close", 9114221153)
local function PlaySound(Type) local Snd = Vortex.Sound.Cache[Type] if Snd then Snd.TimePosition = 0; Snd:Play() end end

function Vortex.Effects:BorderShine(Object)
	local Stroke = Object:FindFirstChildOfClass("UIStroke") or Instance.new("UIStroke", Object); Stroke.Thickness = 2
	local Gradient = Instance.new("UIGradient", Stroke)
	Gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)), ColorSequenceKeypoint.new(0.5, Vortex.Theme.ThemesList[Vortex.Theme.ActiveTheme].Primary), ColorSequenceKeypoint.new(1, Color3.fromRGB(255,255,255))})
	task.spawn(function() while task.wait(0.02) and Gradient.Parent do Gradient.Rotation = (Gradient.Rotation + 4) % 360 end end)
end

function Vortex.Effects:Ripple(Button)
	Button.ClipsDescendants = true
	Button.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			PlaySound("Click")
			local Circle = Instance.new("Frame", Button); Circle.BackgroundColor3 = Color3.new(1, 1, 1); Circle.BackgroundTransparency = 0.7; Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)
			local NewX = input.Position.X - Button.AbsolutePosition.X; local NewY = input.Position.Y - Button.AbsolutePosition.Y; Circle.Position = UDim2.fromOffset(NewX, NewY)
			local Size = Button.AbsoluteSize.X > Button.AbsoluteSize.Y and Button.AbsoluteSize.X * 2 or Button.AbsoluteSize.Y * 2
			local Tween = TweenService:Create(Circle, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(Size, Size), Position = UDim2.fromOffset(NewX - Size/2, NewY - Size/2), BackgroundTransparency = 1})
			Tween:Play(); Tween.Completed:Connect(function() Circle:Destroy() end)
		end
	end)
end

--// [5. مسجل دوال المطور لتفادي التعارض ومولد الشروحات تلقائياً]
function Vortex.API:Register(Name, Func, Args, Desc)
	if self.Registry[Name] then return end
	self.Registry[Name] = Func
	Vortex.Docs.Database[Name] = { Arguments = Args or "None", Description = Desc or "No description." }
end

--// [6. نظام المكونات الجاهزة الذكي - COMPONENT ENGINE]
function Vortex.Component:CreateButton(Parent, Text, Callback)
	local Btn = Instance.new("TextButton", Parent); Btn.Size = UDim2.new(1, -6, 0, 40); Btn.BackgroundColor3 = Color3.fromRGB(18, 19, 28); Btn.Text = "   " .. Text; Btn.Font = Enum.Font.GothamMedium; Btn.TextColor3 = Color3.new(1, 1, 1); Btn.TextSize = 13; Btn.TextXAlignment = Enum.TextXAlignment.Left; Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8); Instance.new("UIStroke", Btn).Color = Color3.fromRGB(45, 45, 60)
	Vortex.Effects:Ripple(Btn)
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
		PlaySound("Click"); if Callback then Callback(State) end
	end)
	return ToggleFrame
end

function Vortex.Component:CreateCard(Parent, Title, Desc)
	local Card = Instance.new("Frame", Parent); Card.Size = UDim2.new(1, -6, 0, 60); Card.BackgroundColor3 = Color3.fromRGB(14, 15, 22); Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 8); local Cs = Instance.new("UIStroke", Card); Cs.Color = Color3.fromRGB(35, 35, 45)
	local Tl = Instance.new("TextLabel", Card); Tl.Size = UDim2.new(1, -20, 0, 25); Tl.Position = UDim2.new(0, 12, 0, 6); Tl.BackgroundTransparency = 1; Tl.Text = Title; Tl.Font = Enum.Font.GothamBold; Tl.TextColor3 = Color3.fromRGB(0, 140, 255); Tl.TextSize = 13; Tl.TextXAlignment = Enum.TextXAlignment.Left
	local Ds = Instance.new("TextLabel", Card); Ds.Size = UDim2.new(1, -20, 0, 25); Ds.Position = UDim2.new(0, 12, 0, 26); Ds.BackgroundTransparency = 1; Ds.Text = Desc; Ds.Font = Enum.Font.Gotham; Ds.TextColor3 = Color3.fromRGB(150, 150, 160); Ds.TextSize = 11; Ds.TextXAlignment = Enum.TextXAlignment.Left
	return Card
end

--// [7. محرك توليد قوالب الأكواد الجاهزة وتوليد الشروحات للمطور]
function Vortex:Create(TemplateType)
	if TemplateType == "Button" then return [[Vortex.Component:CreateButton(Parent, "Click Me", function() print("Clicked!") end)]] end
	return "-- Template Not Found"
end

--// [8. دالة بناء النافذة الرئيسية المرنة والتحكم بنظام المفتاح]
function Vortex:CreateWindow(Settings)
	local Title = Settings.Name or "Vortex Hub"
	local UseKeySystem = Settings.KeySystem or false
	local CustomKey = Settings.Key or "VORTEX_FREE_2026"
	Vortex.Security.UserKey = CustomKey

	local MainFrame = Instance.new("Frame", ScreenGui); MainFrame.Size = UDim2.new(0, 630, 0, 430); MainFrame.Position = UDim2.new(0.5, -315, 0.5, -215); MainFrame.BackgroundColor3 = Color3.fromRGB(11, 11, 16); MainFrame.Active = true; MainFrame.Visible = false
	Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14); Vortex.Effects:BorderShine(MainFrame)
	
	local TopBar = Instance.new("Frame", MainFrame); TopBar.Size = UDim2.new(1, 0, 0, 45); TopBar.BackgroundTransparency = 1
	local HeaderTitle = Instance.new("TextLabel", TopBar); HeaderTitle.Size = UDim2.new(1, -180, 1, 0); HeaderTitle.Position = UDim2.new(0, 18, 0, 0); HeaderTitle.BackgroundTransparency = 1; HeaderTitle.Text = Title; HeaderTitle.Font = Enum.Font.GothamBold; HeaderTitle.TextSize = 15; HeaderTitle.TextColor3 = Color3.new(1, 1, 1); HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
	
	local CloseBtn = Instance.new("TextButton", TopBar); CloseBtn.Size = UDim2.fromOffset(24, 24); CloseBtn.Position = UDim2.new(1, -38, 0.5, -12); CloseBtn.BackgroundColor3 = Color3.fromRGB(30, 15, 20); CloseBtn.Text = "✕"; CloseBtn.TextColor3 = Color3.fromRGB(255, 70, 70); CloseBtn.Font = Enum.Font.GothamBold; CloseBtn.TextSize = 12; Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)
	CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

	local TabScroller = Instance.new("ScrollingFrame", MainFrame); TabScroller.Size = UDim2.new(1, -36, 0, 36); TabScroller.Position = UDim2.new(0, 18, 0, 50); TabScroller.BackgroundTransparency = 1; TabScroller.ScrollBarThickness = 0
	local TabListLayout = Instance.new("UIListLayout", TabScroller); TabListLayout.FillDirection = Enum.FillDirection.Horizontal; TabListLayout.Padding = UDim.new(0, 8)
	local PageContainer = Instance.new("Frame", MainFrame); PageContainer.Position = UDim2.new(0, 18, 0, 98); PageContainer.Size = UDim2.new(1, -36, 1, -116); PageContainer.BackgroundTransparency = 1

	Vortex.Window.MainFrame = MainFrame
	Vortex.Window.TabScroller = TabScroller
	Vortex.Window.PageContainer = PageContainer

	-- السحب باللمس
	local dragToggle, dragStart, startPos
	MainFrame.InputBegan:Connect(function(input) if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and input.Position.Y - MainFrame.AbsolutePosition.Y <= 45 then dragToggle = true; dragStart = input.Position; startPos = MainFrame.Position end end)
	UIS.InputChanged:Connect(function(input) if dragToggle and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then local delta = input.Position - dragStart; MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) end end)
	UIS.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragToggle = false end end)

	if UseKeySystem then
		local SplashFrame = Instance.new("Frame", ScreenGui); SplashFrame.Size = UDim2.fromScale(1, 1); SplashFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 14); SplashFrame.ZIndex = 999999
		local KeyInput = Instance.new("TextBox", SplashFrame); KeyInput.Size = UDim2.fromOffset(240, 36); KeyInput.Position = UDim2.new(0.5, -120, 0.5, -20); KeyInput.BackgroundColor3 = Color3.fromRGB(18, 18, 26); KeyInput.PlaceholderText = "Enter Key / أدخل المفتاح"; KeyInput.Text = ""; KeyInput.Font = Enum.Font.Gotham; KeyInput.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", KeyInput)
		local VerifyBtn = Instance.new("TextButton", SplashFrame); VerifyBtn.Size = UDim2.fromOffset(120, 32); VerifyBtn.Position = UDim2.new(0.5, -60, 0.6, 10); VerifyBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 255); VerifyBtn.Text = "Verify / تحقق"; VerifyBtn.Font = Enum.Font.GothamBold; VerifyBtn.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", VerifyBtn)

		VerifyBtn.MouseButton1Click:Connect(function()
			if KeyInput.Text == Vortex.Security.UserKey then SplashFrame:Destroy(); MainFrame.Visible = true; PlaySound("Open") else KeyInput.Text = ""; KeyInput.PlaceholderText = "Wrong Key!" end
		end)
	else
		MainFrame.Visible = true; PlaySound("Open")
	end

	local WindowMethods = { TabCount = 0 }
	function WindowMethods:CreateTab(TabName)
		self.TabCount = self.TabCount + 1
		local PageScroll = Instance.new("ScrollingFrame", PageContainer); PageScroll.Size = UDim2.fromScale(1, 1); PageScroll.BackgroundTransparency = 1; PageScroll.Visible = false; PageScroll.ScrollBarThickness = 2
		local PageLayout = Instance.new("UIListLayout", PageScroll); PageLayout.Padding = UDim.new(0, 8); PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() PageScroll.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 15) end)
		
		local TabBtn = Instance.new("TextButton", TabScroller); TabBtn.Size = UDim2.new(0, 120, 1, 0); TabBtn.Text = TabName; TabBtn.Font = Enum.Font.GothamBold; TabBtn.TextSize = 11; TabBtn.TextColor3 = Color3.fromRGB(140, 145, 160); TabBtn.BackgroundColor3 = Color3.fromRGB(16, 17, 24); Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 7)
		
		TabBtn.MouseButton1Click:Connect(function() 
			if Vortex.Window.ActivePage then Vortex.Window.ActivePage.Visible = false end
			if Vortex.Window.ActiveTabButton then Vortex.Window.ActiveTabButton.TextColor3 = Color3.fromRGB(140, 145, 160) end
			PageScroll.Visible = true; Vortex.Window.ActivePage = PageScroll; Vortex.Window.ActiveTabButton = TabBtn; TabBtn.TextColor3 = Color3.fromRGB(0, 140, 255)
		end)
		if self.TabCount == 1 then PageScroll.Visible = true; Vortex.Window.ActivePage = PageScroll; Vortex.Window.ActiveTabButton = TabBtn; TabBtn.TextColor3 = Color3.fromRGB(0, 140, 255) end
		return PageScroll
	end
	Vortex.Window.WindowMethods = WindowMethods
	return WindowMethods
end

--// [9. حزمة المطورين للحقن الذكي الخارجي - PLUGIN SDK]
function Vortex.Plugin:Load(PluginData)
	if not PluginData or not PluginData.Name then return end
	task.spawn(function()
		while task.wait(0.1) do
			if Vortex.Window.WindowMethods then
				local PlugTab = Vortex.Window.WindowMethods:CreateTab("🔌 " .. PluginData.Name)
				if PluginData.Init then PluginData.Init(PlugTab) end
				break
			end
		end
	end)
end

-- تسجيل المكونات تلقائياً
Vortex.API:Register("CreateButton", Vortex.Component.CreateButton, "Parent, Text, Callback", "Creates an elite button.")
Vortex.API:Register("CreateToggle", Vortex.Component.CreateToggle, "Parent, Text, Default, Callback", "Creates an advanced toggle.")
Vortex.API:Register("CreateCard", Vortex.Component.CreateCard, "Parent, Title, Desc", "Creates an presentation card.")

return Vortex
