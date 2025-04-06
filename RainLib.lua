local RainLib = {
    Options = {}
}

-- Serviços do Roblox
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Função principal da biblioteca
function RainLib:Window(title)
    local window = {}
    window.ScreenGui = Instance.new("ScreenGui")
    window.ScreenGui.Name = "RainLib"
    window.ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    window.ScreenGui.ResetOnSpawn = false
    
    window.MainFrame = Instance.new("Frame")
    window.MainFrame.Size = UDim2.new(0, 400, 0, 300)
    window.MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    window.MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    window.MainFrame.Parent = window.ScreenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = window.MainFrame
    
    window.TitleLabel = Instance.new("TextLabel")
    window.TitleLabel.Size = UDim2.new(1, 0, 0, 40)
    window.TitleLabel.BackgroundTransparency = 1
    window.TitleLabel.Text = title or "Rain Lib"
    window.TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    window.TitleLabel.Font = Enum.Font.GothamBold
    window.TitleLabel.TextSize = 20
    window.TitleLabel.Parent = window.MainFrame
    
    -- Tornar arrastável
    local dragging, dragStart, startPos
    window.MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = window.MainFrame.Position
        end
    end)
    
    window.MainFrame.InputChanged:Connect(function(input)
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
    
    window.MainFrame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    -- Função de minimizar (como Fluent)
    function window:MinimizeButton(options)
        options = options or {}
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0, 100, 0, 30)
        button.Position = UDim2.new(0, 10, 0, 10)
        button.Text = options.Text or "Minimize"
        button.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.SourceSansBold
        button.TextSize = 16
        button.BackgroundTransparency = options.BackgroundTransparency or 0
        button.Parent = window.ScreenGui
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = options.CornerRadius or UDim.new(0, 8)
        corner.Parent = button
        
        button.MouseButton1Click:Connect(function()
            if window.MainFrame.Visible then
                local tween = TweenService:Create(window.MainFrame, TweenInfo.new(0.3), {Position = UDim2.new(0.5, -200, 0, -150)})
                tween:Play()
                tween.Completed:Wait()
                window.MainFrame.Visible = false
                button.Text = "Open"
            else
                window.MainFrame.Visible = true
                window.MainFrame.Position = UDim2.new(0.5, -200, 0, -150)
                local tween = TweenService:Create(window.MainFrame, TweenInfo.new(0.3), {Position = UDim2.new(0.5, -200, 0.5, -150)})
                tween:Play()
                button.Text = "Close"
            end
        end)
        
        return button
    end
    
    -- Sistema de abas (como Fluent)
    function window:Tab(name)
        local tab = {}
        tab.TabButton = Instance.new("TextButton")
        tab.TabButton.Size = UDim2.new(0, 80, 0, 30)
        tab.TabButton.Position = UDim2.new(0, #window.Tabs * 85 + 5, 0, 5)
        tab.TabButton.Text = name
        tab.TabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        tab.TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tab.TabButton.Font = Enum.Font.SourceSansBold
        tab.TabButton.TextSize = 14
        tab.TabButton.Parent = window.TabFrame or (function()
            local tabFrame = Instance.new("Frame")
            tabFrame.Size = UDim2.new(1, 0, 0, 40)
            tabFrame.Position = UDim2.new(0, 0, 0, 40)
            tabFrame.BackgroundTransparency = 1
            tabFrame.Parent = window.MainFrame
            window.TabFrame = tabFrame
            return tabFrame
        end)()
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 5)
        corner.Parent = tab.TabButton
        
        tab.ContentFrame = Instance.new("ScrollingFrame")
        tab.ContentFrame.Size = UDim2.new(1, -10, 1, -80)
        tab.ContentFrame.Position = UDim2.new(0, 5, 0, 80)
        tab.ContentFrame.BackgroundTransparency = 1
        tab.ContentFrame.Visible = false
        tab.ContentFrame.ScrollBarThickness = 5
        tab.ContentFrame.Parent = window.MainFrame
        
        window.Tabs = window.Tabs or {}
        table.insert(window.Tabs, tab)
        
        local function selectTab()
            for _, t in pairs(window.Tabs) do
                t.TabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                t.ContentFrame.Visible = false
            end
            tab.TabButton.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
            tab.ContentFrame.Visible = true
        end
        
        tab.TabButton.MouseButton1Click:Connect(selectTab)
        if #window.Tabs == 1 then selectTab() end
        
        -- Função de botão (como Fluent)
        function tab:Button(options)
            local button = Instance.new("TextButton")
            button.Size = options.Size or UDim2.new(0, 100, 0, 30)
            button.Position = options.Position or UDim2.new(0, 10, 0, (#tab.ContentFrame:GetChildren() - 1) * 40 + 10)
            button.Text = options.Text or "Button"
            button.BackgroundColor3 = options.BackgroundColor3 or Color3.fromRGB(50, 150, 255)
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
            button.Font = Enum.Font.SourceSansBold
            button.TextSize = 16
            button.Parent = tab.ContentFrame
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = button
            
            button.MouseButton1Click:Connect(options.Callback or function() end)
            return button
        end
        
        -- Função de caixa de texto (como Fluent)
        function tab:Textbox(options)
            local textbox = Instance.new("TextBox")
            textbox.Size = options.Size or UDim2.new(0, 100, 0, 30)
            textbox.Position = options.Position or UDim2.new(0, 10, 0, (#tab.ContentFrame:GetChildren() - 1) * 40 + 10)
            textbox.Text = options.Text or ""
            textbox.BackgroundColor3 = options.BackgroundColor3 or Color3.fromRGB(60, 60, 60)
            textbox.TextColor3 = Color3.fromRGB(255, 255, 255)
            textbox.Font = Enum.Font.SourceSans
            textbox.TextSize = 16
            textbox.Parent = tab.ContentFrame
            
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
        
        -- Função de toggle (como Fluent)
        function tab:Toggle(options)
            local toggle = { Value = options.Default or false }
            local frame = Instance.new("Frame")
            frame.Size = options.Size or UDim2.new(0, 100, 0, 30)
            frame.Position = options.Position or UDim2.new(0, 10, 0, (#tab.ContentFrame:GetChildren() - 1) * 40 + 10)
            frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            frame.Parent = tab.ContentFrame
            
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
        
        return tab
    end
    
    return window
end

return RainLib
