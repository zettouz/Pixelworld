fx_version 'adamant'
games {'gta5'}

description 'PixelWorld Bomb Defusal'
name 'PixelWorld: pw_bombdefuse'
author 'PixelWorldRP'
version 'v1.0.0'

client_script('client/client.lua')

ui_page('client/html/index.html')

files({
    'client/html/index.html',
    'client/html/script.js',
    'client/html/style.css',
    'client/html/cursor.png'
})

dependencies {
    'pw_mysql',
    'pw_notify',
    'pw_progbar',
    'pw_menu',
    'pw_base'
}