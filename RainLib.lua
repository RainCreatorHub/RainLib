local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local HttpService = game:GetService("HttpService")

-- Importar o módulo de animações
local Designin = loadstring(game:HttpGet(*https://raw.githubusercontent.com/RainCreatorHub/RainLib/refs/heads/main/RainLib.Designin.lua"))()

local RainLib = {
    Version = "1.1.3",
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

-- Função auxiliar para aplicar estilos comuns
local function applyCommonStyles(instance, styles)
    for prop, value in pairs(styles) do
        if prop == "UICorner" then
            local corner = Instance.new("UICorner")
            corner.CornerRadius = value
            corner.Parent = instance
        elseif prop == "UIStroke" then
            local stroke = Instance.new("UIStroke")
            for k, v in pairs(value) do
                stroke[k] = v
            end
            stroke.Parent = instance
        else
            instance[prop] = value
        end
    end
    return instance
end

-- Função para arrastar janela
local function MakeDraggable(DragPoint, Main)
    local Dragging, DragInput, MousePos, FramePos
    DragPoint.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            MousePos = input.Position
            FramePos = Main.Position
            Designin:Hover(DragPoint, RainLib.CurrentTheme.Secondary, RainLib.CurrentTheme.Accent:Lerp(Color3.fromRGB(255, 255, 255), 0.1))
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
            Designin:Tween(DragPoint, nil, {BackgroundColor3 = RainLib.CurrentTheme.Secondary})
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
    local notification = applyCommonStyles(Instance.new("Frame"), {
        Size = UDim2.new(0, 250, 0, 70),
        Position = UDim2.new(1, 260, 0, (#target:GetChildren() - 1) * 80 + 10),
        BackgroundColor3 = RainLib.CurrentTheme.Background,
        UICorner = UDim.new(0, 8)
    })

    local shadow = applyCommonStyles(Instance.new("ImageLabel"), {
        Size = UDim2.new(1, 20, 1, 20),
        Position = UDim2.new(0, -10, 0, -10),
        BackgroundTransparency = 1,
        Image = "rbxassetid://1316045217",
        ImageTransparency = 0.7,
        ImageColor3 = Color3.fromRGB(0, 0, 0),
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(10, 10, 118, 118),
        Parent = notification
    })

    local title = applyCommonStyles(Instance.new("TextLabel"), {
        Size = UDim2.new(1, -10, 0, 20),
        Position = UDim2.new(0, 5, 0, 5),
        Text = options.Title or "Notificação",
        BackgroundTransparency = 1,
        TextColor3 = RainLib.CurrentTheme.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        Parent = notification
    })

    local message = applyCommonStyles(Instance.new("TextLabel"), {
        Size = UDim2.new(1, -10, 0, 40),
        Position = UDim2.new(0, 5, 0, 25),
        Text = options.Content or "",
        BackgroundTransparency = 1,
        TextColor3 = RainLib.CurrentTheme.Text,
        Font = Enum.Font.SourceSans,
        TextSize = 12,
        TextWrapped = true,
        Parent = notification
    })

    Designin:FadeIn(notification)
    task.spawn(function()
        task.wait(options.Duration or 3)
        Designin:FadeOut(notification).Completed:Connect(function()
            notification:Destroy()
        end)
    end)
end

-- Função para adicionar tema
function RainLib:AddTheme(name, theme)
    self.Themes[name] = theme
end

-- Função para definir tema
function RainLib:SetTheme(name)
    if self.Themes[name] then
        self.CurrentTheme = self.Themes[name]
        for _, descendant in ipairs(self.ScreenGui:GetDescendants()) do
            if descendant:IsA("Frame") or descendant:IsA("TextButton") or descendant:IsA("TextLabel") then
                if descendant.BackgroundColor3 == self.Themes.Dark.Background then
                    descendant.BackgroundColor3 = self.CurrentTheme.Background
                elseif descendant.BackgroundColor3 == self.Themes.Dark.Accent then
                    descendant.BackgroundColor3 = self.CurrentTheme.Accent
                elseif descendant.BackgroundColor3 == self.Themes.Dark.Secondary then
                    descendant.BackgroundColor3 = self.CurrentTheme.Secondary
                elseif descendant.BackgroundColor3 == self.Themes.Dark.Disabled then
                    descendant.BackgroundColor3 = self.CurrentTheme.Disabled
                end
                if descendant:IsA("TextLabel") or descendant:IsA("TextButton") then
                    if descendant.TextColor3 == self.Themes.Dark.Text then
                        descendant.TextColor3 = self.CurrentTheme.Text
                    end
                end
            end
        end
    else
        warn("[RainLib] Tema '" .. name .. "' não encontrado!")
    end
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

    window.Notifications = applyCommonStyles(window.Notifications, {
        Size = UDim2.new(0, 260, 1, -25),
        Position = UDim2.new(1, -270, 0, 0),
        BackgroundTransparency = 1,
        Parent = RainLib.ScreenGui
    })

    window.MainFrame = applyCommonStyles(Instance.new("Frame"), {
        Size = UDim2.new(0, 500, 0, 350),
        Position = UDim2.new(0.5, -250, 0.5, 300),
        BackgroundColor3 = RainLib.CurrentTheme.Background,
        ClipsDescendants = true,
        Parent = RainLib.ScreenGui,
        UICorner = UDim.new(0, 12)
    })

    local shadow = applyCommonStyles(Instance.new("ImageLabel"), {
        Size = UDim2.new(1, 40, 1, 40),
        Position = UDim2.new(0, -20, 0, -20),
        BackgroundTransparency = 1,
        Image = "rbxassetid://1316045217",
        ImageTransparency = 0.6,
        ImageColor3 = Color3.fromRGB(0, 0, 0),
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(10, 10, 118, 118),
        Parent = window.MainFrame
    })

    window.TitleBar = applyCommonStyles(Instance.new("Frame"), {
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = RainLib.CurrentTheme.Secondary,
        Parent = window.MainFrame,
        UICorner = UDim.new(0, 6)
    })

    local titleGradient = Instance.new("UIGradient")
    titleGradient.Color = ColorSequence.new(RainLib.CurrentTheme.Secondary, RainLib.CurrentTheme.Background)
    titleGradient.Rotation = 90
    titleGradient.Parent = window.TitleBar

    window.TitleLabel = applyCommonStyles(Instance.new("TextLabel"), {
        Size = UDim2.new(1, -60, 0, 20),
        Position = UDim2.new(0, 10, 0, 5),
        BackgroundTransparency = 1,
        Text = window.Options.Title,
        TextColor3 = RainLib.CurrentTheme.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = window.TitleBar
    })

    window.SubTitleLabel = applyCommonStyles(Instance.new("TextLabel"), {
        Size = UDim2.new(1, -60, 0, 15),
        Position = UDim2.new(0, 10, 0, 20),
        BackgroundTransparency = 1,
        Text = window.Options.SubTitle,
        TextColor3 = RainLib.CurrentTheme.Text,
        Font = Enum.Font.Gotham,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = window.TitleBar
    })

    window.CloseButton = applyCommonStyles(Instance.new("TextButton"), {
        Size = UDim2.new(0, 25, 0, 25),
        Position = UDim2.new(1, -35, 0, 7),
        BackgroundColor3 = Color3.fromRGB(255, 80, 80),
        Text = "X",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.SourceSansBold,
        TextSize = 12,
        Parent = window.TitleBar,
        UICorner = UDim.new(0, 6)
    })

    window.MinimizeBtn = applyCommonStyles(Instance.new("TextButton"), {
        Size = UDim2.new(0, 25, 0, 25),
        Position = UDim2.new(1, -65, 0, 7),
        BackgroundColor3 = RainLib.CurrentTheme.Accent,
        Text = "-",
        TextColor3 = RainLib.CurrentTheme.Text,
        Font = Enum.Font.SourceSansBold,
        TextSize = 12,
        Parent = window.TitleBar,
        UICorner = UDim.new(0, 6)
    })

    window.TabContainer = applyCommonStyles(Instance.new("ScrollingFrame"), {
        Size = UDim2.new(0, 120, 1, -40),
        Position = UDim2.new(0, 0, 0, 40),
        BackgroundColor3 = RainLib.CurrentTheme.Secondary,
        ScrollBarThickness = 0,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        Parent = window.MainFrame
    })

    window.TabIndicator = applyCommonStyles(Instance.new("Frame"), {
        Size = UDim2.new(0, 3, 0, 35),
        BackgroundColor3 = RainLib.CurrentTheme.Accent,
        Position = UDim2.new(0, 0, 0, 5),
        Parent = window.TabContainer
    })

    -- Animação inicial
    Designin:FadeIn(window.MainFrame)

    MakeDraggable(window.TitleBar, window.MainFrame)

    window.CloseButton.MouseButton1Click:Connect(function()
        Designin:FadeOut(window.MainFrame, 0.5, UDim2.new(0.5, -250, 0.5, 300)).Completed:Connect(function()
            window.MainFrame:Destroy()
            window.Notifications:Destroy()
        end)
    })

    window.Minimized = false
    window.MinimizeBtn.MouseButton1Click:Connect(function()
        window.Minimized = not window.Minimized
        if window.Minimized then
            Designin:Tween(window.MainFrame, TweenInfo.new(0.5), { Size = UDim2.new(0, 500, 0, 40) })
            window.MinimizeBtn.Text = "+"
            window.MainFrame.ClipsDescendants = true
            window.TabContainer.Visible = false
        else
            Designin:Tween(window.MainFrame, TweenInfo.new(0.5), { Size = UDim2.new(0, 500, 0, 350) })
            window.MinimizeBtn.Text = "-"
            window.MainFrame.ClipsDescendants = false
            window.TabContainer.Visible = true
        end
    })

    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == window.Options.MinimizeKey then
            window.MinimizeBtn:Fire("MouseButton1Click")
        end
    end)

    -- Retângulo com foto e nome do jogador
    local playerFrame = applyCommonStyles(Instance.new("Frame"), {
        Size = UDim2.new(1, -10, 0, 40),
        Position = UDim2.new(0, 5, 1, -45),
        BackgroundColor3 = RainLib.CurrentTheme.Secondary,
        Parent = window.TabContainer,
        UICorner = UDim.new(0, 6)
    })

    local playerImage = applyCommonStyles(Instance.new("ImageLabel"), {
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(0, 5, 0, 5),
        BackgroundTransparency = 1,
        Image = (function()
            local success, thumb = pcall(function()
                return game.Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
            end)
            return success and thumb or "rbxassetid://0"
        end)(),
        Parent = playerFrame
    })

    local playerName = applyCommonStyles(Instance.new("TextLabel"), {
        Size = UDim2.new(1, -40, 1, 0),
        Position = UDim2.new(0, 40, 0, 0),
        BackgroundTransparency = 1,
        Text = LocalPlayer.Name,
        TextColor3 = RainLib.CurrentTheme.Text,
        Font = Enum.Font.SourceSansBold,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = playerFrame
    })

    -- Animações no retângulo
    playerFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            Designin:Tween(playerFrame, TweenInfo.new(0.2), { Size = UDim2.new(1, -10, 0, 42) })
            Designin:Tween(playerName, TweenInfo.new(0.2), { TextColor3 = RainLib.CurrentTheme.Accent })
        end
    end)
    playerFrame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            Designin:Tween(playerFrame, TweenInfo.new(0.2), { Size = UDim2.new(1, -10, 0, 40) })
            Designin:Tween(playerName, TweenInfo.new(0.2), { TextColor3 = RainLib.CurrentTheme.Text })
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

        tab.Content = applyCommonStyles(Instance.new("ScrollingFrame"), {
            Size = UDim2.new(1, -130, 1, -50),
            Position = UDim2.new(0, 125, 0, 45),
            BackgroundTransparency = 1,
            ScrollBarThickness = 4,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            Visible = false,
            Parent = window.MainFrame
        })

        tab.Container = applyCommonStyles(Instance.new("Frame"), {
            Size = UDim2.new(1, -10, 1, -10),
            Position = UDim2.new(0, 5, 0, 5),
            BackgroundTransparency = 1,
            Parent = tab.Content
        })

        tab.Button = applyCommonStyles(Instance.new("TextButton"), {
            Size = UDim2.new(1, -10, 0, 35),
            Position = UDim2.new(0, 5, 0, #window.Tabs * 40 + 5),
            BackgroundColor3 = RainLib.CurrentTheme.Secondary,
            Text = tab.Icon and "" or tab.Name,
            TextColor3 = RainLib.CurrentTheme.Text,
            Font = Enum.Font.SourceSansBold,
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = window.TabContainer,
            UICorner = UDim.new(0, 6)
        })
        window.TabContainer.CanvasSize = UDim2.new(0, 0, 0, #window.Tabs * 40 + 50)

        if tab.Icon then
            local icon = applyCommonStyles(Instance.new("ImageLabel"), {
                Size = UDim2.new(0, 20, 0, 20),
                Position = UDim2.new(0, 10, 0.5, -10),
                BackgroundTransparency = 1,
                Image = tab.Icon,
                Parent = tab.Button
            })

            local text = applyCommonStyles(Instance.new("TextLabel"), {
                Size = UDim2.new(1, -35, 1, 0),
                Position = UDim2.new(0, 35, 0, 0),
                BackgroundTransparency = 1,
                Text = tab.Name,
                TextColor3 = RainLib.CurrentTheme.Text,
                Font = Enum.Font.SourceSansBold,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = tab.Button
            })
        end

        table.insert(window.Tabs, tab)
        table.insert(RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs, { Name = tab.Name, Icon = tab.Icon, Elements = {} })

        local function selectTab(index)
            for i, t in pairs(window.Tabs) do
                if i == index then
                    t.Content.Visible = true
                    Designin:Tween(t.Content, TweenInfo.new(0.3), { BackgroundTransparency = 1, Position = UDim2.new(0, 125, 0, 45) })
                    Designin:Select(window.TabIndicator, UDim2.new(0, 0, 0, (i-1) * 40 + 5))
                    Designin:Tween(t.Button, TweenInfo.new(0.2), { BackgroundColor3 = RainLib.CurrentTheme.Accent })
                else
                    Designin:Tween(t.Content, TweenInfo.new(0.3), { Position = UDim2.new(0, 170, 0, 45) }).Completed:Connect(function()
                        t.Content.Visible = false
                    end)
                    Designin:Tween(t.Button, TweenInfo.new(0.2), { BackgroundColor3 = RainLib.CurrentTheme.Secondary })
                end
            end
        end

        tab.Button.MouseButton1Click:Connect(function()
            selectTab(table.find(window.Tabs, tab))
        end)
        tab.Button.MouseEnter:Connect(function()
            if not tab.Content.Visible then
                Designin:Hover(tab.Button, RainLib.CurrentTheme.Secondary, RainLib.CurrentTheme.Secondary:Lerp(RainLib.CurrentTheme.Accent, 0.3))
            end
        end)
        tab.Button.MouseLeave:Connect(function()
            if not tab.Content.Visible then
                Designin:Tween(tab.Button, TweenInfo.new(0.2), { BackgroundColor3 = RainLib.CurrentTheme.Secondary })
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
            local container = applyCommonStyles(Instance.new("Frame"), {
                Size = UDim2.new(1, -16, 0, size.Y.Offset + 16),
                Position = getNextPosition(size),
                BackgroundTransparency = 1,
                Parent = tab.Container
            })
            element.Parent = container
            element.Position = UDim2.new(0, 8, 0, 8)
            return container
        end

        function tab:AddSection(options)
            options = options or {}
            local sectionSize = UDim2.new(1, -16, 0, 25)
            local section = applyCommonStyles(Instance.new("Frame"), {
                Size = sectionSize,
                BackgroundColor3 = RainLib.CurrentTheme.Secondary,
                UICorner = UDim.new(0, 6)
            })

            local label = applyCommonStyles(Instance.new("TextLabel"), {
                Size = UDim2.new(1, -8, 1, 0),
                Position = UDim2.new(0, 4, 0, 0),
                Text = options.Title or "Section",
                BackgroundTransparency = 1,
                TextColor3 = RainLib.CurrentTheme.Text,
                Font = Enum.Font.GothamBold,
                TextSize = 14,
                Parent = section
            })

            createContainer(section, sectionSize)
            table.insert(RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs[#RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs].Elements, {
                Type = "Section", Options = options
            })

            return section
        end

        function tab:AddParagraph(options)
            options = options or {}
            local paragraphSize = UDim2.new(1, -16, 0, 50)
            local paragraph = applyCommonStyles(Instance.new("Frame"), {
                Size = paragraphSize,
                BackgroundColor3 = RainLib.CurrentTheme.Secondary,
                UICorner = UDim.new(0, 6)
            })

            local title = applyCommonStyles(Instance.new("TextLabel"), {
                Size = UDim2.new(1, -8, 0, 18),
                Position = UDim2.new(0, 4, 0, 4),
                Text = options.Title or "Paragraph",
                BackgroundTransparency = 1,
                TextColor3 = RainLib.CurrentTheme.Text,
                Font = Enum.Font.GothamBold,
                TextSize = 14,
                Parent = paragraph
            })

            local content = applyCommonStyles(Instance.new("TextLabel"), {
                Size = UDim2.new(1, -8, 0, 26),
                Position = UDim2.new(0, 4, 0, 22),
                Text = options.Content or "",
                BackgroundTransparency = 1,
                TextColor3 = RainLib.CurrentTheme.Text,
                Font = Enum.Font.SourceSans,
                TextSize = 12,
                TextWrapped = true,
                Parent = paragraph
            })

            createContainer(paragraph, paragraphSize)
            table.insert(RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs[#RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs].Elements, {
                Type = "Paragraph", Options = options
            })

            return paragraph
        end

        function tab:AddButton(options)
            options = options or {}
            local buttonSize = UDim2.new(1, -16, 0, 35)
            local button = applyCommonStyles(Instance.new("TextButton"), {
                Size = buttonSize,
                Text = options.Title or "Button",
                BackgroundColor3 = RainLib.CurrentTheme.Accent,
                TextColor3 = RainLib.CurrentTheme.Text,
                Font = Enum.Font.SourceSansBold,
                TextSize = 14,
                TextWrapped = true,
                UICorner = UDim.new(0, 6),
                UIStroke = { Thickness = 1, Color = RainLib.CurrentTheme.Accent:Lerp(Color3.fromRGB(0, 0, 0), 0.2) }
            })

            createContainer(button, buttonSize)
            button.MouseButton1Click:Connect(options.Callback or function() end)
            button.MouseEnter:Connect(function()
                Designin:Hover(button, RainLib.CurrentTheme.Accent)
            end)
            button.MouseLeave:Connect(function()
                Designin:Tween(button, TweenInfo.new(0.2), { BackgroundColor3 = RainLib.CurrentTheme.Accent })
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
            local frame = applyCommonStyles(Instance.new("Frame"), {
                Size = toggleSize,
                BackgroundColor3 = RainLib.CurrentTheme.Secondary,
                UICorner = UDim.new(0, 6)
            })

            local label = applyCommonStyles(Instance.new("TextLabel"), {
                Size = UDim2.new(1, -40, 1, 0),
                Text = options.Title or "Toggle",
                BackgroundTransparency = 1,
                TextColor3 = RainLib.CurrentTheme.Text,
                Font = Enum.Font.SourceSans,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true,
                Parent = frame
            })

            local indicator = applyCommonStyles(Instance.new("Frame"), {
                Size = UDim2.new(0, 18, 0, 18),
                Position = UDim2.new(1, -26, 0.5, -9),
                BackgroundColor3 = toggle.Value and RainLib.CurrentTheme.Accent or RainLib.CurrentTheme.Disabled,
                Parent = frame,
                UICorner = UDim.new(0, 9)
            })

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
                    Designin:Tween(indicator, TweenInfo.new(0.2), {
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
            local frame = applyCommonStyles(Instance.new("Frame"), {
                Size = sliderSize,
                BackgroundColor3 = RainLib.CurrentTheme.Secondary,
                UICorner = UDim.new(0, 6)
            })

            local label = applyCommonStyles(Instance.new("TextLabel"), {
                Size = UDim2.new(1, -40, 0, 18),
                Text = options.Title or "Slider",
                BackgroundTransparency = 1,
                TextColor3 = RainLib.CurrentTheme.Text,
                Font = Enum.Font.SourceSans,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true,
                Parent = frame
            })

            local valueLabel = applyCommonStyles(Instance.new("TextLabel"), {
                Size = UDim2.new(0, 30, 0, 18),
                Position = UDim2.new(1, -34, 0, 0),
                Text = tostring(slider.Value),
                BackgroundTransparency = 1,
                TextColor3 = RainLib.CurrentTheme.Text,
                Font = Enum.Font.SourceSans,
                TextSize = 12,
                Parent = frame
            })

            local bar = applyCommonStyles(Instance.new("Frame"), {
                Size = UDim2.new(1, -8, 0, 6),
                Position = UDim2.new(0, 4, 0, 22),
                BackgroundColor3 = RainLib.CurrentTheme.Disabled,
                UICorner = UDim.new(0, 3),
                Parent = frame
            })

            local fill = applyCommonStyles(Instance.new("Frame"), {
                Size = UDim2.new((slider.Value - (options.Min or 0)) / ((options.Max or 100) - (options.Min or 0)), 0, 1, 0),
                BackgroundColor3 = RainLib.CurrentTheme.Accent,
                UICorner = UDim.new(0, 3),
                Parent = bar
            })

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
                    Designin:Tween(bar, TweenInfo.new(0.2), { BackgroundColor3 = RainLib.CurrentTheme.Disabled:Lerp(RainLib.CurrentTheme.Accent, 0.2) })
                end
            end)
            bar.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                    Designin:Tween(bar, TweenInfo.new(0.2), { BackgroundColor3 = RainLib.CurrentTheme.Disabled })
                end
            end)
            RunService.RenderStepped:Connect(function()
                if dragging then
                    local mousePos = UserInputService:GetMouseLocation()
                    local relativeX = math.clamp((mousePos.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
                    local shiftHeld = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)
                    local step = shiftHeld and (options.Step or 1) / 10 or (options.Step or 1)
                    slider.Value = math.floor((options.Min or 0) + relativeX * ((options.Max or 100) - (options.Min or 0)) / step) * step
                    if options.Rounding then
                        slider.Value = math.floor(slider.Value / options.Rounding) * options.Rounding
                    end
                    Designin:Tween(fill, TweenInfo.new(0.1), { Size = UDim2.new(relativeX, 0, 1, 0) })
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
            local frame = applyCommonStyles(Instance.new("Frame"), {
                Size = dropdownSize,
                BackgroundColor3 = RainLib.CurrentTheme.Secondary,
                UICorner = UDim.new(0, 6)
            })

            local label = applyCommonStyles(Instance.new("TextLabel"), {
                Size = UDim2.new(1, -100, 1, 0),
                Text = options.Title or "Dropdown",
                BackgroundTransparency = 1,
                TextColor3 = RainLib.CurrentTheme.Text,
                Font = Enum.Font.SourceSans,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true,
                Parent = frame
            })

            local button = applyCommonStyles(Instance.new("TextButton"), {
                Size = UDim2.new(0, 90, 0, 25),
                Position = UDim2.new(1, -95, 0, 5),
                BackgroundColor3 = RainLib.CurrentTheme.Disabled,
                Text = dropdown.Value or "Selecionar",
                TextColor3 = RainLib.CurrentTheme.Text,
                Font = Enum.Font.SourceSans,
                TextSize = 12,
                TextWrapped = true,
                UICorner = UDim.new(0, 5),
                Parent = frame
            })

            local listFrame = applyCommonStyles(Instance.new("Frame"), {
                Size = UDim2.new(0, 90, 0, 0),
                Position = UDim2.new(1, -95, 0, 35),
                BackgroundColor3 = RainLib.CurrentTheme.Secondary,
                Visible = false,
                UICorner = UDim.new(0, 5),
                Parent = frame
            })

            local listLayout = applyCommonStyles(Instance.new("UIListLayout"), {
                SortOrder = Enum.SortOrder.LayoutOrder,
                Parent = listFrame
            })

            local searchBox
            if options.Searchable then
                searchBox = applyCommonStyles(Instance.new("TextBox"), {
                    Size = UDim2.new(1, 0, 0, 25),
                    Text = "Pesquisar...",
                    TextColor3 = RainLib.CurrentTheme.Text,
                    BackgroundColor3 = RainLib.CurrentTheme.Disabled,
                    Font = Enum.Font.SourceSans,
                    TextSize = 12,
                    UICorner = UDim.new(0, 5),
                    Parent = listFrame
                })
            end

            if options.Flag and window.Options.SaveSettings then
                local settings = RainLib:LoadSettings(window.Options.ConfigFolder)
                if settings and settings.Flags[options.Flag] ~= nil then
                    dropdown.Value = settings.Flags[options.Flag]
                    button.Text = dropdown.Value
                end
            end

            local function updateList()
                for _, child in ipairs(listFrame:GetChildren()) do
                    if child:IsA("TextButton") then
                        child:Destroy()
                    end
                end
                listFrame.Size = UDim2.new(0, 90, 0, math.min(#options.Items * 25 + (options.Searchable and 25 or 0), 100))
                for _, item in ipairs(options.Items or {}) do
                    local itemButton = applyCommonStyles(Instance.new("TextButton"), {
                        Size = UDim2.new(1, 0, 0, 25),
                        BackgroundColor3 = RainLib.CurrentTheme.Secondary,
                        Text = tostring(item),
                        TextColor3 = RainLib.CurrentTheme.Text,
                        Font = Enum.Font.SourceSans,
                        TextSize = 12,
                        TextWrapped = true,
                        Parent = listFrame
                    })

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

            if options.Searchable then
                searchBox:GetPropertyChangedSignal("Text"):Connect(function()
                    local query = searchBox.Text:lower()
                    for _, item in ipairs(listFrame:GetChildren()) do
                        if item:IsA("TextButton") then
                            item.Visible = query == "" or item.Text:lower():find(query) ~= nil
                        end
                    end
                end)
                searchBox.Focused:Connect(function()
                    if searchBox.Text == "Pesquisar..." then
                        searchBox.Text = ""
                    end
                end)
                searchBox.FocusLost:Connect(function()
                    if searchBox.Text == "" then
                        searchBox.Text = "Pesquisar..."
                    end
                end)
            end

            createContainer(frame, dropdownSize)
            button.MouseButton1Click:Connect(function()
                listFrame.Visible = not listFrame.Visible
                Designin:Tween(listFrame, TweenInfo.new(0.2), { Size = listFrame.Visible and UDim2.new(0, 90, 0, math.min(#options.Items * 25 + (options.Searchable and 25 or 0), 100)) or UDim2.new(0, 90, 0, 0) })
            end)

            table.insert(RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs[#RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs].Elements, {
                Type = "Dropdown", Key = key, Options = options
            })

            return dropdown
        end

        function tab:AddMultiDropdown(key, options)
            options = options or {}
            local dropdownSize = UDim2.new(1, -16, 0, 35)
            local dropdown = { Values = options.Default or {} }
            local frame = applyCommonStyles(Instance.new("Frame"), {
                Size = dropdownSize,
                BackgroundColor3 = RainLib.CurrentTheme.Secondary,
                UICorner = UDim.new(0, 6)
            })

            local label = applyCommonStyles(Instance.new("TextLabel"), {
                Size = UDim2.new(1, -100, 1, 0),
                Text = options.Title or "Multi Dropdown",
                BackgroundTransparency = 1,
                TextColor3 = RainLib.CurrentTheme.Text,
                Font = Enum.Font.SourceSans,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true,
                Parent = frame
            })

            local button = applyCommonStyles(Instance.new("TextButton"), {
                Size = UDim2.new(0, 90, 0, 25),
                Position = UDim2.new(1, -95, 0, 5),
                BackgroundColor3 = RainLib.CurrentTheme.Disabled,
                Text = #dropdown.Values > 0 and table.concat(dropdown.Values, ", ") or "Selecionar",
                TextColor3 = RainLib.CurrentTheme.Text,
                Font = Enum.Font.SourceSans,
                TextSize = 12,
                TextWrapped = true,
                UICorner = UDim.new(0, 5),
                Parent = frame
            })

            local listFrame = applyCommonStyles(Instance.new("Frame"), {
                Size = UDim2.new(0, 90, 0, 0),
                Position = UDim2.new(1, -95, 0, 35),
                BackgroundColor3 = RainLib.CurrentTheme.Secondary,
                Visible = false,
                UICorner = UDim.new(0, 5),
                Parent = frame
            })

            local listLayout = applyCommonStyles(Instance.new("UIListLayout"), {
                SortOrder = Enum.SortOrder.LayoutOrder,
                Parent = listFrame
            })

            if options.Flag and window.Options.SaveSettings then
                local settings = RainLib:LoadSettings(window.Options.ConfigFolder)
                if settings and settings.Flags[options.Flag] ~= nil then
                    dropdown.Values = settings.Flags[options.Flag]
                    button.Text = #dropdown.Values > 0 and table.concat(dropdown.Values, ", ") or "Selecionar"
                end
            end

            local function updateList()
                for _, child in ipairs(listFrame:GetChildren()) do
                    if child:IsA("TextButton") then
                        child:Destroy()
                    end
                end
                listFrame.Size = UDim2.new(0, 90, 0, math.min(#options.Items * 25, 100))
                for _, item in ipairs(options.Items or {}) do
                    local itemButton = applyCommonStyles(Instance.new("TextButton"), {
                        Size = UDim2.new(1, 0, 0, 25),
                        BackgroundColor3 = table.find(dropdown.Values, item) and RainLib.CurrentTheme.Accent or RainLib.CurrentTheme.Secondary,
                        Text = tostring(item),
                        TextColor3 = RainLib.CurrentTheme.Text,
                        Font = Enum.Font.SourceSans,
                        TextSize = 12,
                        TextWrapped = true,
                        Parent = listFrame
                    })

                    itemButton.MouseButton1Click:Connect(function()
                        if table.find(dropdown.Values, item) then
                            table.remove(dropdown.Values, table.find(dropdown.Values, item))
                        else
                            table.insert(dropdown.Values, item)
                        end
                        button.Text = #dropdown.Values > 0 and table.concat(dropdown.Values, ", ") or "Selecionar"
                        itemButton.BackgroundColor3 = table.find(dropdown.Values, item) and RainLib.CurrentTheme.Accent or RainLib.CurrentTheme.Secondary
                        if options.Callback then
                            options.Callback(dropdown.Values)
                        end
                        if options.Flag and window.Options.SaveSettings then
                            local settings = RainLib:LoadSettings(window.Options.ConfigFolder) or { Flags = {} }
                            settings.Flags[options.Flag] = dropdown.Values
                            RainLib:SaveSettings(window.Options.ConfigFolder, settings)
                        end
                    end)
                end
            end
            updateList()

            createContainer(frame, dropdownSize)
            button.MouseButton1Click:Connect(function()
                listFrame.Visible = not listFrame.Visible
                Designin:Tween(listFrame, TweenInfo.new(0.2), { Size = listFrame.Visible and UDim2.new(0, 90, 0, math.min(#options.Items * 25, 100)) or UDim2.new(0, 90, 0, 0) })
            end)

            table.insert(RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs[#RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs].Elements, {
                Type = "MultiDropdown", Key = key, Options = options
            })

            return dropdown
        end

        function tab:AddKeybind(key, options)
            options = options or {}
            local keybindSize = UDim2.new(1, -16, 0, 35)
            local keybind = { Value = options.Default or Enum.KeyCode.Unknown }
            local frame = applyCommonStyles(Instance.new("Frame"), {
                Size = keybindSize,
                BackgroundColor3 = RainLib.CurrentTheme.Secondary,
                UICorner = UDim.new(0, 6)
            })

            local label = applyCommonStyles(Instance.new("TextLabel"), {
                Size = UDim2.new(1, -100, 1, 0),
                Text = options.Title or "Keybind",
                BackgroundTransparency = 1,
                TextColor3 = RainLib.CurrentTheme.Text,
                Font = Enum.Font.SourceSans,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true,
                Parent = frame
            })

            local button = applyCommonStyles(Instance.new("TextButton"), {
                Size = UDim2.new(0, 90, 0, 25),
                Position = UDim2.new(1, -95, 0, 5),
                BackgroundColor3 = RainLib.CurrentTheme.Disabled,
                Text = keybind.Value.Name or "None",
                TextColor3 = RainLib.CurrentTheme.Text,
                Font = Enum.Font.SourceSans,
                TextSize = 12,
                TextWrapped = true,
                UICorner = UDim.new(0, 5),
                Parent = frame
            })

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
            local frame = applyCommonStyles(Instance.new("Frame"), {
                Size = pickerSize,
                BackgroundColor3 = RainLib.CurrentTheme.Secondary,
                UICorner = UDim.new(0, 6)
            })

            local label = applyCommonStyles(Instance.new("TextLabel"), {
                Size = UDim2.new(1, -40, 0, 18),
                Text = options.Title or "Colorpicker",
                BackgroundTransparency = 1,
                TextColor3 = RainLib.CurrentTheme.Text,
                Font = Enum.Font.SourceSans,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true,
                Parent = frame
            })

            local preview = applyCommonStyles(Instance.new("Frame"), {
                Size = UDim2.new(0, 25, 0, 25),
                Position = UDim2.new(1, -33, 0, 4),
                BackgroundColor3 = picker.Value,
                UICorner = UDim.new(0, 5),
                Parent = frame
            })

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
            local frame = applyCommonStyles(Instance.new("Frame"), {
                Size = inputSize,
                BackgroundColor3 = RainLib.CurrentTheme.Secondary,
                UICorner = UDim.new(0, 6)
            })

            local label = applyCommonStyles(Instance.new("TextLabel"), {
                Size = UDim2.new(1, -100, 1, 0),
                Text = options.Title or "Input",
                BackgroundTransparency = 1,
                TextColor3 = RainLib.CurrentTheme.Text,
                Font = Enum.Font.SourceSans,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true,
                Parent = frame
            })

            local textBox = applyCommonStyles(Instance.new("TextBox"), {
                Size = UDim2.new(0, 90, 0, 25),
                Position = UDim2.new(1, -95, 0, 5),
                BackgroundColor3 = RainLib.CurrentTheme.Disabled,
                Text = input.Value,
                TextColor3 = RainLib.CurrentTheme.Text,
                Font = Enum.Font.SourceSans,
                TextSize = 12,
                TextWrapped = true,
                UICorner = UDim.new(0, 5),
                Parent = frame
            })

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
            local dialogFrame = applyCommonStyles(Instance.new("Frame"), {
                Size = UDim2.new(0, 250, 0, 130),
                Position = UDim2.new(0.5, -125, 0.5, -65),
                BackgroundColor3 = RainLib.CurrentTheme.Background,
                Visible = false,
                UICorner = UDim.new(0, 10),
                Parent = RainLib.ScreenGui
            })

            local shadow = applyCommonStyles(Instance.new("ImageLabel"), {
                Size = UDim2.new(1, 20, 1, 20),
                Position = UDim2.new(0, -10, 0, -10),
                BackgroundTransparency = 1,
                Image = "rbxassetid://1316045217",
                ImageTransparency = 0.7,
                ImageColor3 = Color3.fromRGB(0, 0, 0),
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(10, 10, 118, 118),
                Parent = dialogFrame
            })

            local title = applyCommonStyles(Instance.new("TextLabel"), {
                Size = UDim2.new(1, -8, 0, 25),
                Position = UDim2.new(0, 4, 0, 4),
                Text = options.Title or "Dialog",
                BackgroundTransparency = 1,
                TextColor3 = RainLib.CurrentTheme.Text,
                Font = Enum.Font.GothamBold,
                TextSize = 16,
                Parent = dialogFrame
            })

            local content = applyCommonStyles(Instance.new("TextLabel"), {
                Size = UDim2.new(1, -8, 0, 45),
                Position = UDim2.new(0, 4, 0, 35),
                Text = options.Content or "",
                BackgroundTransparency = 1,
                TextColor3 = RainLib.CurrentTheme.Text,
                Font = Enum.Font.SourceSans,
                TextSize = 12,
                TextWrapped = true,
                Parent = dialogFrame
            })

            local buttonsFrame = applyCommonStyles(Instance.new("Frame"), {
                Size = UDim2.new(1, -8, 0, 35),
                Position = UDim2.new(0, 4, 1, -40),
                BackgroundTransparency = 1,
                Parent = dialogFrame
            })

            local buttonLayout = applyCommonStyles(Instance.new("UIListLayout"), {
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Right,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 8),
                Parent = buttonsFrame
            })

            for i, btn in ipairs(options.Buttons or {}) do
                local btnFrame = applyCommonStyles(Instance.new("TextButton"), {
                    Size = UDim2.new(0, 70, 0, 25),
                    BackgroundColor3 = RainLib.CurrentTheme.Accent,
                    Text = btn.Text or "Button " .. i,
                    TextColor3 = RainLib.CurrentTheme.Text,
                    Font = Enum.Font.SourceSansBold,
                    TextSize = 12,
                    TextWrapped = true,
                    UICorner = UDim.new(0, 5),
                    Parent = buttonsFrame
                })

                btnFrame.MouseButton1Click:Connect(function()
                    dialogFrame.Visible = false
                    if btn.Callback then
                        btn.Callback()
                    end
                end)
            end

            function dialog:Show()
                dialogFrame.Visible = true
                Designin:FadeIn(dialogFrame)
            end

            function dialog:Hide()
                Designin:FadeOut(dialogFrame).Completed:Connect(function()
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
                elseif elementState.Type == "MultiDropdown" then
                    tab:AddMultiDropdown(elementState.Key, elementState.Options)
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
        Designin:FadeOut(RainLib.ScreenGui).Completed:Connect(function()
            RainLib.ScreenGui:Destroy()
        end)
    end
end

print("[RainLib] Biblioteca carregada!")
return RainLib
