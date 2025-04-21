-- RainLib: Biblioteca UI para Roblox com espaçamento automático e funcionalidades avançadas
-- Versão: 1.1.4 (atualizada para incluir espaçamento automático e novos elementos)
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local HttpService = game:GetService("HttpService")

local RainLib = {
    Version = "1.1.4", -- Versão atualizada
    Themes = {
        Dark = {
            Background = Color3.fromRGB(25, 25, 25),
            Accent = Color3.fromRGB(60, 160, 255),
            Text = Color3.fromRGB(240, 240, 240),
            Secondary = Color3.fromRGB(45, 45, 45),
            Disabled = Color3.fromRGB(90, 90, 90),
            Notification = Color3.fromRGB(35, 35, 35)
        },
        Light = { -- Novo tema para demonstração
            Background = Color3.fromRGB(240, 240, 240),
            Accent = Color3.fromRGB(0, 120, 255),
            Text = Color3.fromRGB(20, 20, 20),
            Secondary = Color3.fromRGB(200, 200, 200),
            Disabled = Color3.fromRGB(150, 150, 150),
            Notification = Color3.fromRGB(220, 220, 220)
        }
    },
    CurrentTheme = nil,
    CreatedFolders = {},
    GUIState = { Windows = {}, Notifications = {} }
}

-- Função auxiliar para animações
-- Cria uma animação com TweenService, permitindo personalização de duração e estilo
local function tween(obj, info, properties)
    local t = TweenService:Create(obj, info or TweenInfo.new(0.3, Enum.EasingStyle.Quint), properties)
    t:Play()
    return t
end

-- Função para arrastar janela
-- Permite arrastar a janela clicando e movendo o mouse ou toque
local function MakeDraggable(DragPoint, Main)
    local Dragging, DragInput, MousePos, FramePos
    DragPoint.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            MousePos = input.Position
            FramePos = Main.Position
            tween(DragPoint, nil, {BackgroundColor3 = RainLib.CurrentTheme.Accent:Lerp(Color3.fromRGB(255, 255, 255), 0.1)})
        end
    end)
    DragPoint.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            DragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == DragInput and Dragging then
            local Delta = input.Position - MousePos
            Main.Position = UDim2.new(FramePos.X.Scale, FramePos.X.Offset + Delta.X, FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y)
        end
    end)
    DragPoint.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = false
            tween(DragPoint, nil, {BackgroundColor3 = RainLib.CurrentTheme.Secondary})
        end
    end)
end

-- Função para redimensionar janela (nova funcionalidade)
-- Permite redimensionar a janela arrastando a borda inferior direita
local function MakeResizable(MainFrame)
    local ResizeHandle = Instance.new("Frame")
    ResizeHandle.Size = UDim2.new(0, 15, 0, 15)
    ResizeHandle.Position = UDim2.new(1, -15, 1, -15)
    ResizeHandle.BackgroundColor3 = RainLib.CurrentTheme.Accent
    ResizeHandle.Parent = MainFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = ResizeHandle

    local Dragging, DragInput, StartSize, StartPos
    ResizeHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            StartPos = input.Position
            StartSize = MainFrame.Size
        end
    end)
    ResizeHandle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            DragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == DragInput and Dragging then
            local Delta = input.Position - StartPos
            local NewWidth = math.max(300, StartSize.X.Offset + Delta.X)
            local NewHeight = math.max(200, StartSize.Y.Offset + Delta.Y)
            MainFrame.Size = UDim2.new(0, NewWidth, 0, NewHeight)
        end
    end)
    ResizeHandle.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = false
        end
    end)
end

-- Inicialização da biblioteca
print("[RainLib] Inicializando...")
local success, err = pcall(function()
    RainLib.ScreenGui = Instance.new("ScreenGui")
    RainLib.ScreenGui.Name = "RainLib"
    RainLib.ScreenGui.Parent = game.CoreGui or LocalPlayer:WaitForChild("PlayerGui", 5)
    RainLib.ScreenGui.ResetOnSpawn = false
    RainLib.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    RainLib.CurrentTheme = RainLib.Themes.Dark
end)
if not success then
    warn("[RainLib] Falha na inicialização: " .. err)
    return nil
end
print("[RainLib] Inicializado com sucesso!")

-- Função para criar pastas de configuração
-- Cria uma pasta para salvar configurações, se suportado pelo ambiente
function RainLib:CreateFolder(folderName)
    if not folderName or folderName == "" then
        warn("[RainLib] Nome da pasta não especificado!")
        return false
    end
    if makefolder and writefile and not self.CreatedFolders[folderName] then
        if not isfolder(folderName) then
            makefolder(folderName)
            local settingsPath = folderName .. "/Settings.json"
            writefile(settingsPath, HttpService:JSONEncode({ Theme = "Dark", Flags = {} }))
            self:Notify(nil, { Title = "Sucesso", Content = "Pasta '" .. folderName .. "' criada!", Duration = 3 })
        end
        self.CreatedFolders[folderName] = true
        return true
    end
    return false
end

-- Funções para salvar e carregar configurações
-- Salvam e recuperam configurações em formato JSON
function RainLib:SaveSettings(folderName, settings)
    if isfolder(folderName) and writefile then
        writefile(folderName .. "/Settings.json", HttpService:JSONEncode(settings))
    end
end

function RainLib:LoadSettings(folderName)
    if isfolder(folderName) and isfile(folderName .. "/Settings.json") then
        local success, settings = pcall(function()
            return HttpService:JSONDecode(readfile(folderName .. "/Settings.json"))
        end)
        return success and settings or nil
    end
    return nil
end

-- Função para aplicar tema personalizado
-- Permite mudar o tema da interface dinamicamente
function RainLib:SetTheme(themeName)
    if self.Themes[themeName] then
        self.CurrentTheme = self.Themes[themeName]
        self:RecreateGUI() -- Recria a GUI para aplicar o novo tema
        self:Notify(nil, { Title = "Tema Alterado", Content = "Tema '" .. themeName .. "' aplicado!", Duration = 3 })
    else
        warn("[RainLib] Tema '" .. themeName .. "' não encontrado!")
    end
end

-- Função para notificações
-- Exibe notificações flutuantes com animações
function RainLib:Notify(window, options)
    local target = window and window.Notifications or RainLib.ScreenGui
    local notification = Instance.new("Frame")
    notification.Size = UDim2.new(0, 250, 0, 70)
    notification.Position = UDim2.new(1, 260, 0, (#target:GetChildren() - 1) * 80 + 10)
    notification.BackgroundColor3 = RainLib.CurrentTheme.Notification or RainLib.CurrentTheme.Background
    notification.Parent = target

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = notification

    local shadow = Instance.new("ImageLabel")
    shadow.Size = UDim2.new(1, 20, 1, 20)
    shadow.Position = UDim2.new(0, -10, 0, -10)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageTransparency = 0.7
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.Parent = notification

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -10, 0, 20)
    title.Position = UDim2.new(0, 5, 0, 5)
    title.Text = options.Title or "Notificação"
    title.BackgroundTransparency = 1
    title.TextColor3 = RainLib.CurrentTheme.Text
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14
    title.Parent = notification

    local message = Instance.new("TextLabel")
    message.Size = UDim2.new(1, -10, 0, 40)
    message.Position = UDim2.new(0, 5, 0, 25)
    message.Text = options.Content or ""
    message.BackgroundTransparency = 1
    message.TextColor3 = RainLib.CurrentTheme.Text
    message.Font = Enum.Font.SourceSans
    message.TextSize = 12
    message.TextWrapped = true
    message.Parent = notification

    tween(notification, TweenInfo.new(0.5), { Position = UDim2.new(1, -260, 0, notification.Position.Y.Offset), BackgroundTransparency = 0 })
    task.spawn(function()
        task.wait(options.Duration or 3)
        tween(notification, TweenInfo.new(0.5), { Position = UDim2.new(1, 260, 0, notification.Position.Y.Offset), BackgroundTransparency = 1 }).Completed:Connect(function()
            notification:Destroy()
        end)
    end)
end

-- Função para criar janela
-- Cria uma janela com abas, notificações e controles
function RainLib:Window(options)
    local window = { Tabs = {}, Notifications = Instance.new("Frame") }
    options = options or {}
    window.Options = {
        Title = options.Title or "Rain Lib",
        SubTitle = options.SubTitle or "",
        Position = options.Position or UDim2.new(0.5, -250, 0.5, -175),
        Theme = options.Theme or "Dark",
        MinimizeKey = options.MinimizeKey or Enum.KeyCode.LeftControl,
        SaveSettings = options.SaveSettings or false,
        ConfigFolder = options.ConfigFolder or "RainConfig"
    }

    if window.Options.SaveSettings then
        RainLib:CreateFolder(window.Options.ConfigFolder)
    end

    window.Notifications.Size = UDim2.new(0, 260, 1, -25)
    window.Notifications.Position = UDim2.new(1, -270, 0, 0)
    window.Notifications.BackgroundTransparency = 1
    window.Notifications.Parent = RainLib.ScreenGui

    window.MainFrame = Instance.new("Frame")
    window.MainFrame.Size = UDim2.new(0, 500, 0, 350)
    window.MainFrame.Position = UDim2.new(0.5, -250, 0.5, 300)
    window.MainFrame.BackgroundColor3 = RainLib.CurrentTheme.Background
    window.MainFrame.ClipsDescendants = true
    window.MainFrame.Parent = RainLib.ScreenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = window.MainFrame

    local shadow = Instance.new("ImageLabel")
    shadow.Size = UDim2.new(1, 40, 1, 40)
    shadow.Position = UDim2.new(0, -20, 0, -20)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageTransparency = 0.6
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.Parent = window.MainFrame

    window.TitleBar = Instance.new("Frame")
    window.TitleBar.Size = UDim2.new(1, 0, 0, 40)
    window.TitleBar.BackgroundColor3 = RainLib.CurrentTheme.Secondary
    window.TitleBar.Parent = window.MainFrame

    local titleGradient = Instance.new("UIGradient")
    titleGradient.Color = ColorSequence.new(RainLib.CurrentTheme.Secondary, RainLib.CurrentTheme.Background)
    titleGradient.Rotation = 90
    titleGradient.Parent = window.TitleBar

    window.TitleLabel = Instance.new("TextLabel")
    window.TitleLabel.Size = UDim2.new(1, -60, 0, 20)
    window.TitleLabel.Position = UDim2.new(0, 10, 0, 5)
    window.TitleLabel.BackgroundTransparency = 1
    window.TitleLabel.Text = window.Options.Title
    window.TitleLabel.TextColor3 = RainLib.CurrentTheme.Text
    window.TitleLabel.Font = Enum.Font.GothamBold
    window.TitleLabel.TextSize = 14
    window.TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    window.TitleLabel.Parent = window.TitleBar

    window.SubTitleLabel = Instance.new("TextLabel")
    window.SubTitleLabel.Size = UDim2.new(1, -60, 0, 15)
    window.SubTitleLabel.Position = UDim2.new(0, 10, 0, 20)
    window.SubTitleLabel.BackgroundTransparency = 1
    window.SubTitleLabel.Text = window.Options.SubTitle
    window.SubTitleLabel.TextColor3 = RainLib.CurrentTheme.Text
    window.SubTitleLabel.Font = Enum.Font.Gotham
    window.SubTitleLabel.TextSize = 10
    window.SubTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    window.SubTitleLabel.Parent = window.TitleBar

    window.CloseButton = Instance.new("TextButton")
    window.CloseButton.Size = UDim2.new(0, 25, 0, 25)
    window.CloseButton.Position = UDim2.new(1, -35, 0, 7)
    window.CloseButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    window.CloseButton.Text = "X"
    window.CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    window.CloseButton.Font = Enum.Font.SourceSansBold
    window.CloseButton.TextSize = 12
    window.CloseButton.Parent = window.TitleBar

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 6)
    closeCorner.Parent = window.CloseButton

    window.MinimizeBtn = Instance.new("TextButton")
    window.MinimizeBtn.Size = UDim2.new(0, 25, 0, 25)
    window.MinimizeBtn.Position = UDim2.new(1, -65, 0, 7)
    window.MinimizeBtn.BackgroundColor3 = RainLib.CurrentTheme.Accent
    window.MinimizeBtn.Text = "-"
    window.MinimizeBtn.TextColor3 = RainLib.CurrentTheme.Text
    window.MinimizeBtn.Font = Enum.Font.SourceSansBold
    window.MinimizeBtn.TextSize = 12
    window.MinimizeBtn.Parent = window.TitleBar

    local minimizeCorner = Instance.new("UICorner")
    minimizeCorner.CornerRadius = UDim.new(0, 6)
    minimizeCorner.Parent = window.MinimizeBtn

    window.TabContainer = Instance.new("ScrollingFrame")
    window.TabContainer.Size = UDim2.new(0, 120, 1, -40)
    window.TabContainer.Position = UDim2.new(0, 0, 0, 40)
    window.TabContainer.BackgroundColor3 = RainLib.CurrentTheme.Secondary
    window.TabContainer.ScrollBarThickness = 0
    window.TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    window.TabContainer.Parent = window.MainFrame

    window.TabIndicator = Instance.new("Frame")
    window.TabIndicator.Size = UDim2.new(0, 3, 0, 35)
    window.TabIndicator.BackgroundColor3 = RainLib.CurrentTheme.Accent
    window.TabIndicator.Position = UDim2.new(0, 0, 0, 5)
    window.TabIndicator.Parent = window.TabContainer

    -- Animação inicial
    tween(window.MainFrame, TweenInfo.new(0.5), { Position = window.Options.Position, BackgroundTransparency = 0 })

    MakeDraggable(window.TitleBar, window.MainFrame)
    MakeResizable(window.MainFrame) -- Nova funcionalidade de redimensionamento

    window.CloseButton.MouseButton1Click:Connect(function()
        tween(window.MainFrame, TweenInfo.new(0.5), { Position = UDim2.new(0.5, -250, 0.5, 300), BackgroundTransparency = 1 }).Completed:Connect(function()
            window.MainFrame:Destroy()
            window.Notifications:Destroy()
            RainLib:Notify(nil, { Title = "Janela Fechada", Content = window.Options.Title .. " foi fechada.", Duration = 3 })
        end)
    end)

    window.Minimized = false
    window.MinimizeBtn.MouseButton1Click:Connect(function()
        window.Minimized = not window.Minimized
        if window.Minimized then
            tween(window.MainFrame, TweenInfo.new(0.5), { Size = UDim2.new(0, 500, 0, 40) })
            window.MinimizeBtn.Text = "+"
            window.MainFrame.ClipsDescendants = true
            window.TabContainer.Visible = false
            for _, tab in ipairs(window.Tabs) do
                tab.Content.Visible = false
            end
        else
            tween(window.MainFrame, TweenInfo.new(0.5), { Size = UDim2.new(0, 500, 0, 350) })
            window.MinimizeBtn.Text = "-"
            window.MainFrame.ClipsDescendants = false
            window.TabContainer.Visible = true
            for i, tab in ipairs(window.Tabs) do
                if i == 1 then
                    tab.Content.Visible = true
                end
            end
        end
        RainLib:Notify(window, { Title = "Janela", Content = window.Minimized and "Janela minimizada" or "Janela restaurada", Duration = 2 })
    end)

    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == window.Options.MinimizeKey then
            window.MinimizeBtn:Fire("MouseButton1Click")
        end
    end)

    -- Retângulo com foto e nome do jogador
    local playerFrame = Instance.new("Frame")
    playerFrame.Size = UDim2.new(1, -10, 0, 40)
    playerFrame.Position = UDim2.new(0, 5, 1, -45)
    playerFrame.BackgroundColor3 = RainLib.CurrentTheme.Secondary
    playerFrame.Parent = window.TabContainer

    local playerCorner = Instance.new("UICorner")
    playerCorner.CornerRadius = UDim.new(0, 6)
    playerCorner.Parent = playerFrame

    local playerImage = Instance.new("ImageLabel")
    playerImage.Size = UDim2.new(0, 30, 0, 30)
    playerImage.Position = UDim2.new(0, 5, 0, 5)
    playerImage.BackgroundTransparency = 1
    local success, thumb = pcall(function()
        return game.Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
    end)
    playerImage.Image = success and thumb or "rbxassetid://0"
    playerImage.Parent = playerFrame

    local playerName = Instance.new("TextLabel")
    playerName.Size = UDim2.new(1, -40, 1, 0)
    playerName.Position = UDim2.new(0, 40, 0, 0)
    playerName.BackgroundTransparency = 1
    playerName.Text = LocalPlayer.Name
    playerName.TextColor3 = RainLib.CurrentTheme.Text
    playerName.Font = Enum.Font.SourceSansBold
    playerName.TextSize = 14
    playerName.TextXAlignment = Enum.TextXAlignment.Left
    playerName.Parent = playerFrame

    -- Animações no retângulo
    playerFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            tween(playerFrame, TweenInfo.new(0.2), { Size = UDim2.new(1, -10, 0, 42) })
            tween(playerName, TweenInfo.new(0.2), { TextColor3 = RainLib.CurrentTheme.Accent })
        end
    end)
    playerFrame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            tween(playerFrame, TweenInfo.new(0.2), { Size = UDim2.new(1, -10, 0, 40) })
            tween(playerName, TweenInfo.new(0.2), { TextColor3 = RainLib.CurrentTheme.Text })
        end
    end)

    -- Salvar estado
    table.insert(RainLib.GUIState.Windows, { Options = window.Options, Tabs = {} })

    function window:Tab(options)
        local tab = { Elements = {}, Containers = {}, ElementCount = 0 }
        options = options or {}
        tab.Name = options.Title or "Tab"
        tab.Icon = options.Icon

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
            RainLib:Notify(window, { Title = "Aba Selecionada", Content = tab.Name .. " foi selecionada.", Duration = 2 })
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
                RainLib:Notify(window, { Title = "Botão Clicado", Content = options.Title or "Botão", Duration = 2 })
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
                    RainLib:Notify(window, { Title = "Toggle Alterado", Content = options.Title .. ": " .. tostring(toggle.Value), Duration = 2 })
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
            label.Parent = frame

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
                    RainLib:Notify(window, { Title = "Slider Alterado", Content = options.Title .. ": " .. slider.Value, Duration = 2 })
                end
            end)

            table.insert(RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs[#RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs].Elements, {
                Type = "Slider", Key = key, Options = options
            })

            return slider
        end

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
                        RainLib:Notify(window, { Title = "Dropdown Alterado", Content = options.Title .. ": " .. tostring(item), Duration = 2 })
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
                    RainLib:Notify(window, { Title = "Keybind Alterado", Content = options.Title .. ": " .. keybind.Value.Name, Duration = 2 })
                end
            end)

            table.insert(RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs[#RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs].Elements, {
                Type = "Keybind", Key = key, Options = options
            })

            return keybind
        end

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
                RainLib:Notify(window, { Title = "Input Alterado", Content = options.Title .. ": " .. input.Value, Duration = 2 })
            end)

            table.insert(RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs[#RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs].Elements, {
                Type = "Input", Key = key, Options = options
            })

            return input
        end

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
                    RainLib:Notify(window, { Title = "Diálogo", Content = "Botão " .. btn.Text .. " clicado.", Duration = 2 })
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

        function tab:AddColorPicker(key, options)
            options = options or {}
            local colorPickerSize = UDim2.new(1, -16, 0, 50)
            local colorPicker = { Value = options.Default or Color3.fromRGB(255, 255, 255) }
            local frame = Instance.new("Frame")
            frame.Size = colorPickerSize
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = frame

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -60, 0, 18)
            label.Text = options.Title or "Color Picker"
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = Enum.Font.SourceSans
            label.TextSize = 14
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.TextWrapped = true
            label.Parent = frame

            local colorButton = Instance.new("Frame")
            colorButton.Size = UDim2.new(0, 40, 0, 20)
            colorButton.Position = UDim2.new(1, -48, 0, 5)
            colorButton.BackgroundColor3 = colorPicker.Value
            colorButton.Parent = frame

            local colorCorner = Instance.new("UICorner")
            colorCorner.CornerRadius = UDim.new(0, 5)
            colorCorner.Parent = colorButton

            local pickerFrame = Instance.new("Frame")
            pickerFrame.Size = UDim2.new(0, 150, 0, 100)
            pickerFrame.Position = UDim2.new(1, -158, 0, 30)
            pickerFrame.BackgroundColor3 = RainLib.CurrentTheme.Secondary
            pickerFrame.Visible = false
            pickerFrame.Parent = frame

            local pickerCorner = Instance.new("UICorner")
            pickerCorner.CornerRadius = UDim.new(0, 6)
            pickerCorner.Parent = pickerFrame

            local hueBar = Instance.new("Frame")
            hueBar.Size = UDim2.new(0, 20, 1, -10)
            hueBar.Position = UDim2.new(0, 5, 0, 5)
            hueBar.Parent = pickerFrame

            local hueGradient = Instance.new("UIGradient")
            hueGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
                ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
                ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
                ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
            })
            hueGradient.Parent = hueBar

            local saturationFrame = Instance.new("Frame")
            saturationFrame.Size = UDim2.new(0, 100, 1, -10)
            saturationFrame.Position = UDim2.new(0, 30, 0, 5)
            saturationFrame.BackgroundColor3 = colorPicker.Value
            saturationFrame.Parent = pickerFrame

            local saturationGradient = Instance.new("UIGradient")
            saturationGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                ColorSequenceKeypoint.new(1, colorPicker.Value)
            })
            saturationGradient.Parent = saturationFrame

            if options.Flag and window.Options.SaveSettings then
                local settings = RainLib:LoadSettings(window.Options.ConfigFolder)
                if settings and settings.Flags[options.Flag] ~= nil then
                    colorPicker.Value = Color3.fromRGB(unpack(settings.Flags[options.Flag]))
                    colorButton.BackgroundColor3 = colorPicker.Value
                end
            end

            createContainer(frame, colorPickerSize)
            colorButton.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    pickerFrame.Visible = not pickerFrame.Visible
                end
            end)

            local draggingHue, draggingSaturation
            hueBar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    draggingHue = true
                end
            end)
            saturationFrame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    draggingSaturation = true
                end
            end)
            hueBar.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    draggingHue = false
                end
            end)
            saturationFrame.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    draggingSaturation = false
                end
            end)

            RunService.RenderStepped:Connect(function()
                if draggingHue or draggingSaturation then
                    local mousePos = UserInputService:GetMouseLocation()
                    if draggingHue then
                        local relativeY = math.clamp((mousePos.Y - hueBar.AbsolutePosition.Y) / hueBar.AbsoluteSize.Y, 0, 1)
                        local hue = 1 - relativeY
                        local h, s, v = colorPicker.Value:ToHSV()
                        colorPicker.Value = Color3.fromHSV(hue, s, v)
                        saturationGradient.Color = ColorSequence.new({
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                            ColorSequenceKeypoint.new(1, colorPicker.Value)
                        })
                    end
                    if draggingSaturation then
                        local relativeX = math.clamp((mousePos.X - saturationFrame.AbsolutePosition.X) / saturationFrame.AbsoluteSize.X, 0, 1)
                        local relativeY = math.clamp((mousePos.Y - saturationFrame.AbsolutePosition.Y) / saturationFrame.AbsoluteSize.Y, 0, 1)
                        local h, _, v = colorPicker.Value:ToHSV()
                        colorPicker.Value = Color3.fromHSV(h, relativeX, 1 - relativeY)
                    end
                    colorButton.BackgroundColor3 = colorPicker.Value
                    if options.Callback then
                        options.Callback(colorPicker.Value)
                    end
                    if options.Flag and window.Options.SaveSettings then
                        local settings = RainLib:LoadSettings(window.Options.ConfigFolder) or { Flags = {} }
                        settings.Flags[options.Flag] = { colorPicker.Value.R * 255, colorPicker.Value.G * 255, colorPicker.Value.B * 255 }
                        RainLib:SaveSettings(window.Options.ConfigFolder, settings)
                    end
                end
            end)

            table.insert(RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs[#RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs].Elements, {
                Type = "ColorPicker", Key = key, Options = options
            })

            return colorPicker
        end

        return tab
    end

    return window
end

-- Função para recriar GUI
-- Recria todas as janelas e abas com base no estado salvo
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
                elseif elementState.Type == "ColorPicker" then
                    tab:AddColorPicker(elementState.Key, elementState.Options)
                end
            end
        end
    end
end

-- Função para carregar configurações
-- Aplica configurações salvas aos elementos
function RainLib:LoadConfig()
    for _, windowState in ipairs(RainLib.GUIState.Windows) do
        if windowState.Options.SaveSettings then
            local settings = RainLib:LoadSettings(windowState.Options.ConfigFolder)
            if settings then
                for _, tabState in ipairs(windowState.Tabs) do
                    for _, elementState in ipairs(tabState.Elements) do
                        if elementState.Options.Flag and settings.Flags[elementState.Options.Flag] ~= nil then
                            elementState.Options.Default = settings.Flags[elementState.Options.Flag]
                        end
                    end
                end
            end
        end
    end
end

-- Função para destruir
-- Remove a GUI com animação
function RainLib:Destroy()
    if RainLib.ScreenGui then
        tween(RainLib.ScreenGui, TweenInfo.new(0.5), { BackgroundTransparency = 1 }).Completed:Connect(function()
            RainLib.ScreenGui:Destroy()
            RainLib.GUIState = { Windows = {}, Notifications = {} }
            RainLib:Notify(nil, { Title = "Interface Destruída", Content = "A interface foi removida.", Duration = 3 })
        end)
    end
end

-- Evento global para toggle da GUI
-- Alterna a visibilidade da GUI com RightShift
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        if RainLib.ScreenGui then
            RainLib.ScreenGui.Enabled = not RainLib.ScreenGui.Enabled
            RainLib:Notify(nil, { Title = "Interface", Content = RainLib.ScreenGui.Enabled and "Interface exibida" or "Interface oculta", Duration = 2 })
        end
    end
end)

print("[RainLib] Biblioteca carregada!")
return RainLib
