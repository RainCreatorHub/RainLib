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
    window:Minimize({
        Text1 = "close",
        Text2 = "open",
        Draggable = true
    })
```

### tab

``` Lua
local Main = window:Tab({
   Name = "Main",
   Icon = "Home",                            ElementsPerRow = 1
})
```

### botão 

``` lua
tab:Button({Text = "Testar", Callback = function() print("Clicado!") end})
```

### Checkbox 

``` Lua
tab:Toggle({
    Text = "Ativar Recurso",
    Size = UDim2.new(1, -20, 0, 30),
    Default = false,
    Callback = function(value)
        print("Toggle alterado para: " .. tostring(value))
    end
})
```

### textbox 

``` Lua
tab:Button({
    Text = "digite aqui",
    Size = UDim2.new(1, -20, 0, 30),
    BackgroundColor3 = Color3.fromRGB(0, 120, 215),
    Callback = function()
        print("Botão clicado!")
    end
})
```


