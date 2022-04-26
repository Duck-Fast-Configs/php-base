#!/bin/bash

# Extra vars
## There should be no '/' at the end
dfc_project_main_folder="../../../.."

# Header of script
. $dfc_project_main_folder/Scripts/Dependencies/dfc-script-header.sh

# General process
message_info "$(date '+%H:%M:%S (%m/%d/%y)')" 2
message_space 2

message_input "Варианты проекта:\n"
message_input "1. Начать новый 'стандартный' проект\n"
message_input "2. Скачать проект с помощью git (только https)\n"
message_input "3. Проектом поделился другой человек\n"
message_input "4. Пропустить выбор варианта проекта\n"
message_input "=> "
read -p '' dfc_project_input_choice
message_space 1

case $dfc_project_input_choice in
"1")
    message_info "Ожидайте..." 1
    docker-compose -p $dfc_global__project_name exec -u dfc-user dfc-host-php zsh -c "rm -rf *" >&1
    docker-compose -p $dfc_global__project_name exec -u dfc-user dfc-host-php zsh -c "rm -rf .*" >&1
    docker-compose -p $dfc_global__project_name exec -u dfc-user dfc-host-php zsh -c "echo \"<?php \necho 'Hello world';\" > main.php" >&1
    ;;
"2")
    message_input "Вставьте ссылку на проект из git (только https)\n"
    message_input "=> "
    read -p '' dfc_project_url
    message_info "Ожидайте..." 1

    docker-compose -p $dfc_global__project_name exec -u dfc-user dfc-host-php zsh -c "rm -rf *" >&1
    docker-compose -p $dfc_global__project_name exec -u dfc-user dfc-host-php zsh -c "rm -rf .*" >&1
    docker-compose -p $dfc_global__project_name exec -u dfc-user dfc-host-php zsh -c "git clone ${dfc_project_url} ." >&1
    ;;
"3")
    . $dfc_project_main_folder/Scripts/Dependencies/dfc-message-exit.sh >&3
    ;;
"4")
    . $dfc_project_main_folder/Scripts/Dependencies/dfc-message-exit.sh >&3
    ;;
esac

message_info "В контейнере 'dfc-host-php' целевые файлы проекта изменены" 1

# End of script
. $dfc_project_main_folder/Scripts/Dependencies/dfc-script-footer.sh
