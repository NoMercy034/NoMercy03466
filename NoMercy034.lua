-- NoMercy034.exe - نسخة كاملة بدون GitHub
-- ✅ واجهة GUI + ESP + TP + سرعة + Super Jump + زر إغلاق/فتح

-- إعداد
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- حذف الواجهة القديمة إن وجدت
pcall(function() PlayerGui.NoMercy034:Destroy() end)

-- إنشاء الواجهة
local screenGui = Instance.new("ScreenGui", PlayerGui)
screenGui.Name = "NoMercy034"
screenGui.ResetOnSpawn = false

-- زر فتح/إغلاق
local openBtn = Instance.new("TextButton")
openBtn.Text = "Nom"
openBtn.Size = UDim2.new(0, 50, 0, 50)
openBtn.Position = UDim2.new(0, 10, 0.8, 0)
openBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
openBtn.TextColor3 = Color3.new(1,1,1)
openBtn.Parent = screenGui

-- الإطار الرئيسي
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 400)
frame.Position = UDim2.new(0.5, -150, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Parent = screenGui
frame.Visible = false
frame.Active = true
frame.Draggable = true

-- عنوان
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
title.Text = "NoMercy034"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 22

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

-- وظائف
local function tpSky()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CFrame = hrp.CFrame + Vector3.new(0, 300, 0)
    end
end

local function tpDown()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CFrame = hrp.CFrame - Vector3.new(0, 300, 0)
    end
end

local function setSpeed(value)
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = value
    end
end

local function superJump(enable)
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.JumpPower = enable and 150 or 50
    end
end

local function enableESP()
    local animals = {"ترلاليلو", "ترلالا", "برتقالة", "أودين دين دون", "لا فاسكا"}
    for _, obj in pairs(workspace:GetChildren()) do
        if table.find(animals, obj.Name) and obj:FindFirstChild("HumanoidRootPart") then
            local h = Instance.new("Highlight", obj)
            h.Name = "NoMercyESP"
            h.FillColor = Color3.fromRGB(255, 100, 100)
            h.OutlineColor = Color3.fromRGB(255, 0, 0)
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
makeButton("🪂 TP Down", 90, tpDown)
makeButton("⚡ Speed 100", 130, function() setSpeed(100) end)
makeButton("🐢 Speed 16", 170, function() setSpeed(16) end)
makeButton("🦘 Super Jump ON", 210, function() superJump(true) end)
makeButton("🦘 Super Jump OFF", 250, function() superJump(false) end)
makeButton("🔍 Enable ESP", 290, enableESP)