-- Simple Auto Job Joiner GUI and functionality

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoJoinerGui"
screenGui.Parent = PlayerGui

-- Create Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 80)
frame.Position = UDim2.new(0, 20, 0, 20)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Parent = screenGui

-- Create Toggle Button
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(1, -20, 0, 40)
toggleBtn.Position = UDim2.new(0, 10, 0, 10)
toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleBtn.TextColor3 = Color3.new(1,1,1)
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

-- Reference your Job-ID input box here:
-- You need to replace this with the actual path/name of the input box in your exploit GUI
local jobIdInput = nil

-- Example: Suppose your exploit GUI is under PlayerGui named "ChilliHub"
local chilliHubGui = PlayerGui:FindFirstChild("ChilliHub") -- Change as needed
if chilliHubGui then
    jobIdInput = chilliHubGui:FindFirstChild("JobIdInput", true) -- search recursively
    -- You might need to adjust the name or hierarchy
end

-- Simulated incoming job code (replace this with actual code receiver)
local latestJobCode = ""

-- Function to update job input text instantly
local function updateJobInput(code)
    if jobIdInput and autoPasteEnabled then
        jobIdInput.Text = code
        -- Optionally fire join action if your exploit has a button or function
        -- e.g., chilliHubGui.JoinButton:Fire()
    end
end

-- Example: simulate code update every 0.5 seconds (replace with your actual code injection method)
spawn(function()
    while true do
        wait(0.5)
        if autoPasteEnabled and latestJobCode ~= "" then
            updateJobInput(latestJobCode)
            -- Reset after pasting to avoid repeats
            latestJobCode = ""
        end
    end
end)

-- To test: change latestJobCode in the command bar or script:
-- latestJobCode = "ABC123"
