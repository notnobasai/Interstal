getgenv().InstalledStatus = getgenv().InstalledStatus or "Not Tested"
if getgenv().InstalledStatus == "Installed" then
  task.spawn(function()
    loadstring(readfile("Inquire/EntityLibrary.lua"))
  end)
  task.wait()
  loadstring(readfile("Inquire/main.lua"))()
elseif getgenv().InstalledStatus == "Not Tested" then
  loadstring(game:HttpGet("https://raw.githubusercontent.com/pasted0/Inquire/refs/heads/main/installer.lua"))()
  else
     task.spawn(function()
       loadstring(readfile("Inquire/EntityLibrary.lua"))
     end)
     task.wait()
     loadstring(readfile("Inquire/main.lua"))()
end