-- [[ KENANS HUB V6.0 - MM2 EDITION ]] --
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🛡️ KENANS HUB | MM2",
   LoadingTitle = "Katil Aranıyor...",
   LoadingSubtitle = "Kenan'ın Adaleti",
   ConfigurationSaving = { Enabled = true, FileName = "KenanMM2" }
})

local MainTab = Window:CreateTab("🎯 Ana Özellikler", 4483362458)

-- // KATİL VE ŞERİF ESP
MainTab:CreateToggle({
   Name = "Oyuncu ESP (Rolleri Gör)",
   CurrentValue = false,
   Callback = function(v)
       _G.MM2ESP = v
       while _G.MM2ESP do
           for _, plr in pairs(game.Players:GetPlayers()) do
               if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                   local b = plr.Character:FindFirstChild("Highlight") or Instance.new("Highlight", plr.Character)
                   if plr.Backpack:FindFirstChild("Knife") or plr.Character:FindFirstChild("Knife") then
                       b.FillColor = Color3.new(1, 0, 0) -- Katil KIRMIZI
                   elseif plr.Backpack:FindFirstChild("Gun") or plr.Character:FindFirstChild("Gun") then
                       b.FillColor = Color3.new(0, 0, 1) -- Şerif MAVİ
                   else
                       b.FillColor = Color3.new(0, 1, 0) -- Masum YEŞİL
                   end
               end
           end
           task.wait(1)
       end
   end,
})

-- // OTOMATİK COIN TOPLAMA
MainTab:CreateButton({
   Name = "Otomatik Altın Topla (Coin Farm)",
   Callback = function()
       Rayfield:Notify({Title = "Farm Başladı", Content = "Altınlar ayağına geliyor!", Duration = 3})
       -- Bu özellik karakterini gizlice coinlere ışınlar
       task.spawn(function()
           while true do
               for _, coin in pairs(game:GetService("Workspace"):GetChildren()) do
                   if coin.Name == "Coin_Collector" then
                       game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = coin.CFrame
                       task.wait(0.1)
                   end
               end
               task.wait(0.5)
           end
       end)
   end,
})

-- // SİLAHI OTOMATİK AL (Şerif Ölünce)
MainTab:CreateToggle({
   Name = "Yerdeki Silahı Otomatik Al",
   CurrentValue = false,
   Callback = function(v)
       _G.AutoGun = v
       task.spawn(function()
           while _G.AutoGun do
               local gun = game:GetService("Workspace"):FindFirstChild("GunDrop")
               if gun then
                   game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = gun.CFrame
               end
               task.wait(0.5)
           end
       end)
   end,
})
