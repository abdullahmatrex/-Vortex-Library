--//==================================================================--
--        VORTEX CLEAN UI - WEIGHTED BUTTON v15.8 (SMOOTH DRAG)
--        DEVELOPED BY: ABDULLAH MATREX (ALL RIGHTS RESERVED © 2026)
--//==================================================================--

local Vortex = {}
Vortex.__index = Vortex

local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")

Vortex.Language = "en"
local Localization = {
	ar = {
		loading = "جاري فحص وتحميل محرك فورتكس...",
		owner = "المطور الإجباري",
		name = "الاسم: عبدالله ماتريكس",
		user = "حساب روبلوكس: eonsali07807863909",
		close_confirm = "هل أنت متأكد من إغلاق القائمة؟",
		yes = "نعم", no = "لا",
		select_lang = "اختر لغة الواجهة / Select UI Language"
	},
	en = {
		loading = "Scanning & Loading Vortex Engine...",
		owner = "Forced Developer",
		name = "Name: Abdullah Matrex",
		user = "Roblox User: eonsali07807863909",
		close_confirm = "Are you sure you want to close?",
		yes = "Yes", no = "No",
		select_lang = "اختر لغة الواجهة / Select UI Language"
	}
}

if CoreGui:FindFirstChild("VortexCleanUI") then CoreGui:FindFirstChild("VortexCleanUI"):Destroy() end
if Lighting:FindFirstChild("VortexBlur") then Lighting:FindFirstChild("VortexBlur"):Destroy() end

local Gui = Instance.new("ScreenGui", CoreGui)
Gui.Name = "VortexCleanUI"
Gui.ResetOnSpawn = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Global

--// 1. شاشة اختيار اللغة
local LangFrame = Instance.new("Frame", Gui)
LangFrame.Size = UDim2.new(0, 340, 0, 180)
LangFrame.Position = UDim2.new(0.5, -170, 0.5, -90)
LangFrame.BackgroundColor3 = Color3.fromRGB(12, 13, 18)
LangFrame.ZIndex = 10
Instance.new("UICorner", LangFrame).CornerRadius = UDim.new(0, 12)
local LangStroke = Instance.new("UIStroke", LangFrame)
LangStroke.Color = Color3.fromRGB(0, 140, 255)
LangStroke.Thickness = 2

local LangTitle = Instance.new("TextLabel", LangFrame)
LangTitle.Size = UDim2.new(1, 0, 0, 50)
LangTitle.Text = Localization.en.select_lang
LangTitle.TextColor3 = Color3.new(1, 1, 1)
LangTitle.Font = Enum.Font.GothamBold
LangTitle.TextSize = 14
LangTitle.BackgroundTransparency = 1
LangTitle.ZIndex = 11

local ArBtn = Instance.new("TextButton", LangFrame)
ArBtn.Size = UDim2.new(0, 120, 0, 42)
ArBtn.Position = UDim2.new(0.12, 0, 0.55, 0)
ArBtn.Text = "العربية"
ArBtn.BackgroundColor3 = Color3.fromRGB(22, 24, 33)
ArBtn.TextColor3 = Color3.fromRGB(0, 140, 255)
ArBtn.Font = Enum.Font.GothamBold
ArBtn.TextSize = 14
ArBtn.ZIndex = 11
Instance.new("UICorner", ArBtn).CornerRadius = UDim.new(0, 8)
local ArStroke = Instance.new("UIStroke", ArBtn)
ArStroke.Color = Color3.fromRGB(40, 42, 55)

local EnBtn = Instance.new("TextButton", LangFrame)
EnBtn.Size = UDim2.new(0, 120, 0, 42)
EnBtn.Position = UDim2.new(0.53, 0, 0.55, 0)
EnBtn.Text = "English"
EnBtn.BackgroundColor3 = Color3.fromRGB(22, 24, 33)
EnBtn.TextColor3 = Color3.new(1, 1, 1)
EnBtn.Font = Enum.Font.GothamBold
EnBtn.TextSize = 14
EnBtn.ZIndex = 11
Instance.new("UICorner", EnBtn).CornerRadius = UDim.new(0, 8)
local EnStroke = Instance.new("UIStroke", EnBtn)
EnStroke.Color = Color3.fromRGB(40, 42, 55)

local SelectedLang = false
ArBtn.MouseButton1Click:Connect(function() Vortex.Language = "ar" SelectedLang = true end)
EnBtn.MouseButton1Click:Connect(function() Vortex.Language = "en" SelectedLang = true end)

while not SelectedLang do task.wait() end
LangFrame:Destroy()

--// 2. شاشة التحميل
local LoadingFrame = Instance.new("Frame", Gui)
LoadingFrame.Size = UDim2.new(0, 320, 0, 110)
LoadingFrame.Position = UDim2.new(0.5, -160, 0.5, -55)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(10, 11, 16)
LoadingFrame.ZIndex = 10
Instance.new("UICorner", LoadingFrame).CornerRadius = UDim.new(0, 12)
local LoadStroke = Instance.new("UIStroke", LoadingFrame)
LoadStroke.Color = Color3.fromRGB(0, 140, 255)
LoadStroke.Thickness = 1.5

local LoadingLabel = Instance.new("TextLabel", LoadingFrame)
LoadingLabel.Size = UDim2.new(1, 0, 1, 0)
LoadingLabel.Text = Localization[Vortex.Language].loading
LoadingLabel.TextColor3 = Color3.fromRGB(0, 140, 255)
LoadingLabel.Font = Enum.Font.GothamBold
LoadingLabel.TextSize = 14
LoadingLabel.BackgroundTransparency = 1
LoadingLabel.ZIndex = 11

task.wait(1.5)
LoadingFrame:Destroy()

local Blur = Instance.new("BlurEffect", Lighting)
Blur.Name = "VortexBlur"
Blur.Size = 0
TweenService:Create(Blur, TweenInfo.new(.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = 12}):Play()

--// 3. بناء هيكل الواجهة
function Vortex:CreateWindow(cfg)
	cfg = cfg or {}
	local Theme = cfg.Theme or Color3.fromRGB(0, 140, 255)

	-- الزر العائم V
	local OpenButton = Instance.new("TextButton", Gui)
	OpenButton.Size = UDim2.new(0, 50, 0, 50)
	OpenButton.Position = UDim2.new(0.03, 0, 0.45, 0)
	OpenButton.Text = "V"
	OpenButton.Font = Enum.Font.GothamBold
	OpenButton.TextSize = 22
	OpenButton.TextColor3 = Color3.new(1, 1, 1)
	OpenButton.BackgroundColor3 = Color3.fromRGB(14, 15, 23)
	OpenButton.ZIndex = 5
	Instance.new("UICorner", OpenButton).CornerRadius = UDim.new(1, 0)
	local BtnStroke = Instance.new("UIStroke", OpenButton)
	BtnStroke.Color = Theme
	BtnStroke.Thickness = 2

	-- 🔥 نظام سحب ثقيل متوسط ناعم (Weighted Smooth Dragging)
	local draggingBtn = false
	local dragInputBtn
	local dragStartBtn
	local startPosBtn

	local function updateBtn(input)
		local delta = input.Position - dragStartBtn
		local targetPos = UDim2.new(startPosBtn.X.Scale, startPosBtn.X.Offset + delta.X, startPosBtn.Y.Scale, startPosBtn.Y.Offset + delta.Y)
		
		-- تم استخدام ثقل متوسط (0.15 ثانية) لجعل الزر ثقيل ومريح أثناء السحب
		TweenService:Create(OpenButton, TweenInfo.new(0.15, Enum.EasingStyle.OutQuad), {Position = targetPos}):Play()
	end

	OpenButton.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			draggingBtn = true
			dragStartBtn = input.Position
			startPosBtn = OpenButton.Position
			
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					draggingBtn = false
				end
			end)
		end
	end)

	OpenButton.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInputBtn = input
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if input == dragInputBtn and draggingBtn then
			updateBtn(input)
		end
	end)

	-- القائمة الرئيسية وباقي الأكواد المستقرة
	local Main = Instance.new("Frame", Gui)
	Main.Size = UDim2.new(0, 540, 0, 360)
	Main.Position = UDim2.new(0.5, -270, 1.2, 0)
	Main.BackgroundColor3 = Color3.fromRGB(12, 13, 20)
	Main.BorderSizePixel = 0
	Main.Active = true
	Main.ZIndex = 2
	Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
	
	local MainStroke = Instance.new("UIStroke", Main)
	MainStroke.Color = Theme
	MainStroke.Thickness = 2
	MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

	-- سحب سريع وعادي للوحة التحكم الرئيسية
	local dragToggle, dragStart, startPos
	Main.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			if input.Position.Y - Main.AbsolutePosition.Y <= 45 then
				dragToggle = true
				dragStart = input.Position
				startPos = Main.Position
			end
		end
	end)
	UIS.InputChanged:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragToggle then
			local delta = input.Position - dragStart
			Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
	UIS.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragToggle = false end
	end)

	local Top = Instance.new("Frame", Main)
	Top.Size = UDim2.new(1, 0, 0, 45)
	Top.BackgroundTransparency = 1
	Top.ZIndex = 3

	local Title = Instance.new("TextLabel", Top)
	Title.Size = UDim2.new(1, -100, 1, 0)
	Title.Position = UDim2.new(0, 16, 0, 0)
	Title.BackgroundTransparency = 1
	Title.Text = cfg.Title or "VORTEX ENGINE"
	Title.Font = Enum.Font.GothamBold
	Title.TextSize = 14
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.ZIndex = 4

	local CloseUIBtn = Instance.new("TextButton", Top)
	CloseUIBtn.Size = UDim2.new(0, 26, 0, 26)
	CloseUIBtn.Position = UDim2.new(1, -36, 0, 10)
	CloseUIBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
	CloseUIBtn.Text = "×"
	CloseUIBtn.Font = Enum.Font.GothamMedium
	CloseUIBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	CloseUIBtn.TextSize = 20
	CloseUIBtn.ZIndex = 4
	Instance.new("UICorner", CloseUIBtn).CornerRadius = UDim.new(0, 6)
	local CloseStroke = Instance.new("UIStroke", CloseUIBtn)
	CloseStroke.Color = Color3.fromRGB(60, 60, 70)

	CloseUIBtn.MouseButton1Click:Connect(function()
		local ConfirmFrame = Instance.new("Frame", Gui)
		ConfirmFrame.Size = UDim2.new(0, 290, 0, 120)
		ConfirmFrame.Position = UDim2.new(0.5, -145, 0.5, -60)
		ConfirmFrame.BackgroundColor3 = Color3.fromRGB(14, 15, 22)
		ConfirmFrame.ZIndex = 20
		Instance.new("UICorner", ConfirmFrame).CornerRadius = UDim.new(0, 10)
		local ConfirmStroke = Instance.new("UIStroke", ConfirmFrame)
		ConfirmStroke.Color = Theme
		ConfirmStroke.Thickness = 1.5

		local TextLbl = Instance.new("TextLabel", ConfirmFrame)
		TextLbl.Size = UDim2.new(1, 0, 0, 50)
		TextLbl.Text = Localization[Vortex.Language].close_confirm
		TextLbl.TextColor3 = Color3.new(1, 1, 1)
		TextLbl.Font = Enum.Font.GothamMedium
		TextLbl.TextSize = 13
		TextLbl.BackgroundTransparency = 1
		TextLbl.ZIndex = 21

		local Yes = Instance.new("TextButton", ConfirmFrame)
		Yes.Size = UDim2.new(0, 100, 0, 34)
		Yes.Position = UDim2.new(0.12, 0, 0.55, 0)
		Yes.Text = Localization[Vortex.Language].yes
		Yes.BackgroundColor3 = Color3.fromRGB(210, 50, 50)
		Yes.TextColor3 = Color3.new(1, 1, 1)
		Yes.Font = Enum.Font.GothamBold
		Yes.ZIndex = 21
		Instance.new("UICorner", Yes).CornerRadius = UDim.new(0, 6)

		local No = Instance.new("TextButton", ConfirmFrame)
		No.Size = UDim2.new(0, 100, 0, 34)
		No.Position = UDim2.new(0.53, 0, 0.55, 0)
		No.Text = Localization[Vortex.Language].no
		No.BackgroundColor3 = Color3.fromRGB(35, 37, 50)
		No.TextColor3 = Color3.new(1, 1, 1)
		No.Font = Enum.Font.GothamBold
		No.ZIndex = 21
		Instance.new("UICorner", No).CornerRadius = UDim.new(0, 6)

		Yes.MouseButton1Click:Connect(function() Gui:Destroy() Blur:Destroy() end)
		No.MouseButton1Click:Connect(function() ConfirmFrame:Destroy() end)
	end)

	local TabBar = Instance.new("Frame", Main)
	TabBar.Size = UDim2.new(1, -32, 0, 36)
	TabBar.Position = UDim2.new(0, 16, 0, 50)
	TabBar.BackgroundTransparency = 1
	TabBar.ZIndex = 3

	local Layout = Instance.new("UIListLayout", TabBar)
	Layout.FillDirection = Enum.FillDirection.Horizontal
	Layout.Padding = UDim.new(0, 6)

	local Pages = Instance.new("Frame", Main)
	Pages.Position = UDim2.new(0, 16, 0, 96)
	Pages.Size = UDim2.new(1, -32, 1, -112)
	Pages.BackgroundTransparency = 1
	Pages.ZIndex = 3

	TweenService:Create(Main, TweenInfo.new(.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -270, 0.5, -180)}):Play()

	local IsUIOpen = true
	OpenButton.MouseButton1Click:Connect(function()
		IsUIOpen = not IsUIOpen
		if IsUIOpen then
			Main.Visible = true
			TweenService:Create(Main, TweenInfo.new(.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -270, 0.5, -180)}):Play()
			TweenService:Create(Blur, TweenInfo.new(.4), {Size = 12}):Play()
		else
			local CloseTween = TweenService:Create(Main, TweenInfo.new(.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -270, 1.2, 0)})
			CloseTween:Play()
			TweenService:Create(Blur, TweenInfo.new(.4), {Size = 0}):Play()
			CloseTween.Completed:Connect(function() if not IsUIOpen then Main.Visible = false end end)
		end
	end)

	local WindowMethods = {Gui = Gui, Main = Main, Theme = Theme, Pages = Pages, TabBar = TabBar, TabsCount = 0}

	function WindowMethods:CreateTab(Name)
		self.TabsCount = self.TabsCount + 1
		local Page = Instance.new("ScrollingFrame", self.Pages)
		Page.Size = UDim2.new(1, 0, 1, 0)
		Page.CanvasSize = UDim2.new(0, 0, 0, 0)
		Page.ScrollBarThickness = 4
		Page.ScrollBarImageColor3 = Theme
		Page.Visible = false
		Page.BackgroundTransparency = 1
		Page.BorderSizePixel = 0
		Page.ClipsDescendants = true
		Page.ZIndex = 4
		
		local List = Instance.new("UIListLayout", Page)
		List.Padding = UDim.new(0, 8)
		List:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			Page.CanvasSize = UDim2.new(0, 0, 0, List.AbsoluteContentSize.Y + 10)
		end)

		local Button = Instance.new("TextButton", self.TabBar)
		Button.Size = UDim2.new(0, 115, 1, 0)
		Button.Text = Name
		Button.Font = Enum.Font.GothamMedium
		Button.TextSize = 13
		Button.TextColor3 = Color3.fromRGB(150, 155, 165)
		Button.BackgroundColor3 = Color3.fromRGB(18, 19, 26)
		Button.ZIndex = 4
		Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 8)
		local TStroke = Instance.new("UIStroke", Button)
		TStroke.Color = Color3.fromRGB(40, 42, 52)

		Button.MouseButton1Click:Connect(function()
			for _, v in ipairs(self.Pages:GetChildren()) do if v:IsA("ScrollingFrame") then v.Visible = false end end
			for _, v in ipairs(self.TabBar:GetChildren()) do
				if v:IsA("TextButton") then
					TweenService:Create(v, TweenInfo.new(.15), {BackgroundColor3 = Color3.fromRGB(18, 19, 26), TextColor3 = Color3.fromRGB(150, 155, 165)}):Play()
					v:FindFirstChildOfClass("UIStroke").Color = Color3.fromRGB(40, 42, 52)
				end
			end
			Page.Visible = true
			TweenService:Create(Button, TweenInfo.new(.15), {BackgroundColor3 = Color3.fromRGB(24, 26, 36), TextColor3 = Theme}):Play()
			TStroke.Color = Theme
		end)

		if self.TabsCount == 1 then
			Page.Visible = true
			Button.BackgroundColor3 = Color3.fromRGB(24, 26, 36)
			Button.TextColor3 = Theme
			TStroke.Color = Theme
		end

		local TabMethods = {Page = Page, Theme = Theme}

		function TabMethods:AddButton(Text, Callback)
			local Btn = Instance.new("TextButton", self.Page)
			Btn.Size = UDim2.new(1, -6, 0, 40)
			Btn.BackgroundColor3 = Color3.fromRGB(20, 21, 30)
			Btn.Text = "   " .. Text
			Btn.Font = Enum.Font.GothamMedium
			Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
			Btn.TextSize = 13
			Btn.TextXAlignment = Enum.TextXAlignment.Left
			Btn.ZIndex = 5
			Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)
			local Stroke = Instance.new("UIStroke", Btn)
			Stroke.Color = Color3.fromRGB(45, 47, 62)
			
			Btn.MouseButton1Click:Connect(function() if Callback then Callback() end end)
		end

		function TabMethods:AddToggle(Text, Default, Callback)
			local Enabled = Default or false
			local Holder = Instance.new("Frame", self.Page)
			Holder.Size = UDim2.new(1, -6, 0, 44)
			Holder.BackgroundColor3 = Color3.fromRGB(20, 21, 30)
			Holder.ZIndex = 5
			Instance.new("UICorner", Holder).CornerRadius = UDim.new(0, 8)
			local Stroke = Instance.new("UIStroke", Holder)
			Stroke.Color = Color3.fromRGB(45, 47, 62)

			local Label = Instance.new("TextLabel", Holder)
			Label.BackgroundTransparency = 1; Label.Size = UDim2.new(.7, 0, 1, 0); Label.Position = UDim2.new(0, 12, 0, 0)
			Label.Font = Enum.Font.GothamMedium; Label.TextColor3 = Color3.fromRGB(255, 255, 255); Label.TextXAlignment = Enum.TextXAlignment.Left
			Label.Text = Text; Label.TextSize = 13; Label.ZIndex = 6

			local Toggle = Instance.new("TextButton", Holder)
			Toggle.Size = UDim2.new(0, 40, 0, 20)
			Toggle.Position = UDim2.new(1, -52, .5, -10)
			Toggle.Text = ""
			Toggle.BackgroundColor3 = Enabled and Theme or Color3.fromRGB(40, 42, 54)
			Toggle.ZIndex = 6
			Instance.new("UICorner", Toggle).CornerRadius = UDim.new(1, 0)

			local Circle = Instance.new("Frame", Toggle)
			Circle.Size = UDim2.new(0, 14, 0, 14)
			Circle.Position = Enabled and UDim2.new(1, -16, .5, -7) or UDim2.new(0, 2, .5, -7)
			Circle.BackgroundColor3 = Color3.new(1, 1, 1)
			Circle.ZIndex = 7
			Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)

			local function Refresh()
				TweenService:Create(Toggle, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Enabled and Theme or Color3.fromRGB(40, 42, 54)}):Play()
				TweenService:Create(Circle, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = Enabled and UDim2.new(1, -16, .5, -7) or UDim2.new(0, 2, .5, -7)}):Play()
				if Callback then Callback(Enabled) end
			end

			Toggle.MouseButton1Click:Connect(function() Enabled = not Enabled Refresh() end)
		end

		function TabMethods:AddSlider(Text, Min, Max, Default, Callback)
			local Value = Default or Min
			local Holder = Instance.new("Frame", self.Page)
			Holder.Size = UDim2.new(1, -6, 0, 58)
			Holder.BackgroundColor3 = Color3.fromRGB(20, 21, 30)
			Holder.ZIndex = 5
			Instance.new("UICorner", Holder).CornerRadius = UDim.new(0, 8)
			local HStroke = Instance.new("UIStroke", Holder)
			HStroke.Color = Color3.fromRGB(45, 47, 62)

			local Label = Instance.new("TextLabel", Holder)
			Label.BackgroundTransparency = 1; Label.Position = UDim2.new(0, 12, 0, 6); Label.Size = UDim2.new(1, -24, 0, 18)
			Label.Font = Enum.Font.GothamMedium; Label.TextXAlignment = Enum.TextXAlignment.Left; Label.TextColor3 = Color3.fromRGB(255, 255, 255); Label.TextSize = 13; Label.ZIndex = 6

			local Bar = Instance.new("TextButton", Holder)
			Bar.Size = UDim2.new(1, -24, 0, 10)
			Bar.Position = UDim2.new(0, 12, 1, -20)
			Bar.BackgroundColor3 = Color3.fromRGB(40, 42, 54)
			Bar.Text = ""
			Bar.ZIndex = 6
			Instance.new("UICorner", Bar).CornerRadius = UDim.new(1, 0)

			local Fill = Instance.new("Frame", Bar)
			Fill.BackgroundColor3 = Theme; Fill.Size = UDim2.new((Value - Min) / (Max - Min), 0, 1, 0)
			Fill.ZIndex = 7
			Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)

			local Drag = false
			local function Update(x)
				local P = math.clamp((x - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
				Value = math.floor((Min + (Max - Min) * P) + 0.5)
				Fill.Size = UDim2.new(P, 0, 1, 0)
				Label.Text = Text .. " : " .. Value
				if Callback then Callback(Value) end
			end

			Label.Text = Text .. " : " .. Value

			Bar.InputBegan:Connect(function(i)
				if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then Drag = true Update(i.Position.X) end
			end)
			UIS.InputChanged:Connect(function(i)
				if Drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then Update(i.Position.X) end
			end)
			UIS.InputEnded:Connect(function(i)
				if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then Drag = false end
			end)
		end

		return TabMethods
	end

	local ForcedTab = WindowMethods:CreateTab(Localization[Vortex.Language].owner)
	local OwnerFrame = Instance.new("Frame", ForcedTab.Page)
	OwnerFrame.Size = UDim2.new(1, -6, 0, 85)
	OwnerFrame.BackgroundColor3 = Color3.fromRGB(24, 25, 35)
	OwnerFrame.ZIndex = 5
	Instance.new("UICorner", OwnerFrame).CornerRadius = UDim.new(0, 8)
	local OwnerStroke = Instance.new("UIStroke", OwnerFrame)
	OwnerStroke.Color = Theme
	OwnerStroke.Thickness = 1.5
	
	local L1 = Instance.new("TextLabel", OwnerFrame)
	L1.Size = UDim2.new(1, -20, 0, 35)
	L1.Position = UDim2.new(0, 12, 0, 6)
	L1.Text = Localization[Vortex.Language].name
	L1.TextColor3 = Color3.new(1, 1, 1)
	L1.Font = Enum.Font.GothamBold
	L1.TextSize = 13
	L1.TextXAlignment = Enum.TextXAlignment.Left
	L1.BackgroundTransparency = 1
	L1.ZIndex = 6

	local L2 = Instance.new("TextLabel", OwnerFrame)
	L2.Size = UDim2.new(1, -20, 0, 35)
	L2.Position = UDim2.new(0, 12, 0, 42)
	L2.Text = Localization[Vortex.Language].user
	L2.TextColor3 = Theme
	L2.Font = Enum.Font.GothamBold
	L2.TextSize = 13
	L2.TextXAlignment = Enum.TextXAlignment.Left
	L2.BackgroundTransparency = 1
	L2.ZIndex = 6

	return WindowMethods
end

return Vortex
