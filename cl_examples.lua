--[[
########################################################################################################################
#                                                                                                                      #
#                                                   client/audio.lua                                                   #
#                                                                                                                      #
########################################################################################################################
]]
RegisterCommand("PlayPedAmbientSpeech", function()
    local ped = PlayerPedId()
    local soundRef = "0083_U_M_O_BlWGeneralStoreOwner_01"
    local soundName = "TAKE_YOUR_TIME"
    local speechParams = 291934926
    local speechLine = 0

    local retval = exports.redm_natives:PlayPedAmbientSpeech(ped, soundRef, soundName, speechParams, speechLine)
    if (retval) then
        print("PlayPedAmbientSpeech")
    else
        print("Failed to PlayPedAmbientSpeech")
    end
end)

RegisterCommand("PlayAmbientSpeechFromPosition", function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local soundRef = "0083_U_M_O_BlWGeneralStoreOwner_01"
    local soundName = "TAKE_YOUR_TIME"
    local speechParams = 291934926
    local speechLine = 0

    local retval = exports.redm_natives:PlayAmbientSpeechFromPosition(coords.x, coords.y, coords.z, soundRef, soundName, speechParams, speechLine)
    if (retval) then
        print("PlayAmbientSpeechFromPosition")
    else
        print("Failed to PlayAmbientSpeechFromPosition")
    end
end)

--[[
########################################################################################################################
#                                                                                                                      #
#                                                   client/inventory.lua                                               #
#                                                                                                                      #
########################################################################################################################
]]
RegisterCommand("InventoryGetInventoryItemInspectionInfo", function()
    local retval, model = exports.redm_natives:InventoryGetInventoryItemInspectionInfo(-780677328)
    if (retval) then
        print("InventoryGetInventoryItemInspectionInfo", model)
    else
        print("Failed to InventoryGetInventoryItemInspectionInfo")
    end
end)

--[[
########################################################################################################################
#                                                                                                                      #
#                                                 client/itemdatabase.lua                                              #
#                                                                                                                      #
########################################################################################################################
]]
RegisterCommand("ItemdatabaseFilloutItemInfo", function()
    local retval, category, group = exports.redm_natives:ItemdatabaseFilloutItemInfo(-780677328)
    if (retval) then
        print("ItemdatabaseFilloutItemInfo", category, group)
    else
        print("Failed to ItemdatabaseFilloutItemInfo")
    end
end)

RegisterCommand("ItemdatabaseFilloutItemEffectIds", function()
    local retval, effectIds = exports.redm_natives:ItemdatabaseFilloutItemEffectIds(`WEAPON_REVOLVER_CATTLEMAN`)
    if (retval) then
        if (#effectIds > 0) then
            print("ItemdatabaseFilloutItemEffectIds")
            for i, effectId in ipairs(effectIds) do
                print(effectId)
            end
        else
            print("No effect ids found")
        end
    else
        print("Failed to ItemdatabaseFilloutItemEffectIds")
    end
end)

RegisterCommand("ItemdatabaseFilloutItemEffectIdInfo", function()
    local retval, effectIds = exports.redm_natives:ItemdatabaseFilloutItemEffectIds(`WEAPON_REVOLVER_CATTLEMAN`)
    if (not retval) or (#effectIds == 0) then return end

    local retval, id, type, value, time, timeUnits, corePercent, durationcategory = exports.redm_natives:ItemdatabaseFilloutItemEffectIdInfo(effectIds[1])
    if (retval) then
        print("ItemdatabaseFilloutItemEffectIdInfo", id, type, value, time, timeUnits, corePercent, durationcategory)
    else
        print("Failed to ItemdatabaseFilloutItemEffectIdInfo")
    end
end)

---@todo Implement ItemdatabaseGetHasSlotInfo
RegisterCommand("ItemdatabaseGetHasSlotInfo", function()
    local retval, category = exports.redm_natives:ItemdatabaseFilloutItemInfo(856287005)
    if (not retval) then print("Failed to ItemdatabaseFilloutItemInfo") return end
    
    local retval, hasSlot = exports.redm_natives:ItemdatabaseGetHasSlotInfo(category, 0)
    if (retval) then
        print("ItemdatabaseGetHasSlotInfo", hasSlot)
    else
        print("Failed to ItemdatabaseGetHasSlotInfo")
    end
end)

---@todo Implement ItemdatabaseFilloutItem
RegisterCommand("ItemdatabaseFilloutItem", function()
    local retval, a = exports.redm_natives:ItemdatabaseFilloutItem(-1814149473, `COST_ABILITY_CARD_RANK_COUPON`, 0)
    if (retval) then
        print("ItemdatabaseFilloutItem", a)
    else
        print("Failed to ItemdatabaseFilloutItem")
    end
end)

---@todo Implement ItemdatabaseFilloutAcquireCost
RegisterCommand("ItemdatabaseFilloutAcquireCost", function()
    local retval, unk1, unk2 = exports.redm_natives:ItemdatabaseFilloutAcquireCost(unk1, unk2)
    if (retval) then
        print("ItemdatabaseFilloutAcquireCost", a, b)
    else
        print("Failed to ItemdatabaseFilloutAcquireCost")
    end
end)

---@todo Implement ItemdatabaseFilloutTagData
RegisterCommand("ItemdatabaseFilloutTagData", function()
    local retval, tagData = exports.redm_natives:ItemdatabaseFilloutTagData(-780677328)
    if (retval) then
        print("ItemdatabaseFilloutTagData", tagData)
    else
        print("Failed to ItemdatabaseFilloutTagData")
    end
end)

--[[
########################################################################################################################
#                                                                                                                      #
#                                                   client/task.lua                                                   #
#                                                                                                                      #
########################################################################################################################
]]
RegisterCommand("GetScenarioPointsInArea", function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local retval, scenarioPoints = exports.redm_natives:GetScenarioPointsInArea(playerCoords.x, playerCoords.y, playerCoords.z, 3.0, 10)
    if (retval) then
        for i, scenarioPoint in ipairs(scenarioPoints) do
            print("ScenarioPoint", scenarioPoint)
        end
    else
        print("No scenario points found")
    end
end)

--[[
########################################################################################################################
#                                                                                                                      #
#                                                   client/uievents.lua                                                #
#                                                                                                                      #
########################################################################################################################
]]
RegisterCommand("EventsUiPeekMessage", function()
    local uiapp = `PLAYER_MENU`
    LaunchUiappByHashWithEntry(uiapp, `MP`)

    Citizen.CreateThread(function()
        while IsUiappRunningByHash(uiapp) == 1 do
            Citizen.Wait(0)
            while EventsUiIsPending(uiapp) do
                local retval, eventTypeHash, index, unk, entryId = exports.redm_natives:EventsUiPeekMessage(uiapp)
                if (retval) then
                    print("EventsUiPeekMessage", eventTypeHash, index, unk, entryId)
                else
                    print("Failed to EventsUiPeekMessage")
                end
                EventsUiPopMessage(uiapp)
            end
        end
    end)

    Wait(5000)

    CloseAllUiapps()
end)

RegisterCommand("GetTrainTrackInfos", function()
    local train = GetVehiclePedIsIn(PlayerPedId(), false)
    local retval, trackHash, trackJunction = exports.redm_natives:GetTrainTrackInfos(train)
    if (retval) then
        print("GetTrainTrackInfos", trackHash, trackJunction)
    else
        print("Failed to GetTrainTrackInfos")
    end
end)

RegisterCommand("redtest", function()
    local playerId = PlayerId()
    local playerPed = PlayerPedId()
    local statemachine = -1468895189
    local weapon = `WEAPON_RIFLE_BOLTACTION` --`WEAPON_REVOLVER_CATTLEMAN`

    if (UiStateMachineExists(statemachine) == 1) then
        UiStateMachineDestroy(statemachine)
    end

    local rootContainer = DatabindingAddDataContainerFromPath("", "DynamicCatalogItems")
    local itemInspectionContainer = DatabindingAddDataContainer(rootContainer, "CatalogItemInspection")

    local effectsEntryId = Citizen.InvokeNative(0x9D21B185ABC2DBC4, itemInspectionContainer, "effects", false, false)
	local statsEntryId = Citizen.InvokeNative(0x9D21B185ABC2DBC5, itemInspectionContainer, "stats", 0, playerId)
	local compareStatsEntryId = Citizen.InvokeNative(0x9D21B185ABC2DBC5, itemInspectionContainer, "compareStats", 0, playerId)

    Citizen.InvokeNative(0x75CFAC49301E134F, effectsEntryId, true, false)
    Citizen.InvokeNative(0x75CFAC49301E134E, statsEntryId, true, playerPed)
    Citizen.InvokeNative(0x75CFAC49301E134E, compareStatsEntryId, weapon, playerPed)

    print(effects, stats, compareStats)

    local flowblock = RequestFlowBlock(`shop_browsing_main_flow`)
    repeat Wait(0) until UiflowblockIsLoaded(flowblock) == 1

    UiflowblockEnter(flowblock, `catalog_weapon_inspection`)
    UiStateMachineCreate(statemachine, flowblock)
end)