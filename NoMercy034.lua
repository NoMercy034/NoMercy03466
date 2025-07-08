local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

pcall(function() PlayerGui.NoMercy034:Destroy() end)

local screenGui = Instance.new("ScreenGui", PlayerGui)
screenGui.Name = "NoMercy034"
screenGui.ResetOnSpawn = false

-- زر Nom بصورة
local openBtn = Instance.new("TextButton", screenGui)
openBtn.Size = UDim2.new(0, 50, 0, 50)
openBtn.Position = UDim2.new(0, 10, 0.8, 0)
openBtn.BackgroundTransparency = 1
openBtn.Text = ""

local image = Instance.new("ImageLabel", openBtn)
image.Size = UDim2.new(1, 0, 1, 0)
image.Image = "rbxassetid://4094500112762930"
image.BackgroundTransparency = 1

-- الإطار الرئيسي
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 300, 0, 450)
frame.Position = UDim2.new(0.5, -150, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Visible = false
frame.Active = true
frame.Draggable = true

-- عنوان
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
title.Text = "NoMercy034.exe"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 22

-- زر إغلاق
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Text = "X"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.MouseButton1Click:Connect(function()
    frame.Visible = false
end)

openBtn.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

-- وظائف السكربت:
local function tpSky()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CFrame = hrp.CFrame + Vector3.new(0, 300, 0)
    end
end

local function fallDown()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        for i = 1, 60 do
            hrp.CFrame = hrp.CFrame - Vector3.new(0, 5, 0)
            task.wait(0.02)
        end
    end
end

local function enableSpeedBoost()
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = 100 end
end

local function disableSpeedBoost()
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = 16 end
end

local function enableSuperJump()
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.JumpPower = 150 end
end

local function disableSuperJump()
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.JumpPower = 50 end
end

-- طيران
local flying = false
local keys = {W=false, A=false, S=false, D=false}
local function startFly()
    if flying then return end
    flying = true
    local hrp = LocalPlayer.Character:WaitForChild("HumanoidRootPart")
    local bv = Instance.new("BodyVelocity", hrp)
    bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    local bg = Instance.new("BodyGyro", hrp)
    bg.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
    RunService.Heartbeat:Connect(function()
        if flying then
            local dir = Vector3.new()
            local cam = workspace.CurrentCamera
            if keys.W then dir += cam.CFrame.LookVector end
            if keys.S then dir -= cam.CFrame.LookVector end
            if keys.A then dir -= cam.CFrame.RightVector end
            if keys.D then dir += cam.CFrame.RightVector end
            bv.Velocity = dir.Unit * 100
            bg.CFrame = cam.CFrame
        end
    end)
end

local function stopFly()
    flying = false
end

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    local key = input.KeyCode
    if keys[key.Name] ~= nil then keys[key.Name] = true end
end)
UserInputService.InputEnded:Connect(function(input)
    local key = input.KeyCode
    if keys[key.Name] ~= nil then keys[key.Name] = false end
end)

-- ESP للاعبين فقط
local function enableESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and not player.Character:FindFirstChild("NoMercyESP") then
            local hl = Instance.new("Highlight", player.Character)
            hl.Name = "NoMercyESP"
            hl.FillColor = Color3.fromRGB(255, 0, 0)
            hl.OutlineColor = Color3.fromRGB(255, 255, 255)
        end
    end
end

-- Glitch to Spawn (ينتظر 4 ثواني)
local function glitchToSpawn()
    task.wait(4)
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local hrp = char.HumanoidRootPart
        hrp.Anchored = false
        local bv = Instance.new("BodyVelocity", hrp)
        bv.Velocity = Vector3.new(0, -250, 0)
        bv.MaxForce = Vector3.new(0, math.huge, 0)
        game.Debris:AddItem(bv, 0.3)
        local fakeFloor = Instance.new("Part", workspace)
        fakeFloor.Size = Vector3.new(10, 1, 10)
        fakeFloor.Position = hrp.Position - Vector3.new(0, 100, 0)
        fakeFloor.Anchored = true
        fakeFloor.Transparency = 1
        fakeFloor.CanCollide = true
        task.wait(2)
        fakeFloor:Destroy()
    end
end

-- إنشاء أزرار الواجهة
local function makeButton(txt, y, fn)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0.8, 0, 0, 30)
    btn.Position = UDim2.new(0.1, 0, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    btn.Text = txt
    btn.MouseButton1Click:Connect(fn)
end

makeButton("🛫 TP to Sky", 50, tpSky)
makeButton("⬇️ Fall Down", 90, fallDown)
makeButton("⚡ Speed Boost ON", 130, enableSpeedBoost)
makeButton("🐢 Speed Boost OFF", 170, disableSpeedBoost)
makeButton("🦘 Super Jump ON", 210, enableSuperJump)
makeButton("🦘 Super Jump OFF", 250, disableSuperJump)
makeButton("🪁 Fly ON", 290, startFly)
makeButton("🛑 Fly OFF", 330, stopFly)
makeButton("🔍 ESP Players", 370, enableESP)
makeButton("🚪 Glitch to Spawn", 410, glitchToSpawn)
