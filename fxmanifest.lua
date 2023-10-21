fx_version 'cerulean'
game 'gta5'

author 'Lxr Dev'
description 'Script By Lxr Dev discord.gg/R9KgyCkXJp'
version '3.1.0'

shared_scripts {
    'config.lua'
}

client_scripts {
	'client/main.lua',
	'client/garage.lua',
	'client/menus.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/*.lua'
}
