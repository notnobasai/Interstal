local http_request = syn and syn.request or http and http.request or http_request or httprequest
getgenv().InstalledStatus = true

local function getFile(Repo, FileName)
    local options = {
        Method = 'GET',
        Url = "https://api.github.com/repos/pasted0/" .. Repo .. "/contents/" .. FileName,
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

local function updateFile(filePath, repo, fileName)
    if isfile(filePath) and readfile(filePath):match("^[^\r\n]+"):find("-- do not overwrite", 1, true) then
        return
    end
    local fileData = getFile(repo, fileName)
    if fileData and fileData.Body then
        writefile(filePath, fileData.Body)
    end
end

if not isfolder("Inquire") then
    getgenv().InstalledStatus = false
    makefolder("Inquire")
end

local files = {
    "main.lua",
    "installer.lua",
    "init.lua",
    "EntityLibrary.lua"
}

for _, file in next, files do
    updateFile("Inquire/" .. file, "Inquire", file)
end

task.wait()
getgenv().InstalledStatus = getgenv().InstalledStatus and "Installed" or "Installer.lua"

task.wait()
loadstring(game:HttpGet("https://raw.githubusercontent.com/pasted0/Inquire/refs/heads/main/init.lua"))()