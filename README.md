# Rain Library v1

![Roblox](https://img.shields.io/badge/Roblox-Lua-blue?style=flat-square&logo=roblox) ![Version](https://img.shields.io/badge/version-1.0.0-green?style=flat-square) ![Executor](https://img.shields.io/badge/Executor-Supported-orange?style=flat-square): todos

**Rain Library** é uma biblioteca de interface de usuário (UI) para Roblox, escrita em Lua/Luau, projetada para criar interfaces gráficas modernas diretamente no jogo. Com ela, você pode adicionar janelas, abas e elementos como botões, toggles, caixas de texto, sliders, dropdowns, sessões e notificações usando um executor de scripts Roblox.

## Oque foi adicionado

 * Auto load config
 * Auto save config

## como usar

 * use o "SaveSettings = true," para salvar e criar as pastas de configurações
 
 * agora use o "ConfigFolder = "MeuScriptConfig"" para definir o nome da pasta de configurações
   
 * use as opções que contém "Flag = "MinhaFlag"," e pronto

#### RainLib

 Load
```lua
local RainLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/RainCreatorHub/RainLib/main/RainLib.lua"))()
```
 Window 
 
``` lua
local window = RainLib:Window({
    Title = "Meu Menu",
    SubTitle = "Bem-vindo(a)",
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl,
    SaveSettings = true,
    ConfigFolder = "MeuScriptConfig"
})
```

 minimize ( erro )

``` Lua
window:Minimize({
    Text1 = "Close",
    Text2 = "Open",
    Draggable = true
})
```

 Aba

``` Lua
local mainTab = window:Tab({
    Name = "Main",
    Icon = "home",
})
```

 section

``` Lua
mainTab:AddSection("section")
```

 paragraph

``` lua
mainTab:AddParagraph({
    Title = "Olaa",
    Content = "Ola"
})
```

 Button

``` Lua
mainTab:AddButton({
    Title = "Testar Botão",
    Callback = function()
        print("Botão clicado!")
    end
})
```

 toggle

``` Lua
mainTab:AddToggle("teste_toggle", {
    Title = "Ligar Algo",
    Default = false,
    Flag = "ToggleTeste",
    Callback = function(value)
        print("Toggle:", value)
    end
})
```

 textbox

``` Lua
mainTab:Textbox({
    Text = "Digite aqui",
    BackgroundColor3 = Color3.fromRGB(0, 120, 215), -- Cor de fundo
    Callback = function(text)
        print("Texto: " .. text)
    end
})
```

 slider

``` Lua
mainTab:Slider({
    Text = "Volume",
    Default = 50,
    Max = 100,
    Flag = "SliderTest",
    Callback = function(value)
        print("Volume: " .. value)
    end
})
```

 Dropdown

``` Lua
local dropdown = mainTab:AddDropdown("tema_dropdown", {
    Title = "Tema",
    Items = {"Dark", "Light", "light"},
    Default = "Dark",
    Flag = "TemaEscolhido",
    Callback = function(value) 
    end
})
```

 notificação 

``` Lua
RainLib:Notify({
    Title = "Aviso",           -- Título
    Message = "Algo aconteceu!", -- Mensagem
    Duration = 5               -- Duração em segundos
})
```

 exemplo completo

``` Lua
local RainLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/RainCreatorHub/RainLib/main/RainLib.lua"))()

local window = RainLib:Window({
    Title = "Meu Menu",
    SubTitle = "Bem-vindo ao meu script!",
    Position = UDim2.new(0.5, -300, 0.5, -200),
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl,
    SaveSettings = true,
    ConfigFolder = "MeuScriptConfig"
})

-- Cria uma aba
local mainTab = window:Tab({
    Name = "Main",
    Icon = "home",
})

mainTab:AddSection("sla1")

mainTab:AddButton({
    Title = "Testar Botão",
    Callback = function()
        print("Botão clicado!")
    end
})

mainTab:AddParagraph({
    Title = "Olaa",
    Content = "Ola"
})

mainTab:AddSection("sla2")

mainTab:AddToggle("teste_toggle", {
    Title = "Ligar Algo",
    Default = false,
    Flag = "ToggleTeste",
    Callback = function(value)
        print("Toggle:", value)
    end
})

mainTab:Textbox({
    Text = "Digite aqui",
    Callback = function(text)
        print("Texto: " .. text)
    end
})

mainTab:Slider({
    Text = "Volume",
    Default = 50,
    Max = 100,
    Flag = "SliderTest",
    Callback = function(value)
        print("Volume: " .. value)
    end
})

local dropdown = mainTab:AddDropdown("tema_dropdown", {
    Title = "Tema",
    Items = {"Dark", "Light", "light"},
    Default = "Dark",
    Flag = "TemaEscolhido",
    Callback = function(value) 
    end
})

RainLib:Notify({
    Title = "Bem-vindo",
    Message = "Interface carregada!",
    Duration = 5
})
```
