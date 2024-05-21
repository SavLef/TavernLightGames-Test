-- This function prints the names of guilds that have less than a specified number of members.
function printSmallGuildNames(memberCount)
    -- Construct the SQL query to select guild names based on the maximum member count
    local selectGuildQuery = string.format("SELECT name FROM guilds WHERE max_members < %d;", memberCount)
    
    -- Attempt to execute the query and retrieve the result
    local resultId = db.storeQuery(selectGuildQuery)
    
    -- Check if the query was successful and there are results
    if resultId then
        -- Iterate over each row in the result set
        repeat
            -- Fetch the name of the guild from the current row
            local guildName = result.getString(resultId, "name")
            
            -- Print the name of the guild
            print(guildName)
            
        -- Continue fetching rows until there are no more
        until not result.next(resultId)
        
        -- Free the result set
        result.free(resultId)
    else
        -- If the query was unsuccessful, print an error message
        print("Error: Unable to fetch guild names from the database.")
    end
end