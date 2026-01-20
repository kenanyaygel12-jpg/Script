-- [[ KENANS HUB V7.0 - ULTRA MM2 ]] --
local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

-- ESKİSİNİ SİL
if pgui:FindFirstChild("KenanUltra") then pgui.KenanUltra:Destroy() end

-- GUI OLUŞTURMA
local sg = Instance.new("ScreenGui", pgui)
sg.Name = "KenanUltra"

local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 200, 0, 280)
frame.Position = UDim2.new(0, 10, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Text = "KENAN MM2 HUB"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
title.TextColor3 = Color3.new(1, 1, 1)

-- HIZ AYARI (45)
player.Character.Humanoid.WalkSpeed = 45

-- BUTON YAPICI FONKSİYON
local function createBtn(name, pos, callback)
    local btn = Instance.new("TextButton", frame)
    btn.Text = name
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, pos)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- ESP SİSTEMİ (KATİL: KIRMIZI, ŞERİF: MAVİ, MASUM: YEŞİL)
task.spawn(function()
    while task.wait(1) do
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= player and p.Character then
                local highlight = p.Character:FindFirstChild("Highlight") or Instance.new("Highlight", p.Character)
                if p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife") then
                    highlight.FillColor = Color3.new(1, 0, 0) -- KATİL
                elseif p.Backpack:FindFirstChild("Gun") or p.Character:FindFirstChild("Gun") then
                    highlight.FillColor = Color3.new(0, 0, 1) -- ŞERİF
                else
                    highlight.FillColor = Color3.new(0, 1, 0) -- MASUM
                end
            end
        end
    end
end)

-- GÖRÜNMEZLİK (FE Invisible)
createBtn("Görünmezlik", 40, function()
    local char = player.Character
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("Decal") then
            v.Transparency = 1
        end
    end
    print("Görünmezlik Aktif!")
end)

-- KATİLE SIK (SILENT AIM)
createBtn("Katile Sık!", 85, function()
    local target = nil
    for _, p in pairs(game.Players:GetPlayers()) do
        if p.Backpack:FindFirstChild("Knife") or (p.Character and p.Character:FindFirstChild("Knife")) then
            target = p.Character
        end
    end
    
    if target and player.Character:FindFirstChild("Gun") then
        -- Katile doğru otomatik nişan al ve ateş et
        player.Character.HumanoidRootPart.CFrame = CFrame.new(player.Character.HumanoidRootPart.Position, target.HumanoidRootPart.Position)
        print("Katile nişan alındı!")
        -- Not: Bazı executorlar Mouse1 click simülasyonu ister
    else
        print("Ya elinde silah yok ya da katil bulunamadı!")
    end
end)

createBtn("Hızı 45 Yap", 130, function()
    player.Character.Humanoid.WalkSpeed = 45
end)

createBtn("Karakter Reset", 175, function()
    player.Character:BreakJoints()
end)

print("Kenans Hub V7.0 Yüklendi!")
