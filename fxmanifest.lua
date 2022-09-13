fx_version 'cerulean'
game 'gta5'

description 'qb-dispatch'
version '1.0.0'

ui_page 'html/index.html'

client_scripts {
    'client/main.lua'
}
shared_scripts{
    'config.lua'
}
server_scripts {
    'server/main.lua'
}

files {'html/*'}
