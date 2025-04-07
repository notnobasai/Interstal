repeat task.wait() until game:IsLoaded()

local playerService = cloneref(game:FindService("Players"))
local lplr = playerService.LocalPlayer or playerService:GetPropertyChangedSignal("LocalPlayer"):Wait() and playerService.LocalPlayer

getgenv().EntityLibrary = {
    ["Players"] = {},
    ["Characters"] = {},
    ["NPCs"] = {},
    ["LocalPlayer"] = lplr and lplr.Character or nil
}

getgenv().EntityLibraryLoaded = true

while task.wait(1) do
    for _, Characters in next, cloneref(game:FindService("Workspace")):GetChildren() do
        if Characters:FindFirstChildWhichIsA("Humanoid") and Characters:IsA("Model") then
            local player = playerService:GetPlayerFromCharacter(Characters)
            
            if player then
                if not table.find(getgenv().EntityLibrary.Players, player) then 
                    table.insert(getgenv().EntityLibrary.Players, player)
                end

                player.CharacterRemoving:Connect(function(char)
                    local index = table.find(getgenv().EntityLibrary.Characters, char)
                    if index then
                        table.remove(getgenv().EntityLibrary.Characters, index)
                    end
                end)

                player.CharacterAdded:Connect(function(char)
                    if not table.find(getgenv().EntityLibrary.Characters, char) then
                        table.insert(getgenv().EntityLibrary.Characters, char)
                    end
                end)

                if not table.find(getgenv().EntityLibrary.Characters, Characters) then
                    table.insert(getgenv().EntityLibrary.Characters, Characters)
                end
            else
                if not table.find(getgenv().EntityLibrary.NPCs, Characters) then
                    table.insert(getgenv().EntityLibrary.NPCs, Characters)
                end
            end
        end
    end
end