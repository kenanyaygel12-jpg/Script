-- [[ KENANS HUB V1.3 - THE ULTIMATE LOADER ]] --
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Kenan'a Özel Giriş Ekranı
local Window = Rayfield:CreateWindow({
   Name = "🛡️ KENANS HUB | SUPREME",
   LoadingTitle = "Sistem Deşifre Ediliyor...",
   LoadingSubtitle = "Kenan v Voidware",
   ConfigurationSaving = { Enabled = false }
})

local MainTab = Window:CreateTab("🌌 Evrensel Hile", 4483362458)

MainTab:CreateButton({
   Name = "VOIDWARE NEW V2 MOTORUNU BAŞLAT",
   Callback = function()
       -- Senin bulduğun o en güncel commitli linki buraya gömdük
       local commit = "4440dc446a396fcb19f17705bbdf3a453990d5f8"
       loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/"..commit.."/newnightsintheforest.lua", true))()
       
       Rayfield:Notify({
          Title = "BAŞARILI!",
          Content = "Kenans Hub en güncel motoru ateşledi.",
          Duration = 5
       })
   end,
})

local DebugTab = Window:CreateTab("🛠️ Sistem", 4483362458)
DebugTab:CreateLabel("Executor Güvenlik Durumu: " .. (identifyexecutor and identifyexecutor() or "Bilinmiyor"))
DebugTab:CreateLabel("Kenan Network Owner: Aktif")
