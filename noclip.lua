-- Noclip com GUI Bonita, Movível e Corrigido

-- Cria a GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "NoclipGUI"

local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.Position = UDim2.new(0, 20, 0, 100)
Frame.Size = UDim2.new(0, 200, 0, 80)

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = Frame

local Button = Instance.new("TextButton")
Button.Parent = Frame
Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Button.Position = UDim2.new(0.05, 0, 0.2, 0)
Button.Size = UDim2.new(0.9, 0, 0.6, 0)
Button.Font = Enum.Font.GothamBold
Button.Text = "Ativar Noclip"
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.TextSize = 18

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 8)
ButtonCorner.Parent = Button

Button.MouseEnter:Connect(function()
    Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
end)

Button.MouseLeave:Connect(function()
    Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
end)

-- 🔥 Drag Manual
local UIS = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                               startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or
       input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or
       input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- 🚀 Função Noclip
local noclip = false
local player = game.Players.LocalPlayer

local function setCollision(state)
    local character = player.Character or player.CharacterAdded:Wait()
    for _, v in pairs(character:GetDescendants()) do
        if v:IsA("BasePart") then
            v.CanCollide = state
        end
    end
end

game:GetService("RunService").Stepped:Connect(function()
    if noclip then
        local character = player.Character
        if character then
            for _, v in pairs(character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end
    end
end)

-- 🔘 Clique no botão
Button.MouseButton1Click:Connect(function()
    noclip = not noclip
    if noclip then
        Button.Text = "Desativar Noclip"
        Button.TextColor3 = Color3.fromRGB(0, 170, 255)
    else
        setCollision(true) -- ✅ Volta a colisão ao desativar
        Button.Text = "Ativar Noclip"
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end)
