client_script('client/client.lua')

server_script {
	'@pw_mysql/lib/MySQL.lua',
	"server/server.lua",
}

ui_page('client/html/index.html')

files({
    'client/html/index.html',
    'client/html/script.js',
    'client/html/style.css',
    'client/html/cursor.png'
})

fx_version 'adamant'
games { 'gta5' }