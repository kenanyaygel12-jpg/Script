-- [[ KENANS HUB - MM2 ROLE TRACKER ]] --
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")

local InfoLabel = Instance.new("TextLabel")
InfoLabel.Parent = ScreenGui
InfoLabel.Size = UDim2.new(0, 250, 0, 100)
InfoLabel.Position = UDim2.new(0, 10, 0, 50)
InfoLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
InfoLabel.BackgroundTransparency = 0.5
InfoLabel.TextColor3 = Color3.new(1, 1, 1)
InfoLabel.TextSize = 18
InfoLabel.TextXAlignment = Enum.TextXAlignment.Left

-- ROLLERİ BULMA FONKSİYONU
task.spawn(function()
    while task.wait(1) do
        local mörder = "Bilinmiyor"
        local sheriff = "Bilinmiyor"
        
        for _, p in pairs(game.Players:GetPlayers()) do
            -- Katili Bul (Envanterinde bıçak olan)
            if p.Backpack:FindFirstChild("Knife") or (p.Character and p.Character:FindFirstChild("Knife")) then
                mörder = p.Name
                -- Katili Kırmızı Yap
                if p.Character and not p.Character:FindFirstChild("Highlight") then
                    local h = Instance.new("Highlight", p.Character)
                    h.FillColor = Color3.new(1, 0, 0)
                end
            end
            
            -- Şerifi Bul (Envanterinde silah olan)
            if p.Backpack:FindFirstChild("Gun") or (p.Character and p.Character:FindFirstChild("Gun")) then
                sheriff = p.Name
                -- Şerifi Mavi Yap
                if p.Character and not p.Character:FindFirstChild("Highlight") then
                    local h = Instance.new("Highlight", p.Character)
                    h.FillColor = Color3.new(0, 0, 1)
                end
            end
        end
        
        InfoLabel.Text = " 🔪 KATİL: " .. mörder .. "\n 🎯 ŞERİF: " .. sheriff .. "\n 🛡️ KENANS HUB AKTİF"
    end
end)
