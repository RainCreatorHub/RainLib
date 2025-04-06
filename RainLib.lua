local RainLib = {
    Version = "1.0.0",
    Themes = {
        Dark = {
            Background = Color3.fromRGB(30, 30, 30),
            Accent = Color3.fromRGB(50, 150, 255),
            Text = Color3.fromRGB(255, 255, 255),
            Secondary = Color3.fromRGB(50, 50, 50),
            Disabled = Color3.fromRGB(100, 100, 100)
        }
    },
    Windows = {},
    CurrentTheme = nil
}

print("[RainLib] Carregando serviços...")

-- Serviços do Roblox
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Função utilitária pra animações
local function tween(obj, info, properties)
    local tween = TweenService:Create(obj, info or TweenInfo.new(0.3), properties)
    tween:Play()
    return tween
end

-- Inicialização automática
print("[RainLib] Inicializando...")
local success, err = pcall(function()
    RainLib.ScreenGui = Instance.new("ScreenGui")
    RainLib.ScreenGui.Name = "RainLib"
    RainLib.ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui", 5)
    RainLib.ScreenGui.ResetOnSpawn = false
    RainLib.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    RainLib.CurrentTheme = RainLib.Themes.Dark
    RainLib.Notifications = Instance.new("Frame")
    RainLib.Notifications.Size = UDim2.new(0, 300, 1, 0)
    RainLib.Notifications.Position = UDim2.new(1, -310, 0, 0)
    RainLib.Notifications.BackgroundTransparency = 1
    RainLib.Notifications.Parent = RainLib.ScreenGui
end)
if not success then
    warn("[RainLib] Erro na inicialização: " .. err)
    return nil
end
print("[RainLib] Inicializado com sucesso!")

-- Criar uma janela
function RainLib:Window(options)
    print("[RainLib] Criando janela...")
    local window = {}
    options = options or {}
    
    window.Title = options.Title or "Rain Lib"
    window.Size = options.Size or UDim2.new(0, 400, 0, 300)
    window.Position = options.Position or UDim2.new(0.5, -200, 0.5, -150)
    window.Minimized = false
    window.Tabs = {}
    
    local success, err = pcall(function()
        window.MainFrame = Instance.new("Frame")
        window.MainFrame.Size = window.Size
        window.MainFrame.Position = window.Position
        window.MainFrame.BackgroundColor3 = RainLib.CurrentTheme.Background
        window.MainFrame.ClipsDescendants = true
        window.MainFrame.Parent = RainLib.ScreenGui
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 10)
        corner.Parent = window.MainFrame
        
        local shadow = Instance.new("ImageLabel")
        shadow.Size = UDim2.new(1, 20, 1, 20)
        shadow.Position = UDim2.new(0, -10, 0, -10)
        shadow.BackgroundTransparency = 1
        shadow.Image = "rbxassetid://1316045217"
        shadow.ImageTransparency = 0.7
        shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
        shadow.ScaleType = Enum.ScaleType.Slice
        shadow.SliceCenter = Rect.new(10, 10, 118, 118)
        shadow.Parent = window.MainFrame
        
        window.TitleBar = Instance.new("Frame")
        window.TitleBar.Size = UDim2.new(1, 0, 0, 40)
        window.TitleBar.BackgroundTransparency = 1
        window.TitleBar.Parent = window.MainFrame
        
        window.TitleLabel = Instance.new("TextLabel")
        window.TitleLabel.Size = UDim2.new(1, -40, 1, 0)
        window.TitleLabel.Position = UDim2.new(0, 10, 0, 0)
        window.TitleLabel.BackgroundTransparency = 1
        window.TitleLabel.Text = window.Title
        window.TitleLabel.TextColor3 = RainLib.CurrentTheme.Text
        window.TitleLabel.Font = Enum.Font.GothamBold
        window.TitleLabel.TextSize = 20
        window.TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
        window.TitleLabel.Parent = window.TitleBar
        
        window.CloseButton = Instance.new("TextButton")
        window.CloseButton.Size = UDim2.new(0, 30, 0, 30)
        window.CloseButton.Position = UDim2.new(1, -35, 0, 5)
        window.CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        window.CloseButton.Text = "X"
        window.CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        window.CloseButton.Font = Enum.Font.SourceSansBold
        window.CloseButton.TextSize = 16
        window.CloseButton.Parent = window.TitleBar
        
        local closeCorner = Instance.new("UICorner")
        closeCorner.CornerRadius = UDim.new(0, 8)
        closeCorner.Parent = window.CloseButton
    end)
    if not success then
        warn("[RainLib] Erro ao criar janela: " .. err)
        return nil
    end
    print("[RainLib] Janela criada!")
    
    window.CloseButton.MouseButton1Click:Connect(function()
        window.MainFrame.Visible = false
        print("[RainLib] Janela fechada")
    end)
    
    -- Tornar arrastável
    local dragging, dragStart, startPos
    window.TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = window.MainFrame.Position
            print("[RainLib] Começando a arrastar")
        end
    end)
    
    window.TitleBar.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            window.MainFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    window.TitleBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
            print("[RainLib] Parou de arrastar")
        end
    end)
    
    -- Funções da janela
    function window:Minimize(options)
        print("[RainLib] Criando botão de minimizar...")
        options = options or {}
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0, 100, 0, 30)
        button.Position = options.Position or UDim2.new(0, 10, 0, 10)
        button.Text = options.Text or "Minimize"
        button.BackgroundColor3 = RainLib.CurrentTheme.Accent
        button.TextColor3 = RainLib.CurrentTheme.Text
        button.Font = Enum.Font.SourceSansBold
        button.TextSize = 16
        button.BackgroundTransparency = options.BackgroundTransparency or 0
        button.Parent = RainLib.ScreenGui
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = options.CornerRadius or UDim.new(0, 8)
        corner.Parent = button
        
        button.MouseButton1Click:Connect(function()
            if window.Minimized then
                tween(window.MainFrame, nil, {Size = window.Size, Position = window.Position})
                window.Minimized = false
                button.Text = options.Text or "Minimize"
                print("[RainLib] Janela restaurada")
            else
                tween(window.MainFrame, nil, {Size = UDim2.new(0, window.Size.X.Offset, 0, 40), Position = UDim2.new(window.Position.X.Scale, window.Position.X.Offset, 1, -50)})
                window.Minimized = true
                button.Text = "Restore"
                print("[RainLib] Janela minimizada")
            end
        end)
        
        return button
    end
    
    function window:Tab(options)
        print("[RainLib] Criando aba...")
        local tab = {}
        options = options or {}
        tab.Name = options.Name or "Tab"
        
        tab.Content = Instance.new("ScrollingFrame")
        tab.Content.Size = UDim2.new(1, -10, 1, -50)
        tab.Content.Position = UDim2.new(0, 5, 0, 45)
        tab.Content.BackgroundTransparency = 1
        tab.Content.ScrollBarThickness = 5
        tab.Content.Visible = false
        tab.Content.Parent = window.MainFrame
        
        tab.Button = Instance.new("TextButton")
        tab.Button.Size = UDim2.new(0, 80, 0, 30)
        tab.Button.Position = UDim2.new(0, #window.Tabs * 85 + 5, 0, 5)
        tab.Button.Text = tab.Name
        tab.Button.BackgroundColor3 = RainLib.CurrentTheme.Secondary
        tab.Button.TextColor3 = RainLib.CurrentTheme.Text
        tab.Button.Font = Enum.Font.SourceSansBold
        tab.Button.TextSize = 14
        tab.Button.Parent = window.TabContainer or (function()
            local container = Instance.new("Frame")
            container.Size = UDim2.new(1, 0, 0, 40)
            container.Position = UDim2.new(0, 0, 0, 40)
            container.BackgroundTransparency = 1
            container.Parent = window.MainFrame
            window.TabContainer = container
            return container
        end)()
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 5)
        corner.Parent = tab.Button
        
        table.insert(window.Tabs, tab)
        
        local function selectTab()
            for _, t in pairs(window.Tabs) do
                t.Button.BackgroundColor3 = RainLib.CurrentTheme.Secondary
                t.Content.Visible = false
            end
            tab.Button.BackgroundColor3 = RainLib.CurrentTheme.Accent
            tab.Content.Visible = true
            print("[RainLib] Aba selecionada: " .. tab.Name)
        end
        
        tab.Button.MouseButton1Click:Connect(selectTab)
        if #window.Tabs == 1 then selectTab() end
        
        function tab:Button(options)
            local button = Instance.new("TextButton")
            button.Size = options.Size or UDim2.new(0, 100, 0, 30)
            button.Position = UDim2.new(0, 10, 0, (#tab.Content:GetChildren() - 1) * 40 + 10)
            button.Text = options.Text or "Button"
            button.BackgroundColor3 = options.BackgroundColor3 or RainLib.CurrentTheme.Accent
            button.TextColor3 = RainLib.CurrentTheme.Text
            button.Font = Enum.Font.SourceSansBold
            button.TextSize = 16
            button.Parent = tab.Content
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = button
            
            button.MouseButton1Click:Connect(options.Callback or function() end)
            return button
        end
        
        function tab:Textbox(options)
            local textbox = Instance.new("TextBox")
            textbox.Size = options.Size or UDim2.new(0, 100, 0, 30)
            textbox.Position = UDim2.new(0, 10, 0, (#tab.Content:GetChildren() - 1) * 40 + 10)
            textbox.Text = options.Text or ""
            textbox.BackgroundColor3 = options.BackgroundColor3 or RainLib.CurrentTheme.Secondary
            textbox.TextColor3 = RainLib.CurrentTheme.Text
            textbox.Font = Enum.Font.SourceSans
            textbox.TextSize = 16
            textbox.Parent = tab.Content
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = textbox
            
            textbox.FocusLost:Connect(function(enterPressed)
                if enterPressed and options.Callback then
                    options.Callback(textbox.Text)
                end
            end)
            
            return textbox
        end
        
        function tab:Toggle(options)
            local toggle = { Value = options.Default or false }
            local frame = Instance.new("Frame")
            frame.Size = options.Size or UDim2.new(0, 100, 0, 30)
            frame.Position = UDim2.new(0, 10, 0, (#tab.Content:GetChildren() - 1) * 40 + 10)
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary
            frame.Parent = tab.Content
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = frame
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0, 70, 1, 0)
            label.Text = options.Text or "Toggle"
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = Enum.Font.SourceSans
            label.TextSize = 16
            label.Parent = frame
            
            local indicator = Instance.new("Frame")
            indicator.Size = UDim2.new(0, 20, 0, 20)
            indicator.Position = UDim2.new(1, -25, 0.5, -10)
            indicator.BackgroundColor3 = toggle.Value and RainLib.CurrentTheme.Accent or RainLib.CurrentTheme.Disabled
            indicator.Parent = frame
            
            local indicatorCorner = Instance.new("UICorner")
            indicatorCorner.CornerRadius = UDim.new(0, 5)
            indicatorCorner.Parent = indicator
            
            frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    toggle.Value = not toggle.Value
                    tween(indicator, TweenInfo.new(0.2), {BackgroundColor3 = toggle.Value and RainLib.CurrentTheme.Accent or RainLib.CurrentTheme.Disabled})
                    if options.Callback then
                        options.Callback(toggle.Value)
                    end
                end
            end)
            
            return toggle
        end
        
        function tab:Slider(options)
            local slider = { Value = options.Default or 0 }
            local frame = Instance.new("Frame")
            frame.Size = options.Size or UDim2.new(0, 200, 0, 40)
            frame.Position = UDim2.new(0, 10, 0, (#tab.Content:GetChildren() - 1) * 40 + 10)
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary
            frame.Parent = tab.Content
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = frame
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0, 100, 0, 20)
            label.Text = options.Text or "Slider"
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = Enum.Font.SourceSans
            label.TextSize = 16
            label.Parent = frame
            
            local valueLabel = Instance.new("TextLabel")
            valueLabel.Size = UDim2.new(0, 50, 0, 20)
            valueLabel.Position = UDim2.new(1, -60, 0, 0)
            valueLabel.Text = tostring(slider.Value)
            valueLabel.BackgroundTransparency = 1
            valueLabel.TextColor3 = RainLib.CurrentTheme.Text
            valueLabel.Font = Enum.Font.SourceSans
            valueLabel.TextSize = 16
            valueLabel.Parent = frame
            
            local bar = Instance.new("Frame")
            bar.Size = UDim2.new(1, -10, 0, 10)
            bar.Position = UDim2.new(0, 5, 0, 25)
            bar.BackgroundColor3 = RainLib.CurrentTheme.Disabled
            bar.Parent = frame
            
            local fill = Instance.new("Frame")
            fill.Size = UDim2.new(slider.Value / (options.Max or 100), 0, 1, 0)
            fill.BackgroundColor3 = RainLib.CurrentTheme.Accent
            fill.Parent = bar
            
            local cornerBar = Instance.new("UICorner")
            cornerBar.CornerRadius = UDim.new(0, 5)
            cornerBar.Parent = bar
            
            local cornerFill = Instance.new("UICorner")
            cornerFill.CornerRadius = UDim.new(0, 5)
            cornerFill.Parent = fill
            
            local dragging
            bar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                end
            end)
            
            bar.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)
            
            RunService.RenderStepped:Connect(function()
                if dragging then
                    local mousePos = UserInputService:GetMouseLocation()
                    local relativeX = math.clamp((mousePos.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
                    slider.Value = math.floor(relativeX * (options.Max or 100))
                    fill.Size = UDim2.new(relativeX, 0, 1, 0)
                    valueLabel.Text = tostring(slider.Value)
                    if options.Callback then
                        options.Callback(slider.Value)
                    end
                end
            end)
            
            return slider
        end
        
        function tab:Dropdown(options)
            local dropdown = { Value = options.Default or options.Options[1] }
            local frame = Instance.new("Frame")
            frame.Size = options.Size or UDim2.new(0, 150, 0, 30)
            frame.Position = UDim2.new(0, 10, 0, (#tab.Content:GetChildren() - 1) * 40 + 10)
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary
            frame.Parent = tab.Content
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = frame
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -30, 1, 0)
            label.Text = dropdown.Value
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = Enum.Font.SourceSans
            label.TextSize = 16
            label.Parent = frame
            
            local arrow = Instance.new("TextLabel")
            arrow.Size = UDim2.new(0, 20, 1, 0)
            arrow.Position = UDim2.new(1, -25, 0, 0)
            arrow.Text = "▼"
            arrow.BackgroundTransparency = 1
            arrow.TextColor3 = RainLib.CurrentTheme.Text
            arrow.Font = Enum.Font.SourceSans
            arrow.TextSize = 16
            arrow.Parent = frame
            
            local list = Instance.new("Frame")
            list.Size = UDim2.new(1, 0, 0, #options.Options * 30)
            list.Position = UDim2.new(0, 0, 1, 5)
            list.BackgroundColor3 = RainLib.CurrentTheme.Secondary
            list.Visible = false
            list.Parent = frame
            
            local listCorner = Instance.new("UICorner")
            listCorner.CornerRadius = UDim.new(0, 8)
            listCorner.Parent = list
            
            for i, opt in ipairs(options.Options) do
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, 0, 0, 30)
                btn.Position = UDim2.new(0, 0, 0, (i-1) * 30)
                btn.Text = opt
                btn.BackgroundTransparency = 1
                btn.TextColor3 = RainLib.CurrentTheme.Text
                btn.Font = Enum.Font.SourceSans
                btn.TextSize = 16
                btn.Parent = list
                
                btn.MouseButton1Click:Connect(function()
                    dropdown.Value = opt
                    label.Text = opt
                    list.Visible = false
                    if options.Callback then
                        options.Callback(dropdown.Value)
                    end
                end)
            end
            
            frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    list.Visible = not list.Visible
                end
            end)
            
            return dropdown
        end
        
        return tab
    end
    
    table.insert(RainLib.Windows, window)
    return window
end

-- Sistema de notificações
function RainLib:Notify(options)
    print("[RainLib] Criando notificação...")
    local success, err = pcall(function()
        local notification = Instance.new("Frame")
        notification.Size = UDim2.new(0, 280, 0, 80)
        notification.Position = UDim2.new(0, 10, 0, (#RainLib.Notifications:GetChildren() - 1) * 90 + 10)
        notification.BackgroundColor3 = RainLib.CurrentTheme.Background
        notification.Parent = RainLib.Notifications
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = notification
        
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, -10, 0, 20)
        title.Position = UDim2.new(0, 5, 0, 5)
        title.Text = options.Title or "Notification"
        title.BackgroundTransparency = 1
        title.TextColor3 = RainLib.CurrentTheme.Text
        title.Font = Enum.Font.GothamBold
        title.TextSize = 16
        title.Parent = notification
        
        local message = Instance.new("TextLabel")
        message.Size = UDim2.new(1, -10, 0, 40)
        message.Position = UDim2.new(0, 5, 0, 30)
        message.Text = options.Message or "Message"
        message.BackgroundTransparency = 1
        message.TextColor3 = RainLib.CurrentTheme.Text
        message.Font = Enum.Font.SourceSans
        message.TextSize = 14
        message.TextWrapped = true
        message.Parent = notification
        
        tween(notification, TweenInfo.new(0.5), {Position = UDim2.new(0, 10, 0, (#RainLib.Notifications:GetChildren() - 1) * 90 + 10)})
        task.wait(options.Duration or 3)
        tween(notification, TweenInfo.new(0.5), {Position = UDim2.new(1, 10, 0, notification.Position.Y.Offset)}).Completed:Connect(function()
            notification:Destroy()
            print("[RainLib] Notificação removida")
        end)
    end)
    if not success then
        warn("[RainLib] Erro na notificação: " .. err)
    end
end

-- Mudar tema
function RainLib:SetTheme(theme)
    print("[RainLib] Mudando tema...")
    local success, err = pcall(function()
        RainLib.CurrentTheme = theme
        for _, window in pairs(RainLib.Windows) do
            window.MainFrame.BackgroundColor3 = theme.Background
            window.TitleLabel.TextColor3 = theme.Text
            for _, tab in pairs(window.Tabs) do
                tab.Button.TextColor3 = theme.Text
                tab.Button.BackgroundColor3 = tab.Content.Visible and theme.Accent or theme.Secondary
                for _, child in pairs(tab.Content:GetChildren()) do
                    if child:IsA("TextButton") or child:IsA("TextBox") then
                        child.BackgroundColor3 = theme.Accent
                        child.TextColor3 = theme.Text
                    elseif child:IsA("Frame") then
                        child.BackgroundColor3 = theme.Secondary
                        for _, subchild in pairs(child:GetChildren()) do
                            if subchild:IsA("TextLabel") then
                                subchild.TextColor3 = theme.Text
                            elseif subchild:IsA("Frame") then
                                subchild.BackgroundColor3 = subchild.Parent.BackgroundColor3 == theme.Accent and theme.Accent or theme.Disabled
                            end
                        end
                    end
                end
            end
        end
    end)
    if not success then
        warn("[RainLib] Erro ao mudar tema: " .. err)
    else
        print("[RainLib] Tema mudado com sucesso!")
    end
end

print("[RainLib] Biblioteca carregada!")
return RainLib
