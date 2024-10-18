---Return scenario points in the area.
---@param x number
---@param y number
---@param z number
---@param radius number
---@param size number
---@return boolean, ?table
function GetScenarioPointsInArea(x, y, z, radius, size)
    local DataStruct = DataView.ArrayBuffer(size*8 + 8)
    if (Citizen.InvokeNative(0x345EC3B7EBDE1CB5, x, y, z, radius, DataStruct:Buffer(), size)) then
        local scenarioPoints = {}
        for i=1, size do
            local scenarioPoint = DataStruct:GetInt32(i*8)
            if (DoesScenarioPointExist(scenarioPoint)) then
                table.insert(scenarioPoints, scenarioPoint)
            end
        end
        return true, scenarioPoints
    end

    return false
end

---Loads the carryable config hash [@outsider]
---@param carryConfigHash number
function LoadCarriableConfigHash(carryConfigHash)
    Citizen.InvokeNative(0xFF745B0346E19E2C, carryConfigHash)
end

---Checks if the carryable config hash has been loaded [@outsider]
---@param carryConfigHash number
---@return boolean
function HasCarriableConfigHashLoaded(carryConfigHash)
    return Citizen.InvokeNative(0xB8F52A3F84A7CC59, carryConfigHash)
end