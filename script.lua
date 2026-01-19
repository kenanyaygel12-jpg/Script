-- [[ TPS: ELITE STRIKER V3.5 - ABSOLUTE REACH FIX ]] --
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "⚽ ULTIMATE FIX V3.5",
   LoadingTitle = "Kenan Pro Script",
   LoadingSubtitle = "iPhone 17 & Delta Optimized",
   ConfigurationSaving = { Enabled = true, FileName = "EliteUltimate" }
})

_G.Reach = 15
_G.Power = 200
_G.AutoShot = true
_G.WalkSpeed = 25

-- // TOPU BULMA FONKSİYONU (Gelişmiş)
local function FindBall()
    for _, v in pairs(game.Workspace:GetDescendants()) do
        if v:IsA("BasePart") and (v.Name:lower():find("ball") or v.Name:lower():find("foot") or v:FindFirstChild("BallTag")) then
            return v
        end
    end
    return nil
end

local MainTab = Window:CreateTab("🎯 Ana Menü", 4483362458)

MainTab:CreateSlider({
   Name = "Vuruş Menzili (Reach)",
   Range = {0, 50},
   Increment = 1,
   CurrentValue = 15,
   Callback = function(Value) _G.Reach = Value end,
})

MainTab:CreateSlider({
   Name = "Şut Gücü",
   Range = {100, 600},
   Increment = 10,
   CurrentValue = 200,
   Callback = function(Value) _G.Power = Value end,
})

-- // ASIL VURUŞ MEKANİZMASI (REACH BURADA)
game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
    if gpe or not _G.AutoShot then return end
    
    -- Ekrana her dokunduğunda çalışır
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        local p = game.Players.LocalPlayer
        local ball = FindBall()
        
        if ball and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (p.Character.HumanoidRootPart.Position - ball.Position).Magnitude
            
            if dist <= _G.Reach then
                local target = game.Workspace:FindFirstChild("Away Goal") or game.Workspace:FindFirstChild("Home Goal")
                if target then
                    -- 3 FARKLI YÖNTEMLE VUR (Biri mutlaka tutar)
                    local dir = (target.Position - ball.Position).Unit * _G.Power
                    
                    ball.AssemblyLinearVelocity = dir -- Yöntem 1 (Modern)
                    ball.Velocity = dir -- Yöntem 2 (Eski)
                    
                    -- Yöntem 3: Fiziksel itme (BodyVelocity)
                    local bv = Instance.new("BodyVelocity")
                    bv.Velocity = dir
                    bv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
                    bv.Parent = ball
                    game.Debris:AddItem(bv, 0.1)
                    
                    Rayfield:Notify({Title = "GOL!", Content = "Menzil aktif: "..math.floor(dist), Duration = 1})
                end
            end
        end
    end
end)

-- Diğer özellikler (Speed vb.)
local PlayerTab = Window:CreateTab("👤 Karakter", 4483362458)
PlayerTab:CreateSlider({
   Name = "Yürüme Hızı",
   Range = {16, 100},
   Increment = 1,
   CurrentValue = 25,
   Callback = function(v) _G.WalkSpeed = v end,
})

game:GetService("RunService").RenderStepped:Connect(function()
    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = _G.WalkSpeed
    end
end)
