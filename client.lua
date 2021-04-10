local anims = json.decode(LoadResourceFile(GetCurrentResourceName(), "anims.json"))

---Gets a table containing all the keys from the table passed
-- @tparam table tbl The table to get the keys from
-- @returns list the list of keys obtained from tbl
local function getKeyList(tbl)
   local list = {}
   for i, _ in pairs(anims) do
       table.insert(list, i)
   end
   return list
end

SendNUIMessage({
    type = 'dictList',
    data = getKeyList(anims)
})

---Send the animations that are part of this dict to the UI when requested
RegisterNUICallback('loadAnim', function(data, cb)
    SendNUIMessage({
        type = 'animList',
        data = anims[data.dict]
    })
    cb('ok')
end)

---Play an animation selected in the UI
RegisterNUICallback('playAnim', function(data, cb)
    RequestAnimDict(data.dict)
    while not HasAnimDictLoaded(data.dict) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), data.dict, data.anim, 8.0, 8.0, -1, 0, 1.0, false, false, false)
    cb('ok')
end)

---Close the UI and return focus
RegisterNUICallback('closeUI', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

---Command to open the menu
RegisterCommand("menu", function(src, args)
    print("trying to open the menu")
    --Open the menu
    SendNUIMessage({
        type = 'enable'
    })
    SetNuiFocus(true, true)
end)