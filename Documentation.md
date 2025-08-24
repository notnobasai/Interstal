# How to use the Inquire UI
A clear and simple documentation on how to create your own commands using Inquire

## Setting a command
```lua
commands['YourCommandThatHasToBeSaid'] = commands.TheCommandInCommandsList
```
This will set up the command. You can either do it like this if you dont want to use the commands list
```lua
commands['YourCommandThatHasToBeSaid'] = function()
    print("Hello, world')
end
```

## How to make a command
```lua
 ["YourCommandName"] = function()
        print("Hello, world")
    end,
```
You put this in commands list, then you can set up ur command

**This documentation is really bad, im really sleepy, and i'll fix it up later..**
