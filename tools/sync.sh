source tools/utils.sh

echo "$CHECK Generating sync patch..."
git diff --staged > tools/sync.patch

echo "$CHECK Pushing branch to remote..."
git push

init

echo "$CHECK Pulling branch from remote on server..."
docker exec fedora /bin/ssh gabarito@localhost -p10022 'cd piranha && git pull'

echo "$CHECK Sending sync patch to remote server..."
docker exec fedora /bin/scp -P10022 /mnt/piranha/tools/sync.patch gabarito@localhost:~/piranha/sync.patch

echo "$CHECK Applying patch on remote server..."
docker exec fedora /bin/ssh gabarito@localhost -p10022 'cd piranha && git stash && git apply sync.patch || true'

# Sync extra files if option is passed
if [ "$1" = "--files" ]; then
    # Files to sync after everything
    declare -a FILES=(
        "./files/KAGGLE/test_data"
        "./files/KAGGLE/test_labels"
    )

    # Sync these files
    for file in ${FILES[@]}; do
        echo "$CHECK Syncing $file to remote server..."
        
        local_checksum=$(shasum $file | awk '{print $1}')
        remote_checksum=$(docker exec fedora /bin/ssh gabarito@localhost -p10022 "shasum ~/piranha/$file | awk '{print \$1}'")

        if [ "$local_checksum" != "$remote_checksum" ]; then
            # Create folder
            filedir=$(dirname $file)
            docker exec fedora /bin/ssh gabarito@localhost -p10022 "mkdir -p ~/piranha/$filedir"

            # Upload
            docker exec fedora /bin/scp -P10022 /mnt/piranha/$file gabarito@localhost:~/piranha/$file
        fi
    done
fi