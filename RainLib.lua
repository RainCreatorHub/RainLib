local RainLib = {
    Version = "1.0.3",
    Themes = {
        Dark = {
            Background = Color3.fromRGB(30, 30, 30),
            Accent = Color3.fromRGB(50, 150, 255),
            Text = Color3.fromRGB(255, 255, 255),
            Secondary = Color3.fromRGB(50, 50, 50),
            Disabled = Color3.fromRGB(100, 100, 100)
        }
    },
    Icons = {
        ["sliders"] = "rbxassetid://10734963400",
        ["slidershorizontal"] = "rbxassetid://10734963191",
        ["smartphone"] = "rbxassetid://10734963940",
        ["smartphonecharging"] = "rbxassetid://10734963671",
        ["smile"] = "rbxassetid://10734964441",
        ["smileplus"] = "rbxassetid://10734964188",
        ["snowflake"] = "rbxassetid://10734964600",
        ["sofa"] = "rbxassetid://10734964852",
        ["sortasc"] = "rbxassetid://10734965115",
        ["sortdesc"] = "rbxassetid://10734965287",
        ["speaker"] = "rbxassetid://10734965419",
        ["sprout"] = "rbxassetid://10734965572",
        ["square"] = "rbxassetid://10734965702",
        ["star"] = "rbxassetid://10734966248",
        ["starhalf"] = "rbxassetid://10734965897",
        ["staroff"] = "rbxassetid://10734966097",
        ["stethoscope"] = "rbxassetid://10734966384",
        ["sticker"] = "rbxassetid://10734972234",
        ["stickynote"] = "rbxassetid://10734972463",
        ["stopcircle"] = "rbxassetid://10734972621",
        ["stretchhorizontal"] = "rbxassetid://10734972862",
        ["stretchvertical"] = "rbxassetid://10734973130",
        ["strikethrough"] = "rbxassetid://10734973290",
        ["subscript"] = "rbxassetid://10734973457",
        ["sun"] = "rbxassetid://10734974297",
        ["sundim"] = "rbxassetid://10734973645",
        ["sunmedium"] = "rbxassetid://10734973778",
        ["sunmoon"] = "rbxassetid://10734973999",
        ["sunsnow"] = "rbxassetid://10734974130",
        ["sunrise"] = "rbxassetid://10734974522",
        ["sunset"] = "rbxassetid://10734974689",
        ["superscript"] = "rbxassetid://10734974850",
        ["swissfranc"] = "rbxassetid://10734975024",
        ["switchcamera"] = "rbxassetid://10734975214",
        ["sword"] = "rbxassetid://10734975486",
        ["swords"] = "rbxassetid://10734975692",
        ["syringe"] = "rbxassetid://10734975932",
        ["table"] = "rbxassetid://10734976230",
        ["table2"] = "rbxassetid://10734976097",
        ["tablet"] = "rbxassetid://10734976394",
        ["tag"] = "rbxassetid://10734976528",
        ["tags"] = "rbxassetid://10734976739",
        ["target"] = "rbxassetid://10734977012",
        ["tent"] = "rbxassetid://10734981750",
        ["terminal"] = "rbxassetid://10734982144",
        ["terminalsquare"] = "rbxassetid://10734981995",
        ["textcursor"] = "rbxassetid://10734982395",
        ["textcursorinput"] = "rbxassetid://10734982297",
        ["thermometer"] = "rbxassetid://10734983134",
        ["thermometersnowflake"] = "rbxassetid://10734982571",
        ["thermometersun"] = "rbxassetid://10734982771",
        ["thumbsdown"] = "rbxassetid://10734983359",
        ["thumbsup"] = "rbxassetid://10734983629",
        ["ticket"] = "rbxassetid://10734983868",
        ["timer"] = "rbxassetid://10734984606",
        ["timeroff"] = "rbxassetid://10734984138",
        ["timerreset"] = "rbxassetid://10734984355",
        ["toggleleft"] = "rbxassetid://10734984834",
        ["toggleright"] = "rbxassetid://10734985040",
        ["tornado"] = "rbxassetid://10734985247",
        ["toybrick"] = "rbxassetid://10747361919",
        ["train"] = "rbxassetid://10747362105",
        ["trash"] = "rbxassetid://10747362393",
        ["trash2"] = "rbxassetid://10747362241",
        ["treedeciduous"] = "rbxassetid://10747362534",
        ["treepine"] = "rbxassetid://10747362748",
        ["trees"] = "rbxassetid://10747363016",
        ["trendingdown"] = "rbxassetid://10747363205",
        ["trendingup"] = "rbxassetid://10747363465",
        ["triangle"] = "rbxassetid://10747363621",
        ["trophy"] = "rbxassetid://10747363809",
        ["truck"] = "rbxassetid://10747364031",
        ["tv"] = "rbxassetid://10747364593",
        ["tv2"] = "rbxassetid://10747364302",
        ["type"] = "rbxassetid://10747364761",
        ["umbrella"] = "rbxassetid://10747364971",
        ["underline"] = "rbxassetid://10747365191",
        ["undo"] = "rbxassetid://10747365484",
        ["undo2"] = "rbxassetid://10747365359",
        ["unlink"] = "rbxassetid://10747365771",
        ["unlink2"] = "rbxassetid://10747397871",
        ["unlock"] = "rbxassetid://10747366027",
        ["upload"] = "rbxassetid://10747366434",
        ["uploadcloud"] = "rbxassetid://10747366266",
        ["usb"] = "rbxassetid://10747366606",
        ["user"] = "rbxassetid://10747373176",
        ["usercheck"] = "rbxassetid://10747371901",
        ["usercog"] = "rbxassetid://10747372167",
        ["userminus"] = "rbxassetid://10747372346",
        ["userplus"] = "rbxassetid://10747372702",
        ["userx"] = "rbxassetid://10747372992",
        ["users"] = "rbxassetid://10747373426",
        ["utensils"] = "rbxassetid://10747373821",
        ["utensilscrossed"] = "rbxassetid://10747373629",
        ["venetianmask"] = "rbxassetid://10747374003",
        ["verified"] = "rbxassetid://10747374131",
        ["vibrate"] = "rbxassetid://10747374489",
        ["vibrateoff"] = "rbxassetid://10747374269",
        ["video"] = "rbxassetid://10747374938",
        ["videooff"] = "rbxassetid://10747374721",
        ["view"] = "rbxassetid://10747375132",
        ["voicemail"] = "rbxassetid://10747375281",
        ["volume"] = "rbxassetid://10747376008",
        ["volume1"] = "rbxassetid://10747375450",
        ["volume2"] = "rbxassetid://10747375679",
        ["volumex"] = "rbxassetid://10747375880",
        ["wallet"] = "rbxassetid://10747376205",
        ["wand"] = "rbxassetid://10747376565",
        ["wand2"] = "rbxassetid://10747376349",
        ["watch"] = "rbxassetid://10747376722",
        ["waves"] = "rbxassetid://10747376931",
        ["webcam"] = "rbxassetid://10747381992",
        ["wifi"] = "rbxassetid://10747382504",
        ["wifioff"] = "rbxassetid://10747382268",
        ["wind"] = "rbxassetid://10747382750",
        ["wraptext"] = "rbxassetid://10747383065",
        ["wrench"] = "rbxassetid://10747383470",
        ["x"] = "rbxassetid://10747384394",
        ["xcircle"] = "rbxassetid://10747383819",
        ["xoctagon"] = "rbxassetid://10747384037",
        ["xsquare"] = "rbxassetid://10747384217",
        ["zoomin"] = "rbxassetid://10747384552",
        ["zoomout"] = "rbxassetid://10747384679"
    },
    Windows = {},
    CurrentTheme = nil
}

print("[RainLib] Carregando serviços...")

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local function tween(obj, info, properties)
    local tween = TweenService:Create(obj, info or TweenInfo.new(0.3), properties)
    tween:Play()
    return tween
end

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

function RainLib:Window(options)
    print("[RainLib] Criando janela...")
    local window = {}
    options = options or {}
    
    window.Title = options.Title or "Rain Lib"
    window.Size = options.Size or UDim2.new(0, 500, 0, 350)
    window.Position = options.Position or UDim2.new(0.5, -250, 0.5, -175)
    window.Minimized = false
    window.Tabs = {}
    window.CurrentTabIndex = 1
    
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
        window.TitleBar.BackgroundColor3 = RainLib.CurrentTheme.Secondary
        window.TitleBar.Parent = window.MainFrame
        
        window.TitleLabel = Instance.new("TextLabel")
        window.TitleLabel.Size = UDim2.new(1, -40, 1, 0)
        window.TitleLabel.Position = UDim2.new(0, 10, 0, 0)
        window.TitleLabel.BackgroundTransparency = 1
        window.TitleLabel.Text = window.Title
        window.TitleLabel.TextColor3 = RainLib.CurrentTheme.Text
        window.TitleLabel.Font = Enum.Font.GothamBold
        window.TitleLabel.TextSize = 16
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
        
        window.TabContainer = Instance.new("ScrollingFrame")
        window.TabContainer.Size = UDim2.new(0, 150, 1, -40)
        window.TabContainer.Position = UDim2.new(0, 0, 0, 40)
        window.TabContainer.BackgroundColor3 = RainLib.CurrentTheme.Secondary
        window.TabContainer.ScrollBarThickness = 0
        window.TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
        window.TabContainer.Parent = window.MainFrame
        
        window.TabIndicator = Instance.new("Frame")
        window.TabIndicator.Size = UDim2.new(0, 3, 0, 40)
        window.TabIndicator.BackgroundColor3 = RainLib.CurrentTheme.Accent
        window.TabIndicator.Position = UDim2.new(0, 0, 0, 5)
        window.TabIndicator.Parent = window.TabContainer
        
        window.NavUp = Instance.new("TextButton")
        window.NavUp.Size = UDim2.new(0, 30, 0, 30)
        window.NavUp.Position = UDim2.new(0, 110, 0, 5)
        window.NavUp.BackgroundColor3 = RainLib.CurrentTheme.Accent
        window.NavUp.Text = "↑"
        window.NavUp.TextColor3 = RainLib.CurrentTheme.Text
        window.NavUp.Font = Enum.Font.SourceSansBold
        window.NavUp.TextSize = 16
        window.NavUp.Parent = window.TitleBar
        
        window.NavDown = Instance.new("TextButton")
        window.NavDown.Size = UDim2.new(0, 30, 0, 30)
        window.NavDown.Position = UDim2.new(0, 145, 0, 5)
        window.NavDown.BackgroundColor3 = RainLib.CurrentTheme.Accent
        window.NavDown.Text = "↓"
        window.NavDown.TextColor3 = RainLib.CurrentTheme.Text
        window.NavDown.Font = Enum.Font.SourceSansBold
        window.NavDown.TextSize = 16
        window.NavDown.Parent = window.TitleBar
        
        local navCornerUp = Instance.new("UICorner")
        navCornerUp.CornerRadius = UDim.new(0, 5)
        navCornerUp.Parent = window.NavUp
        
        local navCornerDown = Instance.new("UICorner")
        navCornerDown.CornerRadius = UDim.new(0, 5)
        navCornerDown.Parent = window.NavDown
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
    
    local dragging, dragStart, startPos
    window.TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = window.MainFrame.Position
            print("[RainLib] Começando a arrastar")
        end
    end)
    
    window.TitleBar.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
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
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
            print("[RainLib] Parou de arrastar")
        end
    end)
    
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
        tab.Icon = options.Icon or nil
        tab.ElementsPerRow = options.ElementsPerRow or 1
        tab.ElementCount = 0
        
        tab.Content = Instance.new("ScrollingFrame")
        tab.Content.Size = UDim2.new(1, -160, 1, -50)
        tab.Content.Position = UDim2.new(0, 155, 0, 45)
        tab.Content.BackgroundTransparency = 1
        tab.Content.ScrollBarThickness = 5
        tab.Content.CanvasPosition = Vector2.new(0, 0)
        tab.Content.Visible = false
        tab.Content.Parent = window.MainFrame
        
        tab.Button = Instance.new("TextButton")
        tab.Button.Size = UDim2.new(1, -10, 0, 40)
        tab.Button.Position = UDim2.new(0, 5, 0, #window.Tabs * 45 + 5)
        tab.Button.BackgroundTransparency = 1
        tab.Button.Text = tab.Icon and "" or tab.Name
        tab.Button.TextColor3 = RainLib.CurrentTheme.Text
        tab.Button.Font = Enum.Font.SourceSansBold
        tab.Button.TextSize = 16
        tab.Button.TextXAlignment = Enum.TextXAlignment.Left
        tab.Button.Parent = window.TabContainer
        window.TabContainer.CanvasSize = UDim2.new(0, 0, 0, #window.Tabs * 45 + 50)
        
        if tab.Icon then
            local icon = Instance.new("ImageLabel")
            icon.Size = UDim2.new(0, 24, 0, 24)
            icon.Position = UDim2.new(0, 5, 0.5, -12)
            icon.BackgroundTransparency = 1
            icon.Image = RainLib.Icons[tab.Icon] or tab.Icon -- Usa a tabela de ícones ou ID direto
            icon.Parent = tab.Button
            
            local text = Instance.new("TextLabel")
            text.Size = UDim2.new(1, -40, 1, 0)
            text.Position = UDim2.new(0, 35, 0, 0)
            text.BackgroundTransparency = 1
            text.Text = tab.Name
            text.TextColor3 = RainLib.CurrentTheme.Text
            text.Font = Enum.Font.SourceSansBold
            text.TextSize = 16
            text.TextXAlignment = Enum.TextXAlignment.Left
            text.Parent = tab.Button
        else
            tab.Button.Position = UDim2.new(0, 15, 0, #window.Tabs * 45 + 5)
        end
        
        table.insert(window.Tabs, tab)
        
        local function selectTab(index)
            for i, t in pairs(window.Tabs) do
                if i == index then
                    t.Content.Visible = true
                    tween(t.Content, TweenInfo.new(0.2), {BackgroundTransparency = 1})
                    tween(window.TabIndicator, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, (i-1) * 45 + 5)})
                    window.CurrentTabIndex = i
                    print("[RainLib] Aba selecionada: " .. t.Name)
                else
                    tween(t.Content, TweenInfo.new(0.2), {BackgroundTransparency = 1})
                    task.delay(0.2, function() t.Content.Visible = false end)
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
        
        window.NavUp.MouseButton1Click:Connect(function()
            if window.CurrentTabIndex > 1 then
                selectTab(window.CurrentTabIndex - 1)
            end
        end)
        
        window.NavDown.MouseButton1Click:Connect(function()
            if window.CurrentTabIndex < #window.Tabs then
                selectTab(window.CurrentTabIndex + 1)
            end
        end)
        
        local function getNextPosition(elementSize)
            local row = math.floor(tab.ElementCount / tab.ElementsPerRow)
            local col = tab.ElementCount % tab.ElementsPerRow
            local xOffset = 10 + col * (elementSize.X.Offset + 10)
            local yOffset = 10 + row * (elementSize.Y.Offset + 10)
            tab.ElementCount = tab.ElementCount + 1
            return UDim2.new(0, xOffset, 0, yOffset)
        end
        
        function tab:Button(options)
            local buttonSize = options.Size or UDim2.new(0, 100, 0, 30)
            local button = Instance.new("TextButton")
            button.Size = buttonSize
            button.Position = getNextPosition(buttonSize)
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
            local textboxSize = options.Size or UDim2.new(0, 100, 0, 30)
            local textbox = Instance.new("TextBox")
            textbox.Size = textboxSize
            textbox.Position = getNextPosition(textboxSize)
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
            local toggleSize = options.Size or UDim2.new(0, 100, 0, 30)
            local toggle = { Value = options.Default or false }
            local frame = Instance.new("Frame")
            frame.Size = toggleSize
            frame.Position = getNextPosition(toggleSize)
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
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
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
            local sliderSize = options.Size or UDim2.new(0, 200, 0, 40)
            local slider = { Value = options.Default or 0 }
            local frame = Instance.new("Frame")
            frame.Size = sliderSize
            frame.Position = getNextPosition(sliderSize)
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
            local dropdownSize = options.Size or UDim2.new(0, 150, 0, 30)
            local dropdown = { Value = options.Default or options.Options[1] }
            local frame = Instance.new("Frame")
            frame.Size = dropdownSize
            frame.Position = getNextPosition(dropdownSize)
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

function RainLib:SetTheme(theme)
    print("[RainLib] Mudando tema...")
    local success, err = pcall(function()
        RainLib.CurrentTheme = theme
        for _, window in pairs(RainLib.Windows) do
            window.MainFrame.BackgroundColor3 = theme.Background
            window.TitleBar.BackgroundColor3 = theme.Secondary
            window.TitleLabel.TextColor3 = theme.Text
            window.TabContainer.BackgroundColor3 = theme.Secondary
            window.TabIndicator.BackgroundColor3 = theme.Accent
            window.NavUp.BackgroundColor3 = theme.Accent
            window.NavUp.TextColor3 = theme.Text
            window.NavDown.BackgroundColor3 = theme.Accent
            window.NavDown.TextColor3 = theme.Text
            for _, tab in pairs(window.Tabs) do
                tab.Button.TextColor3 = theme.Text
                for _, child in pairs(tab.Button:GetChildren()) do
                    if child:IsA("TextLabel") then
                        child.TextColor3 = theme.Text
                    end
                end
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
