#!/bin/bash

create_directory() {
    local dir_path=$1

    # Determine the type of item (file or directory)
    local item_exists
    item_exists=-d

    # Check if the item already exists
    if [ $item_exists "$dir_path" ]; then
        echo "The directory already exists: $dir_path"
    else
        mkdir -p "$dir_path" && echo "Directory created successfully: $dir_path" || echo "Failed to create directory: $item_path"
    fi
}