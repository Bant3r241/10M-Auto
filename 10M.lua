local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- Find the main GUI by partial name match (adjust this if needed)
local function findChilliHubGui()
    for _, gui in pairs(PlayerGui:GetChildren()) do
        if gui:IsA("ScreenGui") and gui.Name:find("Chilli Hub") then
            return gui
        end
    end
    return nil
end

local chilliHubGui = findChilliHubGui()
if not chilliHubGui then
    warn("Chilli Hub GUI not found!")
    return
end

-- Find the "Job-ID Input" TextBox anywhere inside Chilli Hub GUI
local function findJobIdInput(parent)
    for _, child in pairs(parent:GetChildren()) do
        if child:IsA("TextBox") and child.Name == "Job-ID Input" then
            return child
        end
        local found = findJobIdInput(child)
        if found then return found end
    end
    return nil
end

local jobIdInput = findJobIdInput(chilliHubGui)
if not jobIdInput then
    warn("Job-ID Input TextBox not found inside Chilli Hub GUI!")
    return
end

print("Found Job-ID Input TextBox! Ready to paste.")

-- Auto Paste toggle GUI setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoJoinerGui"
screenGui.Parent = PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 90)
frame.Position = UDim2.new(0, 20, 0, 20)
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

local autoPasteEnabled = false
local latestJobCode = ""

toggleBtn.MouseButton1Click:Connect(function()
    autoPasteEnabled = not autoPasteEnabled
    if autoPasteEnabled then
        toggleBtn.Text = "Auto Paste: ON"
    else
        toggleBtn.Text = "Auto Paste: OFF"
    end
end)

-- Function to paste code into the Job-ID Input
local function pasteJobId(code)
    if autoPasteEnabled and code ~= "" then
        jobIdInput.Text = code
        print("Pasted Job-ID: " .. code)
        latestJobCode = "" -- Reset after pasting
    end
end

-- Polling loop to detect new job codes (simulate)
spawn(function()
    while true do
        wait(0.2)
        if latestJobCode ~= "" then
            pasteJobId(latestJobCode)
        end
    end
end)

--[[ 
-- For testing: set latestJobCode manually to paste
latestJobCode = "UtKCQbvBZMjUQpNVLfwP9VtOItPOpNDOTHvB8VvVqMvVk1PQKLETAVkOyHlYG8uJqHPUSfNVNbkTuO3Y4xvPSAFN+HkUqHys"
--]]
