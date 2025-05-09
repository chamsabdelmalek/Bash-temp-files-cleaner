#!/bin/bash

usage() {
    echo "Usage: $0 [--dry-run] <directory>"
    echo "--dry-run  : Shows files to be deleted without deleting them"
    exit 1
}

if [ $# -lt 1 ]; then
    usage
fi

DRY_RUN=false
if [ "$1" == "--dry-run" ]; then
    DRY_RUN=true
    shift  
    if [ -z "$1" ]; then
        usage  
    fi
fi

DIRECTORY="$1"


if [ ! -d "$DIRECTORY" ]; then
    echo "Error: Directory '$DIRECTORY' does not exist"
    exit 1
fi

EXTENSIONS=("*.tmp" "*.log" "*.bak")


clean_directory() {
    for ext in "${EXTENSIONS[@]}"; do
    
        for file in "$DIRECTORY"/$ext; do
        
            if [ -e "$file" ]; then
                if $DRY_RUN; then
                    echo "File found to be deleted : $file"
                else
                    echo "Deleting $file"
                    rm "$file"
                fi
            fi
        done
    done
}

clean_directory
