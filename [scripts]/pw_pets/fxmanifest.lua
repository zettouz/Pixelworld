fx_version 'adamant'
games {'gta5'} -- 'gta5' for GTAv / 'rdr3' for Red Dead 2, 'gta5','rdr3' for both

description 'PixelWorld Pets'
name 'PixelWorld pw_pets'
author 'PixelWorldRP [creaKtive] - https://pixelworldrp.com'
version 'v1.0.0'

client_scripts {
    'client/main.lua',
    'config/main.lua'
}

server_scripts {
    '@pw_mysql/lib/MySQL.lua',
    'server/wrappers/pets.lua',
    'server/main.lua',
    'config/main.lua'
}

ui_page 'html/index.html'

files {
    'html/style.css',
    'html/index.html',
    'html/pw_pets.js',
    'html/scripting/jquery-ui.css',
    'html/scripting/external/jquery/jquery.js',
    'html/scripting/jquery-ui.js',
}

dependencies {
    'pw_mysql',
    'pw_notify',
    'pw_progbar',
    'pw_menu',
    'pw_base'
}