fx_version 'cerulean'
game 'gta5'

version '0.1'
description 'Money Wash'
author 'Lutubecome'

lua54 'yes'
use_experimental_fxv2_oal 'yes'

client_script 'client.lua'

server_script 'server.lua'

dependencies {

    'ox_lib',
    
}

shared_scripts {

    '@ox_lib/init.lua',

}