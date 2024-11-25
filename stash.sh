#!/bin/bash

# Ensure the script stops on error
set -e

# Verify the current directory is a Git repository
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "Error: This script must be run inside a Git repository."
    exit 1
fi

# Create 50 stashes
for i in {1..50}; do
    filename="file_$i.txt"
    stash_message="stash $i"

    # Create or overwrite the file
    echo "This is file $i for $stash_message" > "$filename"

    # Stage the file
    git add "$filename"

    # Create a stash with a message
    git stash push -m "$stash_message"

    # Clean up the working directory
    git clean -f
done

echo "Successfully created 50 stashes."
