-- [[ KENAN'S REPAIRED HUB - V12 ]] --
local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

if pgui:FindFirstChild("KenanFix") then pgui.KenanFix:Destroy() end

local sg = Instance.new("ScreenGui", pgui)
sg.Name = "KenanFix"

local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 220, 0, 300)
main.Position = UDim2.new(0.05, 0, 0.2, 0)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.Active = true
main.Draggable = true

-- KAYDIRMA ALANI (Butonlar kaybolmasın diye)
local scroll = Instance.new("ScrollingFrame", main)
scroll.Size = UDim2.new(1, 0, 1, -40)
scroll.Position = UDim2.new(0, 0, 0, 40)
scroll.CanvasSize = UDim2.new(0, 0, 0, 450) -- Aşağı kayabilir
scroll.ScrollBarThickness = 5
scroll.BackgroundTransparency = 1

local title = Instance.new("TextLabel", main)
title.Text = "KENAN PRO HUB"
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
title.TextColor3 = Color3.new(1,1,1)

local function addBtn(name, yPos, color, func)
    local b = Instance.new("TextButton", scroll)
    b.Text = name
    b.Size = UDim2.new(0.9, 0, 0, 45)
    b.Position = UDim2.new(0.05, 0, 0, yPos)
    b.BackgroundColor3 = color
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 16
    b.MouseButton1Click:Connect(func)
    Instance.new("UICorner", b)
end

-- 1. HIZ
addBtn("HIZI KÖKLE (60)", 10, Color3.fromRGB(50, 50, 50), function()
    player.Character.Humanoid.WalkSpeed = 60
end)

-- 2. ESP (Backpack Kontrollü)
addBtn("ESP: ROLLERİ GÖR", 65, Color3.fromRGB(50, 50, 50), function()
    task.spawn(function()
        while task.wait(1) do
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= player and p.Character then
                    local h = p.Character:FindFirstChild("Highlight") or Instance.new("Highlight", p.Character)
                    if p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife") then
                        h.FillColor = Color3.new(1, 0, 0) -- Murderer
                    elseif p.Backpack:FindFirstChild("Gun") or p.Backpack:FindFirstChild("Revolver") or p.Character:FindFirstChild("Gun") then
                        h.FillColor = Color3.new(0, 0, 1) -- Sheriff
                    else
                        h.FillColor = Color3.new(0, 1, 0) -- Innocent
                    end
                end
            end
        end
    end)
end)

-- 3. GÖRÜNMEZLİK
addBtn("GÖRÜNMEZ OL", 120, Color3.fromRGB(50, 50, 50), function()
    for _, v in pairs(player.Character:GetDescendants()) do
        if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
            v.Transparency = (v.Transparency == 1 and 0 or 1)
        end
    end
end)

-- 4. AUTO SHOOT
addBtn("🎯 KATİLE SIK!", 175, Color3.fromRGB(180, 0, 0), function()
    local target = nil
    for _, p in pairs(game.Players:GetPlayers()) do
        if p.Character and (p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife")) then
            target = p.Character.HumanoidRootPart
        end
    end
    local gun = player.Character:FindFirstChild("Gun") or player.Backpack:FindFirstChild("Gun") or player.Backpack:FindFirstChild("Revolver")
    if target and gun then
        gun.Parent = player.Character
        task.wait(0.1)
        player.Character.HumanoidRootPart.CFrame = CFrame.new(player.Character.HumanoidRootPart.Position, target.Position)
        gun:Activate()
    end
end)
