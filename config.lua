Config = {}

Config.Locale = 'de' -- de | en

Config.HelpNotify = {
    type = 'esx', -- 'esx' | 'custom'  (invalid/off falls back to esx)

    -- only used when type = 'custom'
    resource = 'soh_helpnotify',
    export   = 'showHelpNotification',
}

Config.Marker = {
    type         = 21,                              -- marker type
    size         = vector3(0.5, 0.5, 0.5),          -- width, depth, height
    color        = { r = 0, g = 139, b = 0, a = 150 }, -- color + transparency
    drawDist     = 30.0,                            -- distance (meters) at which the marker is rendered
    interactDist = 2.0,                             -- distance at which the help text and [E] interaction appear
}

Config.EinzahlPunkte = {
    { Name = 'LADOT', job = 'mechanic', coords = vector3(-329.8092, -155.9496, 39.0152) },
    -- { Name = 'Police',    job = 'police',    coords = vector3(441.5, -981.8, 30.7) },
    -- { Name = 'EMS',       job = 'ambulance', coords = vector3(-246.4, -338.3, 38.0) },
}
