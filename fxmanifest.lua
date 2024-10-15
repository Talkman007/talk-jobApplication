fx_version 'cerulean'
game 'gta5'

author 'YourName'
description 'Job Application Script using ox_lib and QBCore'
version '1.0.0'

-- Resource name
name 'talk-jobApplication'

-- Required Dependencies
dependencies {
    'qb-core',      -- Ensure qb-core is installed
    'ox_lib',       -- Ensure ox_lib is installed
    'oxmysql'       -- For database operations (if needed)
}

-- Shared Script
shared_script 'config.lua'

-- Client Scripts
client_scripts {
    '@ox_lib/init.lua',
    'client/main.lua'
}

-- Server Scripts
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

-- Lua 5.4 support
lua54 'yes'
