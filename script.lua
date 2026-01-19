-- 👵 Babaanne Yarı-Aura (SADECE SEN, HASAR YOK)
local Players=game:GetService("Players")
local RS=game:GetService("RunService")
local UIS=game:GetService("UserInputService")
local p=Players.LocalPlayer
local cam=workspace.CurrentCamera
local c=p.Character or p.CharacterAdded:Wait()
local h=c:WaitForChild("Humanoid")
local r=c:WaitForChild("HumanoidRootPart")

------------------------------------------------
-- GUI (Mobil, ölçekli)
------------------------------------------------
local g=Instance.new("ScreenGui",p.PlayerGui); g.ResetOnSpawn=false
local sc=Instance.new("UIScale",g)
local function scale()
	local v=cam.ViewportSize
	sc.Scale=UIS.TouchEnabled and (v.X<700 and .85 or v.X<1000 and .95 or 1.05) or 1
end
scale(); cam:GetPropertyChangedSignal("ViewportSize"):Connect(scale)

local f=Instance.new("Frame",g)
f.Size=UDim2.new(.9,0,.5,0); f.Position=UDim2.new(.05,0,.45,0)
f.BackgroundColor3=Color3.fromRGB(25,25,25); f.Active=true; f.Draggable=true
Instance.new("UICorner",f).CornerRadius=UDim.new(0,16)

local top=Instance.new("Frame",f); top.Size=UDim2.new(1,0,0,40); top.BackgroundTransparency=1
local title=Instance.new("TextLabel",top)
title.Size=UDim2.new(1,-50,1,0); title.Position=UDim2.new(0,10,0,0)
title.Text="👵 Babaanne • Yarı Aura"; title.TextScaled=true; title.TextColor3=Color3.new(1,1,1)
title.BackgroundTransparency=1; title.TextXAlignment=0
local min=Instance.new("TextButton",top)
min.Size=UDim2.new(0,40,0,28); min.Position=UDim2.new(1,-45,.5,-14)
min.Text="-"; min.TextScaled=true; min.BackgroundColor3=Color3.fromRGB(60,60,60)
min.TextColor3=Color3.new(1,1,1); Instance.new("UICorner",min).CornerRadius=UDim.new(0,10)

local grid=Instance.new("UIGridLayout",f)
grid.CellSize=UDim2.new(.45,0,.18,0); grid.CellPadding=UDim2.new(.05,0,.05,0)
grid.StartCorner=Enum.StartCorner.BottomLeft

local function btn(t)
	local b=Instance.new("TextButton",f)
	b.Text=t; b.TextScaled=true; b.BackgroundColor3=Color3.fromRGB(45,45,45)
	b.TextColor3=Color3.new(1,1,1); Instance.new("UICorner",b).CornerRadius=UDim.new(0,12)
	return b
end

local flyB=btn("🕊️ Fly: Kapalı")
local invB=btn("👻 Invis")
local reachB=btn("✋ Reach: Kapalı")
local auraB=btn("🧲 Yarı Aura: Kapalı")

------------------------------------------------
-- 🕊️ Süresiz Uçma
------------------------------------------------
local flying=false; local bv
flyB.MouseButton1Click:Connect(function()
	flying=not flying
	if flying then
		bv=Instance.new("BodyVelocity",r)
		bv.MaxForce=Vector3.new(1e6,1e6,1e6); bv.Velocity=Vector3.new(0,60,0)
		flyB.Text="🕊️ Fly: Açık"
	else
		if bv then bv:Destroy() end; flyB.Text="🕊️ Fly: Kapalı"
	end
end)

------------------------------------------------
-- 👻 Süreli Görünmezlik
------------------------------------------------
local invReady=true
invB.MouseButton1Click:Connect(function()
	if not invReady then return end; invReady=false
	for _,v in pairs(c:GetDescendants()) do if v:IsA("BasePart") then v.Transparency=1 end end
	task.delay(4,function()
		for _,v in pairs(c:GetDescendants()) do if v:IsA("BasePart") then v.Transparency=0 end end
	end)
	task.delay(6,function() invReady=true end)
end)

------------------------------------------------
-- ✋ Süresiz Reach (manuel vurman için)
------------------------------------------------
local reachOn=false; local REACH_STUD=10
reachB.MouseButton1Click:Connect(function()
	reachOn=not reachOn
	for _,v in pairs(c:GetChildren()) do
		if v:IsA("Tool") and v:FindFirstChild("Handle") then
			v.Handle.Size=reachOn and Vector3.new(REACH_STUD,REACH_STUD,REACH_STUD) or Vector3.new(1,1,1)
		end
	end
	reachB.Text=reachOn and "✋ Reach: Açık" or "✋ Reach: Kapalı"
end)

------------------------------------------------
-- 🧲 YARI AURA (VURMAZ)
-- Yakını algılar, kamerayı yumuşak çevirir, uyarı verir
------------------------------------------------
local auraOn=false; local conn
local AURA_RANGE=14

local function closest()
	local d=math.huge; local t=nil
	for _,pl in pairs(Players:GetPlayers()) do
		if pl~=p and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then
			local m=(pl.Character.HumanoidRootPart.Position-r.Position).Magnitude
			if m<d then d=m; t=pl.Character.HumanoidRootPart end
		end
	end
	return t,d
end

auraB.MouseButton1Click:Connect(function()
	auraOn=not auraOn
	auraB.Text=auraOn and "🧲 Yarı Aura: Açık" or "🧲 Yarı Aura: Kapalı"
	if auraOn then
		conn=RS.RenderStepped:Connect(function()
			local t,d=closest()
			if t and d<=AURA_RANGE then
				cam.CFrame=cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position,t.Position),0.18)
				f.BackgroundColor3=Color3.fromRGB(35,25,25) -- yakın uyarı
			else
				f.BackgroundColor3=Color3.fromRGB(25,25,25)
			end
		end)
	else
		if conn then conn:Disconnect() conn=nil end
		f.BackgroundColor3=Color3.fromRGB(25,25,25)
	end
end)

------------------------------------------------
-- Minimize
------------------------------------------------
local mn=false
min.MouseButton1Click:Connect(function()
	mn=not mn
	for _,v in pairs(f:GetChildren()) do
		if v~=top and v~=grid then v.Visible=not mn end
	end
	f.Size=mn and UDim2.new(.9,0,0,40) or UDim2.new(.9,0,.5,0)
	min.Text=mn and "+" or "-"
end)
