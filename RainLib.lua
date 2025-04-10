-- RainLib v1.2.2: Sections tratadas como elementos, 1 elemento por linha, largura dinâmica
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer

local RainLib = {
    Version = "1.2.2",
    Themes = {
        Dark = {
            Background = Color3.fromRGB(25, 25, 25),
            Accent = Color3.fromRGB(60, 160, 255),
            Text = Color3.fromRGB(240, 240, 240),
            Secondary = Color3.fromRGB(45, 45, 45),
            Disabled = Color3.fromRGB(90, 90, 90)
        }
    },
    Icons = loadstring(game:HttpGet("https://raw.githubusercontent.com/RainCreatorHub/RainLib/main/Icons.lua"))(),
    Windows = {},
    CurrentTheme = nil,
    Connections = {},
    CreatedFolders = {} -- Tabela pra rastrear pastas já criadas
}

local function tween(obj, info, properties)
    local tween = TweenService:Create(obj, info or TweenInfo.new(0.3, Enum.EasingStyle.Quint), properties)
    tween:Play()
    return tween
end

local function MakeDraggable(DragPoint, Main)
    local Dragging, DragInput, MousePos, FramePos = false
    RainLib.Connections[#RainLib.Connections + 1] = DragPoint.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            MousePos = Input.Position
            FramePos = Main.Position
            tween(DragPoint, TweenInfo.new(0.2), {BackgroundColor3 = RainLib.CurrentTheme.Accent:Lerp(Color3.fromRGB(255, 255, 255), 0.1)})
        end
    end)
    RainLib.Connections[#RainLib.Connections + 1] = DragPoint.InputChanged:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
            DragInput = Input
        end
    end)
    RainLib.Connections[#RainLib.Connections + 1] = UserInputService.InputChanged:Connect(function(Input)
        if Input == DragInput and Dragging then
            local Delta = Input.Position - MousePos
            Main.Position = UDim2.new(FramePos.X.Scale, FramePos.X.Offset + Delta.X, FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y)
        end
    end)
    RainLib.Connections[#RainLib.Connections + 1] = DragPoint.InputEnded:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            Dragging = false
            tween(DragPoint, TweenInfo.new(0.2), {BackgroundColor3 = RainLib.CurrentTheme.Secondary})
        end
    end)
end

print("[RainLib] Inicializando...")
local success, err = pcall(function()
    RainLib.ScreenGui = Instance.new("ScreenGui")
    RainLib.ScreenGui.Name = "RainLib"
    RainLib.ScreenGui.Parent = game.CoreGui or LocalPlayer:WaitForChild("PlayerGui", 5)
    RainLib.ScreenGui.ResetOnSpawn = false
    RainLib.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    RainLib.CurrentTheme = RainLib.Themes.Dark
    RainLib.Notifications = Instance.new("Frame")
    RainLib.Notifications.Size = UDim2.new(0, 300, 1, -25)
    RainLib.Notifications.Position = UDim2.new(1, -310, 0, 0)
    RainLib.Notifications.BackgroundTransparency = 1
    RainLib.Notifications.Parent = RainLib.ScreenGui
end)
if not success then
    warn("[RainLib] Falha na inicialização: " .. err)
    return nil
end
print("[RainLib] Inicializado com sucesso!")

-- Função CreateFolder modificada pra usar um único makefolder por pasta
function RainLib:CreateFolder(folderName)
    if not folderName or folderName == "" then
        warn("[RainLib] Nome da pasta não especificado!")
        return false
    end
    
    -- Verifica se a pasta já foi criada nesta sessão
    if self.CreatedFolders[folderName] then
        print("[RainLib] Pasta já registrada nesta sessão: " .. folderName)
        return false
    end
    
    if makefolder then
        if not isfolder(folderName) then
            makefolder(folderName)
            self.CreatedFolders[folderName] = true -- Marca como criada
            print("[RainLib] Pasta criada: " .. folderName)
            self:Notify({
                Title = "Sucesso",
                Content = "Pasta '" .. folderName .. "' criada!",
                Duration = 3
            })
            return true
        else
            self.CreatedFolders[folderName] = true -- Marca como existente
            print("[RainLib] Pasta já existe: " .. folderName)
            self:Notify({
                Title = "Aviso",
                Content = "A pasta '" .. folderName .. "' já existe!",
                Duration = 3
            })
            return false
        end
    else
        warn("[RainLib] Este executor não suporta a função makefolder!")
        self:Notify({
            Title = "Erro",
            Content = "Executor não suporta criação de pastas!",
            Duration = 3
        })
        return false
    end
end

function RainLib:Window(options)
    local window = {}
    options = options or {}
    local defaultOptions = {
        Title = "Rain Lib",
        SubTitle = "",
        Position = UDim2.new(0.5, -300, 0.5, -200),
        Theme = "Dark",
        MinimizeKey = Enum.KeyCode.LeftControl,
        SaveSettings = false,        -- Opção pra ativar criação de pasta
        ConfigFolder = "RainConfig"  -- Nome padrão da pasta
    }
    window.Options = {}
    for key, defaultValue in pairs(defaultOptions) do
        window.Options[key] = options[key] or defaultValue
    end
    
    -- Cria a pasta automaticamente se SaveSettings for true
    if window.Options.SaveSettings then
        RainLib:CreateFolder(window.Options.ConfigFolder)
    end
    
    window.Minimized = false
    window.Tabs = {}
    window.CurrentTabIndex = 1
    
    local success, err = pcall(function()
        window.MainFrame = Instance.new("Frame")
        window.MainFrame.Size = UDim2.new(0, 600, 0, 400)
        window.MainFrame.Position = window.Options.Position
        window.MainFrame.BackgroundColor3 = RainLib.CurrentTheme.Background
        window.MainFrame.ClipsDescendants = true
        window.MainFrame.BackgroundTransparency = 1
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
        window.TitleBar.Size = UDim2.new(1, 0, 0, 50)
        window.TitleBar.BackgroundColor3 = RainLib.CurrentTheme.Secondary
        window.TitleBar.Parent = window.MainFrame
        
        local titleGradient = Instance.new("UIGradient")
        titleGradient.Color = ColorSequence.new(RainLib.CurrentTheme.Secondary, RainLib.CurrentTheme.Background)
        titleGradient.Rotation = 90
        titleGradient.Parent = window.TitleBar
        
        window.TitleLabel = Instance.new("TextLabel")
        window.TitleLabel.Size = UDim2.new(1, -60, 0, 20)
        window.TitleLabel.Position = UDim2.new(0, 15, 0, 5)
        window.TitleLabel.BackgroundTransparency = 1
        window.TitleLabel.Text = window.Options.Title
        window.TitleLabel.TextColor3 = RainLib.CurrentTheme.Text
        window.TitleLabel.Font = Enum.Font.GothamBold
        window.TitleLabel.TextSize = 16
        window.TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
        window.TitleLabel.Parent = window.TitleBar
        
        window.SubTitleLabel = Instance.new("TextLabel")
        window.SubTitleLabel.Size = UDim2.new(1, -60, 0, 15)
        window.SubTitleLabel.Position = UDim2.new(0, 15, 0, 25)
        window.SubTitleLabel.BackgroundTransparency = 1
        window.SubTitleLabel.Text = window.Options.SubTitle
        window.SubTitleLabel.TextColor3 = RainLib.CurrentTheme.Text
        window.SubTitleLabel.Font = Enum.Font.Gotham
        window.SubTitleLabel.TextSize = 12
        window.SubTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
        window.SubTitleLabel.Parent = window.TitleBar
        
        window.CloseButton = Instance.new("TextButton")
        window.CloseButton.Size = UDim2.new(0, 30, 0, 30)
        window.CloseButton.Position = UDim2.new(1, -40, 0, 10)
        window.CloseButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
        window.CloseButton.Text = "X"
        window.CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        window.CloseButton.Font = Enum.Font.SourceSansBold
        window.CloseButton.TextSize = 16
        window.CloseButton.Parent = window.TitleBar
        
        local closeCorner = Instance.new("UICorner")
        closeCorner.CornerRadius = UDim.new(0, 8)
        closeCorner.Parent = window.CloseButton
        
        window.MinimizeBtn = Instance.new("TextButton")
        window.MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
        window.MinimizeBtn.Position = UDim2.new(1, -75, 0, 10)
        window.MinimizeBtn.BackgroundColor3 = RainLib.CurrentTheme.Accent
        window.MinimizeBtn.Text = "-"
        window.MinimizeBtn.TextColor3 = RainLib.CurrentTheme.Text
        window.MinimizeBtn.Font = Enum.Font.SourceSansBold
        window.MinimizeBtn.TextSize = 16
        window.MinimizeBtn.Parent = window.TitleBar
        
        local minimizeCorner = Instance.new("UICorner")
        minimizeCorner.CornerRadius = UDim.new(0, 8)
        minimizeCorner.Parent = window.MinimizeBtn
        
        window.TabContainer = Instance.new("ScrollingFrame")
        window.TabContainer.Size = UDim2.new(0, 150, 1, -50)
        window.TabContainer.Position = UDim2.new(0, 0, 0, 50)
        window.TabContainer.BackgroundColor3 = RainLib.CurrentTheme.Secondary
        window.TabContainer.ScrollBarThickness = 0
        window.TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
        window.TabContainer.Parent = window.MainFrame
        
        window.TabIndicator = Instance.new("Frame")
        window.TabIndicator.Size = UDim2.new(0, 4, 0, 40)
        window.TabIndicator.BackgroundColor3 = RainLib.CurrentTheme.Accent
        window.TabIndicator.Position = UDim2.new(0, 0, 0, 5)
        window.TabIndicator.Parent = window.TabContainer
        
        window.MainFrame.Position = UDim2.new(window.Options.Position.X.Scale, window.Options.Position.X.Offset, 0.5, 300)
        tween(window.MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = window.Options.Position, BackgroundTransparency = 0})
    end)
    if not success then
        warn("[RainLib] Falha ao criar janela: " .. err)
        return nil
    end
    
    MakeDraggable(window.TitleBar, window.MainFrame)
    
    window.CloseButton.MouseButton1Click:Connect(function()
        tween(window.MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(0.5, -300, 0.5, 300), BackgroundTransparency = 1}).Completed:Connect(function()
            if window.MinimizeButton then window.MinimizeButton:Destroy() end
            window.MainFrame:Destroy()
            print("[RainLib] Janela destruída")
        end)
    end)
    
    window.MinimizeBtn.MouseButton1Click:Connect(function()
        if window.Minimized then
            tween(window.MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 600, 0, 400)})
            window.MinimizeBtn.Text = "-"
            window.MainFrame.ClipsDescendants = false
            window.TabContainer.Visible = true
        else
            window.MainFrame.ClipsDescendants = true
            window.MinimizeBtn.Text = "+"
            tween(window.MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 600, 0, 50)})
            task.wait(0.1)
            window.TabContainer.Visible = false
        end
        window.Minimized = not window.Minimized
    end)
    
    if window.Options.MinimizeKey then
        UserInputService.InputBegan:Connect(function(input)
            if input.KeyCode == window.Options.MinimizeKey then
                window.MainFrame.Visible = not window.MainFrame.Visible
                if window.MinimizeButton then
                    window.MinimizeButton.Text = window.MainFrame.Visible and "Close" or "Open"
                end
            end
        end)
    end
    
    function window:Minimize(options)
        options = options or {}
        local button
        local success, err = pcall(function()
            button = Instance.new("TextButton")
            button.Size = UDim2.new(0, 100, 0, 30)
            button.Position = UDim2.new(0, 10, 0, 10)
            button.Text = options.Text1 or "Close"
            button.BackgroundColor3 = RainLib.CurrentTheme.Accent
            button.TextColor3 = RainLib.CurrentTheme.Text
            button.Font = Enum.Font.SourceSansBold
            button.TextSize = 16
            button.BackgroundTransparency = 1
            button.Parent = RainLib.ScreenGui
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = options.CornerRadius or UDim.new(0, 8)
            corner.Parent = button
            
            local shadow = Instance.new("ImageLabel")
            shadow.Size = UDim2.new(1, 20, 1, 20)
            shadow.Position = UDim2.new(0, -10, 0, -10)
            shadow.BackgroundTransparency = 1
            shadow.Image = "rbxassetid://1316045217"
            shadow.ImageTransparency = 0.7
            shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
            shadow.ScaleType = Enum.ScaleType.Slice
            shadow.SliceCenter = Rect.new(10, 10, 118, 118)
            shadow.Parent = button
            
            button.MouseButton1Click:Connect(function()
                window.MainFrame.Visible = not window.MainFrame.Visible
                button.Text = window.MainFrame.Visible and (options.Text1 or "Close") or (options.Text2 or "Open")
            end)
            
            button.MouseEnter:Connect(function()
                tween(button, TweenInfo.new(0.2), {BackgroundColor3 = RainLib.CurrentTheme.Accent:Lerp(Color3.fromRGB(255, 255, 255), 0.2)})
            end)
            button.MouseLeave:Connect(function()
                tween(button, TweenInfo.new(0.2), {BackgroundColor3 = RainLib.CurrentTheme.Accent})
            end)
            
            if options.Draggable then
                MakeDraggable(button, button)
            end
            
            tween(button, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = 0})
        end)
        
        if not success then
            warn("[RainLib] Falha ao criar botão de minimizar: " .. err)
            return nil
        end
        
        window.MinimizeButton = button
        return button
    end
    
    function window:Tab(options)
        local tab = {}
        options = options or {}
        tab.Name = options.Title or "Tab"
        tab.Icon = options.Icon or nil
        tab.ElementCount = 0
        tab.Elements = {}
        
        tab.Content = Instance.new("ScrollingFrame")
        tab.Content.Size = UDim2.new(1, -160, 1, -60)
        tab.Content.Position = UDim2.new(0, 155, 0, 55)
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
        tab.Button.Size = UDim2.new(1, -10, 0, 40)
        tab.Button.Position = UDim2.new(0, 5, 0, #window.Tabs * 45 + 5)
        tab.Button.BackgroundColor3 = RainLib.CurrentTheme.Secondary
        tab.Button.Text = tab.Icon and "" or tab.Name
        tab.Button.TextColor3 = RainLib.CurrentTheme.Text
        tab.Button.Font = Enum.Font.SourceSansBold
        tab.Button.TextSize = 16
        tab.Button.TextXAlignment = Enum.TextXAlignment.Left
        tab.Button.Parent = window.TabContainer
        window.TabContainer.CanvasSize = UDim2.new(0, 0, 0, #window.Tabs * 45 + 50)
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 8)
        buttonCorner.Parent = tab.Button
        
        if tab.Icon then
            local icon = Instance.new("ImageLabel")
            icon.Size = UDim2.new(0, 24, 0, 24)
            icon.Position = UDim2.new(0, 10, 0.5, -12)
            icon.BackgroundTransparency = 1
            icon.Image = RainLib.Icons[tab.Icon] or tab.Icon
            icon.Parent = tab.Button
            
            local text = Instance.new("TextLabel")
            text.Size = UDim2.new(1, -40, 1, 0)
            text.Position = UDim2.new(0, 40, 0, 0)
            text.BackgroundTransparency = 1
            text.Text = tab.Name
            text.TextColor3 = RainLib.CurrentTheme.Text
            text.Font = Enum.Font.SourceSansBold
            text.TextSize = 16
            text.TextXAlignment = Enum.TextXAlignment.Left
            text.Parent = tab.Button
        end
        
        tab.Button.MouseEnter:Connect(function()
            if not tab.Content.Visible then
                tween(tab.Button, TweenInfo.new(0.2), {BackgroundColor3 = RainLib.CurrentTheme.Secondary:Lerp(RainLib.CurrentTheme.Accent, 0.3)})
            end
        end)
        tab.Button.MouseLeave:Connect(function()
            if not tab.Content.Visible then
                tween(tab.Button, TweenInfo.new(0.2), {BackgroundColor3 = RainLib.CurrentTheme.Secondary})
            end
        end)
        
        table.insert(window.Tabs, tab)
        
        local function selectTab(index)
            for i, t in pairs(window.Tabs) do
                if i == index then
                    t.Content.Visible = true
                    tween(t.Content, TweenInfo.new(0.3), {BackgroundTransparency = 1, Position = UDim2.new(0, 155, 0, 55)})
                    tween(window.TabIndicator, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Position = UDim2.new(0, 0, 0, (i-1) * 45 + 5)})
                    tween(t.Button, TweenInfo.new(0.2), {BackgroundColor3 = RainLib.CurrentTheme.Accent})
                else
                    tween(t.Content, TweenInfo.new(0.3), {Position = UDim2.new(0, 200, 0, 55)}).Completed:Connect(function()
                        t.Content.Visible = false
                    end)
                    tween(t.Button, TweenInfo.new(0.2), {BackgroundColor3 = RainLib.CurrentTheme.Secondary})
                end
            end
        end
        
        tab.Button.MouseButton1Click:Connect(function()
            local index = table.find(window.Tabs, tab)
            selectTab(index)
        end)
        
        if #window.Tabs == 1 then
            selectTab(1)
        end
        
        local function getNextPosition(elementSize)
            local padding = 10
            local row = tab.ElementCount
            local yOffset = padding + row * (elementSize.Y.Offset + padding)
            tab.ElementCount = tab.ElementCount + 1
            tab.Content.CanvasSize = UDim2.new(0, 0, 0, yOffset + elementSize.Y.Offset + padding)
            return UDim2.new(0, padding, 0, yOffset + 100)
        end
        
        local function createContainer(element, size)
            local container = Instance.new("Frame")
            container.Size = UDim2.new(0, size.X.Offset + 20, 0, size.Y.Offset + 20)
            local targetPos = getNextPosition(size)
            container.Position = UDim2.new(targetPos.X.Scale, targetPos.X.Offset, targetPos.Y.Scale, targetPos.Y.Offset + 100)
            container.BackgroundTransparency = 1
            container.Parent = tab.Container
            element.Parent = container
            element.Position = UDim2.new(0, 10, 0, 10)
            tween(container, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(targetPos.X.Scale, targetPos.X.Offset, targetPos.Y.Scale, targetPos.Y.Offset - 100)})
            
            table.insert(tab.Elements, {container = container, element = element})
            return container
        end
        
        RunService.RenderStepped:Connect(function(deltaTime)
            local currentTime = tick()
            if currentTime - (tab.LastUpdate or 0) >= 0.04 then
                tab.LastUpdate = currentTime
                local contentWidth = tab.Content.AbsoluteSize.X - 20
                for _, elem in pairs(tab.Elements) do
                    local newWidth = contentWidth - 20
                    elem.container.Size = UDim2.new(0, newWidth, 0, elem.container.Size.Y.Offset)
                    elem.element.Size = UDim2.new(0, newWidth - 20, 0, elem.element.Size.Y.Offset)
                end
            end
        end)
        
        function tab:AddSection(name)
            local sectionSize = UDim2.new(0, 420, 0, 30)
            local sectionContainer = Instance.new("Frame")
            sectionContainer.Size = sectionSize
            sectionContainer.BackgroundTransparency = 1
            
            local section = Instance.new("TextLabel")
            section.Size = UDim2.new(0, 420, 0, 30)
            section.BackgroundTransparency = 1
            section.Text = name or "Section"
            section.TextColor3 = RainLib.CurrentTheme.Text
            section.Font = Enum.Font.GothamBold
            section.TextSize = 18
            section.TextXAlignment = Enum.TextXAlignment.Left
            section.TextTransparency = 1
            section.Parent = sectionContainer
            
            local underline = Instance.new("Frame")
            underline.Size = UDim2.new(0, 0, 0, 2)
            underline.Position = UDim2.new(0, 0, 1, -2)
            underline.BackgroundColor3 = RainLib.CurrentTheme.Accent
            underline.Parent = sectionContainer
            
            createContainer(sectionContainer, sectionSize)
            
            tween(section, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 0})
            tween(underline, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Size = UDim2.new(0.3, 0, 0, 2)})
            
            return section
        end
        
        function tab:AddParagraph(options)
            local paragraphSize = UDim2.new(0, 120, 0, 40)
            local frame = Instance.new("Frame")
            frame.Size = paragraphSize
            frame.BackgroundTransparency = 1
            
            local title = Instance.new("TextLabel")
            title.Size = UDim2.new(0, 120, 0, 20)
            title.Text = options.Title or "Paragraph"
            title.BackgroundTransparency = 1
            title.TextColor3 = RainLib.CurrentTheme.Text
            title.Font = Enum.Font.GothamBold
            title.TextSize = 12
            title.TextXAlignment = Enum.TextXAlignment.Left
            title.Parent = frame
            
            local content = Instance.new("TextLabel")
            content.Size = UDim2.new(0, 120, 0, 20)
            content.Position = UDim2.new(0, 0, 0, 20)
            content.Text = options.Content or "Content"
            content.BackgroundTransparency = 1
            content.TextColor3 = RainLib.CurrentTheme.Text
            content.Font = Enum.Font.SourceSans
            content.TextSize = 10
            content.TextWrapped = true
            content.TextXAlignment = Enum.TextXAlignment.Left
            content.Parent = frame
            
            createContainer(frame, paragraphSize)
            return frame
        end
        
        function tab:AddButton(options)
            local buttonSize = UDim2.new(0, 120, 0, 40)
            local button = Instance.new("TextButton")
            button.Size = buttonSize
            button.Text = options.Title or "Button"
            button.BackgroundColor3 = RainLib.CurrentTheme.Accent
            button.TextColor3 = RainLib.CurrentTheme.Text
            button.Font = Enum.Font.SourceSansBold
            button.TextSize = 16
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = button
            
            local stroke = Instance.new("UIStroke")
            stroke.Thickness = 1
            stroke.Color = RainLib.CurrentTheme.Accent:Lerp(Color3.fromRGB(0, 0, 0), 0.2)
            stroke.Parent = button
            
            button.MouseEnter:Connect(function()
                tween(button, TweenInfo.new(0.2), {BackgroundColor3 = RainLib.CurrentTheme.Accent:Lerp(Color3.fromRGB(255, 255, 255), 0.2)})
            end)
            button.MouseLeave:Connect(function()
                tween(button, TweenInfo.new(0.2), {BackgroundColor3 = RainLib.CurrentTheme.Accent})
            end)
            
            createContainer(button, buttonSize)
            button.MouseButton1Click:Connect(options.Callback or function() end)
            return button
        end
        
        function tab:AddToggle(key, options)
            local toggleSize = UDim2.new(0, 120, 0, 40)
            local toggle = { Value = options.Default or false }
            local frame = Instance.new("Frame")
            frame.Size = toggleSize
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = frame
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0, 80, 1, 0)
            label.Text = options.Title or "Toggle"
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = Enum.Font.SourceSans
            label.TextSize = 16
            label.Parent = frame
            
            local indicator = Instance.new("Frame")
            indicator.Size = UDim2.new(0, 20, 0, 20)
            indicator.Position = UDim2.new(1, -30, 0.5, -10)
            indicator.BackgroundColor3 = toggle.Value and RainLib.CurrentTheme.Accent or RainLib.CurrentTheme.Disabled
            indicator.Parent = frame
            
            local indicatorCorner = Instance.new("UICorner")
            indicatorCorner.CornerRadius = UDim.new(0, 10)
            indicatorCorner.Parent = indicator
            
            createContainer(frame, toggleSize)
            frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    toggle.Value = not toggle.Value
                    tween(indicator, TweenInfo.new(0.2), {
                        BackgroundColor3 = toggle.Value and RainLib.CurrentTheme.Accent or RainLib.CurrentTheme.Disabled,
                        Size = UDim2.new(0, toggle.Value and 24 or 20, 0, toggle.Value and 24 or 20),
                        Position = UDim2.new(1, toggle.Value and -34 or -30, 0.5, toggle.Value and -12 or -10)
                    })
                    if options.Callback then
                        options.Callback(toggle.Value)
                    end
                end
            end)
            
            function toggle:OnChanged(callback)
                frame.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        callback(toggle.Value)
                    end
                end)
            end
            
            return toggle
        end
        
        function tab:AddSlider(key, options)
            local sliderSize = UDim2.new(0, 120, 0, 40)
            local slider = { Value = options.Default or options.Min or 0 }
            local frame = Instance.new("Frame")
            frame.Size = sliderSize
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = frame
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0, 80, 0, 20)
            label.Text = options.Title or "Slider"
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = Enum.Font.SourceSans
            label.TextSize = 12
            label.Parent = frame
            
            local valueLabel = Instance.new("TextLabel")
            valueLabel.Size = UDim2.new(0, 30, 0, 20)
            valueLabel.Position = UDim2.new(1, -35, 0, 0)
            valueLabel.Text = tostring(slider.Value)
            valueLabel.BackgroundTransparency = 1
            valueLabel.TextColor3 = RainLib.CurrentTheme.Text
            valueLabel.Font = Enum.Font.SourceSans
            valueLabel.TextSize = 12
            valueLabel.Parent = frame
            
            local bar = Instance.new("Frame")
            bar.Size = UDim2.new(1, -10, 0, 8)
            bar.Position = UDim2.new(0, 5, 0, 25)
            bar.BackgroundColor3 = RainLib.CurrentTheme.Disabled
            bar.Parent = frame
            
            local fill = Instance.new("Frame")
            fill.Size = UDim2.new((slider.Value - (options.Min or 0)) / ((options.Max or 100) - (options.Min or 0)), 0, 1, 0)
            fill.BackgroundColor3 = RainLib.CurrentTheme.Accent
            fill.Parent = bar
            
            local cornerBar = Instance.new("UICorner")
            cornerBar.CornerRadius = UDim.new(0, 4)
            cornerBar.Parent = bar
            
            local cornerFill = Instance.new("UICorner")
            cornerFill.CornerRadius = UDim.new(0, 4)
            cornerFill.Parent = fill
            
            createContainer(frame, sliderSize)
            local dragging
            bar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    tween(bar, TweenInfo.new(0.2), {BackgroundColor3 = RainLib.CurrentTheme.Disabled:Lerp(RainLib.CurrentTheme.Accent, 0.2)})
                end
            end)
            
            bar.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                    tween(bar, TweenInfo.new(0.2), {BackgroundColor3 = RainLib.CurrentTheme.Disabled})
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
                    tween(fill, TweenInfo.new(0.1), {Size = UDim2.new(relativeX, 0, 1, 0)})
                    valueLabel.Text = tostring(slider.Value)
                    if options.Callback then
                        options.Callback(slider.Value)
                    end
                end
            end)
            
            function slider:OnChanged(callback)
                RunService.RenderStepped:Connect(function()
                    if dragging then
                        callback(slider.Value)
                    end
                end)
            end
            
            function slider:SetValue(value)
                slider.Value = math.clamp(value, options.Min or 0, options.Max or 100)
                if options.Rounding then
                    slider.Value = math.floor(slider.Value / options.Rounding) * options.Rounding
                end
                tween(fill, TweenInfo.new(0.2), {Size = UDim2.new((slider.Value - (options.Min or 0)) / ((options.Max or 100) - (options.Min or 0)), 0, 1, 0)})
                valueLabel.Text = tostring(slider.Value)
            end
            
            return slider
        end
        
        function tab:AddDropdown(key, options)
            local dropdownSize = UDim2.new(0, 120, 0, 40)
            local dropdown = { Value = options.Default or (options.Multi and {} or options.Values[1]) }
            local frame = Instance.new("Frame")
            frame.Size = dropdownSize
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = frame
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -30, 1, 0)
            label.Text = options.Multi and table.concat(next(dropdown.Value) and dropdown.Value or {}, ", ") or dropdown.Value
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = Enum.Font.SourceSans
            label.TextSize = 14
            label.Parent = frame
            
            local arrow = Instance.new("TextLabel")
            arrow.Size = UDim2.new(0, 20, 1, 0)
            arrow.Position = UDim2.new(1, -25, 0, 0)
            arrow.Text = "▼"
            arrow.BackgroundTransparency = 1
            arrow.TextColor3 = RainLib.CurrentTheme.Text
            arrow.Font = Enum.Font.SourceSans
            arrow.TextSize = 14
            arrow.Parent = frame
            
            local list = Instance.new("Frame")
            list.Size = UDim2.new(1, 0, 0, #options.Values * 30)
            list.Position = UDim2.new(0, 0, 1, 5)
            list.BackgroundColor3 = RainLib.CurrentTheme.Secondary
            list.BackgroundTransparency = 1
            list.Visible = false
            list.Parent = frame
            
            local listCorner = Instance.new("UICorner")
            listCorner.CornerRadius = UDim.new(0, 8)
            listCorner.Parent = list
            
            for i, opt in ipairs(options.Values) do
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, 0, 0, 30)
                btn.Position = UDim2.new(0, 0, 0, (i-1) * 30)
                btn.Text = opt
                btn.BackgroundTransparency = 0.2
                btn.BackgroundColor3 = RainLib.CurrentTheme.Secondary
                btn.TextColor3 = RainLib.CurrentTheme.Text
                btn.Font = Enum.Font.SourceSans
                btn.TextSize = 14
                btn.Parent = list
                
                btn.MouseEnter:Connect(function()
                    tween(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0, BackgroundColor3 = RainLib.CurrentTheme.Accent})
                end)
                btn.MouseLeave:Connect(function()
                    tween(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.2, BackgroundColor3 = RainLib.CurrentTheme.Secondary})
                end)
                
                btn.MouseButton1Click:Connect(function()
                    if options.Multi then
                        dropdown.Value[opt] = not dropdown.Value[opt]
                        local values = {}
                        for k, v in pairs(dropdown.Value) do
                            if v then table.insert(values, k) end
                        end
                        label.Text = table.concat(values, ", ")
                    else
                        dropdown.Value = opt
                        label.Text = opt
                        tween(list, TweenInfo.new(0.3), {BackgroundTransparency = 1}).Completed:Connect(function() list.Visible = false end)
                    end
                    if options.Callback then
                        options.Callback(dropdown.Value)
                    end
                end)
            end
            
            createContainer(frame, dropdownSize)
            frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    list.Visible = true
                    tween(list, TweenInfo.new(0.3), {BackgroundTransparency = 0})
                    tween(arrow, TweenInfo.new(0.2), {Rotation = list.Visible and 180 or 0})
                end
            end)
            
            function dropdown:OnChanged(callback)
                frame.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        callback(dropdown.Value)
                    end
                end)
            end
            
            function dropdown:SetValue(value)
                if options.Multi then
                    dropdown.Value = {}
                    for k, v in pairs(value) do
                        if table.find(options.Values, k) then
                            dropdown.Value[k] = v
                        end
                    end
                    local values = {}
                    for k, v in pairs(dropdown.Value) do
                        if v then table.insert(values, k) end
                    end
                    label.Text = table.concat(values, ", ")
                else
                    if table.find(options.Values, value) then
                        dropdown.Value = value
                        label.Text = value
                    end
                end
            end
            
            return dropdown
        end
        
        function tab:AddColorpicker(key, options)
            local colorpickerSize = UDim2.new(0, 120, 0, 40)
            local colorpicker = { Value = options.Default or Color3.fromRGB(255, 255, 255) }
            local frame = Instance.new("Frame")
            frame.Size = colorpickerSize
            frame.BackgroundColor3 = colorpicker.Value
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = frame
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0, 80, 1, 0)
            label.Text = options.Title or "Colorpicker"
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = Enum.Font.SourceSans
            label.TextSize = 14
            label.Parent = frame
            
            createContainer(frame, colorpickerSize)
            
            frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    local r = math.random(0, 255)
                    local g = math.random(0, 255)
                    local b = math.random(0, 255)
                    colorpicker:SetValueRGB(Color3.fromRGB(r, g, b))
                end
            end)
            
            function colorpicker:OnChanged(callback)
                -- Placeholder pra callback
            end
            
            function colorpicker:SetValueRGB(color)
                colorpicker.Value = color
                tween(frame, TweenInfo.new(0.2), {BackgroundColor3 = color})
                if options.Callback then
                    options.Callback(color)
                end
            end
            
            return colorpicker
        end
        
        function tab:AddKeybind(key, options)
            local keybindSize = UDim2.new(0, 120, 0, 40)
            local keybind = { Value = options.Default or "None", Mode = options.Mode or "Toggle" }
            local frame = Instance.new("Frame")
            frame.Size = keybindSize
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = frame
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0, 80, 1, 0)
            label.Text = options.Title or "Keybind"
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = Enum.Font.SourceSans
            label.TextSize = 14
            label.Parent = frame
            
            local keyLabel = Instance.new("TextLabel")
            keyLabel.Size = UDim2.new(0, 30, 1, 0)
            keyLabel.Position = UDim2.new(1, -35, 0, 0)
            keyLabel.Text = keybind.Value
            keyLabel.BackgroundTransparency = 1
            keyLabel.TextColor3 = RainLib.CurrentTheme.Text
            keyLabel.Font = Enum.Font.SourceSans
            keyLabel.TextSize = 14
            keyLabel.Parent = frame
            
            createContainer(frame, keybindSize)
            local waitingForInput = false
            
            frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    waitingForInput = true
                    tween(keyLabel, TweenInfo.new(0.2), {TextTransparency = 0.5})
                    keyLabel.Text = "..."
                end
            end)
            
            UserInputService.InputBegan:Connect(function(input)
                if waitingForInput and input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                    keybind.Value = input.KeyCode.Name or input.UserInputType.Name
                    keyLabel.Text = keybind.Value
                    tween(keyLabel, TweenInfo.new(0.2), {TextTransparency = 0})
                    waitingForInput = false
                    if options.ChangedCallback then
                        options.ChangedCallback(input.KeyCode or input.UserInputType)
                    end
                    if options.Callback then
                        options.Callback(true)
                    end
                end
            end)
            
            UserInputService.InputEnded:Connect(function(input)
                if not waitingForInput and (input.KeyCode.Name == keybind.Value or input.UserInputType.Name == keybind.Value) then
                    if keybind.Mode == "Hold" and options.Callback then
                        options.Callback(false)
                    end
                end
            end)
            
            function keybind:GetState()
                return UserInputService:IsKeyDown(Enum.KeyCode[keybind.Value]) or UserInputService:GetMouseButtonPressed(Enum.UserInputType[keybind.Value])
            end
            
            function keybind:OnClick(callback)
                UserInputService.InputBegan:Connect(function(input)
                    if not waitingForInput and keybind.Mode == "Toggle" and (input.KeyCode.Name == keybind.Value or input.UserInputType.Name == keybind.Value) then
                        callback()
                    end
                end)
            end
            
            function keybind:OnChanged(callback)
                frame.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        callback(keybind.Value)
                    end
                end)
            end
            
            function keybind:SetValue(key, mode)
                keybind.Value = key
                keybind.Mode = mode or keybind.Mode
                tween(keyLabel, TweenInfo.new(0.2), {Text = keybind.Value})
            end
            
            return keybind
        end
        
        function tab:AddInput(key, options)
            local inputSize = UDim2.new(0, 120, 0, 40)
            local input = { Value = options.Default or "" }
            local textbox = Instance.new("TextBox")
            textbox.Size = inputSize
            textbox.Text = input.Value
            textbox.BackgroundColor3 = RainLib.CurrentTheme.Secondary
            textbox.TextColor3 = RainLib.CurrentTheme.Text
            textbox.Font = Enum.Font.SourceSans
            textbox.TextSize = 14
            textbox.PlaceholderText = options.Placeholder or ""
            textbox.PlaceholderColor3 = RainLib.CurrentTheme.Disabled
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = textbox
            
            local stroke = Instance.new("UIStroke")
            stroke.Thickness = 1
            stroke.Color = RainLib.CurrentTheme.Accent
            stroke.Transparency = 0.8
            stroke.Parent = textbox
            
            textbox.Focused:Connect(function()
                tween(stroke, TweenInfo.new(0.2), {Transparency = 0})
            end)
            textbox.FocusLost:Connect(function()
                tween(stroke, TweenInfo.new(0.2), {Transparency = 0.8})
            end)
            
            createContainer(textbox, inputSize)
            textbox.FocusLost:Connect(function(enterPressed)
                input.Value = options.Numeric and tonumber(textbox.Text) or textbox.Text
                if enterPressed and options.Callback then
                    options.Callback(input.Value)
                end
            end)
            
            function input:OnChanged(callback)
                textbox.Changed:Connect(function()
                    input.Value = options.Numeric and tonumber(textbox.Text) or textbox.Text
                    callback(input.Value)
                end)
            end
            
            return input
        end
        
        function tab:Dialog(options)
            local dialog = Instance.new("Frame")
            dialog.Size = UDim2.new(0, 300, 0, 150)
            dialog.Position = UDim2.new(0.5, -150, 0.5, 200)
            dialog.BackgroundColor3 = RainLib.CurrentTheme.Background
            dialog.BackgroundTransparency = 1
            dialog.Parent = RainLib.ScreenGui
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 12)
            corner.Parent = dialog
            
            local shadow = Instance.new("ImageLabel")
            shadow.Size = UDim2.new(1, 40, 1, 40)
            shadow.Position = UDim2.new(0, -20, 0, -20)
            shadow.BackgroundTransparency = 1
            shadow.Image = "rbxassetid://1316045217"
            shadow.ImageTransparency = 0.6
            shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
            shadow.ScaleType = Enum.ScaleType.Slice
            shadow.SliceCenter = Rect.new(10, 10, 118, 118)
            shadow.Parent = dialog
            
            local title = Instance.new("TextLabel")
            title.Size = UDim2.new(1, -10, 0, 20)
            title.Position = UDim2.new(0, 5, 0, 5)
            title.Text = options.Title or "Dialog"
            title.BackgroundTransparency = 1
            title.TextColor3 = RainLib.CurrentTheme.Text
            title.Font = Enum.Font.GothamBold
            title.TextSize = 16
            title.Parent = dialog
            
            local content = Instance.new("TextLabel")
            content.Size = UDim2.new(1, -10, 0, 60)
            content.Position = UDim2.new(0, 5, 0, 30)
            content.Text = options.Content or "Content"
            content.BackgroundTransparency = 1
            content.TextColor3 = RainLib.CurrentTheme.Text
            content.Font = Enum.Font.SourceSans
            content.TextSize = 14
            content.TextWrapped = true
            content.Parent = dialog
            
            for i, btn in ipairs(options.Buttons or {}) do
                local button = Instance.new("TextButton")
                button.Size = UDim2.new(0, 80, 0, 30)
                button.Position = UDim2.new(0, 10 + (i-1) * 90, 1, -40)
                button.Text = btn.Title or "Button"
                button.BackgroundColor3 = RainLib.CurrentTheme.Accent
                button.TextColor3 = RainLib.CurrentTheme.Text
                button.Font = Enum.Font.SourceSansBold
                button.TextSize = 16
                button.Parent = dialog
                
                local btnCorner = Instance.new("UICorner")
                btnCorner.CornerRadius = UDim.new(0, 8)
                btnCorner.Parent = button
                
                button.MouseEnter:Connect(function()
                    tween(button, TweenInfo.new(0.2), {BackgroundColor3 = RainLib.CurrentTheme.Accent:Lerp(Color3.fromRGB(255, 255, 255), 0.2)})
                end)
                button.MouseLeave:Connect(function()
                    tween(button, TweenInfo.new(0.2), {BackgroundColor3 = RainLib.CurrentTheme.Accent})
                end)
                
                button.MouseButton1Click:Connect(function()
                    if btn.Callback then
                        btn.Callback()
                    end
                    tween(dialog, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(0.5, -150, 0.5, 200), BackgroundTransparency = 1}).Completed:Connect(function()
                        dialog:Destroy()
                    end)
                end)
            end
            
            tween(dialog, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(0.5, -150, 0.5, -75), BackgroundTransparency = 0})
        end
        
        return tab
    end
    
    function window:SetOption(key, value)
        if defaultOptions[key] ~= nil then
            window.Options[key] = value
            if key == "Title" then
                window.TitleLabel.Text = value
            elseif key == "SubTitle" then
                window.SubTitleLabel.Text = value
            elseif key == "Position" then
                tween(window.MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = value})
            end
        else
            warn("[RainLib] Opção inválida: " .. key)
        end
    end
    
    table.insert(RainLib.Windows, window)
    return window
end

function RainLib:Notify(options)
    local success, err = pcall(function()
        local notification = Instance.new("Frame")
        notification.Size = UDim2.new(0, 280, 0, 80)
        notification.Position = UDim2.new(1, 300, 0, (#RainLib.Notifications:GetChildren() - 1) * 90 + 10)
        notification.BackgroundColor3 = RainLib.CurrentTheme.Background
        notification.BackgroundTransparency = 1
        notification.Parent = RainLib.Notifications
        
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
        title.Text = options.Title or "Notification"
        title.BackgroundTransparency = 1
        title.TextColor3 = RainLib.CurrentTheme.Text
        title.Font = Enum.Font.GothamBold
        title.TextSize = 16
        title.Parent = notification
        
        local message = Instance.new("TextLabel")
        message.Size = UDim2.new(1, -10, 0, 40)
        message.Position = UDim2.new(0, 5, 0, 30)
        message.Text = options.Content or "Message"
        message.BackgroundTransparency = 1
        message.TextColor3 = RainLib.CurrentTheme.Text
        message.Font = Enum.Font.SourceSans
        message.TextSize = 14
        message.TextWrapped = true
        message.Parent = notification
        
        tween(notification, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(1, -290, 0, (#RainLib.Notifications:GetChildren() - 1) * 90 + 10), BackgroundTransparency = 0})
        task.wait(options.Duration or 3)
        tween(notification, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(1, 300, 0, notification.Position.Y.Offset), BackgroundTransparency = 1}).Completed:Connect(function()
            notification:Destroy()
        end)
    end)
end

function RainLib:SetTheme(theme)
    local success, err = pcall(function()
        RainLib.CurrentTheme = theme
        for _, window in pairs(RainLib.Windows) do
            tween(window.MainFrame, TweenInfo.new(0.3), {BackgroundColor3 = theme.Background})
            tween(window.TitleBar, TweenInfo.new(0.3), {BackgroundColor3 = theme.Secondary})
            tween(window.TitleLabel, TweenInfo.new(0.3), {TextColor3 = theme.Text})
            tween(window.SubTitleLabel, TweenInfo.new(0.3), {TextColor3 = theme.Text})
            tween(window.TabContainer, TweenInfo.new(0.3), {BackgroundColor3 = theme.Secondary})
            tween(window.TabIndicator, TweenInfo.new(0.3), {BackgroundColor3 = theme.Accent})
            tween(window.MinimizeBtn, TweenInfo.new(0.3), {BackgroundColor3 = theme.Accent})
            for _, tab in pairs(window.Tabs) do
                tween(tab.Button, TweenInfo.new(0.3), {TextColor3 = theme.Text, BackgroundColor3 = tab.Content.Visible and theme.Accent or theme.Secondary})
                for _, child in pairs(tab.Button:GetChildren()) do
                    if child:IsA("TextLabel") then
                        tween(child, TweenInfo.new(0.3), {TextColor3 = theme.Text})
                    end
                end
                for _, child in pairs(tab.Container:GetChildren()) do
                    if child:IsA("TextButton") or child:IsA("TextBox") then
                        tween(child, TweenInfo.new(0.3), {BackgroundColor3 = theme.Accent, TextColor3 = theme.Text})
                    elseif child:IsA("Frame") then
                        tween(child, TweenInfo.new(0.3), {BackgroundColor3 = theme.Secondary})
                        for _, subchild in pairs(child:GetChildren()) do
                            if subchild:IsA("TextLabel") then
                                tween(subchild, TweenInfo.new(0.3), {TextColor3 = theme.Text})
                            elseif subchild:IsA("Frame") then
                                tween(subchild, TweenInfo.new(0.3), {BackgroundColor3 = subchild.Parent.BackgroundColor3 == theme.Accent and theme.Accent or theme.Disabled})
                            end
                        end
                    end
                end
            end
        end
    end)
end

function RainLib:Destroy()
    for _, conn in pairs(RainLib.Connections) do
        conn:Disconnect()
    end
    tween(RainLib.ScreenGui, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}).Completed:Connect(function()
        RainLib.ScreenGui:Destroy()
    end)
end

print("[RainLib] Biblioteca carregada!")
return RainLib
