#!/bin/bash

check_dir () {
    # Recursivly check for Cargo.toml starting at the given directory.
    # Then run cargo clean on any directories found containing Cargo.toml.
    if [[ -f $1"Cargo.toml" ]]; then
        echo "Cleaning" $1 "..."
        cargo clean --target-dir $1"target/" --manifest-path $1"Cargo.toml"
    else
        for dir in $1*/; do
            # Make sure that $dir does not end in */ or target/
            if [ ${dir: -2} != "*/" ] && [ ${dir: -8} != "/target/" ]; then
                echo "Checking" $dir
                check_dir $dir
            fi
        done
    fi
}

check_dir $1
echo "Done"
