-- [[ TPS: ELITE STRIKER V3.1 - FIX EDITION ]] --
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "⚽ FIX: ELITE STRIKER",
   LoadingTitle = "Kenan Hata Giderildi!",
   LoadingSubtitle = "iPhone 17 & Delta Fix",
   ConfigurationSaving = { Enabled = true, FileName = "EliteFix" }
})

_G.Reach = 15 -- Menzili biraz artırdım garanti olsun
_G.Power = 200
_G.AutoShot = true

local Tab = Window:CreateTab("🎯 Forvet Modu", 4483362458)

-- // YENİLENMİŞ VURUŞ MANTIĞI (DEBUG İÇERİR)
local function GetBall()
    for _, v in pairs(game.Workspace:GetDescendants()) do
        -- Sadece isme bakma, topun fiziksel özelliklerini kontrol et
        if v:IsA("BasePart") and (v.Name:lower():find("ball") or v.Name:lower():find("football")) then
            return v
        end
    end
    return nil
end

game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
    if gpe or not _G.AutoShot then return end
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        local p = game.Players.LocalPlayer
        local ball = GetBall()
        
        if ball and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (p.Character.HumanoidRootPart.Position - ball.Position).Magnitude
            
            if dist <= _G.Reach then
                -- KALEYİ DAHA AGRESİF BUL
                local target = game.Workspace:FindFirstChild("Away Goal") or game.Workspace:FindFirstChild("Home Goal")
                if target then
                    -- ESKİ VELOCITY YERİNE DAHA GÜÇLÜ VEKTÖR
                    ball.AssemblyLinearVelocity = (target.Position - ball.Position).Unit * _G.Power
                    Rayfield:Notify({Title = "VURULDU!", Content = "Menzil: "..math.floor(dist), Duration = 1})
                end
            end
        end
    end
end)

-- Tab ayarlarını buraya (Reach slider vb.) aynen ekle...
Tab:CreateSlider({
   Name = "Vuruş Menzili",
   Range = {0, 50},
   Increment = 1,
   CurrentValue = 15,
   Callback = function(Value) _G.Reach = Value end,
})
