local TextChatService = cloneref(game:GetService("TextChatService"))
local Players = cloneref(game:FindService("Players"))
local lplr = Players.LocalPlayer
local Commands = Instance.new("Folder",TextChatService)

local CreateCommands = {}

local function CreateCommand(Name, PrimaryAlias, Func)
    local command = Instance.new("TextChatCommand",Commands)
    command.Name = Name
    command.PrimaryAlias = PrimaryAlias
    command.Parent = TextChatService

    CreateCommands[Name] = false

    command.Triggered:Connect(function()
        CreateCommands[Name] = not CreateCommands[Name]
        Func()
    end)
end


CreateCommand("Test", ";test", function()
    if CreateCommands["Test"] then
        lplr.Character.Humanoid.WalkSpeed = 90
    else
        lplr.Character.Humanoid.WalkSpeed = 16
    end
end)
