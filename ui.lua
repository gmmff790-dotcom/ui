local Library = {}
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

function Library:CreateWindow(titleText)
    local window = {}

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "XenithHub"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    if PlayerGui:FindFirstChild("XenithHub") then
        PlayerGui.XenithHub:Destroy()
    end
    screenGui.Parent = PlayerGui

    local mainFrame = Instance.new("ImageLabel")
    mainFrame.Size = UDim2.new(0, 350, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -175, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 20, 35)
    mainFrame.Image = "rbxassetid://126239192307237"
    mainFrame.ScaleType = Enum.ScaleType.Slice
    mainFrame.SliceCenter = Rect.new(100, 100, 100, 100)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = mainFrame

    local mainStroke = Instance.new("UIStroke")
    mainStroke.Thickness = 1.5
    mainStroke.Color = Color3.fromRGB(0, 170, 255)
    mainStroke.Parent = mainFrame

    local topBar = Instance.new("Frame")
    topBar.Size = UDim2.new(1, 0, 0, 40)
    topBar.BackgroundTransparency = 1
    topBar.Parent = mainFrame

    local logoImg = Instance.new("ImageLabel")
    logoImg.Size = UDim2.new(0, 24, 0, 24)
    logoImg.Position = UDim2.new(0, 10, 0, 8)
    logoImg.BackgroundTransparency = 1
    logoImg.Image = "rbxassetid://126239192307237"
    logoImg.Parent = topBar

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -75, 1, 0)
    titleLabel.Position = UDim2.new(0, 40, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = titleText or "Auto Pet Hub"
    titleLabel.TextColor3 = Color3.fromRGB(130, 210, 255)
    titleLabel.TextSize = 13
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = topBar

    local separator = Instance.new("Frame")
    separator.Size = UDim2.new(1, -20, 0, 1)
    separator.Position = UDim2.new(0, 10, 0, 40)
    separator.BackgroundColor3 = Color3.fromRGB(30, 80, 140)
    separator.BorderSizePixel = 0
    separator.Parent = mainFrame

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 24, 0, 24)
    closeBtn.Position = UDim2.new(1, -32, 0, 8)
    closeBtn.BackgroundColor3 = Color3.fromRGB(20, 50, 90)
    closeBtn.Text = "×"
    closeBtn.TextColor3 = Color3.fromRGB(180, 220, 255)
    closeBtn.TextSize = 16
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = topBar

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 6)
    closeCorner.Parent = closeBtn

    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)

    local scrollingFrame = Instance.new("ScrollingFrame")
    scrollingFrame.Size = UDim2.new(1, -20, 1, -52)
    scrollingFrame.Position = UDim2.new(0, 10, 0, 46)
    scrollingFrame.BackgroundTransparency = 1
    scrollingFrame.BorderSizePixel = 0
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scrollingFrame.ScrollBarThickness = 4
    scrollingFrame.Parent = mainFrame

    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    uiListLayout.Padding = UDim.new(0, 8)
    uiListLayout.Parent = scrollingFrame

    -- Container สำหรับเก็บ Grid ของ PetBox
    local petGridContainer = nil
    function window:CreatePetContainer()
        if not petGridContainer then
            petGridContainer = Instance.new("Frame")
            petGridContainer.Size = UDim2.new(1, 0, 0, 250)
            petGridContainer.BackgroundTransparency = 1
            petGridContainer.Parent = scrollingFrame

            local gridLayout = Instance.new("UIGridLayout")
            gridLayout.CellSize = UDim2.new(0, 100, 0, 100)
            gridLayout.CellPadding = UDim2.new(0, 9, 0, 9)
            gridLayout.Parent = petGridContainer
        end
        return petGridContainer
    end

    -- ฟังก์ชัน AddDropdown
    function window:AddDropdown(titleText, options, callback)
        local dropContainer = Instance.new("Frame")
        dropContainer.Size = UDim2.new(1, 0, 0, 35)
        dropContainer.BackgroundColor3 = Color3.fromRGB(20, 30, 50)
        dropContainer.BorderSizePixel = 0
        dropContainer.ClipsDescendants = true
        dropContainer.Parent = scrollingFrame

        local dropCorner = Instance.new("UICorner")
        dropCorner.CornerRadius = UDim.new(0, 8)
        dropCorner.Parent = dropContainer

        local dropStroke = Instance.new("UIStroke")
        dropStroke.Thickness = 1
        dropStroke.Color = Color3.fromRGB(40, 70, 110)
        dropStroke.Parent = dropContainer

        local dropBtn = Instance.new("TextButton")
        dropBtn.Size = UDim2.new(1, 0, 0, 35)
        dropBtn.BackgroundTransparency = 1
        dropBtn.Text = "  " .. titleText
        dropBtn.TextColor3 = Color3.fromRGB(200, 230, 255)
        dropBtn.TextSize = 12
        dropBtn.Font = Enum.Font.GothamBold
        dropBtn.TextXAlignment = Enum.TextXAlignment.Left
        dropBtn.Parent = dropContainer

        local arrow = Instance.new("TextLabel")
        arrow.Size = UDim2.new(0, 30, 0, 35)
        arrow.Position = UDim2.new(1, -30, 0, 0)
        arrow.BackgroundTransparency = 1
        arrow.Text = "▼"
        arrow.TextColor3 = Color3.fromRGB(150, 200, 255)
        arrow.TextSize = 10
        arrow.Parent = dropContainer

        local optionList = Instance.new("UIListLayout")
        optionList.SortOrder = Enum.SortOrder.LayoutOrder
        optionList.Padding = UDim.new(0, 2)
        optionList.Parent = dropContainer

        local isOpen = false
        local normalHeight = 35
        local expandedHeight = 35 + (#options * 30)

        for _, option in ipairs(options) do
            local optBtn = Instance.new("TextButton")
            optBtn.Size = UDim2.new(1, 0, 0, 28)
            optBtn.BackgroundColor3 = Color3.fromRGB(25, 40, 65)
            optBtn.BorderSizePixel = 0
            optBtn.Text = "   " .. tostring(option)
            optBtn.TextColor3 = Color3.fromRGB(180, 210, 255)
            optBtn.TextSize = 11
            optBtn.Font = Enum.Font.Gotham
            optBtn.TextXAlignment = Enum.TextXAlignment.Left
            optBtn.Parent = dropContainer

            local optCorner = Instance.new("UICorner")
            optCorner.CornerRadius = UDim.new(0, 6)
            optCorner.Parent = optBtn

            optBtn.MouseButton1Click:Connect(function()
                isOpen = false
                dropContainer.Size = UDim2.new(1, 0, 0, normalHeight)
                arrow.Text = "▼"
                dropBtn.Text = "  " .. titleText .. ": " .. tostring(option)
                if callback then callback(option) end
            end)
        end

        dropBtn.MouseButton1Click:Connect(function()
            isOpen = not isOpen
            if isOpen then
                dropContainer.Size = UDim2.new(1, 0, 0, expandedHeight)
                arrow.Text = "▲"
            else
                dropContainer.Size = UDim2.new(1, 0, 0, normalHeight)
                arrow.Text = "▼"
            end
        end)
    end

    -- ฟังก์ชัน AddToggle
    function window:AddToggle(titleText, callback)
        local toggleContainer = Instance.new("Frame")
        toggleContainer.Size = UDim2.new(1, 0, 0, 35)
        toggleContainer.BackgroundColor3 = Color3.fromRGB(20, 30, 50)
        toggleContainer.BorderSizePixel = 0
        toggleContainer.Parent = scrollingFrame

        local tCorner = Instance.new("UICorner")
        tCorner.CornerRadius = UDim.new(0, 8)
        tCorner.Parent = toggleContainer

        local tStroke = Instance.new("UIStroke")
        tStroke.Thickness = 1
        tStroke.Color = Color3.fromRGB(40, 70, 110)
        tStroke.Parent = toggleContainer

        local tLabel = Instance.new("TextLabel")
        tLabel.Size = UDim2.new(1, -50, 1, 0)
        tLabel.Position = UDim2.new(0, 10, 0, 0)
        tLabel.BackgroundTransparency = 1
        tLabel.Text = titleText
        tLabel.TextColor3 = Color3.fromRGB(200, 230, 255)
        tLabel.TextSize = 12
        tLabel.Font = Enum.Font.GothamBold
        tLabel.TextXAlignment = Enum.TextXAlignment.Left
        tLabel.Parent = toggleContainer

        local switch = Instance.new("TextButton")
        switch.Size = UDim2.new(0, 36, 0, 20)
        switch.Position = UDim2.new(1, -44, 0.5, -10)
        switch.BackgroundColor3 = Color3.fromRGB(40, 50, 70)
        switch.Text = ""
        switch.Parent = toggleContainer

        local sCorner = Instance.new("UICorner")
        sCorner.CornerRadius = UDim.new(1, 0)
        sCorner.Parent = switch

        local circle = Instance.new("Frame")
        circle.Size = UDim2.new(0, 16, 0, 16)
        circle.Position = UDim2.new(0, 2, 0.5, -8)
        circle.BackgroundColor3 = Color3.fromRGB(200, 220, 255)
        circle.Parent = switch

        local cCorner = Instance.new("UICorner")
        cCorner.CornerRadius = UDim.new(1, 0)
        cCorner.Parent = circle

        local toggled = false
        switch.MouseButton1Click:Connect(function()
            toggled = not toggled
            if toggled then
                switch.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
                circle:TweenPosition(UDim2.new(1, -18, 0.5, -8), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
            else
                switch.BackgroundColor3 = Color3.fromRGB(40, 50, 70)
                circle:TweenPosition(UDim2.new(0, 2, 0.5, -8), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
            end
            if callback then callback(toggled) end
        end)
    end

    -- ฟังก์ชัน AddPetBox (ดึง Viewport มาโคลน Model และหมุน 3D อัตโนมัติ)
    function window:AddPetBox(config, clickCallback)
        local container = window:CreatePetContainer()
        
        local petButton = Instance.new("TextButton")
        petButton.Size = UDim2.new(0, 100, 0, 100)
        petButton.BackgroundColor3 = Color3.fromRGB(20, 30, 50)
        petButton.Text = ""
        petButton.AutoButtonColor = false
        petButton.ClipsDescendants = true
        petButton.Parent = container

        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 8)
        btnCorner.Parent = petButton

        local btnStroke = Instance.new("UIStroke")
        btnStroke.Thickness = 1
        btnStroke.Color = Color3.fromRGB(40, 70, 110)
        btnStroke.Parent = petButton

        local newViewport = Instance.new("ViewportFrame")
        newViewport.Size = UDim2.new(1, 0, 1, 0)
        newViewport.BackgroundTransparency = 1
        newViewport.ZIndex = 1
        newViewport.Parent = petButton

        if config.Viewport and config.Viewport:IsA("ViewportFrame") then
            for _, child in ipairs(config.Viewport:GetChildren()) do
                if child:IsA("Model") then
                    local clonedModel = child:Clone()
                    clonedModel.Parent = newViewport
                    
                    local cf, size = clonedModel:GetBoundingBox()
                    local maxDim = math.max(size.X, size.Y, size.Z)
                    
                    local camera = Instance.new("Camera")
                    camera.Parent = newViewport
                    newViewport.CurrentCamera = camera
                    
                    camera.CFrame = CFrame.new(cf.Position + (Vector3.new(1, 0.3, 1).Unit * (maxDim * 1.35)), cf.Position)
                    
                    local accumulatedAngle = 0
                    local renderConn
                    renderConn = RunService.RenderStepped:Connect(function(dt)
                        if not clonedModel or not clonedModel.Parent then
                            if renderConn then renderConn:Disconnect() end
                            return
                        end
                        accumulatedAngle = accumulatedAngle + (dt * 1.0)
                        clonedModel:PivotTo(cf * CFrame.Angles(0, accumulatedAngle, 0))
                    end)
                    break
                end
            end
        end

        local incomeLabel = Instance.new("TextLabel")
        incomeLabel.Size = UDim2.new(1, -6, 0, 19)
        incomeLabel.Position = UDim2.new(0, 3, 1, -21)
        incomeLabel.BackgroundTransparency = 0.3
        incomeLabel.BackgroundColor3 = Color3.fromRGB(10, 15, 30)
        incomeLabel.TextColor3 = Color3.fromRGB(180, 230, 255)
        incomeLabel.TextSize = 10
        incomeLabel.Font = Enum.Font.GothamBold
        incomeLabel.TextScaled = true
        incomeLabel.Text = config.Income or "N/A"
        incomeLabel.ZIndex = 3
        incomeLabel.Parent = petButton

        local labelCorner = Instance.new("UICorner")
        labelCorner.CornerRadius = UDim.new(0, 4)
        labelCorner.Parent = incomeLabel

        local isSelected = false
        local selectStroke = Instance.new("UIStroke")
        selectStroke.Thickness = 3
        selectStroke.Color = Color3.fromRGB(0, 200, 255)
        selectStroke.Transparency = 1
        selectStroke.Parent = petButton

        petButton.MouseButton1Click:Connect(function()
            isSelected = not isSelected
            if isSelected then
                selectStroke.Transparency = 0
                petButton.BackgroundColor3 = Color3.fromRGB(20, 50, 80)
                btnStroke.Transparency = 1
            else
                selectStroke.Transparency = 1
                petButton.BackgroundColor3 = Color3.fromRGB(20, 30, 50)
                btnStroke.Transparency = 0
            end
            if clickCallback then clickCallback(isSelected) end
        end)
        
        return petButton
    end

    return window
end

return Library
