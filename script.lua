-- [[ KENANS HUB - REMOTE SNIFFER V1 ]] --
print("--- [ KENAN EVENT TARAMASI BAŞLADI ] ---")

local function hookRemote(remote)
    if remote:IsA("RemoteEvent") then
        print("🔥 YAKALANDI: " .. remote.Name .. " | Yolu: " .. remote:GetFullName())
    elseif remote:IsA("RemoteFunction") then
        print("💎 FONKSİYON: " .. remote.Name .. " | Yolu: " .. remote:GetFullName())
    end
end

-- Mevcutları tara
for _, v in pairs(game:GetDescendants()) do
    pcall(function() hookRemote(v) end)
end

-- Yeni eklenenleri anlık yakala (Backdoor sızıntısı için)
game.DescendantAdded:Connect(function(v)
    pcall(function() hookRemote(v) end)
end)

print("--- [ GEZİNMEYE BAŞLA, BULDUKLARINI BANA AT ] ---")
