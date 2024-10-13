#!/bin/bash

# Установить пути к директориям для снимков и GIF
output_dir="/home/toma/Pictures/snapshots"
gif_output="/home/toma/Desktop/output.gif"

# Создать директорию для снимков, если она не существует
mkdir -p $output_dir

# Счетчик снимков
i=1
# Счетчик частей GIF
part=1
# Максимум снимков до создания части GIF
max_snapshots=50

# Функция, которая создаст части GIF и объединит их по завершении скрипта
cleanup() {
    echo "Создание частей GIF..."

    # Проверка, есть ли накопленные снимки
    if ls $output_dir/snapshot_*.jpg 1> /dev/null 2>&1; then
        # Объединить снимки в части GIF по группам max_snapshots
        while ls $output_dir/snapshot_*.jpg 1> /dev/null 2>&1; do
            echo "Создание части GIF part_$part.gif..."
            # Берем первые max_snapshots снимков и создаем часть GIF
            convert -delay 10 -loop 0 $(ls $output_dir/snapshot_*.jpg | head -n $max_snapshots) "$output_dir/part_$part.gif"
            rm $(ls $output_dir/snapshot_*.jpg | head -n $max_snapshots)
            part=$((part + 1))
        done
    fi

    echo "Объединение всех частей в один GIF..."
    convert -delay 10 -loop 0 $output_dir/part_*.gif "$gif_output"

    echo "Удаление частей GIF..."
    rm $output_dir/part_*.gif

    echo "Скрипт завершен. Итоговый GIF сохранен в $gif_output"
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

    # Задержка в 30 секунд перед следующим снимком
    sleep 30
done



