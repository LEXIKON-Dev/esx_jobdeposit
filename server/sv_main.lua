local ESX = exports['es_extended']:getSharedObject()
local MAX_AMOUNT = 10000000

local function formatMoney(n)
    local s = tostring(math.floor(n))
    return s:reverse():gsub('(%d%d%d)', '%1.'):reverse():gsub('^%.', '')
end

local function getIcName(xPlayer)
    local first = xPlayer.get('firstName') or ''
    local last = xPlayer.get('lastName') or ''
    local name = (first .. ' ' .. last):match('^%s*(.-)%s*$')

    if name == '' then
        name = xPlayer.getName()
    end

    return name
end

RegisterNetEvent('esx_jobdeposit:deposit', function(jobName, punktName, amount)
    local src = source

    if type(jobName) ~= 'string' or jobName == '' then return end
    if type(punktName) ~= 'string' or punktName == '' then return end
    if type(amount) ~= 'number' or amount <= 0 or amount > MAX_AMOUNT then
        TriggerClientEvent('esx_jobdeposit:notify', src, _U('invalid_betrag'))
        return
    end

    amount = math.floor(amount)

    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end

    if xPlayer.getMoney() < amount then
        TriggerClientEvent('esx_jobdeposit:notify', src, _U('not_enough_money', formatMoney(amount)))
        return
    end

    local icName = getIcName(xPlayer)
    xPlayer.removeMoney(amount)

    TriggerClientEvent('esx_jobdeposit:notify', src, _U('deposit_success', formatMoney(amount), punktName))

    local jobMsg = _U('job_notification', icName, formatMoney(amount), punktName)

    for _, playerId in ipairs(ESX.GetPlayers()) do
        if playerId ~= src then
            local other = ESX.GetPlayerFromId(playerId)
            if other and other.job and other.job.name == jobName then
                TriggerClientEvent('esx_jobdeposit:notify', playerId, jobMsg)
            end
        end
    end

    print(_U('log_deposit', icName, src, amount, jobName, punktName, xPlayer.getMoney()))
end)
