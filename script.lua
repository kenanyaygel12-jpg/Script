-- [[ TOUCH FOOTBALL: REACH FIX & NO-FLY V8.0 ]] --
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "⚽ TOUCH FOOTBALL FIX",
   LoadingTitle = "Reach & Uçma Sorunu Çözüldü",
   LoadingSubtitle = "Kenan Pro Fix",
   ConfigurationSaving = { Enabled = false }
})

-- // AYARLAR
_G.Reach = 15
_G.Power = 60
_G.WalkSpeed = 20
_G.FullInvis = false

local Tab = Window:CreateTab("🎯 Ana Ayarlar", 4483362458)

Tab:CreateSlider({
   Name = "Reach (Menzil)",
   Range = {0, 50},
   Increment = 1,
   CurrentValue = 15,
   Callback = function(v) _G.Reach = v end,
})

-- // KARAKTER AYARLARI (Görünmezlik Dahil)
local PlayerTab = Window:CreateTab("👤 Karakter", 4483362458)

PlayerTab:CreateToggle({
   Name = "Tam Görünmezlik",
   CurrentValue = false,
   Callback = function(v)
       _G.FullInvis = v
       local char = game.Players.LocalPlayer.Character
       if char then
           for _, part in pairs(char:GetDescendants()) do
               if part:IsA("BasePart") or part:IsA("Decal") then
                   part.Transparency = v and 1 or 0
               end
           end
       end
   end,
})

-- // HATASIZ REACH VE FİZİK KONTROLÜ
local lp = game.Players.LocalPlayer
local rs = game:GetService("RunService")

rs.RenderStepped:Connect(function()
    local char = lp.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    local hrp = char.HumanoidRootPart
    char.Humanoid.WalkSpeed = _G.WalkSpeed
    
    -- Karakterin uçmasını engellemek için sadece TOPU hedef alıyoruz
    for _, obj in pairs(workspace:GetDescendants()) do
        -- Topu ismine ve sınıfına göre bul
        if obj:IsA("BasePart") and (obj.Name:lower():find("ball") or obj.Name:lower():find("foot")) then
            local dist = (hrp.Position - obj.Position).Magnitude
            
            -- Eğer top Reach mesafesindeyse
            if dist <= _G.Reach then
                -- Karakterin uçmaması için kuvveti SADECE topa uyguluyoruz
                -- AssemblyLinearVelocity, modern Roblox fizik sistemidir ve uçma yapmaz
                local moveDir = hrp.CFrame.LookVector
                obj.AssemblyLinearVelocity = Vector3.new(moveDir.X * _G.Power, obj.AssemblyLinearVelocity.Y, moveDir.Z * _G.Power)
                
                -- Topun ayağına yapışmasını engelle (Vur ve it mantığı)
                if obj:FindFirstChild("BodyPosition") then obj.BodyPosition:Destroy() end
            end
        end
    end
end)

Rayfield:Notify({Title = "V8.0 AKTİF", Content = "Uçma engellendi, Reach güncellendi!", Duration = 5})
