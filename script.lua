-- [[ TOUCH FOOTBALL: FULL GHOST & HITBOX V7.0 ]] --
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "⚽ TOUCH FOOTBALL ELITE",
   LoadingTitle = "Full Ghost & Touch Fix",
   LoadingSubtitle = "Kenan Ultimate Edition",
   ConfigurationSaving = { Enabled = false }
})

-- // AYARLAR
_G.HitboxLen = 15
_G.PushForce = 60
_G.ShowHitbox = true
_G.WalkSpeed = 20
_G.FullInvis = false

local MainTab = Window:CreateTab("🛡️ Hitbox & Top", 4483362458)

MainTab:CreateSlider({
   Name = "Hitbox Menzili",
   Range = {0, 50},
   Increment = 1,
   CurrentValue = 15,
   Callback = function(v) _G.HitboxLen = v end,
})

-- // KARAKTER MENÜSÜ (TAM GÖRÜNMEZLİK)
local PlayerTab = Window:CreateTab("👤 Karakter", 4483362458)

PlayerTab:CreateToggle({
   Name = "TAM GÖRÜNMEZLİK (Full Invisible)",
   CurrentValue = false,
   Callback = function(v)
       _G.FullInvis = v
       local char = game.Players.LocalPlayer.Character
       if char then
           for _, part in pairs(char:GetDescendants()) do
               if part:IsA("BasePart") or part:IsA("Decal") then
                   -- Eğer aktifse tamamen 1 (Görünmez), değilse 0 (Görünür)
                   part.Transparency = v and 1 or 0
               end
           end
           -- İsmini de gizlemeye çalışır (Sadece sende ve basit korumalarda gözükmez)
           if char:FindFirstChild("Head") and char.Head:FindFirstChild("NameTag") then
                char.Head.NameTag.Enabled = not v
           end
       end
   end,
})

PlayerTab:CreateSlider({
   Name = "Hız",
   Range = {16, 150},
   Increment = 1,
   CurrentValue = 20,
   Callback = function(v) _G.WalkSpeed = v end,
})

-- // TOUCH FOOTBALL ÖZEL DOKUNMA MANTIĞI
local box = Instance.new("Part")
box.Name = "Touch_Hitbox"
box.Anchored = true
box.CanCollide = false
box.Color = Color3.fromRGB(0, 255, 255) -- Farklılık olsun diye Turkuaz yaptım
box.Material = Enum.Material.ForceField
box.Parent = workspace

game:GetService("RunService").RenderStepped:Connect(function()
    local lp = game.Players.LocalPlayer
    local char = lp.Character
    
    if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
        local hrp = char.HumanoidRootPart
        char.Humanoid.WalkSpeed = _G.WalkSpeed
        
        -- Hitbox'ı karakterin önüne sabitle
        box.Size = Vector3.new(15, 8, _G.HitboxLen)
        box.CFrame = hrp.CFrame * CFrame.new(0, 0, -(_G.HitboxLen / 2 + 1))
        box.Transparency = _G.ShowHitbox and 0.8 or 1
        
        -- Touch Football için topu her yerde ara (Workspace ve Players içi)
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and (obj.Name:lower():find("ball") or obj.Name:lower():find("foot")) then
                local mag = (box.Position - obj.Position).Magnitude
                if mag < (_G.HitboxLen / 2 + 3) then
                    -- Topa dokunmayı simüle et ve fırlat
                    obj.AssemblyLinearVelocity = hrp.CFrame.LookVector * _G.PushForce
                    -- Eğer top birine "attach" edildiyse bağını koparmaya zorla
                    if obj:FindFirstChild("BodyPosition") then obj.BodyPosition:Destroy() end
                end
            end
        end
    else
        box.Transparency = 1
    end
end)

Rayfield:Notify({Title = "V7.0 AKTİF", Content = "Touch Football Modu ve Tam Görünmezlik yüklendi.", Duration = 5})
