


repeat task.wait() until game:IsLoaded()
-->> VARIABLES <<--
local textChatService = cloneref(game:GetService("TextChatService"))
local tweenService = cloneref(game:GetService("TweenService"))
local playersService = cloneref(game:FindService("Players"))
local CoreGui = cloneref(game:GetService("CoreGui"))
local lplr = playersService.LocalPlayer
local whitelist = {}
local prefix = ";"

local commands = {
    ["rejoin"] = function()
        notif("Rejoin:", "Rejoining Server", 3)
        cloneref(game:GetService("TeleportService")):Teleport(game.PlaceId, lplr)
    end,
    
    ["say"] = function(args)
        table.remove(args, 1)
        task.wait()
        chat(table.concat(args, " "))
    end,
    
    ["reset"] = function()
        lplr.Character:BreakJoints()
    end,
    
    ["speed"] = function(args)
        table.remove(args, 1)
        task.wait()
        local ws = tonumber(args[1])
        if ws and ws >= 0 then
            lplr.Character:WaitForChild("Humanoid").WalkSpeed = ws
        else
            notif("Inquire", "Please enter a valid number", 5)
        end
    end,

    ["whitelist"] = function(args)
        table.remove(args, 1)
        task.wait()
        local player = playersService:FindFirstChild(args[1])
        if player then
            table.insert(whitelist, player.Name)
            notif("Success!", player.DisplayName .. "(@" .. player.Name .. ") Has Been Whitelisted", 10)
        end
    end,
    
    ["unwhitelist"] = function(args)
        table.remove(args, 1)
        task.wait()
        local index = table.find(whitelist, args[1])
        if index then
            table.remove(whitelist, index)
        else
            notif("UnWhitelist", args[1] .. " Isn't Whitelisted or Isn't in your game", 5)
        end
    end,
    
    ["prefix"] = function(args)
        table.remove(args, 1)
        task.wait()
        prefix = args[1]
        notif("Prefix:", "Prefix changed to " .. args[1], 6)
    end
}

task.wait()
commands["ws"] = commands.speed
commands["walkspeed"] = commands.speed
commands["rj"] = commands.rejoin
commands["re"] = commands.reset
commands["wl"] = commands.whitelist
commands["unwl"] = commands.unwhitelist
commands["uwl"] = commands.unwhitelist

-->> FUNCTIONS <<--
function chat(msg)
    if textChatService.ChatInputBarConfiguration.TargetTextChannel then
        textChatService.ChatInputBarConfiguration.TargetTextChannel:SendAsync(msg)
    else
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
    end
end

function notif(title, text, duration)
    local ScreenGui = Instance.new("ScreenGui", CoreGui)
    ScreenGui.Name = "G7Â°Â£=Â§`Ï€Ã·~HS6-86202828-$&#-(2:"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Enabled = true

    local main = Instance.new("Frame", ScreenGui)
    main.Name = "Main"
    main.Size = UDim2.new(0.25, 0, 0.12, 0)
    main.Position = UDim2.new(1, 0, 0.55, 0)
    main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    main.BackgroundTransparency = 0.2
    main.BorderSizePixel = 0

    local corner = Instance.new("UICorner", main)
    corner.CornerRadius = UDim.new(0, 8)

    local titleLabel = Instance.new("TextLabel", main)
    titleLabel.Size = UDim2.new(1, -10, 0.4, 0)
    titleLabel.Position = UDim2.new(0, 5, 0, 0)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.TextYAlignment = Enum.TextYAlignment.Top
    titleLabel.TextScaled = true
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Text = title

    local textLabel = Instance.new("TextLabel", main)
    textLabel.Size = UDim2.new(1, -10, 0.6, 0)
    textLabel.Position = UDim2.new(0, 5, 0.4, 0)
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.TextYAlignment = Enum.TextYAlignment.Bottom
    textLabel.TextScaled = true
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    textLabel.Text = text

    local progressBar = Instance.new("Frame", main)
    progressBar.Size = UDim2.new(1, 0, 0.05, 0)
    progressBar.Position = UDim2.new(0, 0, 0.95, 0)
    progressBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    progressBar.BorderSizePixel = 0

    local progressCorner = Instance.new("UICorner", progressBar)
    progressCorner.CornerRadius = UDim.new(0, 4)

    local progressTweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    tweenService:Create(progressBar, progressTweenInfo, { Size = UDim2.new(0, 0, 0.05, 0) }):Play()

    local notificationTweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false)
    tweenService:Create(main, notificationTweenInfo, { Position = UDim2.new(0.75, 0, 0.55, 0) }):Play()

    task.wait(duration)

    tweenService:Create(main, notificationTweenInfo, { Position = UDim2.new(1, 0, 0.55, 0) }):Play()
end

for _, v in next, playersService:GetPlayers() do
    v.Chatted:Connect(function(msg)
      if table.find(whitelist, v.Name) or v == lplr then 
        if string.sub(msg, 1, #prefix) == prefix then
            local args = msg:split(" ")
            local cmd = string.sub(args[1], #prefix + 1)
            if commands[cmd] then
                commands[cmd](args)
            end
        end
       end
    end)
end
notif("Inquire", "Inquire Has Loaded!", 5)
