local http_request = syn and syn.request or http and http.request or http_request or httprequest
getgenv().InstalledStatus = true
local url = "https://api.github.com/repos/pasted0/%s/contents/%s"

local function getFile(Repo, FileName)
  local options = {
    Method = 'GET',
    Url = string.format(url, Repo, FileName),
    Headers = {
      ["Accept"] = "application/vnd.github.v3.raw"
    }
  }
  return http_request(options)
end

local isfile = isfile or function(file)
    local suc, res = pcall(function() return readfile(file) end)
    return suc and res ~= nil and res ~= ''
end

local isfolder = isfolder or function(folder)
    local suc, res = pcall(function() return writefile(folder.."/isfolderComp", "print('apple')") end)
    if res ~= nil and suc == nil then
        return true
    else
        return false
    end
end

if not isfolder("Inquire") then
  getgenv().InstalledStatus = false
  makefolder("Inquire")
end

if not isfile("Inquire/main.lua") then
  getgenv().InstalledStatus = false
  local main = getFile("Inquire/main.lua")
  if main and main.Body then
    writefile("Inquire/main.lua", main.Body)
  end
end

if not isfile("Inquire/installer.lua") then
  getgenv().InstalledStatus = false
  local installer = getFile("Inquire/installer.lua")
  if installer and installer.Body then
    writefile("Inquire/installer.lua", installer.Body)
  end
end

if not isfile("Inquire/init.lua") then
  getgenv().InstalledStatus = false
  local init = getFile("Inquire/init.lua")
  if init and init.Body then
    writefile("Inquire/init.lua", init.Body)
  end
end

if not isfile("Inquire/EntityLibrary.lua") then
  getgenv().InstalledStatus = false
  local EntityLibrary = getFile("Inquire/EntityLibrary.lua")
  if EntityLibrary and EntityLibrary.Body then
    writefile("Inquire/EntityLibrary.lua", EntityLibrary.Body)
  end
end

if getgenv().InstalledStatus == true then
  getgenv().InstalledStatus = "installed"
  task.wait()
  loadstring(getFile("Inquire/init.lua").Body)()
else
  getgenv().InstalledStatus = "Installer.lua"
end