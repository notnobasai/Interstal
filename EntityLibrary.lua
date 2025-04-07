repeat task.wait() until game:IsLoaded()

-->> Variables <<--
local playerService = cloneref(game:FindService("Players"))
local lplr = playerService.LocalPlayer or playerService:GetPropertyChangedSignal("LocalPlayer"):Wait() and playerService.LocalPlayer

-->> Entity Library <<--
getgenv().EntityLibrary = {
  ["Players"] = {},
  ["Characters"] = {},
  ["NPCs"] = {},
  ["lplr"] = lplr.Character and {
    ["Root"] = lplr.Character:WaitForChild("HumanoidRootPart"),
    ["Humanoid"] = lplr.Character:FindFirstChildWhichIsA("Humanoid"),
    ["Head"] = lplr.Character:FindFirstChild("Head"),
    ["Torso"] = lplr.Character:FindFirstChild("Torso") or lplr.Character:FindFirstChild("UpperTorso"),
    ["Character"] = lplr.Character
  } or {}
}

-->> For Loops <<--
for _, Characters in next, game.Workspace:GetChildren() do
  if Characters:FindFirstChildWhichIsA("Humanoid") and Characters:IsA("Model") then
    if Characters:GetPlayerFromCharacter() ~= nil then
      table.insert(getgenv().EntityLibrary.Characters, Characters)
    else
      table.insert(getgenv().EntityLibrary.NPCs, Characters)
    end
  end
end