-- [[ TPS: DIRECTIONAL HITBOX V5.0 ]] --
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "⚽ HITBOX SYSTEM V5.0",
   LoadingTitle = "Kenan Hitbox Fix",
   LoadingSubtitle = "iPhone 17 & Delta",
   ConfigurationSaving = { Enabled = false }
})

_G.HitboxLen = 10 -- Hitbox Uzunluğu
_G.HitboxWidth = 10 -- Hitbox Genişliği
_G.PushForce = 50 -- İtme Gücü
_G.ShowHitbox = true -- Hitbox'ı görmek için

local Tab = Window:CreateTab("🛡️ Hitbox Ayar", 4483362458)

Tab:CreateSlider({
   Name = "Hitbox Uzunluğu (Öne Doğru)",
   Range = {0, 30},
   Increment = 1,
   CurrentValue = 10,
   Callback = function(v) _G.HitboxLen = v end,
})

Tab:CreateToggle({
   Name = "Hitbox Görünürlüğü",
   CurrentValue = true,
   Callback = function(v) _G.ShowHitbox = v end,
})

-- // HITBOX OLUŞTURMA VE TAKİP
local lp = game.Players.LocalPlayer
local rs = game:GetService("RunService")

-- Görsel Hitbox (Kırmızı kutu)
local box = Instance.new("Part")
box.Name = "TPS_Hitbox"
box.Anchored = true
box.CanCollide = false
box.Color = Color3.fromRGB(255, 0, 0)
box.Material = Enum.Material.ForceField
box.Parent = workspace

rs.RenderStepped:Connect(function()
    local char = lp.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local hrp = char.HumanoidRootPart
        
        -- Hitbox'ı karakterin önüne yerleştir
        box.Size = Vector3.new(_G.HitboxWidth, 6, _G.HitboxLen)
        box.CFrame = hrp.CFrame * CFrame.new(0, 0, -(_G.HitboxLen / 2 + 2))
        box.Transparency = _G.ShowHitbox and 0.8 or 1
        
        -- Hitbox içindeki objeleri kontrol et
        local parts = workspace:GetPartBoundsInBox(box.CFrame, box.Size)
        for _, part in pairs(parts) do
            if part:IsA("BasePart") and (part.Name:lower():find("ball") or part.Name:lower():find("foot")) then
                -- Hitbox'a değen topu 1 stud değil, baktığın yöne fırlatır
                part.AssemblyLinearVelocity = hrp.CFrame.LookVector * _G.PushForce
            end
        end
    else
        box.Transparency = 1
    end
end)

Rayfield:Notify({Title = "SİSTEM HAZIR", Content = "Önünde kırmızı bir alan belirecek, ona değen top gider!", Duration = 5})
