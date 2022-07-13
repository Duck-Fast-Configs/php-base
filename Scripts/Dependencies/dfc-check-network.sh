#!/bin/bash

if [ "'$(ping -c 1 google.com)'" == "''" ]
then
    message_info "Отсутствует подключение к интернету" 1;
    message_info "Без него разворачинвание dfc-проекта невоможна" 1;
    message_info "Процесс остановлен" 1;
    exit 1;
fi
