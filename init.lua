getgenv().InstalledStatus = getgenv().InstalledStatus or "Not Tested"

if getgenv().InstalledStatus == "Installed" then
  loadstring(readfile("Inquire/EntityLibrary.lua"))()
  loadstring(readfile("Inquire/main.lua"))()
elseif getgenv().InstalledStatus == "Not Tested" then
  loadstring(game:HttpGet("https://raw.githubusercontent.com/pasted0/Inquire/refs/heads/main/installer.lua"))()
elseif InstalledStatus == "Installer.lua" then
  loadstring(readfile("Inquire/EntityLibrary.lua"))()
  loadstring(readfile("Inquire/main.lua"))()
end