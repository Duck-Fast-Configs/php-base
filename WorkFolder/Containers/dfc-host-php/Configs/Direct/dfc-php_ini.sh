#!/bin/bash

# Extra vars
## There should be no '/' at the end 
dfc_project_main_folder="../../../../.."

# Header of script
. $dfc_project_main_folder/Scripts/Dependencies/dfc-script-header.sh

# General process
message_info "$(date '+%H:%M:%S (%m/%d/%y)')" 2
message_space 2

message_info "В контейнере 'dfc-host-php' инициируется открытие файла 'php.ini'" 1

message_space 1
message_input "Нажмите на ENTER чтобы подтвердить вход\n"
message_input "=> "
read -p '' >&3

docker-compose -p $dfc_global__project_name exec -u root dfc-host-php ash -c "nano /etc/php81/php.ini" >&3

message_space 1
message_info "В контейнере 'dfc-host-php' осуществлен вывод информации из php" 1
message_space 1
docker-compose -p $dfc_global__project_name exec -u root dfc-host-php ash -c "php81 -i" >&3

# End of script
. $dfc_project_main_folder/Scripts/Dependencies/dfc-script-footer.sh
