# Replace $2 with $3 in a directory ($1) for all .svg files excluding symlinks
replace() {
    for f in $(find "$1" -name '*.svg' -type f); do
        echo "$f"
        sed -i s/"$2"/"$3"/g $f
    done
}

replace $@
