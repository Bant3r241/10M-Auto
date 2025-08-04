local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- === Wait for Chilli Hub GUI ===
local chilliHubGui = nil
repeat
    chilliHubGui = PlayerGui:FindFirstChild("Steal a Brainot - Chilli Hub - By KhanhSky")
    wait(0.5)
until chilliHubGui

-- === Wait for Server Tab ===
local serverTab = nil
repeat
    serverTab = chilliHubGui:FindFirstChild("Server")
    wait(0.5)
until serverTab

-- === Wait for Job-ID Input TextBox ===
local jobIdInput = nil
repeat
    jobIdInput = serverTab:FindFirstChild("Job-ID Input")
    wait(0.5)
until jobIdInput

print("[AutoJoiner] Found Job-ID Input TextBox!")

-- === Create Auto Paste GUI ===
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoJoinerGui"
screenGui.Parent = PlayerGui
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 90)
frame.Position = UDim2.new(0.5, -110, 0.5, -45)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(1, -20, 0, 45)
toggleBtn.Position = UDim2.new(0, 10, 0, 10)
toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.TextSize = 18
toggleBtn.Text = "Auto Paste: OFF"
toggleBtn.Parent = frame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -20, 0, 30)
statusLabel.Position = UDim2.new(0, 10, 0, 55)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.new(1,1,1)
statusLabel.Font = Enum.Font.SourceSans
statusLabel.TextSize = 16
statusLabel.Text = "Paste job IDs automatically."
statusLabel.Parent = frame

-- === Variables ===
local autoPasteEnabled = false
local latestJobCode = ""

toggleBtn.MouseButton1Click:Connect(function()
    autoPasteEnabled = not autoPasteEnabled
    if autoPasteEnabled then
        toggleBtn.Text = "Auto Paste: ON"
        print("[AutoJoiner] Auto Paste Enabled")
    else
        toggleBtn.Text = "Auto Paste: OFF"
        print("[AutoJoiner] Auto Paste Disabled")
    end
end)

-- === Paste function ===
local function pasteJobId(code)
    if autoPasteEnabled and code ~= "" then
        jobIdInput.Text = code
        print("[AutoJoiner] Pasted Job-ID: " .. code)
        latestJobCode = "" -- Reset after pasting
    end
end

-- === Poll for new job code to paste ===
spawn(function()
    while true do
        wait(0.2)
        if latestJobCode ~= "" then
            pasteJobId(latestJobCode)
        end
    end
end)

-- === TEST EXAMPLE ===
-- To test paste functionality:
-- In the console, set latestJobCode = "1234567890"
-- and toggle Auto Paste ON in the GUI.
