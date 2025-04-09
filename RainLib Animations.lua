-- RainLib Animations.lua
local RainLibAnimations = {}

local TweenService = game:GetService("TweenService")

-- Função genérica pra criar tweens
local function createTween(object, tweenInfo, properties)
    local tween = TweenService:Create(object, tweenInfo, properties)
    tween:Play()
    return tween
end

-- Animação pro Paragraph (fade-in do texto)
function RainLibAnimations.AnimateParagraph(paragraphFrame)
    local title = paragraphFrame:FindFirstChild("Title")
    local content = paragraphFrame:FindFirstChild("Content")
    if title and content then
        title.TextTransparency = 1
        content.TextTransparency = 1
        createTween(title, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0})
        createTween(content, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0})
    end
end

-- Animação pro Button (escala ao clicar)
function RainLibAnimations.AnimateButton(button)
    button.MouseButton1Down:Connect(function()
        createTween(button, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 110, 0, 36)})
    end)
    button.MouseButton1Up:Connect(function()
        createTween(button, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 120, 0, 40)})
    end)
end

-- Animação pro Toggle (transição de cor e movimento do indicador)
function RainLibAnimations.AnimateToggle(toggleFrame, value)
    local indicator = toggleFrame:FindFirstChild("Indicator")
    if indicator then
        local targetColor = value and RainLib.CurrentTheme.Accent or RainLib.CurrentTheme.Disabled
        local targetPos = value and UDim2.new(1, -30, 0.5, -10) or UDim2.new(1, -50, 0.5, -10)
        createTween(indicator, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundColor3 = targetColor,
            Position = targetPos
        })
    end
end

-- Animação pro Slider (preenchimento suave)
function RainLibAnimations.AnimateSlider(sliderFrame, value, min, max)
    local fill = sliderFrame:FindFirstChild("Fill")
    if fill then
        local relativeX = (value - min) / (max - min)
        createTween(fill, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(relativeX, 0, 1, 0)
        })
    end
end

-- Animação pro Dropdown (abrir/fechar com rotação da seta)
function RainLibAnimations.AnimateDropdown(dropdownFrame, listFrame, options, isOpen)
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local arrow = dropdownFrame:FindFirstChild("Arrow")
    local targetSize = isOpen and UDim2.new(1, 0, 0, #options * 35) or UDim2.new(1, 0, 0, 0)
    
    createTween(listFrame, tweenInfo, {Size = targetSize})
    if arrow then
        createTween(arrow, tweenInfo, {Rotation = isOpen and 180 or 0})
    end
end

-- Animação pro Colorpicker (transição de cor)
function RainLibAnimations.AnimateColorpicker(colorpickerFrame, newColor)
    createTween(colorpickerFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundColor3 = newColor
    })
end

-- Animação pro Keybind (pulsar ao mudar a tecla)
function RainLibAnimations.AnimateKeybind(keybindFrame, isChanging)
    local keyLabel = keybindFrame:FindFirstChild("KeyLabel")
    if keyLabel then
        if isChanging then
            createTween(keyLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {TextTransparency = 0.5})
        else
            createTween(keyLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {TextTransparency = 0})
        end
    end
end

-- Animação pro Input (borda piscando ao focar)
function RainLibAnimations.AnimateInput(inputTextbox)
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1
    stroke.Color = RainLib.CurrentTheme.Accent
    stroke.Transparency = 1
    stroke.Parent = inputTextbox

    inputTextbox.Focused:Connect(function()
        createTween(stroke, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = 0})
    end)
    inputTextbox.FocusLost:Connect(function()
        createTween(stroke, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = 1})
    end)
end

-- Animação pro Dialog (fade-in e scale)
function RainLibAnimations.AnimateDialog(dialogFrame)
    dialogFrame.BackgroundTransparency = 1
    dialogFrame.Size = UDim2.new(0, 280, 0, 140)
    for _, child in pairs(dialogFrame:GetChildren()) do
        if child:IsA("TextLabel") or child:IsA("TextButton") then
            child.TextTransparency = 1
        end
    end
    createTween(dialogFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0,
        Size = UDim2.new(0, 300, 0, 150)
    })
    for _, child in pairs(dialogFrame:GetChildren()) do
        if child:IsA("TextLabel") or child:IsA("TextButton") then
            createTween(child, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0})
        end
    end
end

return RainLibAnimations
