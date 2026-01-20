local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🛡️ KENAN HUB | MM2",
   LoadingTitle = "Rayfield Sistemi Yükleniyor...",
   LoadingSubtitle = "Kenan'ın Adaleti",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "KenanHubMM2",
      FileName = "Ayarlar"
   }
})

local MainTab = Window:CreateTab("🎯 Ana Menü", 4483362458)

-- // HIZ AYARI (60)
MainTab:CreateToggle({
   Name = "Hız Hilesi (60)",
   CurrentValue = false,
   Callback = function(Value)
       _G.SpeedHack = Value
       task.spawn(function()
           while _G.SpeedHack do
               if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                   game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 60
               end
               task.wait(1)
           end
           if not Value then game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16 end
       end)
   end,
})

-- // FULL ESP (Kırmızı-Mavi-Yeşil)
MainTab:CreateToggle({
   Name = "Gelişmiş ESP",
   CurrentValue = false,
   Callback = function(Value)
       _G.FullESP = Value
       while _G.FullESP do
           for _, p in pairs(game.Players:GetPlayers()) do
               if p ~= game.Players.LocalPlayer and p.Character then
                   local h = p.Character:FindFirstChild("Highlight") or Instance.new("Highlight", p.Character)
                   if p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife") then
                       h.FillColor = Color3.fromRGB(255, 0, 0) -- Katil
                   elseif p.Backpack:FindFirstChild("Gun") or p.Character:FindFirstChild("Gun") then
                       h.FillColor = Color3.fromRGB(0, 0, 255) -- Şerif
                   else
                       h.FillColor = Color3.fromRGB(0, 255, 0) -- Masum
                   end
               end
           end
           task.wait(1)
       end
       -- Kapatınca sil
       if not Value then
           for _, p in pairs(game.Players:GetPlayers()) do
               if p.Character and p.Character:FindFirstChild("Highlight") then p.Character.Highlight:Destroy() end
           end
       end
   end,
})

-- // GÖRÜNMEZLİK
MainTab:CreateToggle({
   Name = "Görünmezlik (FE)",
   CurrentValue = false,
   Callback = function(Value)
       local char = game.Players.LocalPlayer.Character
       for _, v in pairs(char:GetDescendants()) do
           if v:IsA("BasePart") or v:IsA("Decal") then
               v.Transparency = Value and 1 or 0
               if v.Name == "HumanoidRootPart" then v.Transparency = 1 end
           end
       end
   end,
})

local CombatTab = Window:CreateTab("⚔️ Savaş", 4483362458)

-- // KATİLE SIK (AUTOSHOOT)
CombatTab:CreateButton({
   Name = "Katile Sık (Silent Aim)",
   Callback = function()
       local target = nil
       for _, p in pairs(game.Players:GetPlayers()) do
           if p.Character and (p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife")) then
               target = p.Character.HumanoidRootPart
           end
       end
       local gun = game.Players.LocalPlayer.Character:FindFirstChild("Gun") or game.Players.LocalPlayer.Backpack:FindFirstChild("Gun")
       if target and gun then
           gun.Parent = game.Players.LocalPlayer.Character
           task.wait(0.2)
           local shoot = gun:FindFirstChild("Shoot") or game:GetService("ReplicatedStorage"):FindFirstChild("Shoot", true)
           if shoot then shoot:InvokeServer(target.Position) end
           Rayfield:Notify({Title = "İnfaz", Content = "Katile ateş edildi!", Duration = 3})
       end
   end,
})

Rayfield:Notify({Title = "Yüklendi!", Content = "Kenan Hub V9.0 Hazır kanka!", Duration = 5})
