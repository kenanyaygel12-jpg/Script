-- [[ KENAN'S HANDMADE GUI - MM2 ]] --
local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

-- Varsa eskisini temizle
if pgui:FindFirstChild("KenanCustomHub") then pgui.KenanCustomHub:Destroy() end

-- ANA EKRAN
local sg = Instance.new("ScreenGui", pgui)
sg.Name = "KenanCustomHub"
sg.ResetOnSpawn = false

-- ANA PANEL
local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 180, 0, 260)
frame.Position = UDim2.new(0.05, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(255, 0, 0)
frame.Active = true
frame.Draggable = true -- Paneli istediğin yere çekebilirsin

-- BAŞLIK
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
title.Text = "KENAN MM2"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18

-- BUTON YAPICI (KOLAYLIK OLSUN DİYE)
local function makeBtn(name, pos, color, callback)
    local btn = Instance.new("TextButton", frame)
    btn.Name = name
    btn.Text = name
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, pos)
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.BorderSizePixel = 0
    btn.MouseButton1Click:Connect(callback)
    
    -- Kenar yuvarlama (Opsiyonel)
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = ToolSpace.new(0, 8)
end

-- 1. HIZ BUTONU (60)
makeBtn("HIZ: 60", 40, Color3.fromRGB(60, 60, 60), function()
    player.Character.Humanoid.WalkSpeed = 60
    print("Hiz 60!")
end)

-- 2. ESP BUTONU (KATİL/ŞERİF/MASUM)
makeBtn("ESP AÇ", 85, Color3.fromRGB(60, 60, 60), function()
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= player and p.Character then
            local h = p.Character:FindFirstChild("Highlight") or Instance.new("Highlight", p.Character)
            if p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife") then
                h.FillColor = Color3.new(1, 0, 0) -- Katil
            elseif p.Backpack:FindFirstChild("Gun") or p.Character:FindFirstChild("Gun") then
                h.FillColor = Color3.new(0, 0, 1) -- Şerif
            else
                h.FillColor = Color3.new(0, 1, 0) -- Masum
            end
        end
    end
end)

-- 3. GÖRÜNMEZLİK BUTONU
makeBtn("GÖRÜNMEZLİK", 130, Color3.fromRGB(60, 60, 60), function()
    for _, v in pairs(player.Character:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("Decal") then
            v.Transparency = 1
        end
    end
end)

-- 4. KATİLE SIK (SİLAHI ÇEKER VE VURUR)
makeBtn("🔥 KATİLE SIK!", 175, Color3.fromRGB(150, 0, 0), function()
    local target = nil
    for _, p in pairs(game.Players:GetPlayers()) do
        if p.Character and (p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife")) then
            target = p.Character.HumanoidRootPart
        end
    end
    local gun = player.Character:FindFirstChild("Gun") or player.Backpack:FindFirstChild("Gun")
    if target and gun then
        gun.Parent = player.Character
        task.wait(0.2)
        local shoot = gun:FindFirstChild("Shoot") or game:GetService("ReplicatedStorage"):FindFirstChild("Shoot", true)
        if shoot then shoot:InvokeServer(target.Position) end
    end
end)

-- KAPATMA TUŞU
local close = Instance.new("TextButton", frame)
close.Text = "X"
close.Size = UDim2.new(0, 20, 0, 20)
close.Position = UDim2.new(1, -25, 0, 5)
close.BackgroundColor3 = Color3.new(1,0,0)
close.TextColor3 = Color3.new(1,1,1)
close.MouseButton1Click:Connect(function() sg:Destroy() end)
