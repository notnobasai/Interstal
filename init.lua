print("init")
getgenv().InstalledStatus = getgenv().InstalledStatus or "Not Tested"

if getgenv().InstalledStatus == "Installed" then
task.spawn(function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/notnobasai/Interstal/refs/heads/main/main.lua"))()
end)
task.spawn(function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/notnobasai/Interstal/refs/heads/main/EntityLibrary.lua"))()

end)
elseif getgenv().InstalledStatus == "Not Tested" then
loadstring(game:HttpGet("https://raw.githubusercontent.com/notnobasai/Interstal/refs/heads/main/installer.lua"))()
elseif getgenv().InstalledStatus == "Installer.lua" then
task.spawn(function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/notnobasai/Interstal/refs/heads/main/main.lua"))()
end)
task.spawn(function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/notnobasai/Interstal/refs/heads/main/EntityLibrary.lua"))()
end)
end

