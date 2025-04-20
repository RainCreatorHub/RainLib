-- RainLib.Designin.lua
-- Módulo para gerenciar animações visuais da biblioteca RainLib

local TweenService = game:GetService("TweenService")

local Designin = {}

-- Função para criar e executar uma animação de tween
function Designin:Tween(obj, info, properties)
    local tweenInfo = info or TweenInfo.new(0.3, Enum.EasingStyle.Quint)
    local tween = TweenService:Create(obj, tweenInfo, properties)
    tween:Play()
    return tween
end

-- Função para animação de entrada (ex.: para janelas ou notificações)
function Designin:FadeIn(obj, duration)
    duration = duration or 0.5
    return self:Tween(obj, TweenInfo.new(duration, Enum.EasingStyle.Quint), {
        BackgroundTransparency = 0,
        Position = obj.Position - UDim2.new(0, 0, 0, -10) -- Pequeno deslocamento para efeito
    })
end

-- Função para animação de saída (ex.: para fechar janelas ou notificações)
function Designin:FadeOut(obj, duration, offset)
    duration = duration or 0.5
    offset = offset or UDim2.new(1, 260, 0, obj.Position.Y.Offset)
    return self:Tween(obj, TweenInfo.new(duration, Enum.EasingStyle.Quint), {
        BackgroundTransparency = 1,
        Position = offset
    })
end

-- Função para animação de hover (ex.: para botões)
function Designin:Hover(obj, baseColor, hoverColor, duration)
    duration = duration or 0.2
    return self:Tween(obj, TweenInfo.new(duration, Enum.EasingStyle.Quad), {
        BackgroundColor3 = hoverColor or baseColor:Lerp(Color3.fromRGB(255, 255, 255), 0.2)
    })
end

-- Função para animação de seleção (ex.: para abas ou indicadores)
function Designin:Select(obj, targetPosition, duration)
    duration = duration or 0.3
    return self:Tween(obj, TweenInfo.new(duration, Enum.EasingStyle.Quad), {
        Position = targetPosition
    })
end

return Designin
