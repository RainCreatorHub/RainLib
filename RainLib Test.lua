-- RainLib v3.0.0 (Equivalente à Redz Library v5)
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local HttpService = game:GetService("HttpService")
local SoundService = game:GetService("SoundService")

local RainLib = {
    Version = "3.0.0",
    Themes = {
        Dark = {
            Background = Color3.fromRGB(25, 25, 25),
            Accent = Color3.fromRGB(60, 160, 255),
            Text = Color3.fromRGB(240, 240, 240),
            Secondary = Color3.fromRGB(45, 45, 45),
            Disabled = Color3.fromRGB(90, 90, 90),
            Glow = Color3.fromRGB(80, 180, 255)
        },
        Light = {
            Background = Color3.fromRGB(240, 240, 240),
            Accent = Color3.fromRGB(40, 120, 200),
            Text = Color3.fromRGB(20, 20, 20),
            Secondary = Color3.fromRGB(200, 200, 200),
            Disabled = Color3.fromRGB(150, 150, 150),
            Glow = Color3.fromRGB(60, 140, 220)
        }
    },
    CurrentTheme = nil,
    CreatedFolders = {},
    GUIState = { Windows = {} },
    Animations = {},
    Sounds = { Click = Instance.new("Sound", SoundService) },
    Plugins = {}
}

RainLib.Sounds.Click.SoundId = "rbxassetid://9120386436"
RainLib.Sounds.Click.Volume = 0.5

-- Gerenciador de Animações
function RainLib:CreateAnimation(obj, info, properties, callback)
    local tween = TweenService:Create(obj, info or TweenInfo.new(0.3, Enum.EasingStyle.Quint), properties)
    table.insert(self.Animations, tween)
    tween:Play()
    tween.Completed:Connect(function()
        table.remove(self.Animations, table.find(self.Animations, tween))
        if callback then callback() end
    end)
    return tween
end

-- Sistema de Plugins
function RainLib:RegisterPlugin(pluginName, pluginFunc)
    self.Plugins[pluginName] = pluginFunc
    print("[RainLib] Plugin registrado: " .. pluginName)
end

-- Anti-Detection
local AntiDetection = {
    Enabled = true,
    Methods = {
        SpoofCoreGui = true,
        RandomizeNames = true,
        AntiScreenshot = true,
        ObfuscateProperties = true
    }
}

function RainLib:EnableAntiDetection(options)
    options = options or {}
    AntiDetection.Enabled = true
    AntiDetection.Methods = {
        SpoofCoreGui = options.SpoofCoreGui ~= false,
        RandomizeNames = options.RandomizeNames ~= false,
        AntiScreenshot = options.AntiScreenshot ~= false,
        ObfuscateProperties = options.ObfuscateProperties ~= false
    }

    if AntiDetection.Methods.SpoofCoreGui then
        local randomName = HttpService:GenerateGUID(false)
        self.ScreenGui.Name = "Core_" .. randomName
        self.ScreenGui.Parent = game:GetService("CoreGui")
    end

    if AntiDetection.Methods.RandomizeNames then
        local function randomizeInstance(instance)
            if instance:IsA("GuiObject") then
                instance.Name = HttpService:GenerateGUID(false):sub(1, 8)
            end
            for _, child in ipairs(instance:GetChildren()) do
                randomizeInstance(child)
            end
        end
        randomizeInstance(self.ScreenGui)
    end

    if AntiDetection.Methods.AntiScreenshot then
        local screenshotProtection = Instance.new("Frame")
        screenshotProtection.Size = UDim2.new(1, 0, 1, 0)
        screenshotProtection.BackgroundTransparency = 1
        screenshotProtection.ZIndex = 1000
        screenshotProtection.Visible = false
        screenshotProtection.Parent = self.ScreenGui

        UserInputService.InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.Print then
                screenshotProtection.Visible = true
                task.wait(0.1)
                screenshotProtection.Visible = false
            end
        end)
    end

    if AntiDetection.Methods.ObfuscateProperties then
        local function obfuscate(instance)
            if instance:IsA("GuiObject") then
                instance.Visible = instance.Visible
            end
            for _, child in ipairs(instance:GetChildren()) do
                obfuscate(child)
            end
        end
        obfuscate(self.ScreenGui)
    end
end

-- Função para criar janela
function RainLib:MakeWindow(options)
    local window = { Tabs = {}, Notifications = Instance.new("Frame"), ZIndex = 1 }
    options = options or {}
    options.Hub = options.Hub or {}
    window.Options = {
        Title = options.Hub.Title or "RainLib",
        SubTitle = options.Hub.Animation or "",
        Position = options.Position or UDim2.new(0.5, -250, 0.5, -175),
        Theme = options.Theme or "Dark",
        MinimizeKey = options.MinimizeKey or Enum.KeyCode.LeftControl,
        SaveFolder = options.SaveFolder or "RainConfig",
        Icon = options.Icon or "rbxassetid://18751483361",
        Draggable = options.Draggable ~= false
    }

    if window.Options.SaveFolder then
        RainLib:CreateFolder(window.Options.SaveFolder)
    end

    window.MainFrame = Instance.new("Frame")
    window.MainFrame.Size = UDim2.new(0, 500, 0, 350)
    window.MainFrame.Position = window.Options.Position
    window.MainFrame.BackgroundColor3 = RainLib.CurrentTheme.Background
    window.MainFrame.ClipsDescendants = true
    window.MainFrame.Parent = RainLib.ScreenGui
    window.MainFrame.ZIndex = window.ZIndex

    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new(RainLib.CurrentTheme.Background, RainLib.CurrentTheme.Secondary)
    gradient.Rotation = 45
    gradient.Parent = window.MainFrame

    local glow = Instance.new("UIStroke")
    glow.Thickness = 2
    glow.Color = RainLib.CurrentTheme.Glow
    glow.Transparency = 0.8
    glow.Parent = window.MainFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = window.MainFrame

    window.TitleBar = Instance.new("Frame")
    window.TitleBar.Size = UDim2.new(1, 0, 0, 40)
    window.TitleBar.BackgroundColor3 = RainLib.CurrentTheme.Secondary
    window.TitleBar.Parent = window.MainFrame

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

    -- Botão de Minimizar
    function window:AddMinimizeButton(options)
        options = options or {}
        options.Button = options.Button or {}
        local button = Instance.new("ImageButton")
        button.Size = UDim2.new(0, 30, 0, 30)
        button.Position = UDim2.new(1, -40, 0, 5)
        button.BackgroundTransparency = options.Button.BackgroundTransparency or 1
        button.Image = options.Button.Image or "rbxassetid://71014873973869"
        button.Parent = window.TitleBar

        local corner = Instance.new("UICorner")
        corner.CornerRadius = options.Corner and options.Corner.CornerRadius or UDim.new(0, 8)
        corner.Parent = button

        local minimized = false
        button.MouseButton1Click:Connect(function()
            RainLib.Sounds.Click:Play()
            minimized = not minimized
            RainLib:CreateAnimation(window.MainFrame, TweenInfo.new(0.3), {
                Size = minimized and UDim2.new(0, 500, 0, 40) or UDim2.new(0, 500, 0, 350)
            })
        end)
    end

    -- Função para criar aba
    function window:Tab(options)
        local tab = { Elements = {}, Container = Instance.new("ScrollingFrame") }
        options = options or {}
        tab.Name = options.Name or "Tab"
        tab.Icon = options.Icon or window.Options.Icon
        tab.ElementCount = 0

        tab.Container.Size = UDim2.new(1, -130, 1, -50)
        tab.Container.Position = UDim2.new(0, 125, 0, 45)
        tab.Container.BackgroundTransparency = 1
        tab.Container.ScrollBarThickness = 4
        tab.Container.CanvasSize = UDim2.new(0, 0, 0, 0)
        tab.Container.Visible = false
        tab.Container.Parent = window.MainFrame

        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0, 8)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Parent = tab.Container

        local padding = Instance.new("UIPadding")
        padding.PaddingTop = UDim.new(0, 8)
        padding.PaddingBottom = UDim.new(0, 8)
        padding.PaddingLeft = UDim.new(0, 8)
        padding.PaddingRight = UDim.new(0, 8)
        padding.Parent = tab.Container

        -- Função auxiliar para calcular posição
        function tab:GetNextPosition(size)
            local pos = UDim2.new(0, 0, 0, 16 + (tab.ElementCount * (size.Y.Offset + 16)))
            tab.ElementCount = tab.ElementCount + 1
            tab.Container.CanvasSize = UDim2.new(0, 0, 0, pos.Y.Offset + size.Y.Offset + 16)
            return pos
        end

        -- Button
        function tab:AddButton(options)
            options = options or {}
            local buttonSize = UDim2.new(1, -16, 0, 35)
            local button = Instance.new("TextButton")
            button.Size = buttonSize
            button.Text = options.Name or "Button"
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

            local container = Instance.new("Frame")
            container.Size = UDim2.new(1, -16, 0, buttonSize.Y.Offset + 16)
            container.Position = tab:GetNextPosition(buttonSize)
            container.BackgroundTransparency = 1
            container.Parent = tab.Container
            button.Parent = container
            button.Position = UDim2.new(0, 8, 0, 8)

            button.MouseButton1Click:Connect(function()
                RainLib.Sounds.Click:Play()
                if options.Callback then options.Callback() end
            end)
            button.MouseEnter:Connect(function()
                RainLib:CreateAnimation(button, TweenInfo.new(0.2), {
                    BackgroundColor3 = RainLib.CurrentTheme.Accent:Lerp(Color3.fromRGB(255, 255, 255), 0.2)
                })
            end)
            button.MouseLeave:Connect(function()
                RainLib:CreateAnimation(button, TweenInfo.new(0.2), {
                    BackgroundColor3 = RainLib.CurrentTheme.Accent
                })
            end)

            table.insert(RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs[#RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs].Elements, {
                Type = "Button", Options = options
            })

            return button
        end

        -- Toggle
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
            label.Text = options.Name or "Toggle"
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

            if options.Flag and window.Options.SaveFolder then
                local settings = RainLib:LoadConfig(window.Options.SaveFolder, "Settings")
                if settings and settings.Flags[options.Flag] ~= nil then
                    toggle.Value = settings.Flags[options.Flag]
                    switchContainer.BackgroundColor3 = toggle.Value and RainLib.CurrentTheme.Accent or RainLib.CurrentTheme.Disabled
                    switchKnob.Position = toggle.Value and UDim2.new(1, -20, 0, 2) or UDim2.new(0, 4, 0, 2)
                end
            end

            local container = Instance.new("Frame")
            container.Size = UDim2.new(1, -16, 0, toggleSize.Y.Offset + 16)
            container.Position = tab:GetNextPosition(toggleSize)
            container.BackgroundTransparency = 1
            container.Parent = tab.Container
            frame.Parent = container
            frame.Position = UDim2.new(0, 8, 0, 8)

            frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    RainLib.Sounds.Click:Play()
                    toggle.Value = not toggle.Value
                    RainLib:CreateAnimation(switchContainer, TweenInfo.new(0.2), {
                        BackgroundColor3 = toggle.Value and RainLib.CurrentTheme.Accent or RainLib.CurrentTheme.Disabled
                    })
                    RainLib:CreateAnimation(switchKnob, TweenInfo.new(0.2), {
                        Position = toggle.Value and UDim2.new(1, -20, 0, 2) or UDim2.new(0, 4, 0, 2)
                    })
                    if options.Callback then options.Callback(toggle.Value) end
                    if options.Flag and window.Options.SaveFolder then
                        local settings = RainLib:LoadConfig(window.Options.SaveFolder, "Settings") or { Flags = {} }
                        settings.Flags[options.Flag] = toggle.Value
                        RainLib:SaveConfig(window.Options.SaveFolder, "Settings", settings)
                    end
                end
            end)

            table.insert(RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs[#RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs].Elements, {
                Type = "Toggle", Key = key, Options = options
            })

            return toggle
        end

        -- Slider
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
            label.Text = options.Name or "Slider"
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

            if options.Flag and window.Options.SaveFolder then
                local settings = RainLib:LoadConfig(window.Options.SaveFolder, "Settings")
                if settings and settings.Flags[options.Flag] ~= nil then
                    slider.Value = settings.Flags[options.Flag]
                    fill.Size = UDim2.new((slider.Value - (options.Min or 0)) / ((options.Max or 100) - (options.Min or 0)), 0, 1, 0)
                    valueLabel.Text = tostring(slider.Value)
                end
            end

            local container = Instance.new("Frame")
            container.Size = UDim2.new(1, -16, 0, sliderSize.Y.Offset + 16)
            container.Position = tab:GetNextPosition(sliderSize)
            container.BackgroundTransparency = 1
            container.Parent = tab.Container
            frame.Parent = container
            frame.Position = UDim2.new(0, 8, 0, 8)

            local dragging
            bar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    RainLib:CreateAnimation(bar, TweenInfo.new(0.2), {
                        BackgroundColor3 = RainLib.CurrentTheme.Disabled:Lerp(RainLib.CurrentTheme.Accent, 0.2)
                    })
                end
            end)
            bar.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                    RainLib:CreateAnimation(bar, TweenInfo.new(0.2), {
                        BackgroundColor3 = RainLib.CurrentTheme.Disabled
                    })
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
                    RainLib:CreateAnimation(fill, TweenInfo.new(0.1), { Size = UDim2.new(relativeX, 0, 1, 0) })
                    valueLabel.Text = tostring(slider.Value)
                    if options.Callback then options.Callback(slider.Value) end
                    if options.Flag and window.Options.SaveFolder then
                        local settings = RainLib:LoadConfig(window.Options.SaveFolder, "Settings") or { Flags = {} }
                        settings.Flags[options.Flag] = slider.Value
                        RainLib:SaveConfig(window.Options.SaveFolder, "Settings", settings)
                    end
                end
            end)

            table.insert(RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs[#RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs].Elements, {
                Type = "Slider", Key = key, Options = options
            })

            return slider
        end

        -- Dropdown
        function tab:AddDropdown(key, options)
            options = options or {}
            local dropdownSize = UDim2.new(1, -16, 0, 35)
            local dropdown = { Value = options.Default or (options.Options and options.Options[1]) }
            local frame = Instance.new("Frame")
            frame.Size = dropdownSize
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = frame

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -100, 1, 0)
            label.Text = options.Name or "Dropdown"
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

            if options.Flag and window.Options.SaveFolder then
                local settings = RainLib:LoadConfig(window.Options.SaveFolder, "Settings")
                if settings and settings.Flags[options.Flag] ~= nil then
                    dropdown.Value = settings.Flags[options.Flag]
                    button.Text = dropdown.Value
                end
            end

            local function updateList()
                for _, child in ipairs(listFrame:GetChildren()) do
                    if child:IsA("TextButton") then child:Destroy() end
                end
                listFrame.Size = UDim2.new(0, 90, 0, math.min(#options.Options * 25, 100))
                for _, item in ipairs(options.Options or {}) do
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
                        RainLib.Sounds.Click:Play()
                        dropdown.Value = item
                        button.Text = tostring(item)
                        listFrame.Visible = false
                        if options.Callback then options.Callback(dropdown.Value) end
                        if options.Flag and window.Options.SaveFolder then
                            local settings = RainLib:LoadConfig(window.Options.SaveFolder, "Settings") or { Flags = {} }
                            settings.Flags[options.Flag] = dropdown.Value
                            RainLib:SaveConfig(window.Options.SaveFolder, "Settings", settings)
                        end
                    end)
                end
            end
            updateList()

            local container = Instance.new("Frame")
            container.Size = UDim2.new(1, -16, 0, dropdownSize.Y.Offset + 16)
            container.Position = tab:GetNextPosition(dropdownSize)
            container.BackgroundTransparency = 1
            container.Parent = tab.Container
            frame.Parent = container
            frame.Position = UDim2.new(0, 8, 0, 8)

            button.MouseButton1Click:Connect(function()
                RainLib.Sounds.Click:Play()
                listFrame.Visible = not listFrame.Visible
                RainLib:CreateAnimation(listFrame, TweenInfo.new(0.2), {
                    Size = listFrame.Visible and UDim2.new(0, 90, 0, math.min(#options.Options * 25, 100)) or UDim2.new(0, 90, 0, 0)
                })
            end)

            function dropdown:Update(newOptions)
                options.Options = newOptions
                updateList()
            end

            table.insert(RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs[#RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs].Elements, {
                Type = "Dropdown", Key = key, Options = options
            })

            return dropdown
        end

        -- TextBox
        function tab:AddTextBox(options)
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
            label.Text = options.Name or "Input"
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
            textBox.PlaceholderText = options.PlaceholderText or ""
            textBox.ClearTextOnFocus = options.ClearText or false
            textBox.Parent = frame

            local textBoxCorner = Instance.new("UICorner")
            textBoxCorner.CornerRadius = UDim.new(0, 5)
            textBoxCorner.Parent = textBox

            if options.Flag and window.Options.SaveFolder then
                local settings = RainLib:LoadConfig(window.Options.SaveFolder, "Settings")
                if settings and settings.Flags[options.Flag] ~= nil then
                    input.Value = settings.Flags[options.Flag]
                    textBox.Text = input.Value
                end
            end

            local container = Instance.new("Frame")
            container.Size = UDim2.new(1, -16, 0, inputSize.Y.Offset + 16)
            container.Position = tab:GetNextPosition(inputSize)
            container.BackgroundTransparency = 1
            container.Parent = tab.Container
            frame.Parent = container
            frame.Position = UDim2.new(0, 8, 0, 8)

            textBox.FocusLost:Connect(function()
                RainLib.Sounds.Click:Play()
                input.Value = textBox.Text
                if options.Callback then options.Callback(input.Value) end
                if options.Flag and window.Options.SaveFolder then
                    local settings = RainLib:LoadConfig(window.Options.SaveFolder, "Settings") or { Flags = {} }
                    settings.Flags[options.Flag] = input.Value
                    RainLib:SaveConfig(window.Options.SaveFolder, "Settings", settings)
                end
            end)

            table.insert(RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs[#RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs].Elements, {
                Type = "TextBox", Options = options
            })

            return input
        end

        -- ColorPicker
        function tab:AddColorPicker(key, options)
            options = options or {}
            local pickerSize = UDim2.new(1, -16, 0, 100)
            local picker = { Value = options.Default or Color3.fromRGB(255, 255, 255) }
            local frame = Instance.new("Frame")
            frame.Size = pickerSize
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = frame

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -8, 0, 20)
            label.Text = options.Name or "Color Picker"
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = Enum.Font.GothamBold
            label.TextSize = 14
            label.Parent = frame

            local preview = Instance.new("Frame")
            preview.Size = UDim2.new(0, 50, 0, 50)
            preview.Position = UDim2.new(0, 8, 0, 30)
            preview.BackgroundColor3 = picker.Value
            preview.Parent = frame

            local rSlider = Instance.new("Frame")
            rSlider.Size = UDim2.new(0, 100, 0, 10)
            rSlider.Position = UDim2.new(0, 70, 0, 30)
            rSlider.BackgroundColor3 = RainLib.CurrentTheme.Disabled
            rSlider.Parent = frame

            local gSlider = Instance.new("Frame")
            gSlider.Size = UDim2.new(0, 100, 0, 10)
            gSlider.Position = UDim2.new(0, 70, 0, 50)
            gSlider.BackgroundColor3 = RainLib.CurrentTheme.Disabled
            gSlider.Parent = frame

            local bSlider = Instance.new("Frame")
            bSlider.Size = UDim2.new(0, 100, 0, 10)
            bSlider.Position = UDim2.new(0, 70, 0, 70)
            bSlider.BackgroundColor3 = RainLib.CurrentTheme.Disabled
            bSlider.Parent = frame

            local function updateColor()
                picker.Value = Color3.fromRGB(
                    rSlider.Size.X.Scale * 255,
                    gSlider.Size.X.Scale * 255,
                    bSlider.Size.X.Scale * 255
                )
                preview.BackgroundColor3 = picker.Value
                if options.Callback then options.Callback(picker.Value) end
                if options.Flag and window.Options.SaveFolder then
                    local settings = RainLib:LoadConfig(window.Options.SaveFolder, "Settings") or { Flags = {} }
                    settings.Flags[options.Flag] = { R = picker.Value.R, G = picker.Value.G, B = picker.Value.B }
                    RainLib:SaveConfig(window.Options.SaveFolder, "Settings", settings)
                end
            end

            local function createSlider(slider)
                local fill = Instance.new("Frame")
                fill.Size = UDim2.new(1, 0, 1, 0)
                fill.BackgroundColor3 = RainLib.CurrentTheme.Accent
                fill.Parent = slider

                local dragging
                slider.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                    end
                end)
                slider.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)
                RunService.RenderStepped:Connect(function()
                    if dragging then
                        local mousePos = UserInputService:GetMouseLocation()
                        local relativeX = math.clamp((mousePos.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
                        fill.Size = UDim2.new(relativeX, 0, 1, 0)
                        updateColor()
                    end
                end)
            end

            createSlider(rSlider)
            createSlider(gSlider)
            createSlider(bSlider)

            local container = Instance.new("Frame")
            container.Size = UDim2.new(1, -16, 0, pickerSize.Y.Offset + 16)
            container.Position = tab:GetNextPosition(pickerSize)
            container.BackgroundTransparency = 1
            container.Parent = tab.Container
            frame.Parent = container
            frame.Position = UDim2.new(0, 8, 0, 8)

            table.insert(RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs[#RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs].Elements, {
                Type = "ColorPicker", Key = key, Options = options
            })

            return picker
        end

        -- ProgressBar
        function tab:AddProgressBar(options)
            options = options or {}
            local progressSize = UDim2.new(1, -16, 0, 35)
            local progress = { Value = options.Default or 0 }
            local frame = Instance.new("Frame")
            frame.Size = progressSize
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = frame

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -8, 0, 20)
            label.Text = options.Name or "Progress Bar"
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = Enum.Font.GothamBold
            label.TextSize = 14
            label.Parent = frame

            local bar = Instance.new("Frame")
            bar.Size = UDim2.new(1, -8, 0, 10)
            bar.Position = UDim2.new(0, 4, 0, 20)
            bar.BackgroundColor3 = RainLib.CurrentTheme.Disabled
            bar.Parent = frame

            local fill = Instance.new("Frame")
            fill.Size = UDim2.new(progress.Value / 100, 0, 1, 0)
            fill.BackgroundColor3 = RainLib.CurrentTheme.Accent
            fill.Parent = bar

            local cornerBar = Instance.new("UICorner")
            cornerBar.CornerRadius = UDim.new(0, 5)
            cornerBar.Parent = bar

            local cornerFill = Instance.new("UICorner")
            cornerFill.CornerRadius = UDim.new(0, 5)
            cornerFill.Parent = fill

            function progress:SetValue(value)
                progress.Value = math.clamp(value, 0, 100)
                RainLib:CreateAnimation(fill, TweenInfo.new(0.5), { Size = UDim2.new(progress.Value / 100, 0, 1, 0) })
                if options.Callback then options.Callback(progress.Value) end
            end

            local container = Instance.new("Frame")
            container.Size = UDim2.new(1, -16, 0, progressSize.Y.Offset + 16)
            container.Position = tab:GetNextPosition(progressSize)
            container.BackgroundTransparency = 1
            container.Parent | tab.Container
            frame.Parent = container
            frame.Position = UDim2.new(0, 8, 0, 8)

            table.insert(RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs[#RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs].Elements, {
                Type = "ProgressBar", Options = options
            })

            return progress
        end

        -- Paragraph
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
            title.Text = options[1] or "Paragraph"
            title.BackgroundTransparency = 1
            title.TextColor3 = RainLib.CurrentTheme.Text
            title.Font = Enum.Font.GothamBold
            title.TextSize = 14
            title.Parent = paragraph

            local content = Instance.new("TextLabel")
            content.Size = UDim2.new(1, -8, 0, 26)
            content.Position = UDim2.new(0, 4, 0, 22)
            content.Text = options[2] or ""
            content.BackgroundTransparency = 1
            content.TextColor3 = RainLib.CurrentTheme.Text
            content.Font = Enum.Font.SourceSans
            content.TextSize = 12
            content.TextWrapped = true
            content.Parent = paragraph

            local container = Instance.new("Frame")
            container.Size = UDim2.new(1, -16, 0, paragraphSize.Y.Offset + 16)
            container.Position = tab:GetNextPosition(paragraphSize)
            container.BackgroundTransparency = 1
            container.Parent = tab.Container
            paragraph.Parent = container
            paragraph.Position = UDim2.new(0, 8, 0, 8)

            function paragraph:Set(newOptions)
                title.Text = newOptions[1] or title.Text
                content.Text = newOptions[2] or content.Text
            end

            table.insert(RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs[#RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs].Elements, {
                Type = "Paragraph", Options = options
            })

            return paragraph
        end

        -- Label
        function tab:AddTextLabel(options)
            local labelSize = UDim2.new(1, -16, 0, 25)
            local label = Instance.new("TextLabel")
            label.Size = labelSize
            label.Text = options or "Label"
            label.BackgroundColor3 = RainLib.CurrentTheme.Secondary
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = Enum.Font.SourceSans
            label.TextSize = 14
            label.TextWrapped = true

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = label

            local container = Instance.new("Frame")
            container.Size = UDim2.new(1, -16, 0, labelSize.Y.Offset + 16)
            container.Position = tab:GetNextPosition(labelSize)
            container.BackgroundTransparency = 1
            container.Parent = tab.Container
            label.Parent = container
            label.Position = UDim2.new(0, 8, 0, 8)

            table.insert(RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs[#RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs].Elements, {
                Type = "Label", Options = options
            })

            return label
        end

        -- DiscordInvite
        function tab:AddDiscordInvite(options)
            options = options or {}
            local inviteSize = UDim2.new(1, -16, 0, 80)
            local invite = {}
            local frame = Instance.new("Frame")
            frame.Size = inviteSize
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = frame

            local logo = Instance.new("ImageLabel")
            logo.Size = UDim2.new(0, 50, 0, 50)
            logo.Position = UDim2.new(0, 8, 0, 15)
            logo.BackgroundTransparency = 1
            logo.Image = options.Logo or "rbxassetid://18751483361"
            logo.Parent = frame

            local name = Instance.new("TextLabel")
            name.Size = UDim2.new(1, -70, 0, 20)
            name.Position = UDim2.new(0, 66, 0, 15)
            name.Text = options.Name or "Join Our Server"
            name.BackgroundTransparency = 1
            name.TextColor3 = RainLib.CurrentTheme.Text
            name.Font = Enum.Font.GothamBold
            name.TextSize = 14
            name.Parent = frame

            local description = Instance.new("TextLabel")
            description.Size = UDim2.new(1, -70, 0, 20)
            description.Position = UDim2.new(0, 66, 0, 35)
            description.Text = options.Description or "Click to join our Discord community!"
            description.BackgroundTransparency = 1
            description.TextColor3 = RainLib.CurrentTheme.Text
            description.Font = Enum.Font.Gotham
            description.TextSize = 12
            description.Parent = frame

            local button = Instance.new("TextButton")
            button.Size = UDim2.new(0, 100, 0, 30)
            button.Position = UDim2.new(1, -108, 0, 45)
            button.BackgroundColor3 = RainLib.CurrentTheme.Accent
            button.Text = "Join"
            button.TextColor3 = RainLib.CurrentTheme.Text
            button.Font = Enum.Font.GothamBold
            button.TextSize = 14
            button.Parent = frame

            local buttonCorner = Instance.new("UICorner")
            buttonCorner.CornerRadius = UDim.new(0, 6)
            buttonCorner.Parent = button

            button.MouseButton1Click:Connect(function()
                RainLib.Sounds.Click:Play()
                if options.Invite then
                    print("Discord Invite: " .. options.Invite)
                end
            end)

            local container = Instance.new("Frame")
            container.Size = UDim2.new(1, -16, 0, inviteSize.Y.Offset + 16)
            container.Position = tab:GetNextPosition(inviteSize)
            container.BackgroundTransparency = 1
            container.Parent = tab.Container
            frame.Parent = container
            frame.Position = UDim2.new(0, 8, 0, 8)

            table.insert(RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs[#RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs].Elements, {
                Type = "DiscordInvite", Options = options
            })

            return invite
        end

        -- Toast Notification
        function tab:AddToast(options)
            options = options or {}
            local toast = {}
            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(0, 200, 0, 50)
            frame.Position = UDim2.new(1, -220, 1, -70)
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary
            frame.Parent = RainLib.ScreenGui
            frame.ZIndex = 1000

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = frame

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -8, 1, -8)
            label.Text = options.Text or "Notification"
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = Enum.Font.Gotham
            label.TextSize = 14
            label.TextWrapped = true
            label.Parent = frame

            RainLib:CreateAnimation(frame, TweenInfo.new(0.3), { Position = UDim2.new(1, -220, 1, -70) })
            task.delay(options.Duration or 3, function()
                RainLib:CreateAnimation(frame, TweenInfo.new(0.3), { Position = UDim2.new(1, 0, 1, -70) }, function()
                    frame:Destroy()
                end)
            end)

            return toast
        end

        -- SearchBar
        function tab:AddSearchBar(options)
            options = options or {}
            local searchSize = UDim2.new(1, -16, 0, 35)
            local search = { Value = "" }
            local frame = Instance.new("Frame")
            frame.Size = searchSize
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = frame

            local textBox = Instance.new("TextBox")
            textBox.Size = UDim2.new(1, -8, 0, 25)
            textBox.Position = UDim2.new(0, 4, 0, 5)
            textBox.BackgroundColor3 = RainLib.CurrentTheme.Disabled
            textBox.Text = ""
            textBox.TextColor3 = RainLib.CurrentTheme.Text
            textBox.Font = Enum.Font.SourceSans
            textBox.TextSize = 12
            textBox.TextWrapped = true
            textBox.PlaceholderText = options.PlaceholderText or "Search..."
            textBox.Parent = frame

            local textBoxCorner = Instance.new("UICorner")
            textBoxCorner.CornerRadius = UDim.new(0, 5)
            textBoxCorner.Parent = textBox

            local container = Instance.new("Frame")
            container.Size = UDim2.new(1, -16, 0, searchSize.Y.Offset + 16)
            container.Position = tab:GetNextPosition(searchSize)
            container.BackgroundTransparency = 1
            container.Parent = tab.Container
            frame.Parent = container
            frame.Position = UDim2.new(0, 8, 0, 8)

            textBox.FocusLost:Connect(function()
                RainLib.Sounds.Click:Play()
                search.Value = textBox.Text
                if options.Callback then options.Callback(search.Value) end
            end)

            table.insert(RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs[#RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs].Elements, {
                Type = "SearchBar", Options = options
            })

            return search
        end

        table.insert(window.Tabs, tab)
        table.insert(RainLib.GUIState.Windows[#RainLib.GUIState.Windows].Tabs, { Name = tab.Name, Icon = tab.Icon, Elements = {} })
        return tab
    end

    -- Gerenciamento de Foco
    window.MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            window.ZIndex = window.ZIndex + 1
            window.MainFrame.ZIndex = window.ZIndex
        end
    end)

    -- Hotkey para Minimizar
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == window.Options.MinimizeKey then
            window.MainFrame.Size = window.MainFrame.Size.Y.Offset == 40 and UDim2.new(0, 500, 0, 350) or UDim2.new(0, 500, 0, 40)
        end
    end)

    table.insert(RainLib.GUIState.Windows, window)
    return window
end

-- Sistema de Configuração
function RainLib:CreateFolder(folderName)
    if not isfolder(folderName) then
        makefolder(folderName)
    end
    table.insert(self.CreatedFolders, folderName)
end

function RainLib:SaveConfig(folder, key, value)
    if isfolder(folder) then
        writefile(folder .. "/" .. key .. ".json", HttpService:JSONEncode(value))
    end
end

function RainLib:LoadConfig(folder, key)
    if isfile(folder .. "/" .. key .. ".json") then
        return HttpService:JSONDecode(readfile(folder .. "/" .. key .. ".json"))
    end
    return nil
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
    RainLib:EnableAntiDetection()
end)
if not success then
    warn("[RainLib] Falha na inicialização: " .. err)
    return nil
end
print("[RainLib] Inicializado com sucesso!")
return RainLib
