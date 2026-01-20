-- [[ KENAN'S ABSOLUTE HUB - MM2 ]] --
local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

-- Eskisini tamamen temizle
if pgui:FindFirstChild("KenanUltraHub") then pgui.KenanUltraHub:Destroy() end

local sg = Instance.new("ScreenGui", pgui)
sg.Name = "KenanUltraHub"
sg.ResetOnSpawn = false

-- ANA PANEL (Daha Büyük ve Daha Belirgin)
local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 220, 0, 320)
frame.Position = UDim2.new(0.05, 0, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
frame.BorderSizePixel = 3
frame.BorderColor3 = Color3.fromRGB(255, 0, 0)
frame.Active = true
frame.Draggable = true

-- BAŞLIK
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
title.Text = "KENAN'S MM2 MENU"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 20
title.Font = Enum.Font.SourceSansBold

-- BUTON YAPICI (Hepsini Alt Alta Dizer)
local function createButton(name, pos, color, callback)
    local btn = Instance.new("TextButton", frame)
    btn.Text = name
    btn.Size = UDim2.new(0.9, 0, 0, 50) -- Butonlar kocaman
    btn.Position = UDim2.new(0.05, 0, 0, pos)
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    btn.BorderSizePixel = 0
    btn.MouseButton1Click:Connect(callback)
    
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 8)
end

-- 1. HIZ BUTONU
createButton("⚡ HIZ: 60", 50, Color3.fromRGB(50, 50, 50), function()
    player.Character.Humanoid.WalkSpeed = 60
end)

-- 2. ESP BUTONU (KNIFE=KIRMIZI, GUN=MAVİ, DİĞER=YEŞİL)
createButton("👁️ ESP AÇ", 110, Color3.fromRGB(50, 50, 50), function()
    task.spawn(function()
        while task.wait(1) do
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= player and p.Character then
                    local h = p.Character:FindFirstChild("Highlight") or Instance.new("Highlight", p.Character)
                    local inv = p.Backpack
                    local char = p.Character
                    
                    if inv:FindFirstChild("Knife") or char:FindFirstChild("Knife") then
                        h.FillColor = Color3.new(1, 0, 0) -- MURDERER
                    elseif inv:FindFirstChild("Gun") or char:FindFirstChild("Gun") or inv:FindFirstChild("Revolver") or char:FindFirstChild("Revolver") then
                        h.FillColor = Color3.new(0, 0, 1) -- SHERIFF
                    else
                        h.FillColor = Color3.new(0, 1, 0) -- INNOCENT
                    end
                end
            end
        end
    end)
end)

-- 3. GÖRÜNMEZLİK (HUMANOID ROOT HARİÇ)
createButton("👻 GÖRÜNMEZ OL", 170, Color3.fromRGB(50, 50, 50), function()
    local char = player.Character
    for _, v in pairs(char:GetDescendants()) do
        if (v:IsA("BasePart") or v:IsA("Decal")) and v.Name ~= "HumanoidRootPart" then
            v.Transparency = (v.Transparency == 1 and 0 or 1)
        end
    end
end)

-- 4. AUTO SHOOT (KATİLE SIK)
createButton("🎯 KATİLE SIK!", 230, Color3.fromRGB(150, 0, 0), function()
    local target = nil
    for _, p in pairs(game.Players:GetPlayers()) do
        if p.Character and (p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife")) then
            target = p.Character.HumanoidRootPart
        end
    end
    
    local gun = player.Character:FindFirstChild("Gun") or player.Backpack:FindFirstChild("Gun") or player.Character:FindFirstChild("Revolver") or player.Backpack:FindFirstChild("Revolver")
    
    if target and gun then
        gun.Parent = player.Character
        task.wait(0.1)
        player.Character.HumanoidRootPart.CFrame = CFrame.new(player.Character.HumanoidRootPart.Position, target.Position)
        gun:Activate()
        local event = gun:FindFirstChild("Shoot") or game:GetService("ReplicatedStorage"):FindFirstChild("Shoot", true)
        if event then event:FireServer(target.Position) end
    end
end)
