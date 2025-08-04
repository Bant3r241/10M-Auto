-- Auto Job-ID Paster for Chilli Hub exploit
-- Customize the GUI paths below to your exploit's actual UI structure

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoJoinerGui"
screenGui.Parent = PlayerGui

-- Create Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 90)
frame.Position = UDim2.new(0, 20, 0, 20)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = screenGui

-- Create Toggle Button
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

toggleBtn.MouseButton1Click:Connect(function()
    autoPasteEnabled = not autoPasteEnabled
    if autoPasteEnabled then
        toggleBtn.Text = "Auto Paste: ON"
    else
        toggleBtn.Text = "Auto Paste: OFF"
    end
end)

-- === CHANGE THESE TO MATCH YOUR EXPLOIT GUI STRUCTURE ===
local chilliHubGui = PlayerGui:FindFirstChild("Steal a Brainot - Chilli Hub - By KhanhSky") 
-- This name must exactly match your GUI's top-level name!

-- Find Server tab container inside Chilli Hub GUI
local serverTab = chilliHubGui and chilliHubGui:FindFirstChild("Server")

-- Find the Job-ID Input TextBox inside Server tab
-- This needs to be the exact name of that input box!
local jobIdInput = nil
if serverTab then
    -- Search recursively just in case
    local function findInputGui(parent)
        for _, child in pairs(parent:GetChildren()) do
            if child:IsA("TextBox") and (child.PlaceholderText == "Job-ID Input" or child.Name:lower():find("job")) then
                return child
            end
            local found = findInputGui(child)
            if found then return found end
        end
        return nil
    end
    jobIdInput = findInputGui(serverTab)
end

if not jobIdInput then
    warn("Job-ID Input box not found. Please update script with correct UI path.")
end

-- Simulated variable for new Job-ID code (replace with real input method)
local latestJobCode = ""

-- Function to update Job-ID input text
local function updateJobInput(code)
    if jobIdInput and autoPasteEnabled and code ~= "" then
        jobIdInput.Text = code
        print("Job-ID input updated to: "..code)
        latestJobCode = "" -- reset after paste
    end
end

-- Polling loop to check for new job codes every 0.3 seconds
spawn(function()
    while true do
        wait(0.3)
        if autoPasteEnabled and latestJobCode ~= "" then
            updateJobInput(latestJobCode)
        end
    end
end)

-- For testing: Manually set latestJobCode in command bar or script
-- latestJobCode = "1234567890"
