source tools/utils.sh

echo "$CHECK Generating sync patch..."
git diff --staged > tools/sync.patch

echo "$CHECK Pushing branch to remote..."
git push

init

echo "$CHECK Pulling branch from remote on server..."
docker exec fedora /bin/ssh gabarito@localhost -p10022 'cd piranha && git pull'

echo "$CHECK Sending sync patch to remote server..."
docker exec fedora /bin/scp -P10022 /mnt/Mestrado/Pesquisa/piranha/tools/sync.patch gabarito@localhost:~/piranha/sync.patch

echo "$CHECK Applying patch on remote server..."
docker exec fedora /bin/ssh gabarito@localhost -p10022 'cd piranha && git stash && git apply sync.patch'