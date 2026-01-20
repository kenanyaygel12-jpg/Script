-- [[ KENAN PRO MM2 HUB ]] --
local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

if pgui:FindFirstChild("KenanProHub") then pgui.KenanProHub:Destroy() end

local sg = Instance.new("ScreenGui", pgui)
sg.Name = "KenanProHub"

local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 200, 0, 280)
frame.Position = UDim2.new(0.05, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.Active = true
frame.Draggable = true

local function makeBtn(name, pos, callback)
    local btn = Instance.new("TextButton", frame)
    btn.Text = name
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, pos)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.MouseButton1Click:Connect(callback)
    Instance.new("UICorner", btn)
end

-- 1. HIZ (60)
makeBtn("HIZ: 60", 40, function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 60
    end
end)

-- 2. ESP (KNIFE = KIRMIZI, GUN/REVOLVER = MAVİ, DİĞERİ = YEŞİL)
makeBtn("ESP AÇ", 90, function()
    task.spawn(function()
        while true do
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= player and p.Character then
                    local h = p.Character:FindFirstChild("Highlight") or Instance.new("Highlight", p.Character)
                    h.OutlineTransparency = 0
                    h.FillTransparency = 0.5
                    
                    -- Backpack ve Karakter Taraması
                    local isMurder = p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife")
                    local isSheriff = p.Backpack:FindFirstChild("Gun") or p.Character:FindFirstChild("Gun") or p.Backpack:FindFirstChild("Revolver") or p.Character:FindFirstChild("Revolver")

                    if isMurder then
                        h.FillColor = Color3.new(1, 0, 0) -- KIRMIZI
                    elseif isSheriff then
                        h.FillColor = Color3.new(0, 0, 1) -- MAVİ
                    else
                        h.FillColor = Color3.new(0, 1, 0) -- YEŞİL
                    end
                end
            end
            task.wait(1)
        end
    end)
end)

-- 3. GÖRÜNMEZLİK (HUMANOID TRANSPARENCY)
makeBtn("GÖRÜNMEZLİK", 140, function()
    local char = player.Character
    if char then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") or v:IsA("Decal") then
                if v.Name ~= "HumanoidRootPart" then
                    v.Transparency = (v.Transparency == 1 and 0 or 1)
                end
            end
        end
    end
end)

-- 4. AUTO SHOOT (KATİLE DOĞRU TIKLA)
makeBtn("🔥 KATİLE SIK!", 190, function()
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
        -- Katilin pozisyonuna kilitlen ve tıkla
        player.Character.HumanoidRootPart.CFrame = CFrame.new(player.Character.HumanoidRootPart.Position, target.Position)
        gun:Activate() -- Otomatik tıklar/ateş eder
        
        -- MM2 RemoteEvent Tetikleme (Garantilemek için)
        local event = gun:FindFirstChild("Shoot") or game:GetService("ReplicatedStorage"):FindFirstChild("Shoot", true)
        if event then
            if event:IsA("RemoteEvent") then event:FireServer(target.Position) end
        end
    end
end)
