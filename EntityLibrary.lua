repeat task.wait() until game:IsLoaded()

local playerService = cloneref(game:FindService("Players"))
local lplr = playerService.LocalPlayer or playerService:GetPropertyChangedSignal("LocalPlayer"):Wait() and playerService.LocalPlayer

local lplrMeta = {
    __index = function(_, key)
        if key == "Root" then
            return lplr.Character and lplr.Character:WaitForChild("HumanoidRootPart")
        elseif key == "Humanoid" then
            return lplr.Character and lplr.Character:FindFirstChildWhichIsA("Humanoid")
        elseif key == "Head" then
            return lplr.Character and lplr.Character:FindFirstChild("Head")
        elseif key == "Torso" then
            return lplr.Character and (lplr.Character:FindFirstChild("Torso") or lplr.Character:FindFirstChild("UpperTorso"))
        elseif lplr[key] ~= nil then
            return lplr[key]
        else
            return nil
        end
    end
}

setmetatable(lplr, lplrMeta)

getgenv().EntityLibrary = {
  ["Players"] = {},
  ["Characters"] = {},
  ["NPCs"] = {},
  ["lplr"] = lplr
}

for _, Characters in next, game.Workspace:GetChildren() do
  if Characters:FindFirstChildWhichIsA("Humanoid") and Characters:IsA("Model") then
    if playerServiceGetPlayerFromCharacter(Characters) ~= nil then
      table.insert(getgenv().EntityLibrary.Characters, Characters)
    else
      table.insert(getgenv().EntityLibrary.NPCs, Characters)
    end
  end
end
