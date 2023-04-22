source tools/utils.sh

init

echo "$CHECK Starting remote shell session..."
docker exec -it fedora /bin/ssh -t gabarito@localhost -p10022 'cd ~/piranha ; /bin/fish'