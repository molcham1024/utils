#!/bin/bash

# usage
# ./nginx_access_log_to_csv.sh input_file output_file

if [ -z "$2" ] || [ -n "$3" ]; then
    echo 'Error: Enter 2 arguments "input_file","output_file".'
    echo 'Usage: ./nginx_access_log_to_csv.sh {input_file} {output_file}'
    exit
fi

INPUT_FILE="$1"
OUTPUT_FILE="$2"

if [ ! -e "$INPUT_FILE" ]; then
    echo "Error: \"$INPUT_FILE\" doesn't exists."
    exit
fi

if [ -e "$OUTPUT_FILE" ]; then
    read -p "The file named \"$OUTPUT_FILE\" already exists. Do you want to overwrite it? [y/n]: " yn

    case "$yn" in
        [Nn])
            echo 'Abort.'
            exit
            ;;
    esac

fi

echo '"IP/Host","remote_log","remote_user","date","method","request (without parameters)","parameters","http_version","status","body_bytes_sent","referer","user_agent","x_forwarded_for"' > $OUTPUT_FILE

perl -pe 's/^(.*?) (.*?) (.*?) \[(.*?)\] "(.*?) (.*?)(\?.*?)? (.*?)" (.*?) (.*?) "(.*?)" "(.*?)" "(.*?)"$/"$1","$2","$3","$4","$5","$6","$7","$8","$9","$10","$11","$12","$13"/' $INPUT_FILE >> $OUTPUT_FILE
