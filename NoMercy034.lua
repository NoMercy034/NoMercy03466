-- NoMercy034.exe - نسخة مطورة

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- حذف واجهة قديمة
pcall(function() PlayerGui.NoMercy034:Destroy() end)

-- إنشاء واجهة
local screenGui = Instance.new("ScreenGui", PlayerGui)
screenGui.Name = "NoMercy034"
screenGui.ResetOnSpawn = false

local openBtn = Instance.new("TextButton")
openBtn.Text = "Nom"
openBtn.Size = UDim2.new(0, 50, 0, 50)
openBtn.Position = UDim2.new(0, 10, 0.8, 0)
openBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
openBtn.TextColor3 = Color3.new(1,1,1)
openBtn.Parent = screenGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 400)
frame.Position = UDim2.new(0.5, -150, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Parent = screenGui
frame.Visible = false
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
title.Text = "NoMercy034"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 22

local close = Instance.new("TextButton", frame)
close.Text = "X"
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(1, -35, 0, 5)
close.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
close.TextColor3 = Color3.new(1,1,1)

close.MouseButton1Click:Connect(function()
    frame.Visible = false
end)

openBtn.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

-- وظائف

local function tpSky()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CFrame = hrp.CFrame + Vector3.new(0, 300, 0)
    end
end

local function fallDown()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local startY = hrp.Position.Y
        local targetY = startY - 300
        for y = startY, targetY, -5 do
            hrp.CFrame = CFrame.new(hrp.Position.X, y, hrp.Position.Z)
            wait(0.05)
        end
    end
end

-- السرعة الثابتة (Speed Boost)
local function enableSpeedBoost()
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = 100 -- سرعة عالية وثابتة
    end
end

local function disableSpeedBoost()
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = 16 -- سرعة عادية
    end
end

-- سوبر جامب مضبوط
local function enableSuperJump()
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.JumpPower = 150
    end
end

local function disableSuperJump()
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.JumpPower = 50
    end
end

-- طيران (Fly) متحرك مع WASD و الماوس
local flying = false
local speed = 100
local hrp = nil
local bodyVelocity = nil
local bodyGyro = nil
local keys = {W = false, A = false, S = false, D = false}

local function startFly()
    if flying then return end
    local character = LocalPlayer.Character
    if not character then return end
    hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.Parent = hrp

    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
    bodyGyro.CFrame = hrp.CFrame
    bodyGyro.Parent = hrp

    flying = true
end

local function stopFly()
    flying = false
    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end
    if bodyGyro then
        bodyGyro:Destroy()
        bodyGyro = nil
    end
end

local function updateFly()
    if not flying or not hrp or not bodyVelocity or not bodyGyro then return end

    local cam = workspace.CurrentCamera
    local moveDirection = Vector3.new(0,0,0)

    if keys.W then moveDirection = moveDirection + cam.CFrame.LookVector end
    if keys.S then moveDirection = moveDirection - cam.CFrame.LookVector end
    if keys.A then moveDirection = moveDirection - cam.CFrame.RightVector end
    if keys.D then moveDirection = moveDirection + cam.CFrame.RightVector end

    moveDirection = moveDirection.Unit * speed
    if moveDirection.Magnitude == 0 then
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    else
        bodyVelocity.Velocity = Vector3.new(moveDirection.X, 0, moveDirection.Z)
    end

    bodyGyro.CFrame = cam.CFrame
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.W then keys.W = true end
    if input.KeyCode == Enum.KeyCode.A then keys.A = true end
    if input.KeyCode == Enum.KeyCode.S then keys.S = true end
    if input.KeyCode == Enum.KeyCode.D then keys.D = true end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.W then keys.W = false end
    if input.KeyCode == Enum.KeyCode.A then keys.A = false end
    if input.KeyCode == Enum.KeyCode.S then keys.S = false end
    if input.KeyCode == Enum.KeyCode.D then keys.D = false end
end)

RunService.Heartbeat:Connect(updateFly)

-- ESP للأشخاص فقط
local function enableESP()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            if not plr.Character:FindFirstChild("NoMercyESP") then
                local highlight = Instance.new("Highlight")
                highlight.Name = "NoMercyESP"
                highlight.Adornee = plr.Character
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.Parent = plr.Character
            end
        end
    end
end

-- أزرار الوظائف
local function makeButton(text, yPos, callback)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0.8, 0, 0, 35)
    btn.Position = UDim2.new(0.1, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Text = text
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 18
    btn.MouseButton1Click:Connect(callback)
end

makeButton("🛫 TP to Sky", 50, tpSky)
makeButton("⬇️ Fall Down", 90, fallDown)
makeButton("⚡ Speed Boost ON", 130, enableSpeedBoost)
makeButton("🐢 Speed Boost OFF", 170, disableSpeedBoost)
makeButton("🦘 Super Jump ON", 210, enableSuperJump)
makeButton("🦘 Super Jump OFF", 250, disableSuperJump)
makeButton("🪁 Fly ON", 290, startFly)
makeButton("🛑 Fly OFF", 330, stopFly)
makeButton("🔍 Enable ESP", 370, enableESP)
