local RainLib = {}
RainLib.__index = RainLib

-- Serviços do Roblox
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Função para criar a biblioteca
function RainLib.new()
    local self = setmetatable({}, RainLib)
    
    -- Cria o ScreenGui principal
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "RainLib"
    self.ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    self.ScreenGui.ResetOnSpawn = false
    
    return self
end

-- Função para criar uma janela
function RainLib:CreateWindow(options)
    local window = {}
    
    -- Configurações padrão
    options = options or {}
    local title = options.Title or "Rain Lib Window"
    local size = options.Size or UDim2.new(0, 400, 0, 300)
    local position = options.Position or UDim2.new(0.5, -200, 0.5, -150)
    
    -- Cria o frame da janela
    window.Frame = Instance.new("Frame")
    window.Frame.Size = size
    window.Frame.Position = position
    window.Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    window.Frame.Parent = self.ScreenGui
    
    -- Adiciona cantos arredondados
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = window.Frame
    
    -- Adiciona título
    window.Title = Instance.new("TextLabel")
    window.Title.Size = UDim2.new(1, 0, 0, 40)
    window.Title.BackgroundTransparency = 1
    window.Title.Text = title
    window.Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    window.Title.Font = Enum.Font.GothamBold
    window.Title.TextSize = 20
    window.Title.Parent = window.Frame
    
    -- Torna a janela arrastável
    local dragging, dragStart, startPos
    window.Frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = window.Frame.Position
        end
    end)
    
    window.Frame.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            window.Frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    window.Frame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    -- Função para adicionar botão de minimizar
    function window:AddMinimizeButton(options)
        local buttonOptions = options or {}
        local buttonName = buttonOptions.ButtonName or "Minimize"
        local bgTransparency = buttonOptions.BackgroundTransparency or 0
        
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0, 100, 0, 30)
        button.Position = UDim2.new(0, 10, 0, 10)
        button.Text = buttonName
        button.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.SourceSansBold
        button.TextSize = 16
        button.BackgroundTransparency = bgTransparency
        button.Parent = self.ScreenGui
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = buttonOptions.Corner and buttonOptions.Corner.CornerRadius or UDim.new(0, 8)
        corner.Parent = button
        
        button.MouseButton1Click:Connect(function()
            if window.Frame.Visible then
                local tween = TweenService:Create(window.Frame, TweenInfo.new(0.3), {Position = UDim2.new(0.5, -200, 0, -150)})
                tween:Play()
                tween.Completed:Wait()
                window.Frame.Visible = false
                button.Text = "Open"
            else
                window.Frame.Visible = true
                window.Frame.Position = UDim2.new(0.5, -200, 0, -150)
                local tween = TweenService:Create(window.Frame, TweenInfo.new(0.3), {Position = UDim2.new(0.5, -200, 0.5, -150)})
                tween:Play()
                button.Text = "Close"
            end
        end)
        
        return button
    end
    
    -- Função para adicionar abas
    function window:AddTabSystem()
        local tabSystem = {}
        local tabs = {}
        local tabFrame = Instance.new("Frame")
        tabFrame.Size = UDim2.new(1, 0, 0, 40)
        tabFrame.Position = UDim2.new(0, 0, 0, 40)
        tabFrame.BackgroundTransparency = 1
        tabFrame.Parent = window.Frame
        
        local contentFrame = Instance.new("Frame")
        contentFrame.Size = UDim2.new(1, -10, 1, -80)
        contentFrame.Position = UDim2.new(0, 5, 0, 80)
        contentFrame.BackgroundTransparency = 1
        contentFrame.Parent = window.Frame
        
        function tabSystem:AddTab(name, contentCallback)
            local tabButton = Instance.new("TextButton")
            tabButton.Size = UDim2.new(0, 80, 0, 30)
            tabButton.Position = UDim2.new(0, #tabs * 85 + 5, 0, 5)
            tabButton.Text = name
            tabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            tabButton.Font = Enum.Font.SourceSansBold
            tabButton.TextSize = 14
            tabButton.Parent = tabFrame
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 5)
            corner.Parent = tabButton
            
            local tabContent = Instance.new("ScrollingFrame")
            tabContent.Size = UDim2.new(1, 0, 1, 0)
            tabContent.Position = UDim2.new(0, 0, 0, 0)
            tabContent.BackgroundTransparency = 1
            tabContent.Visible = false
            tabContent.ScrollBarThickness = 5
            tabContent.Parent = contentFrame
            
            contentCallback(tabContent)
            
            local function selectTab()
                for _, tab in pairs(tabs) do
                    tab.Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    tab.Content.Visible = false
                end
                tabButton.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
                tabContent.Visible = true
            end
            
            tabButton.MouseButton1Click:Connect(selectTab)
            table.insert(tabs, {Button = tabButton, Content = tabContent})
            
            if #tabs == 1 then selectTab() end
        end
        
        return tabSystem
    end
    
    return window
end

-- Função para criar um botão dentro de um conteúdo
function RainLib:CreateButton(parent, options)
    local button = Instance.new("TextButton")
    button.Size = options.Size or UDim2.new(0, 100, 0, 30)
    button.Position = options.Position or UDim2.new(0, 10, 0, 10)
    button.Text = options.Text or "Button"
    button.BackgroundColor3 = options.BackgroundColor3 or Color3.fromRGB(50, 150, 255)
    button.TextColor3 = options.TextColor3 or Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 16
    button.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button
    
    button.MouseButton1Click:Connect(options.Callback or function() end)
    
    return button
end

-- Função para criar uma caixa de texto
function RainLib:CreateTextBox(parent, options)
    local textBox = Instance.new("TextBox")
    textBox.Size = options.Size or UDim2.new(0, 100, 0, 30)
    textBox.Position = options.Position or UDim2.new(0, 10, 0, 10)
    textBox.Text = options.Text or ""
    textBox.BackgroundColor3 = options.BackgroundColor3 or Color3.fromRGB(60, 60, 60)
    textBox.TextColor3 = options.TextColor3 or Color3.fromRGB(255, 255, 255)
    textBox.Font = Enum.Font.SourceSans
    textBox.TextSize = 16
    textBox.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = textBox
    
    textBox.FocusLost:Connect(function(enterPressed)
        if enterPressed and options.Callback then
            options.Callback(textBox.Text)
        end
    end)
    
    return textBox
end

-- Função para criar um alternador (toggle)
function RainLib:CreateToggle(parent, options)
    local toggle = {}
    toggle.Value = options.Default or false
    
    local frame = Instance.new("Frame")
    frame.Size = options.Size or UDim2.new(0, 100, 0, 30)
    frame.Position = options.Position or UDim2.new(0, 10, 0, 10)
    frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    frame.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 70, 1, 0)
    label.Text = options.Text or "Toggle"
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.SourceSans
    label.TextSize = 16
    label.Parent = frame
    
    local indicator = Instance.new("Frame")
    indicator.Size = UDim2.new(0, 20, 0, 20)
    indicator.Position = UDim2.new(1, -25, 0.5, -10)
    indicator.BackgroundColor3 = toggle.Value and Color3.fromRGB(50, 150, 255) or Color3.fromRGB(100, 100, 100)
    indicator.Parent = frame
    
    local indicatorCorner = Instance.new("UICorner")
    indicatorCorner.CornerRadius = UDim.new(0, 5)
    indicatorCorner.Parent = indicator
    
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            toggle.Value = not toggle.Value
            indicator.BackgroundColor3 = toggle.Value and Color3.fromRGB(50, 150, 255) or Color3.fromRGB(100, 100, 100)
            if options.Callback then
                options.Callback(toggle.Value)
            end
        end
    end)
    
    return toggle
end

return RainLib
