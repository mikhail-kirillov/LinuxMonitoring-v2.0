#!/bin/bash

site="https://www.my-coolest-site.com"

function get_ip() {
    echo $((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256))
}

function get_response_code() {
    response_codes=(
        "200" # OK - Запрос успешно выполнен. Значение результата «успех» зависит от метода HTTP
        "201" # Created - Запрос выполнен успешно, и в результате был создан новый ресурс. Обычно это ответ, отправляемый на запросы POST или PUT
        "400" # Bad Request - Сервер не может или не будет обрабатывать запрос из-за чего-то, что воспринимается как ошибка клиента
        "401" # Unauthorized - Хотя стандарт HTTP определяет этот ответ как «неавторизованный», семантически он означает «неаутентифицированный». \
              # Это значит, что клиент должен аутентифицировать себя, чтобы получить запрошенный ответ
        "403" # Forbidden - Клиент не имеет прав доступа к контенту, то есть он неавторизован, поэтому сервер отказывается предоставить запрошенный \
              # ресурс. В отличие от 401 Unauthorized, личность клиента известна серверу
        "404" # Not Found - Сервер не может найти запрошенный ресурс
        "500" # Internal Server Error - На сервере произошла ошибка, в результате которой он не может успешно обработать запрос
        "501" # Not Implemented - Метод запроса не поддерживается сервером и поэтому он не может быть обработан. \
              # Методы GET и HEAD должны всегда поддерживаться сервером и для них не должен возвращаться этот код
        "502" # Bad Gateway - Такой ответ может прислать сервер, который выступает в качестве шлюза, если в процессе обработки запроса он получил \
              # недопустимый ответ от целевого сервера
        "503" # Service Unavailable - Сервер не готов обработать запрос в данный момент. Распространёнными причинами являются техническое обслуживание \
              # или перегрузка сервера
    )

    echo ${response_codes[RANDOM % ${#response_codes[@]}]}
}

function get_method() {
    methods=("GET" "POST" "PUT" "PATCH" "DELETE")
    echo ${methods[RANDOM % ${#methods[@]}]}
}

function get_date() {
    day_counter=$1
    echo "[$(date -d "+$day_counter day" '+%d/%b/%Y:%H:%M:%S %z')]"
}

function get_url_request() {
    echo "$site/page-$((RANDOM))-$((RANDOM)).html"
}

function get_agent() {
    agents=("Mozilla" "Google Chrome" "Opera" "Safari" "Internet Explorer" "Microsoft Edge" "Crawler and bot" "Library and net tool")
    echo ${agents[RANDOM % ${#agents[@]}]}
}

function generate_log_string() {
    input_day_counter=$1
    ip=$(get_ip)
    date=$(get_date $input_day_counter)
    method=$(get_method)
    url=$(get_url_request)
    request_first_line=${url##$site}
    request_url=${url:0:$(expr length $site)}
    status_code=$(get_response_code)
    agent=$(get_agent)
    echo "$ip - - $date \"$method $request_first_line HTTP/1.1\" $status_code - \"$request_url\" \"$agent\""
}

function generate_log_for_day() {
    day_counter=$1
    log_file="logs/day$(($day_counter + 1)).log"
    touch $log_file
    for (( j=0; j<$(shuf -i 100-1000 -n 1); j++ ))
    do
        generate_log_string $day_counter >> $log_file
    done
}

if [[ $# -eq 0 ]]
then
	mkdir logs 2>/dev/null
    for (( i=0; i<5; i++ ))
    do
        generate_log_for_day $i
    done
else
    echo "No parameters needed!"
fi
