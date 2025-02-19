-->> VARIABLES <<--
local textChatService = cloneref(game:GetService("TextChatService"))
local tweenService = cloneref(game:GetService("TweenService"))
local playersService = cloneref(game:FindService("Players"))
local CoreGui = cloneref(game:GetService("CoreGui"))
local lplr = playersService.LocalPlayer
local commandsFolder = Instance.new("Folder", textChatService)
local commandPrefix = ";"

local commands = {}
-->> FUNCTIONS <<--
function notif(title, text, duration)
    local ScreenGui = Instance.new("ScreenGui", CoreGui)
    ScreenGui.Name = "G7°£=§`π÷~HS6-86202828-$&#-(2:"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Enabled = true
    local main = Instance.new("Frame", ScreenGui)
    main.Name = "Main"
    main.Size = UDim2.new(0.25, 0, 0.2, 0)
    main.Position = UDim2.new(1, 0, 0.55, 0)

    local titleLabel = Instance.new("TextLabel", main)
    titleLabel.TextWrapped = false
    titleLabel.Size = UDim2.new(1, 0, 1, 0)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Center
    titleLabel.TextYAlignment = Enum.TextYAlignment.Top
    titleLabel.TextScaled = true

    titleLabel.Text = [[
]] .. title .. "\n" .. text

    local notificationTweenInfo = TweenInfo.new(
        0.5,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.In,
        0,
        false
    )
    tweenService:create(main, notificationTweenInfo, { Position = UDim2.new(0.75, 0, 0.55, 0) }):Play()
    task.wait(duration)
    tweenService:create(main, notificationTweenInfo, { Position = UDim2.new(1, 0, 0.55, 0) }):Play()
end

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

-->> COMMANDS <<--
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

notif("Inquire", "Inquire Has Loaded!", 5)
