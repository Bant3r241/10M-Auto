local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer

-- Utility function to search deeply for a TextBox named "Job-ID Input"
local function findJobIDInput()
    -- Search PlayerGui deeply
    local playerGui = player:WaitForChild("PlayerGui")
    for _, guiObject in pairs(playerGui:GetDescendants()) do
        if guiObject:IsA("TextBox") and guiObject.Name == "Job-ID Input" then
            return guiObject
        end
    end
    -- Search CoreGui deeply
    for _, guiObject in pairs(CoreGui:GetDescendants()) do
        if guiObject:IsA("TextBox") and guiObject.Name == "Job-ID Input" then
            return guiObject
        end
    end
    return nil
end

-- Create simple toggle GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AutoPasteToggleGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 220, 0, 60)
Frame.Position = UDim2.new(0, 10, 0, 10)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(1, -20, 0, 40)
ToggleButton.Position = UDim2.new(0, 10, 0, 10)
ToggleButton.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextSize = 20
ToggleButton.Text = "AutoPaste: OFF"
ToggleButton.Parent = Frame

local autoPasteEnabled = false
local lastClipboardText = ""

ToggleButton.MouseButton1Click:Connect(function()
    autoPasteEnabled = not autoPasteEnabled
    ToggleButton.Text = "AutoPaste: " .. (autoPasteEnabled and "ON" or "OFF")
end)

-- Main loop to detect clipboard changes and paste into Job-ID Input
RunService.Heartbeat:Connect(function()
    if autoPasteEnabled then
        local ok, clipboard = pcall(function()
            return UserInputService:GetClipboard()
        end)
        if ok and clipboard and clipboard ~= lastClipboardText then
            lastClipboardText = clipboard

            local jobInput = findJobIDInput()
            if jobInput then
                jobInput.Text = clipboard
                -- Optionally fire events or simulate input here if needed
                print("[AutoPaste] Pasted clipboard into Job-ID Input:", clipboard)
            else
                warn("[AutoPaste] Job-ID Input not found yet.")
            end
        end
    end
end)

print("[AutoPaste] Script loaded. Use the toggle button to enable/disable autopaste.")
