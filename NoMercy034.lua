-- NoMercy034.exe سكربت شامل
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- حذف الواجهة القديمة لو موجودة
pcall(function() PlayerGui.NoMercy034:Destroy() end)

-- GUI
local screenGui = Instance.new("ScreenGui", PlayerGui)
screenGui.Name = "NoMercy034"
screenGui.ResetOnSpawn = false

-- زر فتح الواجهة بصورة
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 50, 0, 50)
openBtn.Position = UDim2.new(0, 10, 0.8, 0)
openBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
openBtn.Text = ""
openBtn.AutoButtonColor = false
openBtn.Parent = screenGui

local image = Instance.new("ImageLabel", openBtn)
image.Size = UDim2.new(1, 0, 1, 0)
image.Image = "rbxassetid://4094500112762930"
image.BackgroundTransparency = 1

-- واجهة رئيسية
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 300, 0, 450)
frame.Position = UDim2.new(0.5, -150, 0.5, -225)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
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
title.TextSize = 20

-- زر إغلاق
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

-- وظائف السكربت
local function tpSky()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.CFrame = hrp.CFrame + Vector3.new(0, 300, 0) end
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

local function enableSpeed()
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = 100 end
end

local function disableSpeed()
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = 16 end
end

local function enableJump()
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.JumpPower = 150 end
end

local function disableJump()
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.JumpPower = 50 end
end

-- طيران
local flying = false
local keys = {W=false, A=false, S=false, D=false}
local speed = 100
local hrp, bv, bg

local function startFly()
    if flying then return end
    local char = LocalPlayer.Character
    if not char then return end
    hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    flying = true

    bv = Instance.new("BodyVelocity", hrp)
    bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)

    bg = Instance.new("BodyGyro", hrp)
    bg.MaxTorque = Vector3.new(1e5, 1e5, 1e5)

    RunService.Heartbeat:Connect(function()
        if flying and hrp then
            local cam = workspace.CurrentCamera
            local dir = Vector3.zero
            if keys.W then dir += cam.CFrame.LookVector end
            if keys.S then dir -= cam.CFrame.LookVector end
            if keys.A then dir -= cam.CFrame.RightVector end
            if keys.D then dir += cam.CFrame.RightVector end
            if dir.Magnitude > 0 then dir = dir.Unit * speed end
            bv.Velocity = Vector3.new(dir.X, 0, dir.Z)
            bg.CFrame = cam.CFrame
        end
    end)
end

local function stopFly()
    flying = false
    if bv then bv:Destroy() bv = nil end
    if bg then bg:Destroy() bg = nil end
end

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.W then keys.W = true end
    if input.KeyCode == Enum.KeyCode.A then keys.A = true end
    if input.KeyCode == Enum.KeyCode.S then keys.S = true end
    if input.KeyCode == Enum.KeyCode.D then keys.D = true end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.W then keys.W = false end
    if input.KeyCode == Enum.KeyCode.A then keys.A = false end
    if input.KeyCode == Enum.KeyCode.S then keys.S = false end
    if input.KeyCode == Enum.KeyCode.D then keys.D = false end
end)

-- ESP للاعبين
local function enableESP()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and not plr.Character:FindFirstChild("NoMercyESP") then
            local highlight = Instance.new("Highlight", plr.Character)
            highlight.Name = "NoMercyESP"
            highlight.FillColor = Color3.fromRGB(255, 0, 0)
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        end
    end
end

-- ثغرة Glitch to Spawn
local function glitchToSpawn()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        task.wait(4) -- انتظر 4 ثواني
        local hrp = char:FindFirstChild("HumanoidRootPart")
        hrp.Anchored = false
        local bv = Instance.new("BodyVelocity")
        bv.Velocity = Vector3.new(0, -250, 0)
        bv.MaxForce = Vector3.new(0, math.huge, 0)
        bv.Parent = hrp
        game.Debris:AddItem(bv, 0.3)

        local part = Instance.new("Part", workspace)
        part.Size = Vector3.new(10, 1, 10)
        part.Position = hrp.Position - Vector3.new(0, 100, 0)
        part.Anchored = true
        part.Transparency = 1
        part.CanCollide = true

        task.wait(2)
        part:Destroy()
    end
end

-- زر يصنع زر
local function makeButton(text, y, callback)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0.8, 0, 0, 30)
    btn.Position = UDim2.new(0.1, 0, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    btn.Text = text
    btn.MouseButton1Click:Connect(callback)
end

-- أزرار الوظائف
makeButton("🛫 TP to Sky", 50, tpSky)
makeButton("⬇️ Fall Down", 90, fallDown)
makeButton("⚡ Speed ON", 130, enableSpeed)
makeButton("🐢 Speed OFF", 170, disableSpeed)
makeButton("🦘 Jump ON", 210, enableJump)
makeButton("🦘 Jump OFF", 250, disableJump)
makeButton("🪁 Fly ON", 290, startFly)
makeButton("🛑 Fly OFF", 330, stopFly)
makeButton("🔍 ESP Players", 370, enableESP)
makeButton("🚪 Glitch to Spawn", 410, glitchToSpawn)
