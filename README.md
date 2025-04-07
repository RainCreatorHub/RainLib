# Rain Library v1

![Roblox](https://img.shields.io/badge/Roblox-Lua-blue?style=flat-square&logo=roblox) ![Version](https://img.shields.io/badge/version-1.0.0-green?style=flat-square) ![Executor](https://img.shields.io/badge/Executor-Supported-orange?style=flat-square): todos

**Rain Library** é uma biblioteca de interface de usuário (UI) para Roblox, escrita em Lua/Luau, projetada para criar interfaces gráficas modernas diretamente no jogo. Com ela, você pode adicionar janelas, abas e elementos como botões, toggles, caixas de texto, sliders, dropdowns e notificações usando um executor de scripts Roblox.

---

## Índice

- [Como Usar com um Executor](#como-usar-com-um-executor)
- [Criando uma Janela](#criando-uma-janela)
- [Botão de Minimizar](#botão-de-minimizar)
- [Adicionando uma Aba](#adicionando-uma-aba)
- [Elementos de UI](#elementos-de-ui)
  - [Botão](#botão)
  - [Toggle (Checkbox)](#toggle-checkbox)
  - [Textbox (Caixa de Texto)](#textbox-caixa-de-texto)
  - [Slider](#slider)
  - [Dropdown (Menu Suspenso)](#dropdown-menu-suspenso)
  - [Notificação](#notificação)
- [Exemplo Completo](#exemplo-completo)
- [Dicas para Executores](#dicas-para-executores)
- [Suporte](#suporte)

---

## Como Usar com um Executor

Para usar a **Rain Library** com um executor (ex.: Synapse X, KRNL, Fluxus), injete o seguinte código no Roblox:

```lua
local RainLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/RainCreatorHub/RainLib/main/RainLib.lua"))()
```
Passos:

A: Abra seu executor, Cole o código acima na área de script, Execute o script enquanto estiver em um jogo Roblox.

Requisitos: O executor deve suportar HttpGet e rodar scripts no lado do cliente.

Criando uma Janela, Crie uma janela com RainLib:Window para começar sua interface.

```Lua
local window = RainLib:Window({
    Title = "Rain Lib!",
    Size = UDim2.new(0, 500, 0, 350)
}
```

Opcional: Adicione Position (ex.: UDim2.new(0.5, -250, 0.5, -175) para centralizar).

Recursos: Arrastável e com botão de Fechar o (X) apaga o gui então não aperte nele.

Botão de Minimizar, Adicione um botão para minimizar a janela com 

``` Lua
window:Minimize({
    Text1 = "Close",           -- Texto quando a janela está visível
    Text2 = "Open",            -- Texto quando a janela está minimizada
    Draggable = true           -- Permite arrastar o botão
})
```

Dica: Use após criar abas e elementos para evitar bugs.

Adicionando uma Aba, Crie uma aba com window:Tab para organizar seus elementos.

``` Lua
local mainTab = window:Tab({
    Name = "Main",
    Icon = "home",
    ElementsPerRow = 1
}
```
Ícones: Veja opções em RainLib.lua no código-fonte (ex.: "home", "settings").

Elementos de UI, Botão Adicione um botão com 

``` Lua
mainTab:Button({
    Text = "Testar",           -- Texto no botão
    Size = UDim2.new(1, -20, 0, 30), -- Largura ajustada, altura fixa
    Callback = function()      -- Função ao clicar
        print("Clicado!")
    end
})
```

Opcional: BackgroundColor3 (ex.: Color3.fromRGB(0, 120, 215)).

Toggle (Checkbox), Crie um toggle com 
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

Retorno: Tabela com Value (true/false).

Textbox (Caixa de Texto), Adicione uma caixa de texto com
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
Nota: Callback acionado ao pressionar Enter.

Slider, Crie um slider com 
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
Retorno: Tabela com Value (número).

Dropdown (Menu Suspenso), Adicione um menu suspenso com 
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
Retorno: Tabela com Value (string).

Notificação, Exiba uma notificação com 
``` Lua
RainLib:Notify({
    Title = "Aviso",           -- Título
    Message = "Algo aconteceu!", -- Mensagem
    Duration = 5               -- Duração em segundos
})
```

Efeito: Aparece no canto direito e desaparece após o tempo.Exemplo Completo

Um script completo para injetar com seu executor:

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

-- Elementos
mainTab:Button({
    Text = "Testar",
    Size = UDim2.new(1, -20, 0, 30),
    Callback = function()
        print("Clicado!")
    end
})

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
Como Usar: Copie, cole no executor e execute no executor. 

Dicas para Executores:

Ordem: Adicione window:Minimize por último para evitar falhas no carregamento.

Teste: Use um jogo Roblox com suporte a GUIs (ex.: um hub ou lugar próprio).

Debug: Verifique a aba de saída do executor para mensagens de erro ou prints.

Segurança: Não execute em jogos com anti-cheat forte, pois injetar scripts pode ser detectado.

Ícones: Veja RainLib.lus no código para personalizar abas.

Suporte:

Problemas ou sugestões? Entre no meu discord ou entre em contato comigo diretamente.

### Mudanças para Executores
- **Foco**: Instruções adaptadas para usuários de executores, com passos claros para injetar o script.
- **Badge**: Adicionei um badge "Executor Supported" para destacar compatibilidade.
- **Suporte**: Removi a seção de contribuição e licença (menos relevante para esse público) e simplifiquei para "Suporte".
- **Dicas**: Incluí dicas específicas para executores, como evitar anti-cheats.
