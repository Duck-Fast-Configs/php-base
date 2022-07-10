#!/bin/bash

# Extra vars
## There should be no '/' at the end 
dfc_project_main_folder="../../../../../../.."

# Header of script
. $dfc_project_main_folder/Scripts/Dependencies/dfc-script-header.sh

# General process
message_info "$(date '+%H:%M:%S (%m/%d/%y)')" 2
message_space 2

docker-compose -p $dfc_global__project_name exec -u root dfc-host-php ash -c "mkdir /var/log/php7" >&1
docker-compose -p $dfc_global__project_name exec -u root dfc-host-php ash -c "apk add php7-fpm --repository=https://dl-cdn.alpinelinux.org/alpine/v3.15/community" >&1

(cd $dfc_project_main_folder/Scripts/Containers/dfc-host-php/Services/Enable && sh dfc-php-fpm.sh -d1) >&3

message_info "В контейнере 'dfc-host-php' установлен пакет 'php7-fpm' и готов к работе" 1

# End of script
. $dfc_project_main_folder/Scripts/Dependencies/dfc-script-footer.sh
