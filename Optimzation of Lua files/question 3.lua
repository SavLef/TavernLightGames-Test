-- This function removes a player from their party based on the player's ID.
-- It checks if the player is in a party, and then removes them from the party.
function removePlayerFromParty(targetPlayerID)
    -- Attempt to find the player based on the provided ID.
    local targetPlayer = Player(targetPlayerID)
    
    -- Check if the player exists.
    if targetPlayer then
        -- Get the party of the target player.
        local party = targetPlayer:getParty()
        
        -- Check if the target player is in a party.
        if party then
            -- Remove the target player from the party.
            party:removeMember(targetPlayer)
            print("Player " .. targetPlayer:getName() .. " removed from their party.")
        else
            print("Player " .. targetPlayer:getName() .. " is not in a party.")
        end
    else
        print("Player not found.")
    end
end
