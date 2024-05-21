-- This function releases a specific storage value associated with a player.
-- If the player exists, it resets the storage value to -1, effectively releasing it.
local function releaseStorage(player)
    -- Check if the player object exists
    if player then
        -- Reset the storage value to -1 to release it.
        player:setStorageValue(1000, -1)
    end
end

-- This event handler is triggered when a player logs out of the game.
-- It checks if the player exists and if their storage value for a specific task is set to 1.
-- If both conditions are met, it immediately releases the storage value to clean up resources.
function onLogout(player)
    -- Check if the player object exists and if their storage value is set to 1.
    if player and player:getStorageValue(1000) == 1 then
        -- Release the storage value associated with the task.
        releaseStorage(player)
    end
    -- Return true to allow the player to logout safely.
    return true
end
