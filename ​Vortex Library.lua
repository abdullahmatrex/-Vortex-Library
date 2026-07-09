--//==================================================================--
--        VORTEX UI LIBRARY - AURA GRAPHICS & 3D CYBER ENGINE v13.0
--//==================================================================--

local Vortex = {}
Vortex.__index = Vortex

local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local SoundService = game:GetService("SoundService")
local UIS = game:GetService("UserInputService")

--//==================================================================--
-- [ مكتبة الأصوات الاحترافية الخاصة بك ]
--//==================================================================--
local Sounds = {
	Hover = Instance.new("Sound", SoundService),
	Click = Instance.new("Sound", SoundService),
	Success = Instance.new("Sound", SoundService),
	Open = Instance.new("Sound", SoundService),
	Close = Instance.new("Sound", SoundService)
}

Sounds.Hover.SoundId = "rbxassetid://6895079853"   Sounds.Hover.Volume = 0.6
Sounds.Click.SoundId = "rbxassetid://6026984224"   Sounds.Click.Volume = 1
Sounds.Success.SoundId = "rbxassetid://9118828562" Sounds.Success.Volume = 0.8
Sounds.Open.SoundId = "rbxassetid://156750593"     Sounds.Open.Volume = 0.8
Sounds.Close.SoundId = "rbxassetid://12222216"     Sounds.Close.Volume = 0.8

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
		Ripple.BackgroundTransparency = 0.6
		Ripple.BorderSizePixel = 0
		Ripple.Position = UDim2.fromOffset(
			Input.Position.X - Object.AbsolutePosition.X,
			Input.Position.Y - Object.AbsolutePosition.Y
		)
		Ripple.Size = UDim2.fromOffset(0,0)
		Instance.new("UICorner",Ripple).CornerRadius = UDim.new(1,0)

		local Max = math.max(Object.AbsoluteSize.X, Object.AbsoluteSize.Y) * 2.5
		TweenService:Create(Ripple, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
			Size = UDim2.fromOffset(Max,Max),
			BackgroundTransparency = 1
		}):Play()

		task.delay(0.46, function() Ripple:Destroy() end)
	end)
end

--//==================================================================--
-- Window Creator
--//==================================================================--
function Vortex:CreateWindow(cfg)
	cfg = cfg or {}
	local Theme = cfg.Theme or Color3.fromRGB(0,170,255)
	local Rainbow = cfg.Rainbow or false
	local ParticlesEnabled = true

	local Gui = Instance.new("ScreenGui", CoreGui)
	Gui.Name = "VortexUltimateUI"
	Gui.ResetOnSpawn = false
	Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	-- Blur Effect
	local Blur = Instance.new("BlurEffect", Lighting)
	Blur.Name = "VortexBlur"
	Blur.Size = 0
	TweenService:Create(Blur, TweenInfo.new(.4), {Size = 20}):Play()

	-- Floating Button (Vortex Switch)
	local OpenButton = Instance.new("TextButton", Gui)
	OpenButton.Size = UDim2.new(0,70,0,70)
	OpenButton.Position = UDim2.new(.02,0,.55,0)
	OpenButton.Text = "Vortex"
	OpenButton.TextScaled = true
	OpenButton.Font = Enum.Font.GothamBold
	OpenButton.TextColor3 = Color3.new(1,1,1)
	OpenButton.BackgroundColor3 = Theme
	OpenButton.AutoButtonColor = false
	OpenButton.Active = true
	OpenButton.Draggable = true
	Instance.new("UICorner", OpenButton).CornerRadius = UDim.new(1,0)

	local ButtonGlow = Instance.new("UIStroke", OpenButton)
	ButtonGlow.Thickness = 2
	ButtonGlow.Color = Theme

	task.spawn(function()
		local t = 0
		while OpenButton.Parent do
			t += task.wait()
			ButtonGlow.Transparency = 0.25 + math.abs(math.sin(t*4))*0.5
			OpenButton.BackgroundColor3 = Theme
		end
	end)

	-- Main 3D Base Frame Shadow
	local Shadow3D = Instance.new("Frame", Gui)
	Shadow3D.Size = UDim2.new(0,560,0,360)
	Shadow3D.Position = UDim2.new(.5,-280,1.3,4)
	Shadow3D.BackgroundColor3 = Color3.fromRGB(0,0,0)
	Instance.new("UICorner", Shadow3D).CornerRadius = UDim.new(0,18)

	-- Main UI Frame (Absolute Non-Transparent Black)
	local Main = Instance.new("Frame", Gui)
	Main.Size = UDim2.new(0,560,0,360)
	Main.Position = UDim2.new(.5,-280,1.3,0)
	Main.BackgroundColor3 = Color3.fromRGB(10,12,20)
	Main.BackgroundTransparency = 0 -- أسود فخم ملكي معتم بالكامل
	Main.BorderSizePixel = 0
	Main.Active = true
	Main.Draggable = true
	Instance.new("UICorner", Main).CornerRadius = UDim.new(0,18)

	-- UIGradient Background Moving System
	local BG = Instance.new("UIGradient", Main)
	BG.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(5,7,15)),
		ColorSequenceKeypoint.new(.5, Color3.fromRGB(12,22,45)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(5,7,15))
	}
	task.spawn(function()
		while Main.Parent do
			BG.Rotation += 0.08
			task.wait()
		end
	end)

	-- Main Scale Factor (Hover Effect)
	local MainScale = Instance.new("UIScale", Main)
	MainScale.Scale = 1

	Main.MouseEnter:Connect(function()
		Sounds.Hover:Play()
		TweenService:Create(MainScale, TweenInfo.new(.25), {Scale = 1.02}):Play()
	end)
	Main.MouseLeave:Connect(function()
		TweenService:Create(MainScale, TweenInfo.new(.25), {Scale = 1}):Play()
	end)

	----------------------------------------------------
	-- Acrylic Glass & Shine Engine
	----------------------------------------------------
	local Glass = Instance.new("Frame", Main)
	Glass.Size = UDim2.new(1,0,1,0)
	Glass.BackgroundColor3 = Color3.fromRGB(18,22,35)
	Glass.BackgroundTransparency = 0.85 -- طبقة حماية زجاجية كربونية معتمة
	Glass.BorderSizePixel = 0
	Glass.ZIndex = -2
	Instance.new("UICorner", Glass).CornerRadius = UDim.new(0,18)

	local Shine = Instance.new("Frame", Glass)
	Shine.Size = UDim2.new(0,120,2,0)
	Shine.Position = UDim2.new(-.4,0,-.5,0)
	Shine.BackgroundColor3 = Color3.new(1,1,1)
	Shine.BackgroundTransparency = .92
	Shine.Rotation = 20
	Shine.ZIndex = -1

	local ShineGradient = Instance.new("UIGradient", Shine)
	ShineGradient.Transparency = NumberSequence.new{
		NumberSequenceKeypoint.new(0,1),
		NumberSequenceKeypoint.new(.5,.55),
		NumberSequenceKeypoint.new(1,1)
	}

	task.spawn(function()
		while Main.Parent do
			Shine.Position = UDim2.new(-.35,0,-.5,0)
			TweenService:Create(Shine, TweenInfo.new(4, Enum.EasingStyle.Linear), {Position = UDim2.new(1.35,0,-.5,0)}):Play()
			task.wait(4.2)
		end
	end)

	----------------------------------------------------
	-- Vortex Aura Engine & Glow Engine
	----------------------------------------------------
	local GlowStroke = Instance.new("UIStroke", Main)
	GlowStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	GlowStroke.Thickness = 2.5
	GlowStroke.Color = Theme

	local Aura = Instance.new("ImageLabel", Main)
	Aura.Name = "Aura"
	Aura.BackgroundTransparency = 1
	Aura.AnchorPoint = Vector2.new(0.5,0.5)
	Aura.Position = UDim2.new(0.5,0,0.5,0)
	Aura.Size = UDim2.new(1,180,1,180)
	Aura.ZIndex = -5
	Aura.Image = "rbxassetid://5028857084"
	Aura.ScaleType = Enum.ScaleType.Stretch
	Aura.ImageColor3 = Theme
	Aura.ImageTransparency = 0.45

	local AuraScale = Instance.new("UIScale", Aura)

	local Glow = Instance.new("ImageLabel", Main)
	Glow.BackgroundTransparency = 1
	Glow.AnchorPoint = Vector2.new(.5,.5)
	Glow.Position = UDim2.new(.5,0,.5,0)
	Glow.Size = UDim2.new(1,80,1,80)
	Glow.ZIndex = -1
	Glow.Image = "rbxassetid://5028857084"
	Glow.ImageColor3 = Theme

	----------------------------------------------------
	-- Particle Engine Frame
	----------------------------------------------------
	local ParticleHolder = Instance.new("Frame", Main)
	ParticleHolder.Size = UDim2.new(1,0,1,0)
	ParticleHolder.BackgroundTransparency = 1
	ParticleHolder.ClipsDescendants = true
	ParticleHolder.ZIndex = 0

	local function CreateParticle()
		if not ParticlesEnabled then return end
		local Dot = Instance.new("Frame", ParticleHolder)
		local Size = math.random(2,6)
		Dot.Size = UDim2.fromOffset(Size,Size)
		Dot.Position = UDim2.new(math.random(), 0, 1.1, 0)
		Dot.BackgroundColor3 = Theme
		Dot.BackgroundTransparency = math.random(25,70)/100
		Instance.new("UICorner", Dot).CornerRadius = UDim.new(1,0)

		local PStroke = Instance.new("UIStroke", Dot)
		PStroke.Color = Theme
		PStroke.Transparency = .45

		local X = math.random(-120,120)
		local Tween = TweenService:Create(Dot, TweenInfo.new(math.random(6,12), Enum.EasingStyle.Linear), {
			Position = UDim2.new(.5, X, -.2, 0),
			Rotation = math.random(180,720),
			BackgroundTransparency = 1
		})
		Tween:Play()
		Tween.Completed:Connect(function() Dot:Destroy() end)
	end

	task.spawn(function()
		while Gui.Parent do
			if ParticlesEnabled then CreateParticle() end
			task.wait(.22)
		end
	end)

	-- TopBar & Animated Title System
	local Top = Instance.new("Frame", Main)
	Top.Size = UDim2.new(1,0,0,52)
	Top.BackgroundTransparency = 1

	local Title = Instance.new("TextLabel", Top)
	Title.Size = UDim2.new(1,0,1,0)
	Title.BackgroundTransparency = 1
	Title.Text = cfg.Title or "VORTEX UI"
	Title.Font = Enum.Font.GothamBlack
	Title.TextSize = 18
	Title.TextColor3 = Theme

	local TitleScale = Instance.new("UIScale", Title)

	-- Main Rendering Loop for Animations (Pulse, Rainbow, Aura)
	task.spawn(function()
		local t = 0
		while Main.Parent do
			t += task.wait()
			
			local Pulse = 1 + math.sin(t*2.5)*0.03
			Glow.Size = UDim2.new(Pulse, 80, Pulse, 80)
			Glow.ImageTransparency = .30 + math.abs(math.sin(t*2))*0.25
			
			Aura.Rotation += 0.15
			AuraScale.Scale = 1 + math.sin(t*2)*0.04
			Aura.ImageTransparency = 0.35 + math.abs(math.sin(t*3))*0.25

			TitleScale.Scale = 1 + math.sin(t*2.5)*0.03

			if Rainbow then
				local c = Color3.fromHSV((tick()*0.1)%1, 1, 1)
				Theme = c
			end
			
			Glow.ImageColor3 = Theme
			Aura.ImageColor3 = Theme
			GlowStroke.Color = Theme
			Title.TextColor3 = Theme
		end
	end)

	-- Layout Controls for Tabs
	local TabBar = Instance.new("Frame", Main)
	TabBar.Size = UDim2.new(1,-20,0,42)
	TabBar.Position = UDim2.new(0,10,0,55)
	TabBar.BackgroundTransparency = 1

	local Layout = Instance.new("UIListLayout", TabBar)
	Layout.FillDirection = Enum.FillDirection.Horizontal
	Layout.Padding = UDim.new(0,8)

	local Pages = Instance.new("Frame", Main)
	Pages.Position = UDim2.new(0,10,0,110)
	Pages.Size = UDim2.new(1,-20,1,-125)
	Pages.BackgroundTransparency = 1

	-- Opening & Toggling Logic
	Sounds.Open:Play()
	TweenService:Create(Main, TweenInfo.new(.75, Enum.EasingStyle.Back), {Position = UDim2.new(.5,-280,.5,-180)}):Play()
	TweenService:Create(Shadow3D, TweenInfo.new(.75, Enum.EasingStyle.Back), {Position = UDim2.new(.5,-280,.5,-176)}):Play()

	local Open = true
	OpenButton.MouseButton1Click:Connect(function()
		Open = not Open
		if Open then
			Sounds.Open:Play()
			TweenService:Create(Main, TweenInfo.new(.35, Enum.EasingStyle.QuadOut), {Position = UDim2.new(.5,-280,.5,-180)}):Play()
			TweenService:Create(Shadow3D, TweenInfo.new(.35, Enum.EasingStyle.QuadOut), {Position = UDim2.new(.5,-280,.5,-176)}):Play()
			TweenService:Create(Blur, TweenInfo.new(.35), {Size = 20}):Play()
		else
			Sounds.Close:Play()
			TweenService:Create(Main, TweenInfo.new(.35, Enum.EasingStyle.QuadIn), {Position = UDim2.new(.5,-280,1.3,0)}):Play()
			TweenService:Create(Shadow3D, TweenInfo.new(.35, Enum.EasingStyle.QuadIn), {Position = UDim2.new(.5,-280,1.3,4)}):Play()
			TweenService:Create(Blur, TweenInfo.new(.35), {Size = 0}):Play()
		end
	end)

	local WindowMethods = {Gui = Gui, Main = Main, Theme = Theme, Pages = Pages, TabBar = TabBar, TabsCount = 0}

	--//==================================================================--
	-- Tab Handler
	--//==================================================================--
	function WindowMethods:CreateTab(Name)
		self.TabsCount = self.TabsCount + 1
		
		local Page = Instance.new("ScrollingFrame", self.Pages)
		Page.Size = UDim2.new(1,0,1,0)
		Page.CanvasSize = UDim2.new(0,0,0,0)
		Page.ScrollBarThickness = 3
		Page.ScrollBarImageColor3 = Theme
		Page.Visible = false
		Page.BackgroundTransparency = 1
		Page.BorderSizePixel = 0

		local List = Instance.new("UIListLayout", Page)
		List.Padding = UDim.new(0,8)

		List:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			Page.CanvasSize = UDim2.new(0, 0, 0, List.AbsoluteContentSize.Y + 10)
		end)

		local Button = Instance.new("TextButton", self.TabBar)
		Button.Size = UDim2.new(0,115,1,0)
		Button.Text = Name
		Button.Font = Enum.Font.GothamBold
		Button.TextSize = 14
		Button.TextColor3 = Color3.fromRGB(200,200,200)
		Button.BackgroundColor3 = Color3.fromRGB(5,5,5)
		Button.AutoButtonColor = false
		Instance.new("UICorner", Button).CornerRadius = UDim.new(0,10)
		
		local TStroke = Instance.new("UIStroke", Button)
		TStroke.Color = Color3.fromRGB(25,25,25)

		Button.MouseEnter:Connect(function()
			Sounds.Hover:Play()
			if not Page.Visible then
				TweenService:Create(Button, TweenInfo.new(.18), {BackgroundColor3 = Theme, TextColor3 = Color3.new(1,1,1)}):Play()
			end
		end)

		Button.MouseLeave:Connect(function()
			if not Page.Visible then
				TweenService:Create(Button, TweenInfo.new(.18), {BackgroundColor3 = Color3.fromRGB(5,5,5), TextColor3 = Color3.fromRGB(200,200,200)}):Play()
			end
		end)

		Button.MouseButton1Click:Connect(function()
			Sounds.Click:Play()
			for _,v in ipairs(self.Pages:GetChildren()) do
				if v:IsA("ScrollingFrame") then v.Visible = false end
			end
			for _,v in ipairs(self.TabBar:GetChildren()) do
				if v:IsA("TextButton") then
					TweenService:Create(v, TweenInfo.new(.15), {BackgroundColor3 = Color3.fromRGB(5,5,5), TextColor3 = Color3.fromRGB(200,200,200)}):Play()
					v:FindFirstChildOfClass("UIStroke").Color = Color3.fromRGB(25,25,25)
				end
			end
			Page.Visible = true
			TweenService:Create(Button, TweenInfo.new(.15), {BackgroundColor3 = Color3.fromRGB(12,12,12), TextColor3 = Theme}):Play()
			TStroke.Color = Theme
		end)

		if self.TabsCount == 1 then
			Page.Visible = true
			Button.BackgroundColor3 = Color3.fromRGB(12,12,12)
			Button.TextColor3 = Theme
			TStroke.Color = Theme
		end

		local TabMethods = {Page = Page, Theme = Theme}

		-- [1] Button Component with 3D Down-Click & Ripple
		function TabMethods:AddButton(Text, Callback)
			local Holder = Instance.new("Frame", self.Page)
			Holder.Size = UDim2.new(1,-6,0,42)
			Holder.BackgroundColor3 = Color3.fromRGB(0,0,0)
			Instance.new("UICorner", Holder).CornerRadius = UDim.new(0,10)

			local Btn = Instance.new("TextButton", Holder)
			Btn.Size = UDim2.new(1,0,1,-3)
			Btn.BackgroundColor3 = Color3.fromRGB(8,8,12)
			Btn.Text = Text
			Btn.Font = Enum.Font.GothamBold
			Btn.TextColor3 = Color3.new(1,1,1)
			Btn.TextSize = 14
			Btn.AutoButtonColor = false
			Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,10)

			local Stroke = Instance.new("UIStroke", Btn)
			Stroke.Color = Theme
			Stroke.Thickness = 1

			CreateRipple(Btn)

			Btn.MouseEnter:Connect(function() Sounds.Hover:Play() end)
			Btn.MouseButton1Down:Connect(function()
				Sounds.Click:Play()
				TweenService:Create(Btn, TweenInfo.new(.08), {Size = UDim2.new(1,0,1,0)}):Play()
			end)
			Btn.MouseButton1Up:Connect(function()
				TweenService:Create(Btn, TweenInfo.new(.08), {Size = UDim2.new(1,0,1,-3)}):Play()
				if Callback then Sounds.Success:Play() task.spawn(Callback) end
			end)
		end

		-- [2] Toggle Component
		function TabMethods:AddToggle(Text, Default, Callback)
			local Enabled = Default or false
			local Holder = Instance.new("Frame", self.Page)
			Holder.Size = UDim2.new(1,-6,0,46)
			Holder.BackgroundColor3 = Color3.fromRGB(8,8,12)
			Instance.new("UICorner", Holder).CornerRadius = UDim.new(0,10)
			Instance.new("UIStroke", Holder).Color = Color3.fromRGB(20,20,25)

			local Label = Instance.new("TextLabel", Holder)
			Label.BackgroundTransparency = 1
			Label.Size = UDim2.new(.65,0,1,0)
			Label.Position = UDim2.new(0,12,0,0)
			Label.Font = Enum.Font.GothamBold
			Label.TextColor3 = Color3.new(1,1,1)
			Label.TextXAlignment = Enum.TextXAlignment.Left
			Label.Text = Text
			Label.TextSize = 14

			local Toggle = Instance.new("Frame", Holder)
			Toggle.Size = UDim2.new(0,46,0,22)
			Toggle.Position = UDim2.new(1,-58,.5,-11)
			Toggle.BackgroundColor3 = Enabled and Theme or Color3.fromRGB(25,25,30)
			Instance.new("UICorner", Toggle).CornerRadius = UDim.new(1,0)

			local Circle = Instance.new("Frame", Toggle)
			Circle.Size = UDim2.new(0,16,0,16)
			Circle.Position = Enabled and UDim2.new(1,-19,.5,-8) or UDim2.new(0,3,.5,-8)
			Circle.BackgroundColor3 = Color3.new(1,1,1)
			Instance.new("UICorner", Circle).CornerRadius = UDim.new(1,0)

			local function Refresh(IsClick)
				if IsClick then Sounds.Click:Play() end
				TweenService:Create(Toggle, TweenInfo.new(.22, Enum.EasingStyle.Quint), {
					BackgroundColor3 = Enabled and Theme or Color3.fromRGB(25,25,30)
				}):Play()
				TweenService:Create(Circle, TweenInfo.new(.22, Enum.EasingStyle.Quint), {
					Position = Enabled and UDim2.new(1,-19,.5,-8) or UDim2.new(0,3,.5,-8)
				}):Play()
				if Callback then task.spawn(function() Callback(Enabled) end) end
			end

			Holder.InputBegan:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 then
					Enabled = not Enabled
					Refresh(true)
				end
			end)
		end

		-- [3] Slider Component
		function TabMethods:AddSlider(Text, Min, Max, Default, Callback)
			local Value = Default or Min
			local Holder = Instance.new("Frame", self.Page)
			Holder.Size = UDim2.new(1,-6,0,54)
			Holder.BackgroundColor3 = Color3.fromRGB(8,8,12)
			Instance.new("UICorner", Holder).CornerRadius = UDim.new(0,10)
			Instance.new("UIStroke", Holder).Color = Color3.fromRGB(20,20,25)

			local Label = Instance.new("TextLabel", Holder)
			Label.BackgroundTransparency = 1
			Label.Position = UDim2.new(0,12,0,5)
			Label.Size = UDim2.new(1,-24,0,20)
			Label.Font = Enum.Font.GothamBold
			Label.TextXAlignment = Enum.TextXAlignment.Left
			Label.TextColor3 = Color3.new(1,1,1)
			Label.TextSize = 13

			local Bar = Instance.new("Frame", Holder)
			Bar.Size = UDim2.new(1,-24,0,5)
			Bar.Position = UDim2.new(0,12,1,-16)
			Bar.BackgroundColor3 = Color3.fromRGB(25,25,30)
			Instance.new("UICorner", Bar).CornerRadius = UDim.new(1,0)

			local Fill = Instance.new("Frame", Bar)
			Fill.BackgroundColor3 = Theme
			Fill.Size = UDim2.new((Value-Min)/(Max-Min),0,1,0)
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
				if i.UserInputType == Enum.UserInputType.MouseButton1 then
					Drag = true
					Sounds.Click:Play()
					Update(i.Position.X)
				end
			end)
			UIS.InputChanged:Connect(function(i)
				if Drag and i.UserInputType == Enum.UserInputType.MouseMovement then Update(i.Position.X) end
			end)
			UIS.InputEnded:Connect(function(i)
				if i.UserInputType == Enum.UserInputType.MouseButton1 then Drag = false end
			end)
		end

		-- [4] TextBox Component
		function TabMethods:AddTextBox(Text, Placeholder, Callback)
			local Box = Instance.new("TextBox", self.Page)
			Box.Size = UDim2.new(1,-6,0,42)
			Box.BackgroundColor3 = Color3.fromRGB(8,8,12)
			Box.PlaceholderText = Placeholder or Text
			Box.Text = ""
			Box.ClearTextOnFocus = false
			Box.Font = Enum.Font.GothamMedium
			Box.TextColor3 = Color3.new(1,1,1)
			Box.PlaceholderColor3 = Color3.fromRGB(110,110,120)
			Box.TextSize = 14
			Instance.new("UICorner", Box).CornerRadius = UDim.new(0,10)
			Instance.new("UIStroke", Box).Color = Color3.fromRGB(20,20,25)

			Box.FocusLost:Connect(function()
				Sounds.Success:Play()
				if Callback then Callback(Box.Text) end
			end)
		end

		-- [5] Dropdown Component
		function TabMethods:AddDropdown(Text, List, Callback)
			local Open = false
			local Holder = Instance.new("Frame", self.Page)
			Holder.Size = UDim2.new(1,-6,0,42)
			Holder.BackgroundColor3 = Color3.fromRGB(8,8,12)
			Holder.ClipsDescendants = true
			Instance.new("UICorner", Holder).CornerRadius = UDim.new(0,10)
			local HStroke = Instance.new("UIStroke", Holder)
			HStroke.Color = Color3.fromRGB(20,20,25)

			local Btn = Instance.new("TextButton", Holder)
			Btn.Size = UDim2.new(1,0,0,42)
			Btn.Text = "   " .. Text
			Btn.BackgroundTransparency = 1
			Btn.Font = Enum.Font.GothamBold
			Btn.TextColor3 = Color3.new(1,1,1)
			Btn.TextXAlignment = Enum.TextXAlignment.Left
			Btn.TextSize = 14

			local OContainer = Instance.new("Frame", Holder)
			OContainer.Size = UDim2.new(1,-16,0,#List*34)
			OContainer.Position = UDim2.new(0,8,0,42)
			OContainer.BackgroundTransparency = 1
			Instance.new("UIListLayout", OContainer).Padding = UDim.new(0,4)

			Btn.MouseButton1Click:Connect(function()
				Sounds.Click:Play()
				Open = not Open
				TweenService:Create(Holder, TweenInfo.new(.25, Enum.EasingStyle.Quart), {
					Size = Open and UDim2.new(1,-6,0,46 + (#List * 34)) or UDim2.new(1,-6,0,42)
				}):Play()
				HStroke.Color = Open and Theme or Color3.fromRGB(20,20,25)
			end)

			for _,v in ipairs(List) do
				local Op = Instance.new("TextButton", OContainer)
				Op.Size = UDim2.new(1,0,0,30)
				Op.BackgroundColor3 = Color3.fromRGB(2,2,4)
				Op.Text = "    " .. tostring(v)
				Op.Font = Enum.Font.Gotham
				Op.TextColor3 = Color3.fromRGB(200,200,210)
				Op.TextXAlignment = Enum.TextXAlignment.Left
				Op.TextSize = 13
				Instance.new("UICorner", Op).CornerRadius = UDim.new(0,6)
				Instance.new("UIStroke", Op).Color = Color3.fromRGB(15,15,18)

				Op.MouseButton1Click:Connect(function()
					Sounds.Success:Play()
					Btn.Text = "   " .. Text .. " : " .. tostring(v)
					Open = false
					TweenService:Create(Holder, TweenInfo.new(.2, Enum.EasingStyle.Quart), {Size = UDim2.new(1,-6,0,42)}):Play()
					HStroke.Color = Color3.fromRGB(20,20,25)
					if Callback then Callback(v) end
				end)
			end
		end

		-- [6] Keybind Component
		function TabMethods:AddKeybind(Text, DefaultKey, Callback)
			local CurrentKey = DefaultKey or Enum.KeyCode.RightShift
			local Waiting = false

			local Holder = Instance.new("Frame", self.Page)
			Holder.Size = UDim2.new(1,-6,0,46)
			Holder.BackgroundColor3 = Color3.fromRGB(8,8,12)
			Instance.new("UICorner", Holder).CornerRadius = UDim.new(0,10)
			Instance.new("UIStroke", Holder).Color = Color3.fromRGB(20,20,25)

			local Label = Instance.new("TextLabel", Holder)
			Label.Size = UDim2.new(.65,0,1,0)
			Label.Position = UDim2.new(0,12,0,0)
			Label.BackgroundTransparency = 1
			Label.Text = Text
			Label.TextColor3 = Color3.new(1,1,1)
			Label.TextXAlignment = Enum.TextXAlignment.Left
			Label.Font = Enum.Font.GothamBold
			Label.TextSize = 14

			local Button = Instance.new("TextButton", Holder)
			Button.Size = UDim2.new(0,100,0,28)
			Button.Position = UDim2.new(1,-112,.5,-14)
			Button.BackgroundColor3 = Theme
			Button.TextColor3 = Color3.new(1,1,1)
			Button.Font = Enum.Font.GothamBold
			Button.Text = CurrentKey.Name
			Button.TextSize = 12
			Button.AutoButtonColor = false
			Instance.new("UICorner", Button).CornerRadius = UDim.new(0,6)

			CreateRipple(Button)

			Button.MouseButton1Click:Connect(function()
				Sounds.Click:Play()
				if Waiting then return end
				Waiting = true
				Button.Text = "..."
			end)

			UIS.InputBegan:Connect(function(Input, Typing)
				if Typing then return end
				if Waiting then
					if Input.KeyCode ~= Enum.KeyCode.Unknown then
						CurrentKey = Input.KeyCode
						Button.Text = CurrentKey.Name
						Waiting = false
						Sounds.Success:Play()
					end
					return
				end
				if Input.KeyCode == CurrentKey then
					Sounds.Click:Play()
					if Callback then task.spawn(function() Callback(CurrentKey) end) end
				end
			end)
		end

		return TabMethods
	end

	--//==================================================================--
	-- Notification Component (Standalone)
	--//==================================================================--
	local NotificationGui = Instance.new("ScreenGui", CoreGui)
	NotificationGui.Name = "VortexNotifications"
	NotificationGui.ResetOnSpawn = false

	local NHolder = Instance.new("Frame", NotificationGui)
	NHolder.AnchorPoint = Vector2.new(1,0)
	NHolder.Position = UDim2.new(1,-20,0,20)
	NHolder.Size = UDim2.new(0,320,1,-40)
	NHolder.BackgroundTransparency = 1
	Instance.new("UIListLayout", NHolder).Padding = UDim.new(0,10)

	function Vortex:Notify(TitleText, MainText, Duration, Color)
		Duration = Duration or 3
		Color = Color or Theme

		local NFrame = Instance.new("Frame", NHolder)
		NFrame.Size = UDim2.new(0,0,0,70)
		NFrame.BackgroundColor3 = Color3.fromRGB(4,4,6)
		NFrame.ClipsDescendants = true
		Instance.new("UICorner", NFrame).CornerRadius = UDim.new(0,12)
		Instance.new("UIStroke", NFrame).Color = Color

		local T = Instance.new("TextLabel", NFrame)
		T.BackgroundTransparency = 1; T.Position = UDim2.new(0,15,0,8); T.Size = UDim2.new(1,-20,0,22)
		T.Font = Enum.Font.GothamBold; T.Text = TitleText; T.TextSize = 15; T.TextColor3 = Color; T.TextXAlignment = Enum.TextXAlignment.Left

		local D = Instance.new("TextLabel", NFrame)
		D.BackgroundTransparency = 1; D.Position = UDim2.new(0,15,0,32); D.Size = UDim2.new(1,-20,0,25)
		D.Font = Enum.Font.Gotham; D.Text = MainText; D.TextWrapped = true; D.TextSize = 13; D.TextColor3 = Color3.fromRGB(220,220,220); D.TextXAlignment = Enum.TextXAlignment.Left

		TweenService:Create(NFrame, TweenInfo.new(.35, Enum.EasingStyle.Back), {Size = UDim2.new(0,300,0,70)}):Play()
		Sounds.Success:Play()

		task.delay(Duration, function()
			TweenService:Create(NFrame, TweenInfo.new(.25), {Size = UDim2.new(0,0,0,70)}):Play()
			task.wait(.3)
			NFrame:Destroy()
		end)
	end

	-- Control Particle Visibility Function
	function WindowMethods:SetParticles(State)
		ParticlesEnabled = State
		ParticleHolder.Visible = State
	end

	return WindowMethods
end

return Vortex
