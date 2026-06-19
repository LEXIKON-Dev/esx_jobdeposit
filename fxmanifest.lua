fx_version 'cerulean'
game      'gta5'

name        'esx_jobdeposit'
description 'ESX Fraktions-Einzahlung an konfigurierbaren Punkten'
version     '1.0.0'
author      'LEXIKON'

shared_scripts {
    '@es_extended/imports.lua',
    'config.lua',
    'shared/locale.lua',
}

client_scripts {
    'client/cl_main.lua',
}

server_scripts {
    'server/sv_main.lua',
}

files {
    'locales/*.lua',
}

dependencies {
    'es_extended',
    'esx_menu_dialog',
}

lua54 'yes'
