local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local HttpService = game:GetService("HttpService")

local RainLib = {
    Version = "1.2.3",
    Themes = {
        Dark = {
            Background = Color3.fromRGB(25, 25, 25),
            Accent = Color3.fromRGB(60, 160, 255),
            Text = Color3.fromRGB(240, 240, 240),
            Secondary = Color3.fromRGB(45, 45, 45),
            Disabled = Color3.fromRGB(90, 90, 90)
        }
    },
    CurrentTheme = nil,
    CreatedFolders = {},
    GUIState = { Windows = {} }
}

-- Função auxiliar para animações
local function tween(obj, info, properties)
    local t = TweenService:Create(obj, info or TweenInfo.new(0.3, Enum.EasingStyle.Quint), properties)
    t:Play()
    return t
end

-- Função para arrastar janela
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

-- Inicialização
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

-- Função para criar pastas
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

-- Funções para salvar/carregar configurações
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

-- Função para notificações
function RainLib:Notify(window, options)
    local target = window and window.Notifications or RainLib.ScreenGui
    local notification = Instance.new("Frame")
    notification.Size = UDim2.new(0, 250, 0, 70)
    notification.Position = UDim2.new(1, 260, 0, (#target:GetChildren() - 1) * 80 + 10)
    notification.BackgroundColor3 = RainLib.CurrentTheme.Background
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

    window.CloseButton.MouseButton1Click:Connect(function()
        tween(window.MainFrame, TweenInfo.new(0.5), { Position = UDim2.new(0.5, -250, 0.5, 300), BackgroundTransparency = 1 }).Completed:Connect(function()
            window.MainFrame:Destroy()
            window.Notifications:Destroy()
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
        else
            tween(window.MainFrame, TweenInfo.new(0.5), { Size = UDim2.new(0, 500, 0, 350) })
            window.MinimizeBtn.Text = "-"
            window.MainFrame.ClipsDescendants = false
            window.TabContainer.Visible = true
        end
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
        local tab = { Elements = {} }
        options = options or {}
        tab.Name = options.Title or "Tab"
        tab.Icon = options.Icon
        tab.ElementCount = 0

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

        local function getNextPosition(size)
            local padding = 8
            local yOffset = padding + tab.ElementCount * (size.Y.Offset + padding)
            tab.ElementCount = tab.ElementCount + 1
            tab.Content.CanvasSize = UDim2.new(0, 0, 0, yOffset + size.Y.Offset + padding)
            return UDim2.new(0, padding, 0, yOffset)
        end

        local function createContainer(element, size)
            local container = Instance.new("Frame")
            container.Size = UDim2.new(1, -16, 0, size.Y.Offset + 16)
            container.Position = getNextPosition(size)
            container.BackgroundTransparency = 1
            container.Parent = tab.Container
            element.Parent = container
            element.Position = UDim2.new(0, 8, 0, 8)
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
            button.MouseButton1Click:Connect(options.Callback or function() end)
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
            label.Size = UDim2.new(1, -40, 1, 0)
            label.Text = options.Title or "Toggle"
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = Enum.Font.SourceSans
            label.TextSize = 14
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.TextWrapped = true
            label.Parent = frame

            local indicator = Instance.new("Frame")
            indicator.Size = UDim2.new(0, 18, 0, 18)
            indicator.Position = UDim2.new(1, -26, 0.5, -9)
            indicator.BackgroundColor3 = toggle.Value and RainLib.CurrentTheme.Accent or RainLib.CurrentTheme.Disabled
            indicator.Parent = frame

            local indicatorCorner = Instance.new("UICorner")
            indicatorCorner.CornerRadius = UDim.new(0, 9)
            indicatorCorner.Parent = indicator

            if options.Flag and window.Options.SaveSettings then
                local settings = RainLib:LoadSettings(window.Options.ConfigFolder)
                if settings and settings.Flags[options.Flag] ~= nil then
                    toggle.Value = settings.Flags[options.Flag]
                    indicator.BackgroundColor3 = toggle.Value and RainLib.CurrentTheme.Accent or RainLib.CurrentTheme.Disabled
                end
            end

            createContainer(frame, toggleSize)
            frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    toggle.Value = not toggle.Value
                    tween(indicator, TweenInfo.new(0.2), {
                        BackgroundColor3 = toggle.Value and RainLib.CurrentTheme.Accent or RainLib.CurrentTheme.Disabled,
                        Size = UDim2.new(0, toggle.Value and 22 or 18, 0, toggle.Value and 22 or 18),
                        Position = UDim2.new(1, toggle.Value and -30 or -26, 0.5, toggle.Value and -11 or -9)
                    })
                    if options.Callback then
                        options.Callback(toggle.Value)
                    end
                    if options.Flag and window.Options.SaveSettings then
                        local settings = RainLib:LoadSettings(window.Options.ConfigFolder) or { Flags = {} }
                        settings.Flags[options.Flag] = toggle.Value
                        RainLib:SaveSettings(window.Options.ConfigFolder, settings)
                    end
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
                end
            end)

            table.insert(RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs[#RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs].Elements, {
                Type = "Keybind", Key = key, Options = options
            })

            return keybind
        end

        function tab:AddColorpicker(key, options)
            options = options or {}
            local pickerSize = UDim2.new(1, -16, 0, 90)
            local picker = { Value = options.Default or Color3.fromRGB(255, 255, 255) }
            local frame = Instance.new("Frame")
            frame.Size = pickerSize
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = frame

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -40, 0, 18)
            label.Text = options.Title or "Colorpicker"
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = Enum.Font.SourceSans
            label.TextSize = 14
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.TextWrapped = true
            label.Parent = frame

            local preview = Instance.new("Frame")
            preview.Size = UDim2.new(0, 25, 0, 25)
            preview.Position = UDim2.new(1, -33, 0, 4)
            preview.BackgroundColor3 = picker.Value
            preview.Parent = frame

            local previewCorner = Instance.new("UICorner")
            previewCorner.CornerRadius = UDim.new(0, 5)
            previewCorner.Parent = preview

            local rSlider = tab:AddSlider(key .. "_R", {
                Title = "R",
                Min = 0,
                Max = 255,
                Default = math.floor(picker.Value.R * 255),
                Callback = function(value)
                    picker.Value = Color3.fromRGB(value, picker.Value.G * 255, picker.Value.B * 255)
                    preview.BackgroundColor3 = picker.Value
                    if options.Callback then
                        options.Callback(picker.Value)
                    end
                    if options.Flag and window.Options.SaveSettings then
                        local settings = RainLib:LoadSettings(window.Options.ConfigFolder) or { Flags = {} }
                        settings.Flags[options.Flag] = { picker.Value.R, picker.Value.G, picker.Value.B }
                        RainLib:SaveSettings(window.Options.ConfigFolder, settings)
                    end
                end
            })
            rSlider.Parent.Position = UDim2.new(0, 8, 0, 34)

            local gSlider = tab:AddSlider(key .. "_G", {
                Title = "G",
                Min = 0,
                Max = 255,
                Default = math.floor(picker.Value.G * 255),
                Callback = function(value)
                    picker.Value = Color3.fromRGB(picker.Value.R * 255, value, picker.Value.B * 255)
                    preview.BackgroundColor3 = picker.Value
                    if options.Callback then
                        options.Callback(picker.Value)
                    end
                    if options.Flag and window.Options.SaveSettings then
                        local settings = RainLib:LoadSettings(window.Options.ConfigFolder) or { Flags = {} }
                        settings.Flags[options.Flag] = { picker.Value.R, picker.Value.G, picker.Value.B }
                        RainLib:SaveSettings(window.Options.ConfigFolder, settings)
                    end
                end
            })
            gSlider.Parent.Position = UDim2.new(0, 8, 0, 64)

            local bSlider = tab:AddSlider(key .. "_B", {
                Title = "B",
                Min = 0,
                Max = 255,
                Default = math.floor(picker.Value.B * 255),
                Callback = function(value)
                    picker.Value = Color3.fromRGB(picker.Value.R * 255, picker.Value.G * 255, value)
                    preview.BackgroundColor3 = picker.Value
                    if options.Callback then
                        options.Callback(picker.Value)
                    end
                    if options.Flag and window.Options.SaveSettings then
                        local settings = RainLib:LoadSettings(window.Options.ConfigFolder) or { Flags = {} }
                        settings.Flags[options.Flag] = { picker.Value.R, picker.Value.G, picker.Value.B }
                        RainLib:SaveSettings(window.Options.ConfigFolder, settings)
                    end
                end
            })
            bSlider.Parent.Position = UDim2.new(0, 8, 0, 94)

            if options.Flag and window.Options.SaveSettings then
                local settings = RainLib:LoadSettings(window.Options.ConfigFolder)
                if settings and settings.Flags[options.Flag] then
                    picker.Value = Color3.new(unpack(settings.Flags[options.Flag]))
                    preview.BackgroundColor3 = picker.Value
                    rSlider.Value = math.floor(picker.Value.R * 255)
                    gSlider.Value = math.floor(picker.Value.G * 255)
                    bSlider.Value = math.floor(picker.Value.B * 255)
                end
            end

            createContainer(frame, pickerSize)
            table.insert(RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs[#RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs].Elements, {
                Type = "Colorpicker", Key = key, Options = options
            })

            return picker
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

-- Função para recriar GUI
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
                elseif elementState.Type == "Colorpicker" then
                    tab:AddColorpicker(elementState.Key, elementState.Options)
                elseif elementState.Type == "Input" then
                    tab:AddInput(elementState.Key, elementState.Options)
                elseif elementState.Type == "Dialog" then
                    tab:AddDialog(elementState.Options)
                end
            end
        end
    end
end

-- Função para carregar configurações
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
function RainLib:Destroy()
    if RainLib.ScreenGui then
        tween(RainLib.ScreenGui, TweenInfo.new(0.5), { BackgroundTransparency = 1 }).Completed:Connect(function()
            RainLib.ScreenGui:Destroy()
        end)
    end
end

print("[RainLib] Biblioteca carregada!")
return RainLib
