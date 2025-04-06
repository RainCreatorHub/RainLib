## Rain Library v1

### load

``` Lua
local RainLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/RainCreatorHub/RainLib/main/RainLib.lua"))()
```
### window

``` Lua
  local Window = RainLib:Window({
        Title = "Rain Lib!",
        Size = UDim2.new(0, 500, 0, 350)
    })
```

### minimize

``` Lua
    Window:Minimize({
        Text1 = "close",
        Text2 = "open",
        Draggable = true
    })
```

