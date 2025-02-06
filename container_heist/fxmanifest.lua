fx_version 'cerulean'
games { 'gta5' }

lua54 'yes'

shared_script {
    'config.lua',
    '@ox_lib/init.lua',
    '@es_extended/imports.lua'
}

server_script {
    'server.lua'
}

client_script {
    'client.lua'
}

dependencies {
    'ox_target',
    'ox_lib'
}
