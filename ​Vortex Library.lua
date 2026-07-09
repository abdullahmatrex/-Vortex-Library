--//==================================================================--
--        VORTEX CLEAN UI - PRO v14.0 (ADVANCED ARCHITECTURE)
--        DEVELOPED BY: ABDULLAH MATREX (ALL RIGHTS RESERVED © 2026)
--//==================================================================--

local Vortex = {}
Vortex.__index = Vortex

local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local SoundService = game:GetService("SoundService")
local UIS = game:GetService("UserInputService")

-- إعدادات اللغة الافتراضية
Vortex.Language = "en" 
local Localization = {
	ar = {
		loading = "جاري تحميل فورتكس...",
		owner = "المطور الإجباري",
		name = "الاسم: عبدالله ماتريكس",
		user = "اليوزر: eonsali07807863909",
		close_confirm = "هل أنت متأكد من إغلاق القائمة؟",
		yes = "نعم", no = "لا",
		select_lang = "اختر اللغة / Select Language"
	},
	en = {
		loading = "Loading Vortex Engine...",
		owner = "Forced Developer",
		name = "Name: Abdullah Matrex",
		user = "User: eonsali07807863909",
		close_confirm = "Are you sure you want to close?",
		yes = "Yes", no = "No",
		select_lang = "اختر اللغة / Select Language"
	}
}

-- تنظيف النسخ القديمة
if CoreGui:FindFirstChild("VortexCleanUI") then CoreGui:FindFirstChild("VortexCleanUI"):Destroy() end
if Lighting:FindFirstChild("VortexBlur") then Lighting:FindFirstChild("VortexBlur"):Destroy() end

-- إنشاء الشاشة الرئيسية
local Gui = Instance.new("ScreenGui", CoreGui)
Gui.Name = "VortexCleanUI"
Gui.ResetOnSpawn = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- نظام اختيار اللغة أولاً قبل كل شيء
local LangFrame = Instance.new("Frame", Gui)
LangFrame.Size = UDim2.new(0, 320, 0, 180)
LangFrame.Position = UDim2.new(0.5, -160, 0.5, -90)
LangFrame.BackgroundColor3 = Color3.fromRGB(15, 16, 22)
Instance.new("UICorner", LangFrame).CornerRadius = UDim.new(0, 12)
local LangStroke = Instance.new("UIStroke", LangFrame)
LangStroke.Color = Color3.fromRGB(0, 140, 255)
LangStroke.Thickness = 2

local LangTitle = Instance.new("TextLabel", LangFrame)
LangTitle.Size = UDim2.new(1, 0, 0, 40)
LangTitle.Text = Localization.en.select_lang
LangTitle.TextColor3 = Color3.new(1,1,1)
LangTitle.Font = Enum.Font.GothamBold
LangTitle.TextSize = 14
LangTitle.BackgroundTransparency = 1

local ArBtn = Instance.new("TextButton", LangFrame)
ArBtn.Size = UDim2.new(0, 120, 0, 40)
ArBtn.Position = UDim2.new(0.15, 0, 0.5, 0)
ArBtn.Text = "العربية"
ArBtn.BackgroundColor3 = Color3.fromRGB(25, 26, 35)
ArBtn.TextColor3 = Color3.new(1,1,1)
ArBtn.Font = Enum.Font.GothamMedium
Instance.new("UICorner", ArBtn)

local EnBtn = Instance.new("TextButton", LangFrame)
EnBtn.Size = UDim2.new(0, 120, 0, 40)
EnBtn.Position = UDim2.new(0.55, 0, 0.5, 0)
EnBtn.Text = "English"
EnBtn.BackgroundColor3 = Color3.fromRGB(25, 26, 35)
EnBtn.TextColor3 = Color3.new(1,1,1)
EnBtn.Font = Enum.Font.GothamMedium
Instance.new("UICorner", EnBtn)

-- نظام انتصار اختيار اللغة والتحميل
local SelectedLang = false
ArBtn.MouseButton1Click:Connect(function() Vortex.Language = "ar" SelectedLang = true end)
EnBtn.MouseButton1Click:Connect(function() Vortex.Language = "en" SelectedLang = true end)

while not SelectedLang do task.wait() end
LangFrame:Destroy()

-- شاشة التحميل (Loading Screen)
local LoadingFrame = Instance.new("Frame", Gui)
LoadingFrame.Size = UDim2.new(0, 300, 0, 100)
LoadingFrame.Position = UDim2.new(0.5, -150, 0.5, -50)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(10, 11, 16)
Instance.new("UICorner", LoadingFrame).CornerRadius = UDim.new(0, 12)

local LoadingLabel = Instance.new("TextLabel", LoadingFrame)
LoadingLabel.Size = UDim2.new(1, 0, 1, 0)
LoadingLabel.Text = Localization[Vortex.Language].loading
LoadingLabel.TextColor3 = Color3.fromRGB(0, 140, 255)
LoadingLabel.Font = Enum.Font.GothamBold
LoadingLabel.TextSize = 14
LoadingLabel.BackgroundTransparency = 1

task.wait(2) -- وقت التحميل المحاكي
LoadingFrame:Destroy()

-- تشغيل الـ Blur بعد التحميل
local Blur = Instance.new("BlurEffect", Lighting)
Blur.Name = "VortexBlur"
Blur.Size = 0
TweenService:Create(Blur, TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = 14}):Play()

-- Window Creator
function Vortex:CreateWindow(cfg)
	cfg = cfg or {}
	local Theme = cfg.Theme or Color3.fromRGB(0, 140, 255)

	local Main = Instance.new("Frame", Gui)
	Main.Size = UDim2.new(0,540,0,340)
	Main.Position = UDim2.new(.5,-270,1.2,0)
	Main.BackgroundColor3 = Color3.fromRGB(10, 11, 16)
	Main.BackgroundTransparency = 0.25
	Main.BorderSizePixel = 0
	Main.Active = true
	Instance.new("UICorner", Main).CornerRadius = UDim.new(0,14)

	local MainStroke = Instance.new("UIStroke", Main)
	MainStroke.Color = Color3.fromRGB(45, 48, 60)
	MainStroke.Thickness = 1

	-- نظام سحب مستقر
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

	-- كثافة أعلى للدوائر من اليمين واليسار بالتساوي
	local ParticleHolder = Instance.new("Frame", Main)
	ParticleHolder.Size = UDim2.new(1,0,1,0)
	ParticleHolder.BackgroundTransparency = 1
	ParticleHolder.ClipsDescendants = true

	local function CreateCircle(side)
		local Circle = Instance.new("Frame", ParticleHolder)
		local Size = math.random(6, 14)
		Circle.Size = UDim2.fromOffset(Size, Size)
		local minX = side == "left" and 0.02 or 0.55
		local maxX = side == "left" and 0.45 or 0.98
		Circle.Position = UDim2.new(math.random() * (maxX - minX) + minX, 0, 1.05, 0)
		Circle.BackgroundColor3 = Theme
		Circle.BackgroundTransparency = 0.85
		Instance.new("UICorner", Circle).CornerRadius = UDim.new(1,0)

		TweenService:Create(Circle, TweenInfo.new(math.random(4, 7), Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Position = UDim2.new(Circle.Position.X.Scale, math.random(-20, 20), -0.1, 0),
			BackgroundTransparency = 1
		}):Play()
		task.delay(7.1, function() Circle:Destroy() end)
	end

	task.spawn(function()
		while Gui.Parent do
			CreateCircle("left")
			CreateCircle("right")
			task.wait(0.2)
		end
	end)

	local Top = Instance.new("Frame", Main)
	Top.Size = UDim2.new(1,0,0,45)
	Top.BackgroundTransparency = 1

	local Title = Instance.new("TextLabel", Top)
	Title.Size = UDim2.new(1,-100,1,0)
	Title.Position = UDim2.new(0,16,0,0)
	Title.BackgroundTransparency = 1
	Title.Text = cfg.Title or "VORTEX ENGINE"
	Title.Font = Enum.Font.GothamBold
	Title.TextSize = 14
	Title.TextColor3 = Color3.fromRGB(230, 235, 245)
	Title.TextXAlignment = Enum.TextXAlignment.Left

	-- زر إغلاق مع التحقق (تأكيد الإغلاق أولاً)
	local CloseUIBtn = Instance.new("TextButton", Top)
	CloseUIBtn.Size = UDim2.new(0,24,0,24)
	CloseUIBtn.Position = UDim2.new(1,-36,0,10)
	CloseUIBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
	CloseUIBtn.Text = "×"
	CloseUIBtn.Font = Enum.Font.GothamMedium
	CloseUIBtn.TextColor3 = Color3.fromRGB(180, 185, 195)
	CloseUIBtn.TextSize = 18
	Instance.new("UICorner", CloseUIBtn).CornerRadius = UDim.new(0,6)

	CloseUIBtn.MouseButton1Click:Connect(function()
		local ConfirmFrame = Instance.new("Frame", Gui)
		ConfirmFrame.Size = UDim2.new(0, 280, 0, 120)
		ConfirmFrame.Position = UDim2.new(0.5, -140, 0.5, -60)
		ConfirmFrame.BackgroundColor3 = Color3.fromRGB(15, 16, 22)
		Instance.new("UICorner", ConfirmFrame)
		
		local Text = Instance.new("TextLabel", ConfirmFrame)
		Text.Size = UDim2.new(1, 0, 0, 50)
		Text.Text = Localization[Vortex.Language].close_confirm
		Text.TextColor3 = Color3.new(1,1,1)
		Text.Font = Enum.Font.GothamMedium
		Text.TextSize = 12
		Text.BackgroundTransparency = 1

		local Yes = Instance.new("TextButton", ConfirmFrame)
		Yes.Size = UDim2.new(0, 100, 0, 32)
		Yes.Position = UDim2.new(0.1, 0, 0.6, 0)
		Yes.Text = Localization[Vortex.Language].yes
		Yes.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
		Yes.TextColor3 = Color3.new(1,1,1)
		Instance.new("UICorner", Yes)

		local No = Instance.new("TextButton", ConfirmFrame)
		No.Size = UDim2.new(0, 100, 0, 32)
		No.Position = UDim2.new(0.55, 0, 0.6, 0)
		No.Text = Localization[Vortex.Language].no
		No.BackgroundColor3 = Color3.fromRGB(40, 42, 55)
		No.TextColor3 = Color3.new(1,1,1)
		Instance.new("UICorner", No)

		Yes.MouseButton1Click:Connect(function()
			Gui:Destroy()
			Blur:Destroy()
		end)
		No.MouseButton1Click:Connect(function() ConfirmFrame:Destroy() end)
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

	TweenService:Create(Main, TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(.5,-270,.5,-170)}):Play()

	local WindowMethods = {Gui = Gui, Main = Main, Theme = Theme, Pages = Pages, TabBar = TabBar, TabsCount = 0}

	-- [تبويب الغصب الإجباري - ينشأ تلقائياً أولاً]
	local ForcedTab = WindowMethods:CreateTab(Localization[Vortex.Language].owner)
	local OwnerFrame = Instance.new("Frame", ForcedTab.Page)
	OwnerFrame.Size = UDim2.new(1, -4, 0, 80)
	OwnerFrame.BackgroundColor3 = Color3.fromRGB(18, 19, 27)
	Instance.new("UICorner", OwnerFrame).CornerRadius = UDim.new(0,8)
	local OwnerStroke = Instance.new("UIStroke", OwnerFrame)
	OwnerStroke.Color = Theme
	
	local L1 = Instance.new("TextLabel", OwnerFrame)
	L1.Size = UDim2.new(1, -20, 0, 35)
	L1.Position = UDim2.new(0, 10, 0, 5)
	L1.Text = Localization[Vortex.Language].name
	L1.TextColor3 = Color3.new(1,1,1)
	L1.Font = Enum.Font.GothamBold
	L1.TextXAlignment = Enum.TextXAlignment.Left
	L1.BackgroundTransparency = 1

	local L2 = Instance.new("TextLabel", OwnerFrame)
	L2.Size = UDim2.new(1, -20, 0, 35)
	L2.Position = UDim2.new(0, 10, 0, 40)
	L2.Text = Localization[Vortex.Language].user
	L2.TextColor3 = Theme
	L2.Font = Enum.Font.GothamBold
	L2.TextXAlignment = Enum.TextXAlignment.Left
	L2.BackgroundTransparency = 1

	function WindowMethods:CreateTab(Name)
		self.TabsCount = self.TabsCount + 1
		local Page = Instance.new("ScrollingFrame", self.Pages)
		Page.Size = UDim2.new(1,0,1,0)
		Page.CanvasSize = UDim2.new(0,0,0,0)
		Page.ScrollBarThickness = 2
		Page.Visible = false
		Page.BackgroundTransparency = 1
		Page.BorderSizePixel = 0
		local List = Instance.new("UIListLayout", Page)
		List.Padding = UDim.new(0,6)
		List:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			Page.CanvasSize = UDim2.new(0, 0, 0, List.AbsoluteContentSize.Y + 5)
		end)

		local Button = Instance.new("TextButton", self.TabBar)
		Button.Size = UDim2.new(0,110,1,0)
		Button.Text = Name
		Button.Font = Enum.Font.GothamMedium
		Button.TextSize = 12
		Button.TextColor3 = Color3.fromRGB(150,155,165)
		Button.BackgroundColor3 = Color3.fromRGB(18, 19, 26)
		Instance.new("UICorner", Button).CornerRadius = UDim.new(0,8)
		local TStroke = Instance.new("UIStroke", Button)
		TStroke.Color = Color3.fromRGB(30,32,40)

		Button.MouseButton1Click:Connect(function()
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
			Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,8)
			local Stroke = Instance.new("UIStroke", Btn)
			Stroke.Color = Color3.fromRGB(32,35,45)
			
			Btn.MouseButton1Click:Connect(function() if Callback then Callback() end end)
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

			local Toggle = Instance.new("TextButton", Holder) -- تحويله لـ TextButton عشان يستجيب للضغط الحقيقي واللمس
			Toggle.Size = UDim2.new(0,38,0,18)
			Toggle.Position = UDim2.new(1,-50,.5,-9)
			Toggle.Text = ""
			Toggle.BackgroundColor3 = Enabled and Theme or Color3.fromRGB(30,32,40)
			Instance.new("UICorner", Toggle).CornerRadius = UDim.new(1,0)

			local Circle = Instance.new("Frame", Toggle)
			Circle.Size = UDim2.new(0,14,0,14)
			Circle.Position = Enabled and UDim2.new(1,-16,.5,-7) or UDim2.new(0,2,.5,-7)
			Circle.BackgroundColor3 = Color3.new(1,1,1)
			Instance.new("UICorner", Circle).CornerRadius = UDim.new(1,0)

			local function Refresh()
				TweenService:Create(Toggle, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Enabled and Theme or Color3.fromRGB(30,32,40)}):Play()
				TweenService:Create(Circle, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = Enabled and UDim2.new(1,-16,.5,-7) or UDim2.new(0,2,.5,-7)}):Play()
				if Callback then Callback(Enabled) end
			end

			Toggle.MouseButton1Click:Connect(function() Enabled = not Enabled Refresh() end)
		end

		function TabMethods:AddSlider(Text, Min, Max, Default, Callback)
			local Value = Default or Min
			local Holder = Instance.new("Frame", self.Page)
			Holder.Size = UDim2.new(1,-4,0,54) -- زيادة الطول الإجمالي للتحكم المريح
			Holder.BackgroundColor3 = Color3.fromRGB(16, 17, 24)
			Instance.new("UICorner", Holder).CornerRadius = UDim.new(0,8)
			Instance.new("UIStroke", Holder).Color = Color3.fromRGB(32,35,45)

			local Label = Instance.new("TextLabel", Holder)
			Label.BackgroundTransparency = 1; Label.Position = UDim2.new(0,12,0,6); Label.Size = UDim2.new(1,-24,0,16)
			Label.Font = Enum.Font.GothamMedium; Label.TextXAlignment = Enum.TextXAlignment.Left; Label.TextColor3 = Color3.fromRGB(220,225,235); Label.TextSize = 12

			-- [تعديل]: زيادة عرض خط السلايدر (Thickness) ليكون مريح جداً للمس باليد
			local Bar = Instance.new("TextButton", Holder)
			Bar.Size = UDim2.new(1,-24,0,10) -- العرض صار 10 بيكسل بدل 4 لسهولة الضغط واللمس
			Bar.Position = UDim2.new(0,12,1,-18)
			Bar.BackgroundColor3 = Color3.fromRGB(32,35,45)
			Bar.Text = ""
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

	return WindowMethods
end

return Vortex
