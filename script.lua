-- [[ KENANS HUB - FULL ESP & TRACKER ]] --
local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

-- Ekran Yazısı (Tracker)
if pgui:FindFirstChild("KenanTracker") then pgui.KenanTracker:Destroy() end
local sg = Instance.new("ScreenGui", pgui)
sg.Name = "KenanTracker"

local label = Instance.new("TextLabel", sg)
label.Size = UDim2.new(0, 300, 0, 40)
label.Position = UDim2.new(0.5, -150, 0, 10)
label.BackgroundColor3 = Color3.new(0,0,0)
label.BackgroundTransparency = 0.5
label.TextColor3 = Color3.new(1,1,1)
label.Text = "KENANS HUB: ROLLER TARANIYOR..."

-- ESP VE TAKİP DÖNGÜSÜ
task.spawn(function()
    while task.wait(1) do
        local katilIsim = "Yok"
        local serifIsim = "Yok"

        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                
                -- Katili Belirle (Bıçak Kontrolü)
                if p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife") then
                    katilIsim = p.Name
                    -- Kırmızı ESP ekle
                    if not p.Character:FindFirstChild("KenanESP") then
                        local esp = Instance.new("Highlight", p.Character)
                        esp.Name = "KenanESP"
                        esp.FillColor = Color3.new(1, 0, 0) -- Kırmızı
                        esp.OutlineColor = Color3.new(1, 1, 1)
                        esp.FillTransparency = 0.5
                    end
                
                -- Şerifi Belirle (Silah Kontrolü)
                elseif p.Backpack:FindFirstChild("Gun") or p.Character:FindFirstChild("Gun") then
                    serifIsim = p.Name
                    -- Mavi ESP ekle
                    if not p.Character:FindFirstChild("KenanESP") then
                        local esp = Instance.new("Highlight", p.Character)
                        esp.Name = "KenanESP"
                        esp.FillColor = Color3.new(0, 0, 1) -- Mavi
                        esp.OutlineColor = Color3.new(1, 1, 1)
                        esp.FillTransparency = 0.5
                    end
                
                -- Masum ESP (Opsiyonel - Yeşil)
                else
                    if not p.Character:FindFirstChild("KenanESP") then
                        local esp = Instance.new("Highlight", p.Character)
                        esp.Name = "KenanESP"
                        esp.FillColor = Color3.new(0, 1, 0) -- Yeşil
                        esp.FillTransparency = 0.8 -- Masumlar daha silik olsun
                    end
                end
            end
        end
        label.Text = "🔪 KATİL: " .. katilIsim .. " | 🎯 ŞERİF: " .. serifIsim
    end
end)
