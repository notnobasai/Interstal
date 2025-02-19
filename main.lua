local function notif(title, text, duration)
    cloneref(game:GetService("StarterGui")):SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration
    })
end

local textChatService = cloneref(game:GetService("TextChatService"))
local playersService = cloneref(game:FindService("Players"))
local lplr = playersService.LocalPlayer
local commandsFolder = Instance.new("Folder", textChatService)
local commandPrefix = ";"

local commands = {}



function createCommand(commandName, commandAlias, callbackFunc)
    local newCommand = Instance.new("TextChatCommand", commandsFolder)
    newCommand.Name = commandName
    newCommand.PrimaryAlias = commandAlias
    newCommand.Parent = textChatService

    commands[commandName] = false

    newCommand.Triggered:Connect(function()
        commands[commandName] = not commands[commandName]
        callbackFunc()
    end)
end

lplr.Chatted:Connect(function(message)
    if message:sub(1, #commandPrefix) == commandPrefix then
        local commandAndArguments = message:sub(#commandPrefix + 1)
        local commandName = commandAndArguments:match("^[%w_]+")
        local commandArguments = commandAndArguments:sub(#commandName + 2)
        
        if commands[commandName] then
            commands[commandName](commandArguments)
        end
    end
end)

createCommand("Prefix", commandPrefix .. "prefix", function(commandArguments)
    if commandArguments and #commandArguments > 0 then
        commandPrefix = commandArguments:match("^%s*(.-)%s*$")
        print("Prefix changed to: " .. commandPrefix)
    else
        print("No new prefix provided.")
    end
end)

createCommand("Reset", commandPrefix .. "reset", function()
    if commands["Reset"] then
        lplr.Character:BreakJoints()
    end
end)

createCommand("Test", commandPrefix .. "test", function()
    if commands["Test"] then
        lplr.Character.Humanoid.WalkSpeed = 90
    else
        lplr.Character.Humanoid.WalkSpeed = 16
    end
end)


notif("Inquire", "Loaded!", 5)
