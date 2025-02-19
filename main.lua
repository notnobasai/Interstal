local TextChatService = cloneref(game:GetService("TextChatService"))
local Players = cloneref(game:FindService("Players"))
local lplr = Players.LocalPlayer
local CommandsFolder = Instance.new("Folder", TextChatService)
local prefix = ";"
local Commands = {}

local function CreateCommand(Name, PrimaryAlias, Func)
    local command = Instance.new("TextChatCommand", CommandsFolder)
    command.Name = Name
    command.PrimaryAlias = PrimaryAlias
    command.Parent = TextChatService

    Commands[Name] = false

    command.Triggered:Connect(function()
        Commands[Name] = not Commands[Name]
        Func()
    end)
end

lplr.Chatted:Connect(function(msg)
    if msg:sub(1, #prefix) == prefix then
        local commandAndArgs = msg:sub(#prefix + 1)
        local commandName = commandAndArgs:match("^[%w_]+")
        local arguments = commandAndArgs:sub(#commandName + 2)
        
        if Commands[commandName] then
            Commands[commandName](arguments)
        end
    end
end)

CreateCommand("Prefix", prefix.."prefix", function(arguments)
    if arguments and #arguments > 0 then
        prefix = arguments:match("^%s*(.-)%s*$")
        print("Prefix changed to: " .. prefix)
    else
        print("No new prefix provided.")
    end
end)

CreateCommand("Reset", prefix.."reset", function()
    if Commands["Reset"] then
        lplr.Character:BreakJoints()
    end
end)

CreateCommand("Test", prefix.."test", function()
    if Commands["Test"] then
        lplr.Character.Humanoid.WalkSpeed = 90
    else
        lplr.Character.Humanoid.WalkSpeed = 16
    end
end)
