-- RainLib: Uma biblioteca UI para Roblox com espaçamento automático
local RainLib = {}
RainLib.__index = RainLib

-- Tema padrão da interface
RainLib.CurrentTheme = {
    Background = Color3.fromRGB(30, 30, 30),
    Secondary = Color3.fromRGB(40, 40, 40),
    Accent = Color3.fromRGB(0, 120, 255),
    Text = Color3.fromRGB(255, 255, 255),
    Disabled = Color3.fromRGB(60, 60, 60),
    Notification = Color3.fromRGB(50, 50, 50)
}

-- Estado global da GUI para persistência
RainLib.GUIState = { Windows = {}, Notifications = {} }

-- Serviços do Roblox
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Função auxiliar para animações
local function tween(obj, tweenInfo, properties)
    local tween = TweenService:Create(obj, tweenInfo, properties)
    tween:Play()
    return tween
end

-- Função para salvar configurações
function RainLib:SaveSettings(folder, settings)
    if writefile and isfolder and makefolder then
        if not isfolder(folder) then
            makefolder(folder)
        end
        writefile(folder .. "/settings.json", HttpService:JSONEncode(settings))
    end
end

-- Função para carregar configurações
function RainLib:LoadSettings(folder)
    if readfile and isfile and isfolder then
        if isfolder(folder) and isfile(folder .. "/settings.json") then
            return HttpService:JSONDecode(readfile(folder .. "/settings.json"))
        end
    end
    return nil
end

-- Função para aplicar tema personalizado
function RainLib:SetTheme(theme)
    RainLib.CurrentTheme = theme or RainLib.CurrentTheme
    for _, windowState in ipairs(RainLib.GUIState.Windows) do
        RainLib:RecreateGUI()
    end
end

-- Função para criar notificações
function RainLib:Notify(options)
    options = options or {}
    local notification = {}
    notification.Title = options.Title or "Notificação"
    notification.Content = options.Content or ""
    notification.Duration = options.Duration or 5

    local notifyFrame = Instance.new("Frame")
    notifyFrame.Size = UDim2.new(0, 250, 0, 80)
    notifyFrame.Position = UDim2.new(1, -260, 1, -90 - (#RainLib.GUIState.Notifications * 90))
    notifyFrame.BackgroundColor3 = RainLib.CurrentTheme.Notification
    notifyFrame.Parent = RainLib.ScreenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = notifyFrame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -8, 0, 20)
    title.Position = UDim2.new(0, 4, 0, 4)
    title.Text = notification.Title
    title.BackgroundTransparency = 1
    title.TextColor3 = RainLib.CurrentTheme.Text
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = notifyFrame

    local content = Instance.new("TextLabel")
    content.Size = UDim2.new(1, -8, 0, 40)
    content.Position = UDim2.new(0, 4, 0, 24)
    content.Text = notification.Content
    content.BackgroundTransparency = 1
    content.TextColor3 = RainLib.CurrentTheme.Text
    content.Font = Enum.Font.SourceSans
    content.TextSize = 12
    content.TextWrapped = true
    content.Parent = notifyFrame

    table.insert(RainLib.GUIState.Notifications, notifyFrame)
    
    -- Animação de entrada
    notifyFrame.Position = UDim2.new(1, 0, 1, -90 - (#RainLib.GUIState.Notifications * 90))
    tween(notifyFrame, TweenInfo.new(0.5), { Position = UDim2.new(1, -260, 1, -90 - (#RainLib.GUIState.Notifications * 90)) })

    -- Remove após duração
    spawn(function()
        wait(notification.Duration)
        tween(notifyFrame, TweenInfo.new(0.5), { Position = UDim2.new(1, 0, 1, -90 - (#RainLib.GUIState.Notifications * 90)) }).Completed:Connect(function()
            notifyFrame:Destroy()
            table.remove(RainLib.GUIState.Notifications, table.find(RainLib.GUIState.Notifications, notifyFrame))
            -- Reorganiza notificações
            for i, frame in ipairs(RainLib.GUIState.Notifications) do
                tween(frame, TweenInfo.new(0.3), { Position = UDim2.new(1, -260, 1, -90 - (i * 90)) })
            end
        end)
    end)

    return notification
end

-- Função principal para criar janela
function RainLib:Window(options)
    options = options or {}
    local window = { Tabs = {}, Options = options }
    table.insert(RainLib.GUIState.Windows, { Options = options, Tabs = {} })

    -- Inicializa ScreenGui se necessário
    if not RainLib.ScreenGui then
        RainLib.ScreenGui = Instance.new("ScreenGui")
        RainLib.ScreenGui.Name = "RainLib"
        RainLib.ScreenGui.Parent = game.CoreGui or LocalPlayer:WaitForChild("PlayerGui", 5)
        RainLib.ScreenGui.ResetOnSpawn = false
        RainLib.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    end

    -- Cria o frame principal da janela
    window.MainFrame = Instance.new("Frame")
    window.MainFrame.Size = UDim2.new(0, 600, 0, 400)
    window.MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    window.MainFrame.BackgroundColor3 = RainLib.CurrentTheme.Background
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

    -- Barra de título
    window.TitleBar = Instance.new("Frame")
    window.TitleBar.Size = UDim2.new(1, 0, 0, 45)
    window.TitleBar.BackgroundColor3 = RainLib.CurrentTheme.Secondary
    window.TitleBar.Parent = window.MainFrame

    local titleBarCorner = Instance.new("UICorner")
    titleBarCorner.CornerRadius = UDim.new(0, 10)
    titleBarCorner.Parent = window.TitleBar

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -80, 0, 25)
    title.Position = UDim2.new(0, 10, 0, 5)
    title.Text = options.Title or "RainLib"
    title.BackgroundTransparency = 1
    title.TextColor3 = RainLib.CurrentTheme.Text
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = window.TitleBar

    local subtitle = Instance.new("TextLabel")
    subtitle.Size = UDim2.new(1, -80, 0, 15)
    subtitle.Position = UDim2.new(0, 10, 0, 25)
    subtitle.Text = options.SubTitle or ""
    subtitle.BackgroundTransparency = 1
    subtitle.TextColor3 = RainLib.CurrentTheme.Text
    subtitle.Font = Enum.Font.SourceSans
    subtitle.TextSize = 12
    subtitle.TextXAlignment = Enum.TextXAlignment.Left
    subtitle.Parent = window.TitleBar

    -- Botões de controle
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -40, 0, 7)
    closeButton.BackgroundColor3 = RainLib.CurrentTheme.Accent
    closeButton.Text = "X"
    closeButton.TextColor3 = RainLib.CurrentTheme.Text
    closeButton.Font = Enum.Font.SourceSansBold
    closeButton.TextSize = 14
    closeButton.Parent = window.TitleBar

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 5)
    closeCorner.Parent = closeButton

    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Size = UDim2.new(0, 30, 0, 30)
    minimizeButton.Position = UDim2.new(1, -80, 0, 7)
    minimizeButton.BackgroundColor3 = RainLib.CurrentTheme.Accent
    minimizeButton.Text = "-"
    minimizeButton.TextColor3 = RainLib.CurrentTheme.Text
    minimizeButton.Font = Enum.Font.SourceSansBold
    minimizeButton.TextSize = 14
    minimizeButton.Parent = window.TitleBar

    local minimizeCorner = Instance.new("UICorner")
    minimizeCorner.CornerRadius = UDim.new(0, 5)
    minimizeCorner.Parent = minimizeButton

    -- Container de abas
    window.TabContainer = Instance.new("ScrollingFrame")
    window.TabContainer.Size = UDim2.new(0, 120, 1, -50)
    window.TabContainer.Position = UDim2.new(0, 5, 0, 45)
    window.TabContainer.BackgroundTransparency = 1
    window.TabContainer.ScrollBarThickness = 0
    window.TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    window.TabContainer.Parent = window.MainFrame

    window.TabIndicator = Instance.new("Frame")
    window.TabIndicator.Size = UDim2.new(0, 5, 0, 35)
    window.TabIndicator.BackgroundColor3 = RainLib.CurrentTheme.Accent
    window.TabIndicator.Parent = window.TabContainer

    local indicatorCorner = Instance.new("UICorner")
    indicatorCorner.CornerRadius = UDim.new(0, 5)
    indicatorCorner.Parent = window.TabIndicator

    -- Lógica de arrastar janela
    local dragging, dragStart, startPos
    window.TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = window.MainFrame.Position
        end
    end)
    window.TitleBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    RunService.RenderStepped:Connect(function()
        if dragging then
            local delta = UserInputService:GetMouseLocation() - dragStart
            window.MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- Lógica de fechar janela
    closeButton.MouseButton1Click:Connect(function()
        RainLib.ScreenGui.Enabled = false
        RainLib:Notify({ Title = "Janela Fechada", Content = "A interface foi fechada.", Duration = 3 })
    end)
    closeButton.MouseEnter:Connect(function()
        tween(closeButton, TweenInfo.new(0.2), { BackgroundColor3 = RainLib.CurrentTheme.Accent:Lerp(Color3.fromRGB(255, 0, 0), 0.5) })
    end)
    closeButton.MouseLeave:Connect(function()
        tween(closeButton, TweenInfo.new(0.2), { BackgroundColor3 = RainLib.CurrentTheme.Accent })
    end)

    -- Lógica de minimizar janela
    local minimized = false
    minimizeButton.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            tween(window.MainFrame, TweenInfo.new(0.3), { Size = UDim2.new(0, 600, 0, 45) })
            window.TabContainer.Visible = false
            for _, tab in ipairs(window.Tabs) do
                tab.Content.Visible = false
            end
            minimizeButton.Text = "+"
        else
            tween(window.MainFrame, TweenInfo.new(0.3), { Size = UDim2.new(0, 600, 0, 400) })
            window.TabContainer.Visible = true
            for i, tab in ipairs(window.Tabs) do
                if i == 1 then
                    tab.Content.Visible = true
                end
            end
            minimizeButton.Text = "-"
        end
    end)
    minimizeButton.MouseEnter:Connect(function()
        tween(minimizeButton, TweenInfo.new(0.2), { BackgroundColor3 = RainLib.CurrentTheme.Accent:Lerp(Color3.fromRGB(255, 255, 255), 0.2) })
    end)
    minimizeButton.MouseLeave:Connect(function()
        tween(minimizeButton, TweenInfo.new(0.2), { BackgroundColor3 = RainLib.CurrentTheme.Accent })
    end)

    -- Função para criar abas
    function window:Tab(options)
        local tab = { Elements = {}, Containers = {}, ElementCount = 0 }
        options = options or {}
        tab.Name = options.Title or "Tab"
        tab.Icon = options.Icon

        -- Cria o ScrollingFrame para o conteúdo da aba
        tab.Content = Instance.new("ScrollingFrame")
        tab.Content.Size = UDim2.new(1, -130, 1, -50)
        tab.Content.Position = UDim2.new(0, 125, 0, 45)
        tab.Content.BackgroundTransparency = 1
        tab.Content.ScrollBarThickness = 4
        tab.Content.CanvasSize = UDim2.new(0, 0, 0, 0)
        tab.Content.Visible = false
        tab.Content.Parent = window.MainFrame

        tab.Container = Instance.new("Frame")
        tab.Container.Size = UDim2.new(1, -10, 1, -10)
        tab.Container.Position = UDim2.new(0, 5, 0, 5)
        tab.Container.BackgroundTransparency = 1
        tab.Container.Parent = tab.Content

        -- Botão da aba
        tab.Button = Instance.new("TextButton")
        tab.Button.Size = UDim2.new(1, -10, 0, 35)
        tab.Button.Position = UDim2.new(0, 5, 0, #window.Tabs * 40 + 5)
        tab.Button.BackgroundColor3 = RainLib.CurrentTheme.Secondary
        tab.Button.Text = tab.Icon and "" or tab.Name
        tab.Button.TextColor3 = RainLib.CurrentTheme.Text
        tab.Button.Font = Enum.Font.SourceSansBold
        tab.Button.TextSize = 14
        tab.Button.TextXAlignment = Enum.TextXAlignment.Left
        tab.Button.Parent = window.TabContainer
        window.TabContainer.CanvasSize = UDim2.new(0, 0, 0, #window.Tabs * 40 + 50)

        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 6)
        buttonCorner.Parent = tab.Button

        if tab.Icon then
            local icon = Instance.new("ImageLabel")
            icon.Size = UDim2.new(0, 20, 0, 20)
            icon.Position = UDim2.new(0, 10, 0.5, -10)
            icon.BackgroundTransparency = 1
            icon.Image = tab.Icon
            icon.Parent = tab.Button

            local text = Instance.new("TextLabel")
            text.Size = UDim2.new(1, -35, 1, 0)
            text.Position = UDim2.new(0, 35, 0, 0)
            text.BackgroundTransparency = 1
            text.Text = tab.Name
            text.TextColor3 = RainLib.CurrentTheme.Text
            text.Font = Enum.Font.SourceSansBold
            text.TextSize = 14
            text.TextXAlignment = Enum.TextXAlignment.Left
            text.Parent = tab.Button
        end

        table.insert(window.Tabs, tab)
        table.insert(RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs, { Name = tab.Name, Icon = tab.Icon, Elements = {} })

        -- Lógica de seleção de aba
        local function selectTab(index)
            for i, t in pairs(window.Tabs) do
                if i == index then
                    t.Content.Visible = true
                    tween(t.Content, TweenInfo.new(0.3), { BackgroundTransparency = 1, Position = UDim2.new(0, 125, 0, 45) })
                    tween(window.TabIndicator, TweenInfo.new(0.3, Enum.EasingStyle.Quad), { Position = UDim2.new(0, 0, 0, (i-1) * 40 + 5) })
                    tween(t.Button, TweenInfo.new(0.2), { BackgroundColor3 = RainLib.CurrentTheme.Accent })
                else
                    tween(t.Content, TweenInfo.new(0.3), { Position = UDim2.new(0, 170, 0, 45) }).Completed:Connect(function()
                        t.Content.Visible = false
                    end)
                    tween(t.Button, TweenInfo.new(0.2), { BackgroundColor3 = RainLib.CurrentTheme.Secondary })
                end
            end
        end

        tab.Button.MouseButton1Click:Connect(function()
            selectTab(table.find(window.Tabs, tab))
            RainLib:Notify({ Title = "Aba Selecionada", Content = "Aba " .. tab.Name .. " foi selecionada.", Duration = 2 })
        end)
        tab.Button.MouseEnter:Connect(function()
            if not tab.Content.Visible then
                tween(tab.Button, TweenInfo.new(0.2), { BackgroundColor3 = RainLib.CurrentTheme.Secondary:Lerp(RainLib.CurrentTheme.Accent, 0.3) })
            end
        end)
        tab.Button.MouseLeave:Connect(function()
            if not tab.Content.Visible then
                tween(tab.Button, TweenInfo.new(0.2), { BackgroundColor3 = RainLib.CurrentTheme.Secondary })
            end
        end)

        if #window.Tabs == 1 then
            selectTab(1)
        end

        -- Função para atualizar posições com espaçamento automático
        local function updatePositions()
            local totalHeight = 0
            for _, element in ipairs(tab.Elements) do
                totalHeight = totalHeight + element.Size.Y.Offset + 16 -- Margem do container
            end

            local contentHeight = tab.Content.AbsoluteSize.Y
            local spacing = 0
            if tab.ElementCount > 1 then
                spacing = math.max(0, (contentHeight - totalHeight) / (tab.ElementCount - 1))
            end

            local yOffset = 0
            for i, container in ipairs(tab.Containers) do
                container.Position = UDim2.new(0, 8, 0, yOffset)
                yOffset = yOffset + container.Size.Y.Offset + spacing
            end

            tab.Content.CanvasSize = UDim2.new(0, 0, 0, yOffset)
        end

        -- Função para criar container de elementos
        local function createContainer(element, size)
            local container = Instance.new("Frame")
            container.Size = UDim2.new(1, -16, 0, size.Y.Offset + 16)
            container.BackgroundTransparency = 1
            container.Parent = tab.Container
            element.Parent = container
            element.Position = UDim2.new(0, 8, 0, 8)
            table.insert(tab.Elements, element)
            table.insert(tab.Containers, container)
            tab.ElementCount = tab.ElementCount + 1
            updatePositions()
            return container
        end

        -- Adiciona seção
        function tab:AddSection(options)
            options = options or {}
            local sectionSize = UDim2.new(1, -16, 0, 25)
            local section = Instance.new("Frame")
            section.Size = sectionSize
            section.BackgroundColor3 = RainLib.CurrentTheme.Secondary

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = section

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -8, 1, 0)
            label.Position = UDim2.new(0, 4, 0, 0)
            label.Text = options.Title or "Section"
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = Enum.Font.GothamBold
            label.TextSize = 14
            label.Parent = section

            createContainer(section, sectionSize)
            table.insert(RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs[#RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs].Elements, {
                Type = "Section", Options = options
            })

            return section
        end

        -- Adiciona parágrafo
        function tab:AddParagraph(options)
            options = options or {}
            local paragraphSize = UDim2.new(1, -16, 0, 50)
            local paragraph = Instance.new("Frame")
            paragraph.Size = paragraphSize
            paragraph.BackgroundColor3 = RainLib.CurrentTheme.Secondary

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = paragraph

            local title = Instance.new("TextLabel")
            title.Size = UDim2.new(1, -8, 0, 18)
            title.Position = UDim2.new(0, 4, 0, 4)
            title.Text = options.Title or "Paragraph"
            title.BackgroundTransparency = 1
            title.TextColor3 = RainLib.CurrentTheme.Text
            title.Font = Enum.Font.GothamBold
            title.TextSize = 14
            title.Parent = paragraph

            local content = Instance.new("TextLabel")
            content.Size = UDim2.new(1, -8, 0, 26)
            content.Position = UDim2.new(0, 4, 0, 22)
            content.Text = options.Content or ""
            content.BackgroundTransparency = 1
            content.TextColor3 = RainLib.CurrentTheme.Text
            content.Font = Enum.Font.SourceSans
            content.TextSize = 12
            content.TextWrapped = true
            content.Parent = paragraph

            createContainer(paragraph, paragraphSize)
            table.insert(RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs[#RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs].Elements, {
                Type = "Paragraph", Options = options
            })

            return paragraph
        end

        -- Adiciona botão
        function tab:AddButton(options)
            options = options or {}
            local buttonSize = UDim2.new(1, -16, 0, 35)
            local button = Instance.new("TextButton")
            button.Size = buttonSize
            button.Text = options.Title or "Button"
            button.BackgroundColor3 = RainLib.CurrentTheme.Accent
            button.TextColor3 = RainLib.CurrentTheme.Text
            button.Font = Enum.Font.SourceSansBold
            button.TextSize = 14
            button.TextWrapped = true

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = button

            local stroke = Instance.new("UIStroke")
            stroke.Thickness = 1
            stroke.Color = RainLib.CurrentTheme.Accent:Lerp(Color3.fromRGB(0, 0, 0), 0.2)
            stroke.Parent = button

            createContainer(button, buttonSize)
            button.MouseButton1Click:Connect(function()
                if options.Callback then
                    options.Callback()
                end
                RainLib:Notify({ Title = "Botão Clicado", Content = options.Title or "Botão", Duration = 2 })
            end)
            button.MouseEnter:Connect(function()
                tween(button, TweenInfo.new(0.2), { BackgroundColor3 = RainLib.CurrentTheme.Accent:Lerp(Color3.fromRGB(255, 255, 255), 0.2) })
            end)
            button.MouseLeave:Connect(function()
                tween(button, TweenInfo.new(0.2), { BackgroundColor3 = RainLib.CurrentTheme.Accent })
            end)

            table.insert(RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs[#RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs].Elements, {
                Type = "Button", Options = options
            })

            return button
        end

        -- Adiciona toggle
        function tab:AddToggle(key, options)
            options = options or {}
            local toggleSize = UDim2.new(1, -16, 0, 35)
            local toggle = { Value = options.Default or false }
            local frame = Instance.new("Frame")
            frame.Size = toggleSize
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = frame

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -60, 1, 0)
            label.Text = options.Title or "Toggle"
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = Enum.Font.SourceSans
            label.TextSize = 14
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.TextWrapped = true
            label.Parent = frame

            local switchContainer = Instance.new("Frame")
            switchContainer.Size = UDim2.new(0, 40, 0, 20)
            switchContainer.Position = UDim2.new(1, -48, 0.5, -10)
            switchContainer.BackgroundColor3 = toggle.Value and RainLib.CurrentTheme.Accent or RainLib.CurrentTheme.Disabled
            switchContainer.Parent = frame

            local switchCorner = Instance.new("UICorner")
            switchCorner.CornerRadius = UDim.new(0, 10)
            switchCorner.Parent = switchContainer

            local switchKnob = Instance.new("Frame")
            switchKnob.Size = UDim2.new(0, 16, 0, 16)
            switchKnob.Position = toggle.Value and UDim2.new(1, -20, 0, 2) or UDim2.new(0, 4, 0, 2)
            switchKnob.BackgroundColor3 = RainLib.CurrentTheme.Text
            switchKnob.Parent = switchContainer

            local knobCorner = Instance.new("UICorner")
            knobCorner.CornerRadius = UDim.new(0, 8)
            knobCorner.Parent = switchKnob

            if options.Flag and window.Options.SaveSettings then
                local settings = RainLib:LoadSettings(window.Options.ConfigFolder)
                if settings and settings.Flags[options.Flag] ~= nil then
                    toggle.Value = settings.Flags[options.Flag]
                    switchContainer.BackgroundColor3 = toggle.Value and RainLib.CurrentTheme.Accent or RainLib.CurrentTheme.Disabled
                    switchKnob.Position = toggle.Value and UDim2.new(1, -20, 0, 2) or UDim2.new(0, 4, 0, 2)
                end
            end

            createContainer(frame, toggleSize)
            frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    toggle.Value = not toggle.Value
                    tween(switchContainer, TweenInfo.new(0.2), {
                        BackgroundColor3 = toggle.Value and RainLib.CurrentTheme.Accent or RainLib.CurrentTheme.Disabled
                    })
                    tween(switchKnob, TweenInfo.new(0.2), {
                        Position = toggle.Value and UDim2.new(1, -20, 0, 2) or UDim2.new(0, 4, 0, 2)
                    })
                    if options.Callback then
                        options.Callback(toggle.Value)
                    end
                    if options.Flag and window.Options.SaveSettings then
                        local settings = RainLib:LoadSettings(window.Options.ConfigFolder) or { Flags = {} }
                        settings.Flags[options.Flag] = toggle.Value
                        RainLib:SaveSettings(window.Options.ConfigFolder, settings)
                    end
                    RainLib:Notify({ Title = "Toggle Alterado", Content = options.Title .. ": " .. tostring(toggle.Value), Duration = 2 })
                end
            end)

            frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    tween(switchContainer, TweenInfo.new(0.2), {
                        BackgroundColor3 = toggle.Value and RainLib.CurrentTheme.Accent:Lerp(Color3.fromRGB(255, 255, 255), 0.1) or RainLib.CurrentTheme.Disabled:Lerp(Color3.fromRGB(255, 255, 255), 0.1)
                    })
                end
            end)
            frame.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    tween(switchContainer, TweenInfo.new(0.2), {
                        BackgroundColor3 = toggle.Value and RainLib.CurrentTheme.Accent or RainLib.CurrentTheme.Disabled
                    })
                end
            end)

            table.insert(RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs[#RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs].Elements, {
                Type = "Toggle", Key = key, Options = options
            })

            return toggle
        end

        -- Adiciona slider
        function tab:AddSlider(key, options)
            options = options or {}
            local sliderSize = UDim2.new(1, -16, 0, 35)
            local slider = { Value = options.Default or options.Min or 0 }
            local frame = Instance.new("Frame")
            frame.Size = sliderSize
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = frame

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -40, 0, 18)
            label.Text = options.Title or "Slider"
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = Enum.Font.SourceSans
            label.TextSize = 12
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.TextWrapped = true
            label.Parent = frame

            local valueLabel = Instance.new("TextLabel")
            valueLabel.Size = UDim2.new(0, 30, 0, 18)
            valueLabel.Position = UDim2.new(1, -34, 0, 0)
            valueLabel.Text = tostring(slider.Value)
            valueLabel.BackgroundTransparency = 1
            valueLabel.TextColor3 = RainLib.CurrentTheme.Text
            valueLabel.Font = Enum.Font.SourceSans
            valueLabel.TextSize = 12
            valueLabel.Parent = frame

            local bar = Instance.new("Frame")
            bar.Size = UDim2.new(1, -8, 0, 6)
            bar.Position = UDim2.new(0, 4, 0, 22)
            bar.BackgroundColor3 = RainLib.CurrentTheme.Disabled
            bar.Parent = frame

            local fill = Instance.new("Frame")
            fill.Size = UDim2.new((slider.Value - (options.Min or 0)) / ((options.Max or 100) - (options.Min or 0)), 0, 1, 0)
            fill.BackgroundColor3 = RainLib.CurrentTheme.Accent
            fill.Parent = bar

            local cornerBar = Instance.new("UICorner")
            cornerBar.CornerRadius = UDim.new(0, 3)
            cornerBar.Parent = bar

            local cornerFill = Instance.new("UICorner")
            cornerFill.CornerRadius = UDim.new(0, 3)
            cornerFill.Parent = fill

            if options.Flag and window.Options.SaveSettings then
                local settings = RainLib:LoadSettings(window.Options.ConfigFolder)
                if settings and settings.Flags[options.Flag] ~= nil then
                    slider.Value = settings.Flags[options.Flag]
                    fill.Size = UDim2.new((slider.Value - (options.Min or 0)) / ((options.Max or 100) - (options.Min or 0)), 0, 1, 0)
                    valueLabel.Text = tostring(slider.Value)
                end
            end

            createContainer(frame, sliderSize)
            local dragging
            bar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    tween(bar, TweenInfo.new(0.2), { BackgroundColor3 = RainLib.CurrentTheme.Disabled:Lerp(RainLib.CurrentTheme.Accent, 0.2) })
                end
            end)
            bar.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                    tween(bar, TweenInfo.new(0.2), { BackgroundColor3 = RainLib.CurrentTheme.Disabled })
                end
            end)
            RunService.RenderStepped:Connect(function()
                if dragging then
                    local mousePos = UserInputService:GetMouseLocation()
                    local relativeX = math.clamp((mousePos.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
                    slider.Value = math.floor((options.Min or 0) + relativeX * ((options.Max or 100) - (options.Min or 0)))
                    if options.Rounding then
                        slider.Value = math.floor(slider.Value / options.Rounding) * options.Rounding
                    end
                    tween(fill, TweenInfo.new(0.1), { Size = UDim2.new(relativeX, 0, 1, 0) })
                    valueLabel.Text = tostring(slider.Value)
                    if options.Callback then
                        options.Callback(slider.Value)
                    end
                    if options.Flag and window.Options.SaveSettings then
                        local settings = RainLib:LoadSettings(window.Options.ConfigFolder) or { Flags = {} }
                        settings.Flags[options.Flag] = slider.Value
                        RainLib:SaveSettings(window.Options.ConfigFolder, settings)
                    end
                end
            end)

            table.insert(RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs[#RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs].Elements, {
                Type = "Slider", Key = key, Options = options
            })

            return slider
        end

        -- Adiciona dropdown
        function tab:AddDropdown(key, options)
            options = options or {}
            local dropdownSize = UDim2.new(1, -16, 0, 35)
            local dropdown = { Value = options.Default or (options.Items and options.Items[1]) }
            local frame = Instance.new("Frame")
            frame.Size = dropdownSize
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = frame

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -100, 1, 0)
            label.Text = options.Title or "Dropdown"
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = Enum.Font.SourceSans
            label.TextSize = 14
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.TextWrapped = true
            label.Parent = frame

            local button = Instance.new("TextButton")
            button.Size = UDim2.new(0, 90, 0, 25)
            button.Position = UDim2.new(1, -95, 0, 5)
            button.BackgroundColor3 = RainLib.CurrentTheme.Disabled
            button.Text = dropdown.Value or "Select"
            button.TextColor3 = RainLib.CurrentTheme.Text
            button.Font = Enum.Font.SourceSans
            button.TextSize = 12
            button.TextWrapped = true
            button.Parent = frame

            local buttonCorner = Instance.new("UICorner")
            buttonCorner.CornerRadius = UDim.new(0, 5)
            buttonCorner.Parent = button

            local listFrame = Instance.new("Frame")
            listFrame.Size = UDim2.new(0, 90, 0, 0)
            listFrame.Position = UDim2.new(1, -95, 0, 35)
            listFrame.BackgroundColor3 = RainLib.CurrentTheme.Secondary
            listFrame.Visible = false
            listFrame.Parent = frame

            local listCorner = Instance.new("UICorner")
            listCorner.CornerRadius = UDim.new(0, 5)
            listCorner.Parent = listFrame

            local listLayout = Instance.new("UIListLayout")
            listLayout.SortOrder = Enum.SortOrder.LayoutOrder
            listLayout.Parent = listFrame

            if options.Flag and window.Options.SaveSettings then
                local settings = RainLib:LoadSettings(window.Options.ConfigFolder)
                if settings and settings.Flags[options.Flag] ~= nil then
                    dropdown.Value = settings.Flags[options.Flag]
                    button.Text = dropdown.Value
                end
            end

            local function updateList()
                listFrame.Size = UDim2.new(0, 90, 0, math.min(#options.Items * 25, 100))
                for _, item in ipairs(options.Items or {}) do
                    local itemButton = Instance.new("TextButton")
                    itemButton.Size = UDim2.new(1, 0, 0, 25)
                    itemButton.BackgroundColor3 = RainLib.CurrentTheme.Secondary
                    itemButton.Text = tostring(item)
                    itemButton.TextColor3 = RainLib.CurrentTheme.Text
                    itemButton.Font = Enum.Font.SourceSans
                    itemButton.TextSize = 12
                    itemButton.TextWrapped = true
                    itemButton.Parent = listFrame

                    itemButton.MouseButton1Click:Connect(function()
                        dropdown.Value = item
                        button.Text = tostring(item)
                        listFrame.Visible = false
                        if options.Callback then
                            options.Callback(dropdown.Value)
                        end
                        if options.Flag and window.Options.SaveSettings then
                            local settings = RainLib:LoadSettings(window.Options.ConfigFolder) or { Flags = {} }
                            settings.Flags[options.Flag] = dropdown.Value
                            RainLib:SaveSettings(window.Options.ConfigFolder, settings)
                        end
                        RainLib:Notify({ Title = "Dropdown Alterado", Content = options.Title .. ": " .. tostring(item), Duration = 2 })
                    end)
                end
            end
            updateList()

            createContainer(frame, dropdownSize)
            button.MouseButton1Click:Connect(function()
                listFrame.Visible = not listFrame.Visible
                tween(listFrame, TweenInfo.new(0.2), { Size = listFrame.Visible and UDim2.new(0, 90, 0, math.min(#options.Items * 25, 100)) or UDim2.new(0, 90, 0, 0) })
            end)

            table.insert(RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs[#RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs].Elements, {
                Type = "Dropdown", Key = key, Options = options
            })

            return dropdown
        end

        -- Adiciona keybind
        function tab:AddKeybind(key, options)
            options = options or {}
            local keybindSize = UDim2.new(1, -16, 0, 35)
            local keybind = { Value = options.Default or Enum.KeyCode.Unknown }
            local frame = Instance.new("Frame")
            frame.Size = keybindSize
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = frame

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -100, 1, 0)
            label.Text = options.Title or "Keybind"
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = Enum.Font.SourceSans
            label.TextSize = 14
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.TextWrapped = true
            label.Parent = frame

            local button = Instance.new("TextButton")
            button.Size = UDim2.new(0, 90, 0, 25)
            button.Position = UDim2.new(1, -95, 0, 5)
            button.BackgroundColor3 = RainLib.CurrentTheme.Disabled
            button.Text = keybind.Value.Name or "None"
            button.TextColor3 = RainLib.CurrentTheme.Text
            button.Font = Enum.Font.SourceSans
            button.TextSize = 12
            button.TextWrapped = true
            button.Parent = frame

            local buttonCorner = Instance.new("UICorner")
            buttonCorner.CornerRadius = UDim.new(0, 5)
            buttonCorner.Parent = button

            if options.Flag and window.Options.SaveSettings then
                local settings = RainLib:LoadSettings(window.Options.ConfigFolder)
                if settings and settings.Flags[options.Flag] ~= nil then
                    keybind.Value = Enum.KeyCode[settings.Flags[options.Flag]] or keybind.Value
                    button.Text = keybind.Value.Name or "None"
                end
            end

            createContainer(frame, keybindSize)
            local binding
            button.MouseButton1Click:Connect(function()
                button.Text = "..."
                binding = true
            end)
            UserInputService.InputBegan:Connect(function(input)
                if binding and input.KeyCode ~= Enum.KeyCode.Unknown then
                    keybind.Value = input.KeyCode
                    button.Text = keybind.Value.Name
                    binding = false
                    if options.Callback then
                        options.Callback(keybind.Value)
                    end
                    if options.Flag and window.Options.SaveSettings then
                        local settings = RainLib:LoadSettings(window.Options.ConfigFolder) or { Flags = {} }
                        settings.Flags[options.Flag] = keybind.Value.Name
                        RainLib:SaveSettings(window.Options.ConfigFolder, settings)
                    end
                    RainLib:Notify({ Title = "Keybind Alterado", Content = options.Title .. ": " .. keybind.Value.Name, Duration = 2 })
                end
            end)

            table.insert(RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs[#RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs].Elements, {
                Type = "Keybind", Key = key, Options = options
            })

            return keybind
        end

        -- Adiciona input
        function tab:AddInput(key, options)
            options = options or {}
            local inputSize = UDim2.new(1, -16, 0, 35)
            local input = { Value = options.Default or "" }
            local frame = Instance.new("Frame")
            frame.Size = inputSize
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = frame

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -100, 1, 0)
            label.Text = options.Title or "Input"
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = Enum.Font.SourceSans
            label.TextSize = 14
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.TextWrapped = true
            label.Parent = frame

            local textBox = Instance.new("TextBox")
            textBox.Size = UDim2.new(0, 90, 0, 25)
            textBox.Position = UDim2.new(1, -95, 0, 5)
            textBox.BackgroundColor3 = RainLib.CurrentTheme.Disabled
            textBox.Text = input.Value
            textBox.TextColor3 = RainLib.CurrentTheme.Text
            textBox.Font = Enum.Font.SourceSans
            textBox.TextSize = 12
            textBox.TextWrapped = true
            textBox.Parent = frame

            local textBoxCorner = Instance.new("UICorner")
            textBoxCorner.CornerRadius = UDim.new(0, 5)
            textBoxCorner.Parent = textBox

            if options.Flag and window.Options.SaveSettings then
                local settings = RainLib:LoadSettings(window.Options.ConfigFolder)
                if settings and settings.Flags[options.Flag] ~= nil then
                    input.Value = settings.Flags[options.Flag]
                    textBox.Text = input.Value
                end
            end

            createContainer(frame, inputSize)
            textBox.FocusLost:Connect(function()
                input.Value = textBox.Text
                if options.Callback then
                    options.Callback(input.Value)
                end
                if options.Flag and window.Options.SaveSettings then
                    local settings = RainLib:LoadSettings(window.Options.ConfigFolder) or { Flags = {} }
                    settings.Flags[options.Flag] = input.Value
                    RainLib:SaveSettings(window.Options.ConfigFolder, settings)
                end
                RainLib:Notify({ Title = "Input Alterado", Content = options.Title .. ": " .. input.Value, Duration = 2 })
            end)

            table.insert(RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs[#RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs].Elements, {
                Type = "Input", Key = key, Options = options
            })

            return input
        end

        -- Adiciona diálogo
        function tab:AddDialog(options)
            options = options or {}
            local dialog = {}
            local dialogFrame = Instance.new("Frame")
            dialogFrame.Size = UDim2.new(0, 250, 0, 130)
            dialogFrame.Position = UDim2.new(0.5, -125, 0.5, -65)
            dialogFrame.BackgroundColor3 = RainLib.CurrentTheme.Background
            dialogFrame.Visible = false
            dialogFrame.Parent = RainLib.ScreenGui

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 10)
            corner.Parent = dialogFrame

            local shadow = Instance.new("ImageLabel")
            shadow.Size = UDim2.new(1, 20, 1, 20)
            shadow.Position = UDim2.new(0, -10, 0, -10)
            shadow.BackgroundTransparency = 1
            shadow.Image = "rbxassetid://1316045217"
            shadow.ImageTransparency = 0.7
            shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
            shadow.ScaleType = Enum.ScaleType.Slice
            shadow.SliceCenter = Rect.new(10, 10, 118, 118)
            shadow.Parent = dialogFrame

            local title = Instance.new("TextLabel")
            title.Size = UDim2.new(1, -8, 0, 25)
            title.Position = UDim2.new(0, 4, 0, 4)
            title.Text = options.Title or "Dialog"
            title.BackgroundTransparency = 1
            title.TextColor3 = RainLib.CurrentTheme.Text
            title.Font = Enum.Font.GothamBold
            title.TextSize = 16
            title.Parent = dialogFrame

            local content = Instance.new("TextLabel")
            content.Size = UDim2.new(1, -8, 0, 45)
            content.Position = UDim2.new(0, 4, 0, 35)
            content.Text = options.Content or ""
            content.BackgroundTransparency = 1
            content.TextColor3 = RainLib.CurrentTheme.Text
            content.Font = Enum.Font.SourceSans
            content.TextSize = 12
            content.TextWrapped = true
            content.Parent = dialogFrame

            local buttonsFrame = Instance.new("Frame")
            buttonsFrame.Size = UDim2.new(1, -8, 0, 35)
            buttonsFrame.Position = UDim2.new(0, 4, 1, -40)
            buttonsFrame.BackgroundTransparency = 1
            buttonsFrame.Parent = dialogFrame

            local buttonLayout = Instance.new("UIListLayout")
            buttonLayout.FillDirection = Enum.FillDirection.Horizontal
            buttonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
            buttonLayout.SortOrder = Enum.SortOrder.LayoutOrder
            buttonLayout.Padding = UDim.new(0, 8)
            buttonLayout.Parent = buttonsFrame

            for i, btn in ipairs(options.Buttons or {}) do
                local btnFrame = Instance.new("TextButton")
                btnFrame.Size = UDim2.new(0, 70, 0, 25)
                btnFrame.BackgroundColor3 = RainLib.CurrentTheme.Accent
                btnFrame.Text = btn.Text or "Button " .. i
                btnFrame.TextColor3 = RainLib.CurrentTheme.Text
                btnFrame.Font = Enum.Font.SourceSansBold
                btnFrame.TextSize = 12
                btnFrame.TextWrapped = true
                btnFrame.Parent = buttonsFrame

                local btnCorner = Instance.new("UICorner")
                btnCorner.CornerRadius = UDim.new(0, 5)
                btnCorner.Parent = btnFrame

                btnFrame.MouseButton1Click:Connect(function()
                    dialogFrame.Visible = false
                    if btn.Callback then
                        btn.Callback()
                    end
                    RainLib:Notify({ Title = "Diálogo", Content = "Botão " .. btn.Text .. " clicado.", Duration = 2 })
                end)
            end

            function dialog:Show()
                dialogFrame.Visible = true
                tween(dialogFrame, TweenInfo.new(0.5), { BackgroundTransparency = 0 })
            end

            function dialog:Hide()
                tween(dialogFrame, TweenInfo.new(0.5), { BackgroundTransparency = 1 }).Completed:Connect(function()
                    dialogFrame.Visible = false
                end)
            end

            table.insert(RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs[#RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs].Elements, {
                Type = "Dialog", Options = options
            })

            return dialog
        end

        return tab
    end

    return window
end

-- Função para recriar a GUI
function RainLib:RecreateGUI()
    if RainLib.ScreenGui then
        RainLib.ScreenGui:Destroy()
        RainLib.ScreenGui = Instance.new("ScreenGui")
        RainLib.ScreenGui.Name = "RainLib"
        RainLib.ScreenGui.Parent = game.CoreGui or LocalPlayer:WaitForChild("PlayerGui", 5)
        RainLib.ScreenGui.ResetOnSpawn = false
        RainLib.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    end

    for _, windowState in ipairs(RainLib.GUIState.Windows) do
        local window = RainLib:Window(windowState.Options)
        for _, tabState in ipairs(windowState.Tabs) do
            local tab = window:Tab({ Title = tabState.Name, Icon = tabState.Icon })
            for _, elementState in ipairs(tabState.Elements) do
                if elementState.Type == "Section" then
                    tab:AddSection(elementState.Options)
                elseif elementState.Type == "Paragraph" then
                    tab:AddParagraph(elementState.Options)
                elseif elementState.Type == "Button" then
                    tab:AddButton(elementState.Options)
                elseif elementState.Type == "Toggle" then
                    tab:AddToggle(elementState.Key, elementState.Options)
                elseif elementState.Type == "Slider" then
                    tab:AddSlider(elementState.Key, elementState.Options)
                elseif elementState.Type == "Dropdown" then
                    tab:AddDropdown(elementState.Key, elementState.Options)
                elseif elementState.Type == "Keybind" then
                    tab:AddKeybind(elementState.Key, elementState.Options)
                elseif elementState.Type == "Input" then
                    tab:AddInput(elementState.Key, elementState.Options)
                elseif elementState.Type == "Dialog" then
                    tab:AddDialog(elementState.Options)
                end
            end
        end
    end
end

-- Função para destruir a GUI
function RainLib:Destroy()
    if RainLib.ScreenGui then
        RainLib.ScreenGui:Destroy()
        RainLib.ScreenGui = nil
        RainLib.GUIState = { Windows = {}, Notifications = {} }
    end
end

-- Inicializa eventos globais
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        if RainLib.ScreenGui then
            RainLib.ScreenGui.Enabled = not RainLib.ScreenGui.Enabled
            RainLib:Notify({ Title = "Interface", Content = RainLib.ScreenGui.Enabled and "Interface exibida" or "Interface oculta", Duration = 2 })
        end
    end
end)

return RainLib
