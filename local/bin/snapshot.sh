#!/bin/bash

# Установить пути к директориям для снимков и GIF
output_dir="/home/toma/Pictures/snapshots"
gif_output="/home/toma/Desktop/output.gif"

# Создать директорию для снимков, если она не существует
mkdir -p $output_dir

# Счетчик снимков
i=1

# Функция, которая создаст GIF и удалит снимки при остановке скрипта
cleanup() {
    echo "Создание GIF..."
    convert -delay 10 -loop 0 $output_dir/snapshot_*.jpg "$gif_output"

    echo "Удаление снимков..."
    rm $output_dir/snapshot_*.jpg

    echo "Скрипт завершен. GIF сохранен в $gif_output"
    exit 0
}

# Поймать сигнал завершения (например, Ctrl+C) и вызвать функцию cleanup
trap cleanup SIGINT

# Запуск бесконечного цикла
while true; do
    # Сохранить снимок без баннера
    fswebcam -r 640x480 --no-banner "$output_dir/snapshot_$i.jpg"

    # Получить текущее время и дату
    current_time=$(date +"%H:%M:%S")
    current_date=$(date +"%Y-%m-%d")

    # Добавить время и дату на изображение с помощью ImageMagick: время сверху, дата снизу
    convert "$output_dir/snapshot_$i.jpg" \
        -pointsize 24 -fill white -gravity SouthWest \
        -annotate +10+40 "$current_time" \
        -annotate +10+10 "$current_date" \
        "$output_dir/snapshot_$i.jpg"

    # Увеличить счетчик снимков
    i=$((i + 1))

    # Задержка в 10 секунд перед следующим снимком
    sleep 10
done

