local strings = {}

local function loadStrings()
    local lang = Config.Locale or 'de'
    local file = LoadResourceFile(GetCurrentResourceName(), ('locales/%s.lua'):format(lang))

    if not file then
        print(('[esx_jobdeposit] Locale "%s" nicht gefunden, fallback auf de.'):format(lang))
        file = LoadResourceFile(GetCurrentResourceName(), 'locales/de.lua')
    end

    if file then
        local chunk = load(file, ('@locales/%s.lua'):format(lang))
        if chunk then
            strings = chunk() or {}
        end
    end
end

loadStrings()

function _U(key, ...)
    local str = strings[key]
    if not str then
        return key
    end

    if select('#', ...) > 0 then
        return string.format(str, ...)
    end

    return str
end
