# Rain Library v1

![Roblox](https://img.shields.io/badge/Roblox-Lua-blue?style=flat-square&logo=roblox) ![Version](https://img.shields.io/badge/version-1.0.0-green?style=flat-square) ![Executor](https://img.shields.io/badge/Executor-Supported-orange?style=flat-square): todos

**Rain Library** é uma biblioteca de interface de usuário (UI) para Roblox, escrita em Lua/Luau, projetada para criar interfaces gráficas modernas diretamente no jogo. Com ela, você pode adicionar janelas, abas e elementos como botões, toggles, caixas de texto, sliders, dropdowns, sessões e notificações usando um executor de scripts Roblox.

#### ui library 

 Load
```lua
local RainLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/RainCreatorHub/RainLib/main/RainLib.lua"))()
```
 Window 
 
```Lua
local window = RainLib:Window({
    Title = "Rain Lib!",
    Size = UDim2.new(0, 500, 0, 350)
}
```

 minimize

``` Lua
window:Minimize({
    Text1 = "Close",           -- Texto quando a janela está visível
    Text2 = "Open",            -- Texto quando a janela está minimizada
    Draggable = true           -- Permite arrastar o botão
})
```

 Aba

``` Lua
local mainTab = window:Tab({
    Name = "Main",
    Icon = "home",
    ElementsPerRow = 1
}
```

 section

``` Lua
mainTab:AddSection("section")
```

 Button

``` Lua
mainTab:Button({
    Text = "Testar",           -- Texto no botão
    Size = UDim2.new(1, -20, 0, 30), -- Largura ajustada, altura fixa
    Callback = function()      -- Função ao clicar
        print("Clicado!")
    end
})
```

 checkBox

``` Lua
mainTab:Toggle({
    Text = "Ativar Recurso",   -- Texto ao lado
    Size = UDim2.new(1, -20, 0, 30), -- Tamanho
    Default = false,           -- Estado inicial
    Callback = function(value) -- Função ao alternar
        print("Toggle: " .. tostring(value))
    end
})
```

 textbox

``` Lua
mainTab:Textbox({
    Text = "Digite aqui",      -- Texto inicial
    Size = UDim2.new(1, -20, 0, 30), -- Tamanho
    BackgroundColor3 = Color3.fromRGB(0, 120, 215), -- Cor de fundo
    Callback = function(text)  -- Função ao pressionar Enter
        print("Texto: " .. text)
    end
})
```

 slider

``` Lua
mainTab:Slider({
    Text = "Volume",           -- Texto acima
    Size = UDim2.new(1, -20, 0, 40), -- Tamanho
    Default = 50,              -- Valor inicial
    Max = 100,                 -- Valor máximo
    Callback = function(value) -- Função ao ajustar
        print("Volume: " .. value)
    end
})
```

 Dropdown

``` Lua
mainTab:Dropdown({
    Size = UDim2.new(1, -20, 0, 30), -- Tamanho
    Options = {"Fácil", "Médio", "Difícil"}, -- Opções
    Default = "Fácil",         -- Opção inicial
    Callback = function(value) -- Função ao selecionar
        print("Selecionado: " .. value)
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

-- Cria a janela
local window = RainLib:Window({
    Title = "Rain Lib!",
    Size = UDim2.new(0, 500, 0, 350)
})

-- Cria uma aba
local mainTab = window:Tab({
    Name = "Main",
    Icon = "home",
    ElementsPerRow = 1
})

mainTab:AddSection("sla1")

-- Elementos
mainTab:Button({
    Text = "Testar",
    Size = UDim2.new(1, -20, 0, 30),
    Callback = function()
        print("Clicado!")
    end
})

mainTab:AddSection("sla2")

mainTab:Toggle({
    Text = "Ativar",
    Size = UDim2.new(1, -20, 0, 30),
    Default = false,
    Callback = function(value)
        print("Toggle: " .. tostring(value))
    end
})

mainTab:Textbox({
    Text = "Digite aqui",
    Size = UDim2.new(1, -20, 0, 30),
    Callback = function(text)
        print("Texto: " .. text)
    end
})

mainTab:Slider({
    Text = "Volume",
    Size = UDim2.new(1, -20, 0, 40),
    Default = 50,
    Max = 100,
    Callback = function(value)
        print("Volume: " .. value)
    end
})

mainTab:Dropdown({
    Size = UDim2.new(1, -20, 0, 30),
    Options = {"Fácil", "Médio", "Difícil"},
    Default = "Fácil",
    Callback = function(value)
        print("Selecionado: " .. value)
    end
})

RainLib:Notify({
    Title = "Bem-vindo",
    Message = "Interface carregada!",
    Duration = 5
})

-- Botão de minimizar
window:Minimize({
    Text1 = "Close",
    Text2 = "Open",
    Draggable = true
})
```
