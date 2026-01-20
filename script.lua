-- [[ KENANS HUB V8.0 - MM2 ULTIMATE ]] --
local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

-- ESKİ GUI VARSA TEMİZLE
if pgui:FindFirstChild("KenanV8") then pgui.KenanV8:Destroy() end

local sg = Instance.new("ScreenGui", pgui)
sg.Name = "KenanV8"

-- ANA PANEL
local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 220, 0, 320)
frame.Position = UDim2.new(0, 15, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Text = "KENAN V8 MM2"
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 18

-- DEĞİŞKENLER (ON/OFF DURUMLARI)
_G.EspAcik = false
_G.GörünmezlikAcik = false

-- BUTON TASARIM FONKSİYONU
local function createToggle(name, pos, callback)
    local btn = Instance.new("TextButton", frame)
    btn.Text = name .. ": OFF"
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, pos)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 16

    local status = false
    btn.MouseButton1Click:Connect(function()
        status = not status
        btn.Text = name .. (status and ": ON" or ": OFF")
        btn.BackgroundColor3 = status and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(50, 50, 50)
        callback(status)
    end)
end

-- 1. HIZ AYARI (60)
createToggle("HIZ (60)", 45, function(state)
    if state then
        player.Character.Humanoid.WalkSpeed = 60
    else
        player.Character.Humanoid.WalkSpeed = 16
    end
end)

-- 2. ESP SİSTEMİ (ON/OFF)
createToggle("ESP", 95, function(state)
    _G.EspAcik = state
    if not state then
        -- ESP Kapatıldığında parlamaları temizle
        for _, p in pairs(game.Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("KenanHighlight") then
                p.Character.KenanHighlight:Destroy()
            end
        end
    end
end)

-- ESP DÖNGÜSÜ
task.spawn(function()
    while task.wait(0.5) do
        if _G.EspAcik then
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= player and p.Character then
                    local h = p.Character:FindFirstChild("KenanHighlight") or Instance.new("Highlight", p.Character)
                    h.Name = "KenanHighlight"
                    h.OutlineColor = Color3.new(1, 1, 1)
                    
                    if p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife") then
                        h.FillColor = Color3.new(1, 0, 0) -- KATİL
                    elseif p.Backpack:FindFirstChild("Gun") or p.Character:FindFirstChild("Gun") then
                        h.FillColor = Color3.new(0, 0, 1) -- ŞERİF
                    else
                        h.FillColor = Color3.new(0, 1, 0) -- MASUM
                    end
                end
            end
        end
    end
end)

-- 3. GÖRÜNMEZLİK (ON/OFF)
createToggle("GÖRÜNMEZ", 145, function(state)
    local char = player.Character
    if char then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") or v:IsA("Decal") then
                v.Transparency = state and 1 or 0
                if v.Name == "HumanoidRootPart" then v.Transparency = 1 end
            end
        end
    end
end)

-- 4. KATİLE SIK (AUTOSHOOT)
local sikBtn = Instance.new("TextButton", frame)
sikBtn.Text = "🔥 KATİLE SIK!"
sikBtn.Size = UDim2.new(0.9, 0, 0, 50)
sikBtn.Position = UDim2.new(0.05, 0, 0, 200)
sikBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
sikBtn.TextColor3 = Color3.new(1, 1, 1)
sikBtn.TextSize = 18

sikBtn.MouseButton1Click:Connect(function()
    local target = nil
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= player and p.Character and (p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife")) then
            target = p.Character.HumanoidRootPart
            break
        end
    end
    if target and (player.Backpack:FindFirstChild("Gun") or player.Character:FindFirstChild("Gun")) then
        local gun = player.Character:FindFirstChild("Gun") or player.Backpack.Gun
        gun.Parent = player.Character
        task.wait(0.1)
        local shootEvent = gun:FindFirstChild("Shoot") or game:GetService("ReplicatedStorage"):FindFirstChild("Shoot", true)
        if shootEvent then
            shootEvent:InvokeServer(target.Position)
            print("Katil Paket Edildi!")
        end
    end
end)

print("Kenans Hub V8.0 AKTİF!")
