-- Load required modules
local jumpWindow = nil
local jumpButton = nil
local moveTimer = nil
local moveDirection = -1
local movementSpeed = 1
local moveFrequency = 1
local startingY = 250
local startingX = 250
local isJumping = false

-- Module initialization
function init()
    -- Load the UI
    jumpWindow = g_ui.displayUI('jumpModule')
    
    -- Connect the button signal
    jumpButton = jumpWindow:getChildById('jumpButton')
    
    -- Start the timer to move the button
    moveTimer = scheduleEvent(moveButton, moveFrequency, -1)
    
    -- Reset button position
    resetPositionX()
	resetPositionY()
    
    -- Set click function
    jumpButton.onClick = onJumpButtonClick
end

-- Function to reset the button X position
function resetPositionX()
    local windowPos = jumpButton:getParent():getPosition()
    jumpButton:setX(windowPos.x + startingX)
	moveDirection = -1
end

-- Function to reset the button Y position
function resetPositionY()
    local windowPos = jumpButton:getParent():getPosition()
	jumpButton:setY(windowPos.y + startingY)
end

-- Function to automatically move the button horizontally
function moveButton()
    local currentX = jumpButton:getX()
    local windowWidth = jumpButton:getParent():getWidth()
    local buttonWidth = jumpButton:getWidth()
    
    if currentX <= jumpButton:getParent():getX() then
        moveDirection = 1
    elseif currentX + buttonWidth >= windowWidth + jumpButton:getParent():getX() then
        moveDirection = -1
    end
    
    local newX = currentX + (movementSpeed * moveDirection)
    jumpButton:setX(newX)
    
    moveTimer = scheduleEvent(moveButton, moveFrequency)
end

-- Callback function for button click
function onJumpButtonClick()

-- Get the windowPos to make relative calculations
    local windowPos = jumpButton:getParent():getPosition()
-- Declare minHeight and maxHeight for the random function (always relative to the window)
    local minHeight = windowPos.y + startingY - 50
    local maxHeight = windowPos.y + 50
    
    if isJumping then
        resetPositionX()
		resetPositionY()
    else
        local randomHeight = math.random(minHeight, maxHeight)
		
		-- Set the Y position to the new calculated random height
        jumpButton:setY(randomHeight)
		-- Reset the X position
		resetPositionX()
    end
    
    isJumping = not isJumping
end

-- Termination function
function terminate()
    if jumpWindow then
        jumpWindow:destroy()
        jumpWindow = nil
        jumpButton = nil
        moveTimer = nil
    end
end