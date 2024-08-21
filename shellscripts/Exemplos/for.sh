#!/bin/bash
for f in *.txt; do
    if [ ! -f $f ]; then
        continue
    fi
    echo "Text File: $f"
done
