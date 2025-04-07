local http_request = syn and syn.request or http and http.request or http_request or httprequest
getgenv().InstalledStatus = true

local function getFile(Repo, FileName)
  local options = {
    Method = 'GET',
    Url = string.format("https://api.github.com/repos/pasted0/%s/contents/%s", Repo, FileName),
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

if not isfile("Inquire/init.lua") then
  getgenv().InstalledStatus = false
  local init = getFile("Inquire/init.lua")
  if init and init.Body then
    writefile("Inquire/init.lua" .. init.Body)
  end
end

if not isfile("Inquire/main.lua") then
  getgenv().InstalledStatus = false
  local main = getFile("Inquire/main.lua")
  if main and main.Body then
    writefile("Inquire/main.lua" .. main.Body)
  end
end
-->> il add entity lib support later since im lazy :face_tongue: <<--

getgenv().InstalledStatus = "Installer.lua"

loadstring(getFile("Inquire/init.lua"))

