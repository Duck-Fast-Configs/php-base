#!/bin/bash

# Extra vars
## There should be no '/' at the end
dfc_project_main_folder="."

# Header of script
. $dfc_project_main_folder/Scripts/Dependencies/dfc-script-header.sh

# General process
message_info "$(date '+%H:%M:%S (%d/%m/%Y)')" 2
message_space 2

docker stop $(docker ps -a -q)
message_info "Все контейнеры всех dfc-проектов остановлены" 2
docker-compose -p $dfc_global__project_name start >&1
message_info "Все контейнеры текущего dfc-проекта запущены" 2
(cd $dfc_project_main_folder/Scripts/Containers/dfc-host-php/Firewall/Unblock && sh dfc-all.sh -d1) >&3
(cd $dfc_project_main_folder/Scripts/Containers/dfc-host-php/Firewall/Transfer && sh dfc-import.sh -d1) >&3
(cd $dfc_project_main_folder/Scripts/Containers/dfc-host-php/Firewall/Block && sh dfc-insecure.sh -d1) >&3
(cd $dfc_project_main_folder/Scripts/Containers/dfc-host-php/Services/Start && sh dfc-crond.sh -d1) >&3
message_info "Для запуска определенного процесса в проекте используйте файл 'dfc-run.sh'" 2
message_space 2

message_info "Контейнеры dfc-проекта запущены" 1

# End of script
. $dfc_project_main_folder/Scripts/Dependencies/dfc-script-footer.sh
