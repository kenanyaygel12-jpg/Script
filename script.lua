-- [[ TPS: ELITE HITBOX & UTILITY V6.0 ]] --
-- Optimized for iPhone 17 & Delta
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "⚽ ELITE HITBOX V6.0",
   LoadingTitle = "Kenan Ultimate System",
   LoadingSubtitle = "Görünmezlik & Hitbox Eklendi",
   ConfigurationSaving = { Enabled = false }
})

-- // AYARLAR
_G.HitboxLen = 12
_G.PushForce = 55
_G.ShowHitbox = true
_G.WalkSpeed = 16
_G.JumpPower = 50
_G.Invisibility = false

-- // ANA MENÜ (HITBOX)
local MainTab = Window:CreateTab("🛡️ Hitbox & Şut", 4483362458)

MainTab:CreateSlider({
   Name = "Hitbox Uzunluğu (Reach)",
   Range = {0, 40},
   Increment = 1,
   CurrentValue = 12,
   Callback = function(v) _G.HitboxLen = v end,
})

MainTab:CreateSlider({
   Name = "Vuruş Gücü",
   Range = {0, 300},
   Increment = 5,
   CurrentValue = 55,
   Callback = function(v) _G.PushForce = v end,
})

MainTab:CreateToggle({
   Name = "Hitboxı Göster (Kırmızı Alan)",
   CurrentValue = true,
   Callback = function(v) _G.ShowHitbox = v end,
})

-- // KARAKTER MENÜSÜ (GÖRÜNMEZLİK & HIZ)
local PlayerTab = Window:CreateTab("👤 Karakter", 4483362458)

PlayerTab:CreateToggle({
   Name = "Görünmezlik (Semi-Invisible)",
   CurrentValue = false,
   Callback = function(v)
       _G.Invisibility = v
       local char = game.Players.LocalPlayer.Character
       if char then
           for _, part in pairs(char:GetDescendants()) do
               if part:IsA("BasePart") or part:IsA("Decal") then
                   part.Transparency = v and 0.7 or 0
               end
           end
       end
   end,
})

PlayerTab:CreateSlider({
   Name = "Yürüme Hızı",
   Range = {16, 120},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(v) _G.WalkSpeed = v end,
})

PlayerTab:CreateButton({
   Name = "Anti-AFK Aktif Et",
   Callback = function()
       local vu = game:GetService("VirtualUser")
       game.Players.LocalPlayer.Idled:Connect(function()
           vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
           wait(1)
           vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
       end)
       Rayfield:Notify({Title = "Anti-AFK", Content = "Artık oyundan atılmayacaksın!", Duration = 2})
   end,
})

-- // SİSTEM DÖNGÜSÜ (RENDERSTEPPED)
local box = Instance.new("Part")
box.Name = "TPS_Hitbox"
box.Anchored = true
box.CanCollide = false
box.Color = Color3.fromRGB(255, 0, 0)
box.Material = Enum.Material.ForceField
box.Parent = workspace

game:GetService("RunService").RenderStepped:Connect(function()
    local lp = game.Players.LocalPlayer
    local char = lp.Character
    
    if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
        local hrp = char.HumanoidRootPart
        local hum = char.Humanoid
        
        -- Hız Ayarı
        hum.WalkSpeed = _G.WalkSpeed
        
        -- Hitbox Konumu
        box.Size = Vector3.new(12, 6, _G.HitboxLen)
        box.CFrame = hrp.CFrame * CFrame.new(0, 0, -(_G.HitboxLen / 2 + 2))
        box.Transparency = _G.ShowHitbox and 0.8 or 1
        
        -- Hitbox Etkileşimi
        local parts = workspace:GetPartBoundsInBox(box.CFrame, box.Size)
        for _, part in pairs(parts) do
            if part:IsA("BasePart") and (part.Name:lower():find("ball") or part.Name:lower():find("foot")) then
                part.AssemblyLinearVelocity = hrp.CFrame.LookVector * _G.PushForce
            end
        end
    else
        box.Transparency = 1
    end
end)

Rayfield:Notify({Title = "V6.0 YÜKLENDİ", Content = "Görünmezlik ve Hitbox aktif kanka!", Duration = 5})
