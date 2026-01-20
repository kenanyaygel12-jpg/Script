-- [[ KENANS HUB - PRO SPEED & GUN ESP ]] --
local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

-- Ekran Yazısı (Gelişmiş)
if pgui:FindFirstChild("KenanPro") then pgui.KenanPro:Destroy() end
local sg = Instance.new("ScreenGui", pgui)
sg.Name = "KenanPro"

local info = Instance.new("TextLabel", sg)
info.Size = UDim2.new(0, 400, 0, 60)
info.Position = UDim2.new(0.5, -200, 0, 10)
info.BackgroundColor3 = Color3.new(0, 0, 0)
info.BackgroundTransparency = 0.4
info.TextColor3 = Color3.new(1, 1, 0) -- Sarı yazı
info.TextSize = 20
info.Text = "KENANS HUB: SİSTEM AKTİF"

-- HIZ AYARI (45 İDEALDİR)
if player.Character and player.Character:FindFirstChild("Humanoid") then
    player.Character.Humanoid.WalkSpeed = 45
end

-- ANA DÖNGÜ
task.spawn(function()
    while task.wait(0.5) do
        local gunDropped = false
        
        -- 1. Yerdeki Silahı Kontrol Et
        local droppedGun = workspace:FindFirstChild("GunDrop")
        if droppedGun then
            gunDropped = true
            -- Silahın yerini parlat
            if not droppedGun:FindFirstChild("GunLight") then
                local highlight = Instance.new("Highlight", droppedGun)
                highlight.Name = "GunLight"
                highlight.FillColor = Color3.new(1, 1, 0) -- Parlak Sarı
                highlight.OutlineColor = Color3.new(1, 1, 1)
            end
        end

        -- 2. Katil ve Şerif Tarama
        local k = "Bilinmiyor"
        local s = "Bilinmiyor"
        for _, p in pairs(game.Players:GetPlayers()) do
            if p.Character then
                if p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife") then
                    k = p.Name
                elseif p.Backpack:FindFirstChild("Gun") or p.Character:FindFirstChild("Gun") then
                    s = p.Name
                end
            end
        end

        -- 3. Yazıyı Güncelle
        if gunDropped then
            info.Text = "⚠️ SİLAH YERDE! KOŞ AL! ⚠️\n🔪 KATİL: " .. k
            info.TextColor3 = Color3.new(1, 0, 0) -- Silah yerdeyse yazı kırmızı olsun
        else
            info.Text = "🔪 KATİL: " .. k .. " | 🎯 ŞERİF: " .. s
            info.TextColor3 = Color3.new(1, 1, 1)
        end
        
        -- Karakter her doğduğunda hızı tekrar ayarla
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = 45
        end
    end
end)
