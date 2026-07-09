--//==================================================================--
--        VORTEX CLEAN UI - MINIMALIST ACRYLIC ENGINE v13.5
--        DEVELOPED BY: ABDULLAH MATREX (ALL RIGHTS RESERVED © 2026)
--//==================================================================--

local Vortex = {}
Vortex.__index = Vortex

local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local SoundService = game:GetService("SoundService")
local UIS = game:GetService("UserInputService")

--//==================================================================--
-- [ مكتبة الأصوات المحدثة - صوت كيبورد خفيف ومريح ]
--//==================================================================--
local Sounds = {
	Hover = Instance.new("Sound", SoundService),
	Click = Instance.new("Sound", SoundService), -- صوت كيبورد ميكانيكي هادئ
	Success = Instance.new("Sound", SoundService)
}

Sounds.Hover.SoundId = "rbxassetid://9114223104"   Sounds.Hover.Volume = 0.3
Sounds.Click.SoundId = "rbxassetid://7203304562"   Sounds.Click.Volume = 0.6 -- Mechanical Keyboard Style
Sounds.Success.SoundId = "rbxassetid://6895079853" Sounds.Success.Volume = 0.2

--//==================================================================--
-- Ripple Effect Function
--//==================================================================--
local function CreateRipple(Object)
	Object.ClipsDescendants = true
	Object.InputBegan:Connect(function(Input)
		if Input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
		
		local Ripple = Instance.new("Frame", Object)
		Ripple.AnchorPoint = Vector2.new(0.5,0.5)
		Ripple.BackgroundColor3 = Color3.new(1,1,1)
		Ripple.BackgroundTransparency = 0.75
		Ripple.BorderSizePixel = 0
		Ripple.Position = UDim2.fromOffset(Input.Position.X - Object.AbsolutePosition.X, Input.Position.Y - Object.AbsolutePosition.Y)
		Ripple.Size = UDim2.fromOffset(0,0)
		Instance.new("UICorner",Ripple).CornerRadius = UDim.new(1,0)

		TweenService:Create(Ripple, TweenInfo.new(0.4, Enum.EasingStyle.QuadOut), {
			Size = UDim2.fromOffset(Object.AbsoluteSize.X * 2, Object.AbsoluteSize.X * 2),
			BackgroundTransparency = 1
		}):Play()

		task.delay(0.41, function() Ripple:Destroy() end)
	end)
end

--//==================================================================--
-- Window Creator
--////==================================================================--
function Vortex:CreateWindow(cfg)
	cfg = cfg or {}
	local Theme = cfg.Theme or Color3.fromRGB(0, 140, 255)
	local ParticlesEnabled = true

	-- تنظيف النسخ السابقة لتفادي الـ Lag
	if CoreGui:FindFirstChild("VortexCleanUI") then CoreGui:FindFirstChild("VortexCleanUI"):Destroy() end
	if Lighting:FindFirstChild("VortexBlur") then Lighting:FindFirstChild("VortexBlur"):Destroy() end

	local Gui = Instance.new("ScreenGui", CoreGui)
	Gui.Name = "VortexCleanUI"
	Gui.ResetOnSpawn = false
	Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	-- Blur Effect الخلفي الناعم
	local Blur = Instance.new("BlurEffect", Lighting)
	Blur.Name = "VortexBlur"
	Blur.Size = 0
	TweenService:Create(Blur, TweenInfo.new(.5, Enum.EasingStyle.QuadOut), {Size = 14}):Play()

	-- [تصغير زر الفتح والإغلاق ليصبح هادئاً وأنيقاً]
	local OpenButton = Instance.new("TextButton", Gui)
	OpenButton.Size = UDim2.new(0,45,0,45)
	OpenButton.Position = UDim2.new(.02, 0, .5, 0)
	OpenButton.Text = "V"
	OpenButton.Font = Enum.Font.GothamBold
	OpenButton.TextSize = 16
	OpenButton.TextColor3 = Color3.new(1,1,1)
	OpenButton.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
	OpenButton.AutoButtonColor = false
	OpenButton.Active = true
	OpenButton.Draggable = true
	Instance.new("UICorner", OpenButton).CornerRadius = UDim.new(1,0)
	local BtnStroke = Instance.new("UIStroke", OpenButton)
	BtnStroke.Color = Theme
	BtnStroke.Thickness = 1.5

	-- Main UI Frame (تصميم شفاف مريح مع تأثير زجاجي Acrylic)
	local Main = Instance.new("Frame", Gui)
	Main.Size = UDim2.new(0,540,0,340)
	Main.Position = UDim2.new(.5,-270,1.2,0)
	Main.BackgroundColor3 = Color3.fromRGB(10, 11, 16)
	Main.BackgroundTransparency = 0.25 -- شفافية مريحة جداً للعين
	Main.BorderSizePixel = 0
	Main.Active = true
	Main.Draggable = true
	Instance.new("UICorner", Main).CornerRadius = UDim.new(0,14)

	local MainStroke = Instance.new("UIStroke", Main)
	MainStroke.Color = Color3.fromRGB(45, 48, 60)
	MainStroke.Thickness = 1

	----------------------------------------------------
	-- [محرك الدوائر الصاعدة من أسفل لأعلى بنعومة]
	----------------------------------------------------
	local ParticleHolder = Instance.new("Frame", Main)
	ParticleHolder.Size = UDim2.new(1,0,1,0)
	ParticleHolder.BackgroundTransparency = 1
	ParticleHolder.ClipsDescendants = true
	ParticleHolder.ZIndex = 0

	local function CreateVerticalCircle()
		if not ParticlesEnabled or not Main.Parent then return end
		local Circle = Instance.new("Frame", ParticleHolder)
		local Size = math.random(6, 16) -- دوائر مريحة
		Circle.Size = UDim2.fromOffset(Size, Size)
		Circle.Position = UDim2.new(math.random(0.05, 0.95), 0, 1.05, 0) -- تبدأ من الأسفل تماماً
		Circle.BackgroundColor3 = Theme
		Circle.BackgroundTransparency = math.random(80, 92) / 100 -- خفيفة جداً شبه مخفية لراحة العين
		Instance.new("UICorner", Circle).CornerRadius = UDim.new(1,0)

		local FloatTween = TweenService:Create(Circle, TweenInfo.new(math.random(5, 8), Enum.EasingStyle.QuadOut), {
			Position = UDim2.new(Circle.Position.X.Scale, math.random(-20, 40), -0.1, 0), -- تصعد للأعلى
			BackgroundTransparency = 1
		})
		FloatTween:Play()
		FloatTween.Completed:Connect(function() Circle:Destroy() end)
	end

	task.spawn(function()
		while Gui.Parent do
			CreateVerticalCircle()
			task.wait(0.35) -- توقيت هادئ غير مزعج
		end
	end)

	-- TopBar & Clean Title System (الحقوق مثبتة بنقاء)
	local Top = Instance.new("Frame", Main)
	Top.Size = UDim2.new(1,0,0,45)
	Top.BackgroundTransparency = 1

	local Title = Instance.new("TextLabel", Top)
	Title.Size = UDim2.new(1,-100,1,0)
	Title.Position = UDim2.new(0,16,0,0)
	Title.BackgroundTransparency = 1
	Title.Text = cfg.Title or "VORTEX ENGINE — BY ABDULLAH MATREX"
	Title.Font = Enum.Font.GothamBold
	Title.TextSize = 14
	Title.TextColor3 = Color3.fromRGB(230, 235, 245)
	Title.TextXAlignment = Enum.TextXAlignment.Left

	-- [تصغير وتعديل زر الإغلاق X]
	local CloseUIBtn = Instance.new("TextButton", Top)
	CloseUIBtn.Size = UDim2.new(0,24,0,24)
	CloseUIBtn.Position = UDim2.new(1,-36,0,10)
	CloseUIBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
	CloseUIBtn.Text = "×"
	CloseUIBtn.Font = Enum.Font.GothamMedium
	CloseUIBtn.TextColor3 = Color3.fromRGB(180, 185, 195)
	CloseUIBtn.TextSize = 18
	Instance.new("UICorner", CloseUIBtn).CornerRadius = UDim.new(0,6)
	local CloseStroke = Instance.new("UIStroke", CloseUIBtn)
	CloseStroke.Color = Color3.fromRGB(40,40,45)

	CloseUIBtn.MouseEnter:Connect(function() CloseUIBtn.TextColor3 = Color3.fromRGB(255, 75, 75) end)
	CloseUIBtn.MouseLeave:Connect(function() CloseUIBtn.TextColor3 = Color3.fromRGB(180, 185, 195) end)

	CloseUIBtn.MouseButton1Click:Connect(function()
		Sounds.Click:Play()
		TweenService:Create(Main, TweenInfo.new(.35, Enum.EasingStyle.QuadIn), {Position = UDim2.new(.5,-270,1.2,0), BackgroundTransparency = 1}):Play()
		TweenService:Create(Blur, TweenInfo.new(.3), {Size = 0}):Play()
		task.wait(.35)
		Gui:Destroy()
	end)

	local TabBar = Instance.new("Frame", Main)
	TabBar.Size = UDim2.new(1,-32,0,36)
	TabBar.Position = UDim2.new(0,16,0,50)
	TabBar.BackgroundTransparency = 1

	local Layout = Instance.new("UIListLayout", TabBar)
	Layout.FillDirection = Enum.FillDirection.Horizontal
	Layout.Padding = UDim.new(0,6)

	local Pages = Instance.new("Frame", Main)
	Pages.Position = UDim2.new(0,16,0,96)
	Pages.Size = UDim2.new(1,-32,1,-112)
	Pages.BackgroundTransparency = 1

	-- انيميشن الدخول الناعم والمريح
	Main.Position = UDim2.new(.5,-270,1.2,0)
	TweenService:Create(Main, TweenInfo.new(.5, Enum.EasingStyle.OutCubic), {Position = UDim2.new(.5,-270,.5,-170)}):Play()

	-- نظام الفتح والإغلاق السلس عبر الزر الصغير
	local IsUIOpen = true
	OpenButton.MouseButton1Click:Connect(function()
		IsUIOpen = not IsUIOpen
		Sounds.Click:Play()
		if IsUIOpen then
			Main.Visible = true
			TweenService:Create(Main, TweenInfo.new(.4, Enum.EasingStyle.OutCubic), {Position = UDim2.new(.5,-270,.5,-170)}):Play()
			TweenService:Create(Blur, TweenInfo.new(.4), {Size = 14}):Play()
		else
			local CloseTween = TweenService:Create(Main, TweenInfo.new(.4, Enum.EasingStyle.InCubic), {Position = UDim2.new(.5,-270,1.2,0)})
			CloseTween:Play()
			TweenService:Create(Blur, TweenInfo.new(.4), {Size = 0}):Play()
			CloseTween.Completed:Connect(function() if not IsUIOpen then Main.Visible = false end end)
		end
	end)

	local WindowMethods = {Gui = Gui, Main = Main, Theme = Theme, Pages = Pages, TabBar = TabBar, TabsCount = 0}

	function WindowMethods:CreateTab(Name)
		self.TabsCount = self.TabsCount + 1
		
		local Page = Instance.new("ScrollingFrame", self.Pages)
		Page.Size = UDim2.new(1,0,1,0)
		Page.CanvasSize = UDim2.new(0,0,0,0)
		Page.ScrollBarThickness = 2
		Page.ScrollBarImageColor3 = Theme
		Page.Visible = false
		Page.BackgroundTransparency = 1
		Page.BorderSizePixel = 0

		local List = Instance.new("UIListLayout", Page)
		List.Padding = UDim.new(0,6)

		List:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			Page.CanvasSize = UDim2.new(0, 0, 0, List.AbsoluteContentSize.Y + 5)
		end)

		local Button = Instance.new("TextButton", self.TabBar)
		Button.Size = UDim2.new(0,100,1,0)
		Button.Text = Name
		Button.Font = Enum.Font.GothamMedium
		Button.TextSize = 13
		Button.TextColor3 = Color3.fromRGB(150,155,165)
		Button.BackgroundColor3 = Color3.fromRGB(18, 19, 26)
		Button.AutoButtonColor = false
		Instance.new("UICorner", Button).CornerRadius = UDim.new(0,8)
		
		local TStroke = Instance.new("UIStroke", Button)
		TStroke.Color = Color3.fromRGB(30,32,40)

		Button.MouseEnter:Connect(function()
			if not Page.Visible then
				TweenService:Create(Button, TweenInfo.new(.15), {TextColor3 = Color3.new(1,1,1)}):Play()
			end
		end)

		Button.MouseLeave:Connect(function()
			if not Page.Visible then
				TweenService:Create(Button, TweenInfo.new(.15), {TextColor3 = Color3.fromRGB(150,155,165)}):Play()
			end
		end)

		Button.MouseButton1Click:Connect(function()
			Sounds.Click:Play()
			for _,v in ipairs(self.Pages:GetChildren()) do if v:IsA("ScrollingFrame") then v.Visible = false end end
			for _,v in ipairs(self.TabBar:GetChildren()) do
				if v:IsA("TextButton") then
					TweenService:Create(v, TweenInfo.new(.15), {BackgroundColor3 = Color3.fromRGB(18, 19, 26), TextColor3 = Color3.fromRGB(150,155,165)}):Play()
					v:FindFirstChildOfClass("UIStroke").Color = Color3.fromRGB(30,32,40)
				end
			end
			Page.Visible = true
			TweenService:Create(Button, TweenInfo.new(.15), {BackgroundColor3 = Color3.fromRGB(25, 27, 38), TextColor3 = Theme}):Play()
			TStroke.Color = Theme
		end)

		if self.TabsCount == 1 then
			Page.Visible = true
			Button.BackgroundColor3 = Color3.fromRGB(25, 27, 38)
			Button.TextColor3 = Theme
			TStroke.Color = Theme
		end

		local TabMethods = {Page = Page, Theme = Theme}

		function TabMethods:AddButton(Text, Callback)
			local Btn = Instance.new("TextButton", self.Page)
			Btn.Size = UDim2.new(1,-4,0,38)
			Btn.BackgroundColor3 = Color3.fromRGB(16, 17, 24)
			Btn.Text = "   " .. Text
			Btn.Font = Enum.Font.GothamMedium
			Btn.TextColor3 = Color3.fromRGB(220,225,235)
			Btn.TextSize = 13
			Btn.TextXAlignment = Enum.TextXAlignment.Left
			Btn.AutoButtonColor = false
			Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,8)

			local Stroke = Instance.new("UIStroke", Btn)
			Stroke.Color = Color3.fromRGB(32,35,45)

			CreateRipple(Btn)

			Btn.MouseEnter:Connect(function() TweenService:Create(Stroke, TweenInfo.new(.15), {Color = Theme}):Play() end)
			Btn.MouseLeave:Connect(function() TweenService:Create(Stroke, TweenInfo.new(.15), {Color = Color3.fromRGB(32,35,45)}):Play() end)
			
			Btn.MouseButton1Click:Connect(function()
				Sounds.Click:Play()
				if Callback then task.spawn(Callback) end
			end)
		end

		function TabMethods:AddToggle(Text, Default, Callback)
			local Enabled = Default or false
			local Holder = Instance.new("Frame", self.Page)
			Holder.Size = UDim2.new(1,-4,0,40)
			Holder.BackgroundColor3 = Color3.fromRGB(16, 17, 24)
			Instance.new("UICorner", Holder).CornerRadius = UDim.new(0,8)
			local Stroke = Instance.new("UIStroke", Holder)
			Stroke.Color = Color3.fromRGB(32,35,45)

			local Label = Instance.new("TextLabel", Holder)
			Label.BackgroundTransparency = 1; Label.Size = UDim2.new(.7,0,1,0); Label.Position = UDim2.new(0,12,0,0)
			Label.Font = Enum.Font.GothamMedium; Label.TextColor3 = Color3.fromRGB(220,225,235); Label.TextXAlignment = Enum.TextXAlignment.Left
			Label.Text = Text; Label.TextSize = 13

			local Toggle = Instance.new("Frame", Holder)
			Toggle.Size = UDim2.new(0,38,0,18)
			Toggle.Position = UDim2.new(1,-50,.5,-9)
			Toggle.BackgroundColor3 = Enabled and Theme or Color3.fromRGB(30,32,40)
			Instance.new("UICorner", Toggle).CornerRadius = UDim.new(1,0)

			local Circle = Instance.new("Frame", Toggle)
			Circle.Size = UDim2.new(0,14,0,14)
			Circle.Position = Enabled and UDim2.new(1,-16,.5,-7) or UDim2.new(0,2,.5,-7)
			Circle.BackgroundColor3 = Color3.new(1,1,1)
			Instance.new("UICorner", Circle).CornerRadius = UDim.new(1,0)

			local function Refresh()
				TweenService:Create(Toggle, TweenInfo.new(.2), {BackgroundColor3 = Enabled and Theme or Color3.fromRGB(30,32,40)}):Play()
				TweenService:Create(Circle, TweenInfo.new(.2), {Position = Enabled and UDim2.new(1,-16,.5,-7) or UDim2.new(0,2,.5,-7)}):Play()
				if Callback then task.spawn(function() Callback(Enabled) end) end
			end

			Holder.InputBegan:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 then
					Sounds.Click:Play()
					Enabled = not Enabled
					Refresh()
				end
			end)
		end

		function TabMethods:AddSlider(Text, Min, Max, Default, Callback)
			local Value = Default or Min
			local Holder = Instance.new("Frame", self.Page)
			Holder.Size = UDim2.new(1,-4,0,48)
			Holder.BackgroundColor3 = Color3.fromRGB(16, 17, 24)
			Instance.new("UICorner", Holder).CornerRadius = UDim.new(0,8)
			Instance.new("UIStroke", Holder).Color = Color3.fromRGB(32,35,45)

			local Label = Instance.new("TextLabel", Holder)
			Label.BackgroundTransparency = 1; Label.Position = UDim2.new(0,12,0,6); Label.Size = UDim2.new(1,-24,0,16)
			Label.Font = Enum.Font.GothamMedium; Label.TextXAlignment = Enum.TextXAlignment.Left; Label.TextColor3 = Color3.fromRGB(220,225,235); Label.TextSize = 12

			local Bar = Instance.new("Frame", Holder)
			Bar.Size = UDim2.new(1,-24,0,4)
			Bar.Position = UDim2.new(0,12,1,-14)
			Bar.BackgroundColor3 = Color3.fromRGB(32,35,45)
			Instance.new("UICorner", Bar).CornerRadius = UDim.new(1,0)

			local Fill = Instance.new("Frame", Bar)
			Fill.BackgroundColor3 = Theme; Fill.Size = UDim2.new((Value-Min)/(Max-Min),0,1,0)
			Instance.new("UICorner", Fill).CornerRadius = UDim.new(1,0)

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
				if i.UserInputType == Enum.UserInputType.MouseButton1 then Drag = true; Sounds.Click:Play(); Update(i.Position.X) end
			end)
			UIS.InputChanged:Connect(function(i)
				if Drag and i.UserInputType == Enum.UserInputType.MouseMovement then Update(i.Position.X) end
			end)
			UIS.InputEnded:Connect(function(i)
				if i.UserInputType == Enum.UserInputType.MouseButton1 then Drag = false end
			end)
		end

		function TabMethods:AddTextBox(Text, Placeholder, Callback)
			local Box = Instance.new("TextBox", self.Page)
			Box.Size = UDim2.new(1,-4,0,38)
			Box.BackgroundColor3 = Color3.fromRGB(16, 17, 24)
			Box.PlaceholderText = Placeholder or Text
			Box.Text = ""
			Box.ClearTextOnFocus = false
			Box.Font = Enum.Font.GothamMedium
			Box.TextColor3 = Color3.new(1,1,1)
			Box.PlaceholderColor3 = Color3.fromRGB(100,105,115)
			Box.TextSize = 13
			Instance.new("UICorner", Box).CornerRadius = UDim.new(0,8)
			Instance.new("UIStroke", Box).Color = Color3.fromRGB(32,35,45)

			Box.FocusLost:Connect(function()
				Sounds.Click:Play()
				if Callback then Callback(Box.Text) end
			end)
		end

		function TabMethods:AddDropdown(Text, List, Callback)
			local Open = false
			local Holder = Instance.new("Frame", self.Page)
			Holder.Size = UDim2.new(1,-4,0,38)
			Holder.BackgroundColor3 = Color3.fromRGB(16, 17, 24)
			Holder.ClipsDescendants = true
			Instance.new("UICorner", Holder).CornerRadius = UDim.new(0,8)
			local HStroke = Instance.new("UIStroke", Holder)
			HStroke.Color = Color3.fromRGB(32,35,45)

			local Btn = Instance.new("TextButton", Holder)
			Btn.Size = UDim2.new(1,0,0,38)
			Btn.Text = "   " .. Text
			Btn.BackgroundTransparency = 1; Btn.Font = Enum.Font.GothamMedium; Btn.TextColor3 = Color3.fromRGB(220,225,235); Btn.TextXAlignment = Enum.TextXAlignment.Left; Btn.TextSize = 13

			local OContainer = Instance.new("Frame", Holder)
			OContainer.Size = UDim2.new(1,-16,0,#List*32)
			OContainer.Position = UDim2.new(0,8,0,38)
			OContainer.BackgroundTransparency = 1
			Instance.new("UIListLayout", OContainer).Padding = UDim.new(0,4)

			Btn.MouseButton1Click:Connect(function()
				Sounds.Click:Play()
				Open = not Open
				TweenService:Create(Holder, TweenInfo.new(.2, Enum.EasingStyle.Quart), {Size = Open and UDim2.new(1,-4,0,42 + (#List * 32)) or UDim2.new(1,-4,0,38)}):Play()
				HStroke.Color = Open and Theme or Color3.fromRGB(32,35,45)
			end)

			for _,v in ipairs(List) do
				local Op = Instance.new("TextButton", OContainer)
				Op.Size = UDim2.new(1,0,0,28)
				Op.BackgroundColor3 = Color3.fromRGB(22, 23, 30)
				Op.Text = "    " .. tostring(v)
				Op.Font = Enum.Font.Gotham; Op.TextColor3 = Color3.fromRGB(180,185,195); Op.TextXAlignment = Enum.TextXAlignment.Left; Op.TextSize = 12
				Instance.new("UICorner", Op).CornerRadius = UDim.new(0,6)

				Op.MouseButton1Click:Connect(function()
					Sounds.Click:Play()
					Btn.Text = "   " .. Text .. " : " .. tostring(v)
					Open = false
					TweenService:Create(Holder, TweenInfo.new(.2, Enum.EasingStyle.Quart), {Size = UDim2.new(1,-4,0,38)}):Play()
					HStroke.Color = Color3.fromRGB(32,35,45)
					if Callback then Callback(v) end
				end)
			end
		end

		return TabMethods
	end

	return WindowMethods
end

return Vortex
