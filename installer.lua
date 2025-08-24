local http_request = syn and syn.request or http and http.request or http_request or httprequest
 getgenv().InstalledStatus = true
 
 
 local function getFile(Repo, FileName)
   local options = {
     Method = 'GET',
     Url = "https://api.github.com/repos/notnobasai/"..Repo.."/contents/"..FileName,
     Headers = {
       ["Accept"] = "application/vnd.github.v3.raw"
     }
   }
   return http_request(options)
 end
 
 
 
 local function isfile(file)
     local suc, res = pcall(function() return readfile(file) end)
     return suc and res ~= nil and res ~= ''
 end
 
 local function isfolder(folder)
     local suc, res = pcall(function() return listfiles(folder) end)
     return suc and type(res) == "table" and #res > 0
 end
 
 
 if not isfolder("Interstal") then
   getgenv().InstalledStatus = false
   makefolder("Interstal")
 end
 
 if not isfile("Interstal/main.lua") then
   getgenv().InstalledStatus = false
   local main = getFile("Interstal", "main.lua")
   if main and main.Body then
     writefile("Interstal/main.lua", main.Body)
   end
   else
     local main = getFile("Interstal", "main.lua")
     if main and main.Body and main.Body ~= readfile("Interstal/main.lua") then
       writefile("Interstal/main.lua", main.Body)
     end
 end
 
 if not isfile("Interstal/installer.lua") then
   getgenv().InstalledStatus = false
   local installer = getFile("Interstal", "installer.lua")
   if installer and installer.Body then
     writefile("Interstal/installer.lua", installer.Body)
   end
   else
     local installer = getFile("Interstal", "installer.lua")
     if installer and installer.Body and installer.Body ~= readfile("Interstal/installer.lua") then
       writefile("Interstal/installer.lua", installer.Body)
     end
 end
 
 if not isfile("Interstal/init.lua") then
   getgenv().InstalledStatus = false
   local init = getFile("Interstal", "init.lua")
   if init and init.Body then
     writefile("Interstal/init.lua", init.Body)
   end
   else
     local init = getFile("Interstal", "init.lua")
     if init and init.Body and init.Body ~= readfile("Interstal/init.lua") then
       writefile("Interstal/init.lua", init.Body)
     end
 end
 
 if not isfile("Interstal/EntityLibrary.lua") then
   getgenv().InstalledStatus = false
   local EntityLibrary = getFile("Interstal", "EntityLibrary.lua")
   if EntityLibrary and EntityLibrary.Body then
     writefile("Interstal/EntityLibrary.lua", EntityLibrary.Body)
   end
   else
     local EntityLibrary = getFile("Interstal", "EntityLibrary.lua")
     if EntityLibrary and EntityLibrary.Body and EntityLibrary.Body ~= readfile("Interstal/EntityLibrary.lua") then
       writefile("Interstal/EntityLibrary.lua", EntityLibrary.Body)
     end
 end
 task.wait()
 if getgenv().InstalledStatus == true then
   getgenv().InstalledStatus = "Installed"
   task.wait()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/notnobasai/Interstal/refs/heads/main/init.lua"))()
 else
   getgenv().InstalledStatus = "Installer.lua"
 task.wait()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/pasted0/Inquire/refs/heads/main/init.lua"))()
 end
