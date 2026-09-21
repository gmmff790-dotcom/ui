local Library = {}
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

function Library:CreateWindow(titleText)
    local window = {}

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "XenithHubPro"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    if PlayerGui:FindFirstChild("XenithHubPro") then
        PlayerGui.XenithHubPro:Destroy()
    end
    screenGui.Parent = PlayerGui

    -- หน้าต่างหลักดีไซน์พรีเมียม ขอบโค้งมนและเงางาม
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 360, 0, 420)
    mainFrame.Position = UDim2.new(0.5, -180, 0.5, -210)
    mainFrame.BackgroundColor3 = Color3.fromRGB(12, 16, 28)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = mainFrame

    local mainStroke = Instance.new("UIStroke")
    mainStroke.Thickness = 1.2
    mainStroke.Color = Color3.fromRGB(35, 90, 150)
    mainStroke.Parent = mainFrame

    -- แถบบน (TopBar)
    local topBar = Instance.new("Frame")
    topBar.Size = UDim2.new(1, 0, 0, 42)
    topBar.BackgroundTransparency = 1
    topBar.Parent = mainFrame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -50, 1, 0)
    titleLabel.Position = UDim2.new(0, 14, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = titleText or "Xenith Hub Pro"
    titleLabel.TextColor3 = Color3.fromRGB(220, 240, 255)
    titleLabel.TextSize = 14
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = topBar

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 26, 0, 26)
    closeBtn.Position = UDim2.new(1, -34, 0.5, -13)
    closeBtn.BackgroundColor3 = Color3.fromRGB(25, 35, 55)
    closeBtn.Text = "×"
    closeBtn.TextColor3 = Color3.fromRGB(200, 220, 255)
    closeBtn.TextSize = 16
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = topBar

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 6)
    closeCorner.Parent = closeBtn

    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)

    -- เส้นคั่นสวยๆ
    local separator = Instance.new("Frame")
    separator.Size = UDim2.new(1, -24, 0, 1)
    separator.Position = UDim2.new(0, 12, 0, 42)
    separator.BackgroundColor3 = Color3.fromRGB(25, 55, 90)
    separator.BorderSizePixel = 0
    separator.Parent = mainFrame

    -- ScrollingFrame หลัก (ตั้งค่า AutomaticCanvasSize แบบถูกต้อง 100% เพื่อให้เลื่อนได้ปกติ)
    local scrollingFrame = Instance.new("ScrollingFrame")
    scrollingFrame.Size = UDim2.new(1, -16, 1, -54)
    scrollingFrame.Position = UDim2.new(0, 8, 0, 48)
    scrollingFrame.BackgroundTransparency = 1
    scrollingFrame.BorderSizePixel = 0
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scrollingFrame.ScrollBarThickness = 5
    scrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(40, 100, 160)
    scrollingFrame.Parent = mainFrame

    local mainLayout = Instance.new("UIListLayout")
    mainLayout.SortOrder = Enum.SortOrder.LayoutOrder
    mainLayout.Padding = UDim.new(0, 10)
    mainLayout.Parent = scrollingFrame

    -- 1. ฟังก์ชัน AddDropdown (ดีไซน์พรีเมียม ไม่ดันเลย์เอาต์มั่ว)
   function window:AddDropdown(titleText, options, callback)
        local isOpen = false
        local itemHeight = 28
        local padding = 3
        local normalHeight = 38
        -- คำนวณความสูงรวมของตัวเลือกทั้งหมดแบบแม่นยำ
        local expandedHeight = normalHeight + (#options * (itemHeight + padding)) + 6

        local dropContainer = Instance.new("Frame")
        dropContainer.Size = UDim2.new(1, -8, 0, normalHeight)
        dropContainer.BackgroundColor3 = Color3.fromRGB(18, 25, 42)
        dropContainer.BorderSizePixel = 0
        dropContainer.ClipsDescendants = true
        dropContainer.Parent = scrollingFrame

        local dropCorner = Instance.new("UICorner")
        dropCorner.CornerRadius = UDim.new(0, 8)
        dropCorner.Parent = dropContainer

        local dropStroke = Instance.new("UIStroke")
        dropStroke.Thickness = 1
        dropStroke.Color = Color3.fromRGB(30, 65, 110)
        dropStroke.Parent = dropContainer

        local dropBtn = Instance.new("TextButton")
        dropBtn.Size = UDim2.new(1, 0, 0, normalHeight)
        dropBtn.BackgroundTransparency = 1
        dropBtn.Text = "  " .. titleText
        dropBtn.TextColor3 = Color3.fromRGB(210, 230, 255)
        dropBtn.TextSize = 12
        dropBtn.Font = Enum.Font.GothamBold
        dropBtn.TextXAlignment = Enum.TextXAlignment.Left
        dropBtn.Parent = dropContainer

        -- ใช้ขีดล่าง/ขีดบนแทนลูกศร เพื่อป้องกันสี่เหลี่ยมบัค 100%
        local arrow = Instance.new("TextLabel")
        arrow.Size = UDim2.new(0, 30, 0, normalHeight)
        arrow.Position = UDim2.new(1, -30, 0, 0)
        arrow.BackgroundTransparency = 1
        arrow.Text = "+"
        arrow.TextColor3 = Color3.fromRGB(130, 180, 230)
        arrow.TextSize = 14
        arrow.Font = Enum.Font.GothamBold
        arrow.Parent = dropContainer

        local optionsHolder = Instance.new("Frame")
        optionsHolder.Size = UDim2.new(1, -12, 0, #options * (itemHeight + padding))
        optionsHolder.Position = UDim2.new(0, 6, 0, normalHeight + 2)
        optionsHolder.BackgroundTransparency = 1
        optionsHolder.Parent = dropContainer

        local optList = Instance.new("UIListLayout")
        optList.SortOrder = Enum.SortOrder.LayoutOrder
        optList.Padding = UDim.new(0, padding)
        optList.Parent = optionsHolder

        for _, option in ipairs(options) do
            local optBtn = Instance.new("TextButton")
            optBtn.Size = UDim2.new(1, 0, 0, itemHeight)
            optBtn.BackgroundColor3 = Color3.fromRGB(25, 38, 60)
            optBtn.BorderSizePixel = 0
            optBtn.Text = "   " .. tostring(option)
            optBtn.TextColor3 = Color3.fromRGB(180, 210, 255)
            optBtn.TextSize = 11
            optBtn.Font = Enum.Font.Gotham
            optBtn.TextXAlignment = Enum.TextXAlignment.Left
            optBtn.Parent = optionsHolder

            local optCorner = Instance.new("UICorner")
            optCorner.CornerRadius = UDim.new(0, 6)
            optCorner.Parent = optBtn

            optBtn.MouseButton1Click:Connect(function()
                isOpen = false
                dropContainer.Size = UDim2.new(1, -8, 0, normalHeight)
                arrow.Text = "+"
                dropBtn.Text = "  " .. titleText .. ": " .. tostring(option)
                if callback then callback(option) end
            end)
        end

        dropBtn.MouseButton1Click:Connect(function()
            isOpen = not isOpen
            if isOpen then
                dropContainer.Size = UDim2.new(1, -8, 0, expandedHeight)
                arrow.Text = "-"
            else
                dropContainer.Size = UDim2.new(1, -8, 0, normalHeight)
                arrow.Text = "+"
            end
        end)
    end

    -- 2. ฟังก์ชัน AddToggle
    function window:AddToggle(titleText, callback)
        local toggleContainer = Instance.new("Frame")
        toggleContainer.Size = UDim2.new(1, -8, 0, 38)
        toggleContainer.BackgroundColor3 = Color3.fromRGB(18, 25, 42)
        toggleContainer.BorderSizePixel = 0
        toggleContainer.Parent = scrollingFrame

        local tCorner = Instance.new("UICorner")
        tCorner.CornerRadius = UDim.new(0, 8)
        tCorner.Parent = toggleContainer

        local tStroke = Instance.new("UIStroke")
        tStroke.Thickness = 1
        tStroke.Color = Color3.fromRGB(30, 65, 110)
        tStroke.Parent = toggleContainer

        local tLabel = Instance.new("TextLabel")
        tLabel.Size = UDim2.new(1, -60, 1, 0)
        tLabel.Position = UDim2.new(0, 12, 0, 0)
        tLabel.BackgroundTransparency = 1
        tLabel.Text = titleText
        tLabel.TextColor3 = Color3.fromRGB(210, 230, 255)
        tLabel.TextSize = 12
        tLabel.Font = Enum.Font.GothamBold
        tLabel.TextXAlignment = Enum.TextXAlignment.Left
        tLabel.Parent = toggleContainer

        local switch = Instance.new("TextButton")
        switch.Size = UDim2.new(0, 40, 0, 22)
        switch.Position = UDim2.new(1, -48, 0.5, -11)
        switch.BackgroundColor3 = Color3.fromRGB(30, 45, 70)
        switch.Text = ""
        switch.Parent = toggleContainer

        local sCorner = Instance.new("UICorner")
        sCorner.CornerRadius = UDim.new(1, 0)
        sCorner.Parent = switch

        local circle = Instance.new("Frame")
        circle.Size = UDim2.new(0, 18, 0, 18)
        circle.Position = UDim2.new(0, 2, 0.5, -9)
        circle.BackgroundColor3 = Color3.fromRGB(220, 240, 255)
        circle.Parent = switch

        local cCorner = Instance.new("UICorner")
        cCorner.CornerRadius = UDim.new(1, 0)
        cCorner.Parent = circle

        local toggled = false
        switch.MouseButton1Click:Connect(function()
            toggled = not toggled
            if toggled then
                switch.BackgroundColor3 = Color3.fromRGB(0, 160, 255)
                circle:TweenPosition(UDim2.new(1, -20, 0.5, -9), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
            else
                switch.BackgroundColor3 = Color3.fromRGB(30, 45, 70)
                circle:TweenPosition(UDim2.new(0, 2, 0.5, -9), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
            end
            if callback then callback(toggled) end
        end)
    end

    -- 3. ระบบ Grid สัตว์เลี้ยง (แก้ปัญหาเลื่อนไม่ได้เด็ดขาดด้วย AutomaticSize)
    local petGridContainer = nil
    function window:CreatePetContainer()
        if not petGridContainer then
            petGridContainer = Instance.new("Frame")
            petGridContainer.Size = UDim2.new(1, -8, 0, 0)
            petGridContainer.BackgroundTransparency = 1
            petGridContainer.AutomaticSize = Enum.AutomaticSize.Y
            petGridContainer.Parent = scrollingFrame

            local gridLayout = Instance.new("UIGridLayout")
            gridLayout.CellSize = UDim2.new(0, 105, 0, 105)
            gridLayout.CellPadding = UDim2.new(0, 10, 0, 10)
            gridLayout.SortOrder = Enum.SortOrder.LayoutOrder
            
            gridLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                petGridContainer.Size = UDim2.new(1, -8, 0, gridLayout.AbsoluteContentSize.Y)
            end)
            
            gridLayout.Parent = petGridContainer
        end
        return petGridContainer
    end

    -- 4. ฟังก์ชัน AddPetBox (โคลนโมเดล 3D หมุนเนียนๆ)
    function window:AddPetBox(config, clickCallback)
        local container = window:CreatePetContainer()
        
        local petButton = Instance.new("TextButton")
        petButton.Size = UDim2.new(0, 105, 0, 105)
        petButton.BackgroundColor3 = Color3.fromRGB(18, 26, 42)
        petButton.Text = ""
        petButton.AutoButtonColor = false
        petButton.ClipsDescendants = true
        petButton.Parent = container

        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 8)
        btnCorner.Parent = petButton

        local btnStroke = Instance.new("UIStroke")
        btnStroke.Thickness = 1
        btnStroke.Color = Color3.fromRGB(35, 70, 120)
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
        incomeLabel.Size = UDim2.new(1, -8, 0, 20)
        incomeLabel.Position = UDim2.new(0, 4, 1, -24)
        incomeLabel.BackgroundTransparency = 0.2
        incomeLabel.BackgroundColor3 = Color3.fromRGB(10, 15, 25)
        incomeLabel.TextColor3 = Color3.fromRGB(170, 220, 255)
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
        selectStroke.Thickness = 2.5
        selectStroke.Color = Color3.fromRGB(0, 180, 255)
        selectStroke.Transparency = 1
        selectStroke.Parent = petButton

        petButton.MouseButton1Click:Connect(function()
            isSelected = not isSelected
            if isSelected then
                selectStroke.Transparency = 0
                petButton.BackgroundColor3 = Color3.fromRGB(20, 45, 75)
                btnStroke.Transparency = 1
            else
                selectStroke.Transparency = 1
                petButton.BackgroundColor3 = Color3.fromRGB(18, 26, 42)
                btnStroke.Transparency = 0
            end
            if clickCallback then clickCallback(isSelected) end
        end)
        
        return petButton
    end

    return window
end

return Library
