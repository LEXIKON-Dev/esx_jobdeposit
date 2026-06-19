local menuOpen = false
local helpShown = false

local function getHelpMode()
    local mode = Config.HelpNotify and Config.HelpNotify.type

    if mode == 'custom' then
        return 'custom'
    end

    return 'esx'
end

local function hideHelp()
    if not helpShown then
        return
    end

    if getHelpMode() == 'esx' then
        if ESX.HideUI then
            ESX.HideUI()
        elseif exports.es_extended and exports.es_extended.HideUI then
            exports['es_extended']:HideUI()
        end
    end

    helpShown = false
end

local function showHelp(text)
    local mode = getHelpMode()

    if mode == 'esx' then
        local msg = ('[E] %s'):format(text)

        if ESX.TextUI then
            ESX.TextUI(msg)
        elseif exports.es_extended and exports.es_extended.TextUI then
            exports['es_extended']:TextUI(msg)
        elseif ESX.ShowHelpNotification then
            ESX.ShowHelpNotification(('~INPUT_CONTEXT~ %s'):format(text))
        end

        helpShown = true
        return
    end

    local cfg = Config.HelpNotify

    if cfg.resource and cfg.export and GetResourceState(cfg.resource) == 'started' then
        exports[cfg.resource][cfg.export](text)
    end
end

local function openDepositMenu(punkt)
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'deposit_' .. punkt.job, {
        title = _U('menu_title', punkt.Name),
    }, function(data, menu)
        local amount = tonumber(data.value)

        if not amount or amount <= 0 or math.floor(amount) ~= amount then
            ESX.ShowNotification(_U('invalid_amount'))
            menu.close()
            menuOpen = false
            return
        end

        menu.close()
        menuOpen = false
        TriggerServerEvent('esx_jobdeposit:deposit', punkt.job, punkt.Name, math.floor(amount))
    end, function(data, menu)
        menu.close()
        menuOpen = false
    end)
end

CreateThread(function()
    local inRange = false

    while true do
        local wait = 1000
        local pos = GetEntityCoords(PlayerPedId())
        local nearInteract = false

        for _, punkt in ipairs(Config.EinzahlPunkte) do
            local dist = #(pos - punkt.coords)

            if dist < Config.Marker.drawDist then
                wait = 0
                local c = Config.Marker.color
                DrawMarker(
                    Config.Marker.type,
                    punkt.coords.x, punkt.coords.y, punkt.coords.z,
                    0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                    Config.Marker.size.x, Config.Marker.size.y, Config.Marker.size.z,
                    c.r, c.g, c.b, c.a,
                    false, true, 2, false, nil, nil, false
                )
            end

            if dist < Config.Marker.interactDist then
                nearInteract = true
                showHelp(_U('help_deposit', punkt.Name))

                if IsControlJustPressed(0, 38) and not menuOpen then
                    menuOpen = true
                    openDepositMenu(punkt)
                end
            end
        end

        if inRange and not nearInteract then
            hideHelp()
        end

        inRange = nearInteract
        Wait(wait)
    end
end)

RegisterNetEvent('esx_jobdeposit:notify', function(msg)
    ESX.ShowNotification(msg)
end)
