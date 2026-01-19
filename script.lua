-- [[ TPS: ELITE STRIKER ULTIMATE EDITION - V3.0 ]] --
-- Optimized for iPhone 17 (A19 Pro) & Android Flagships
-- GitHub: https://github.com/kenanyaygel12-jpg/Script

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "⚽ TPS: ELITE ULTIMATE V3.0",
   LoadingTitle = "Kenan Elite Scripting",
   LoadingSubtitle = "iPhone 17 Pro Max Edition",
   ConfigurationSaving = { Enabled = true, FileName = "KenanTPS_Config" },
   Discord = { Enabled = false, Invite = "none", RememberJoins = true },
   KeySystem = false
})

-- // DEĞİŞKENLER VE AYARLAR
_G.Reach = 12
_G.Power = 180
_G.AutoShot = true
_G.InfiniteJump = false
_G.AntiAFK = true
_G.WalkSpeed = 16
_G.JumpPower = 50
_G.Invisibility = false
_G.GK_Mode = false

-- // ANA MENÜ SEKİMESİ
local MainTab = Window:CreateTab("🎯 Forvet Modu", 4483362458)
MainTab:CreateSection("Şut ve Gol Ayarları")

MainTab:CreateToggle({
   Name = "Otomatik Gol Sistemi (Aimbot)",
   CurrentValue = true,
   Callback = function(Value) _G.AutoShot = Value end,
})

MainTab:CreateSlider({
   Name = "Vuruş Menzili (Reach)",
   Range = {0, 50},
   Increment = 1,
   CurrentValue = 12,
   Callback = function(Value) _G.Reach = Value end,
})

MainTab:CreateSlider({
   Name = "Vuruş Gücü (Power)",
   Range = {100, 500},
   Increment = 10,
   CurrentValue = 180,
   Callback = function(Value) _G.Power = Value end,
})

-- // KARAKTER SEKİMESİ
local PlayerTab = Window:CreateTab("👤 Karakter", 4483362458)
PlayerTab:CreateSection("Fiziksel Özellikler")

PlayerTab:CreateSlider({
   Name = "Yürüme Hızı",
   Range = {16, 150},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value) 
       _G.WalkSpeed = Value
       game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value 
   end,
})

PlayerTab:CreateSlider({
   Name = "Zıplama Gücü",
   Range = {50, 200},
   Increment = 5,
   CurrentValue = 50,
   Callback = function(Value) 
       _G.JumpPower = Value
       game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value 
   end,
})

PlayerTab:CreateToggle({
   Name = "Sınırsız Zıplama",
   CurrentValue = false,
   Callback = function(Value) _G.InfiniteJump = Value end,
})

-- // ÖZEL MODLAR SEKİMESİ
local MiscTab = Window:CreateTab("🌟 Özel Modlar", 4483362458)

MiscTab:CreateToggle({
   Name = "Kaleci Modu (Büyük Reach)",
   CurrentValue = false,
   Callback = function(Value) 
       _G.GK_Mode = Value
       if Value then _G.Reach = 40 else _G.Reach = 12 end
   end,
})

MiscTab:CreateButton({
   Name = "Görünmezlik (Invisibility)",
   Callback = function()
       local char = game.Players.LocalPlayer.Character
       for _, v in pairs(char:GetDescendants()) do
           if v:IsA("BasePart") or v:IsA("Decal") then
               v.Transparency = 0.5
           end
       end
       Rayfield:Notify({Title = "Görünmezlik", Content = "Yarı şeffaf oldun kanka!", Duration = 2})
   end,
})

-- // SİSTEM ÇALIŞTIRICILARI (DÖNGÜLER)

-- Infinite Jump Logic
game:GetService("UserInputService").JumpRequest:Connect(function()
    if _G.InfiniteJump then
        game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

-- Anti-AFK Logic
if _G.AntiAFK then
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
end

-- Şut Mekanizması
game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
    if gpe or not _G.AutoShot then return end
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        local p = game.Players.LocalPlayer
        local char = p.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if (v.Name == "Ball" or v.Name:lower():find("ball")) and v:IsA("BasePart") then
                    local dist = (char.HumanoidRootPart.Position - v.Position).Magnitude
                    if dist <= _G.Reach then
                        -- En yakın kaleyi bul
                        local target = game.Workspace:FindFirstChild("Away Goal") or game.Workspace:FindFirstChild("Home Goal")
                        if target then
                            v.Velocity = (target.Position - v.Position).Unit * _G.Power
                            Rayfield:Notify({Title = "GOL!", Content = "Hedefe kitlendi!", Duration = 1})
                        end
                    end
                end
            end
        end
    end
end)

-- WalkSpeed Fix (Karakter ölünce gitmesin diye)
game:GetService("RunService").RenderStepped:Connect(function()
    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = _G.WalkSpeed
    end
end)

Rayfield:Notify({
   Title = "SİSTEM AKTİF",
   Content = "Kenan Elite Hub v3.0 Başarıyla Yüklendi.",
   Duration = 5
})
