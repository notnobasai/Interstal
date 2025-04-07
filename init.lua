getgenv().InstalledStatus = getgenv().InstalledStatus or "Not Tested"

if getgenv().InstalledStatus == "Installed" then
  task.spawn(function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/pasted0/Inquire/refs/heads/main/EntityLibrary.lua"))() 
    task.spawn(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/pasted0/Inquire/refs/heads/main/main.lua"))()
    end)
  end)
elseif getgenv().InstalledStatus == "Not Tested" then
  loadstring(game:HttpGet("https://raw.githubusercontent.com/pasted0/Inquire/refs/heads/main/installer.lua"))()

elseif InstalledStatus == "Installer.lua" then
  task.spawn(function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/pasted0/Inquire/refs/heads/main/EntityLibrary.lua"))() 
    task.spawn(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/pasted0/Inquire/refs/heads/main/main.lua"))()
    end)
  end)
end