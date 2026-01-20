-- [[ KENAN CUSTOM HUB V10 - FULL FIX ]] --
local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

if pgui:FindFirstChild("KenanFinal") then pgui.KenanFinal:Destroy() end

local sg = Instance.new("ScreenGui", pgui)
sg.Name = "KenanFinal"
sg.ResetOnSpawn = false

local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 200, 0, 280)
frame.Position = UDim2.new(0.05, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Active = true
frame.Draggable = true

local function makeBtn(name, pos, color, callback)
    local btn = Instance.new("TextButton", frame)
    btn.Text = name
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, pos)
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.MouseButton1Click:Connect(callback)
    Instance.new("UICorner", btn).CornerRadius = BoxBlurSize.new(0, 6)
end

-- 1. HIZ (60)
makeBtn("HIZI KÖKLE (60)", 40, Color3.fromRGB(70, 70, 70), function()
    player.Character.Humanoid.WalkSpeed = 60
end)

-- 2. ESP (GELİŞMİŞ SİSTEM)
makeBtn("ESP AÇ (FIXED)", 90, Color3.fromRGB(70, 70, 70), function()
    task.spawn(function()
        while true do
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local char = p.Character
                    local h = char:FindFirstChild("KenanHighlight") or Instance.new("Highlight", char)
                    h.Name = "KenanHighlight"
                    
                    -- MM2 Rollerini Bulma (Envanter Taraması)
                    local hasKnife = p.Backpack:FindFirstChild("Knife") or char:FindFirstChild("Knife")
                    local hasGun = p.Backpack:FindFirstChild("Gun") or char:FindFirstChild("Gun") or p.Backpack:FindFirstChild("Revolver") or char:FindFirstChild("Revolver")

                    if hasKnife then
                        h.FillColor = Color3.new(1, 0, 0) -- Katil
                    elseif hasGun then
                        h.FillColor = Color3.new(0, 0, 1) -- Şerif
                    else
                        h.FillColor = Color3.new(0, 1, 0) -- Masum
                    end
                end
            end
            task.wait(2)
        end
    end)
end)

-- 3. GÖRÜNMEZLİK (FIXED)
makeBtn("GÖRÜNMEZ OL", 140, Color3.fromRGB(70, 70, 70), function()
    local char = player.Character
    if char then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") or v:IsA("Decal") then
                v.Transparency = (v.Transparency == 1 and 0 or 1)
                if v.Name == "HumanoidRootPart" then v.Transparency = 1 end
            end
        end
    end
end)

-- 4. KATİLE SIK (REMOTEEVENT TRIGGER)
makeBtn("🔥 KATİLE SIK!", 190, Color3.fromRGB(150, 0, 0), function()
    local target = nil
    for _, p in pairs(game.Players:GetPlayers()) do
        if p.Character and (p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife")) then
            target = p.Character.HumanoidRootPart
        end
    end
    
    local gun = player.Character:FindFirstChild("Gun") or player.Backpack:FindFirstChild("Gun") or player.Character:FindFirstChild("Revolver") or player.Backpack:FindFirstChild("Revolver")
    
    if target and gun then
        gun.Parent = player.Character
        task.wait(0.2)
        -- MM2 Ateş Etme Eventini Bulma
        local event = gun:FindFirstChild("Shoot") or game:GetService("ReplicatedStorage"):FindFirstChild("Shoot", true)
        if event and event:IsA("RemoteEvent") then
            event:FireServer(target.Position)
        elseif event and event:IsA("RemoteFunction") then
            event:InvokeServer(target.Position)
        else
            gun:Activate() -- Eğer event bulunamazsa manuel ateş
        end
    end
end)
