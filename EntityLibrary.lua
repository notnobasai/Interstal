repeat task.wait() until game:IsLoaded()

local playerService = cloneref(game:FindService("Players"))
local lplr = playerService.LocalPlayer or playerService:GetPropertyChangedSignal("LocalPlayer"):Wait() and playerService.LocalPlayer



getgenv().EntityLibrary = {
  ["Players"] = {},
  ["Characters"] = {},
  ["NPCs"] = {},
  ["lplr"] = lplr
}
while task.wait(15) do
for _, Characters in next, game.Workspace:GetChildren() do
  if Characters:FindFirstChildWhichIsA("Humanoid") and Characters:IsA("Model") then
    if playerService:GetPlayerFromCharacter(Characters) ~= nil then
      table.insert(getgenv().EntityLibrary.Characters, Characters)
    else
      table.insert(getgenv().EntityLibrary.NPCs, Characters)
    end
  end
end
end
