---Attach an entity to coordinates physically [@sarbatore]
---@param entity number
---@param x number
---@param y number
---@param z number
---@param p4 number
---@param p5 number
---@param p6 number
---@param p7 number
---@param p8 boolean
---@param p9 number
---@param p10 number
---@param p11 number
---@param p12 number
---@param p13 number
---@param p14 number
function AttachEntityToCoordsPhysically(entity, x, y, z, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14)
    return Citizen.InvokeNative(0x715012E3A63023C0, entity, x, y, z, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14)
end