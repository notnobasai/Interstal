local http_request = syn and syn.request or http and http.request or http_request or httprequest
 getgenv().InstalledStatus = true
 
 
 local function getFile(Repo, FileName)
   local options = {
     Method = 'GET',
     Url = "https://api.github.com/repos/pasted0/"..Repo.."/contents/"..FileName,
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
 
 
 if not isfolder("Inquire") then
   getgenv().InstalledStatus = false
   makefolder("Inquire")
 end
 
 if not isfile("Inquire/main.lua") then
   getgenv().InstalledStatus = false
   local main = getFile("Inquire", "main.lua")
   if main and main.Body then
     writefile("Inquire/main.lua", main.Body)
   end
   else
     local main = getFile("Inquire", "main.lua")
     if main and main.Body and main.Body ~= readfile("Inquire/main.lua") then
       writefile("Inquire/main.lua", main.Body)
     end
 end
 
 if not isfile("Inquire/installer.lua") then
   getgenv().InstalledStatus = false
   local installer = getFile("Inquire", "installer.lua")
   if installer and installer.Body then
     writefile("Inquire/installer.lua", installer.Body)
   end
   else
     local installer = getFile("Inquire", "installer.lua")
     if installer and installer.Body and installer.Body ~= readfile("Inquire/installer.lua") then
       writefile("Inquire/installer.lua", installer.Body)
     end
 end
 
 if not isfile("Inquire/init.lua") then
   getgenv().InstalledStatus = false
   local init = getFile("Inquire", "init.lua")
   if init and init.Body then
     writefile("Inquire/init.lua", init.Body)
   end
   else
     local init = getFile("Inquire", "init.lua")
     if init and init.Body and init.Body ~= readfile("Inquire/init.lua") then
       writefile("Inquire/init.lua", init.Body)
     end
 end
 
 if not isfile("Inquire/EntityLibrary.lua") then
   getgenv().InstalledStatus = false
   local EntityLibrary = getFile("Inquire", "EntityLibrary.lua")
   if EntityLibrary and EntityLibrary.Body then
     writefile("Inquire/EntityLibrary.lua", EntityLibrary.Body)
   end
   else
     local EntityLibrary = getFile("Inquire", "EntityLibrary.lua")
     if EntityLibrary and EntityLibrary.Body and EntityLibrary.Body ~= readfile("Inquire/EntityLibrary.lua") then
       writefile("Inquire/EntityLibrary.lua", EntityLibrary.Body)
     end
 end
 task.wait()
 if getgenv().InstalledStatus == true then
   getgenv().InstalledStatus = "Installed"
   task.wait()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/pasted0/Inquire/refs/heads/main/init.lua"))()
 else
   getgenv().InstalledStatus = "Installer.lua"
 task.wait()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/pasted0/Inquire/refs/heads/main/init.lua"))()
 end
