CHECK=$(echo "[\033[0;32m✓\033[0m]")

function startFedora(){
    echo "$CHECK Starting local docker..."
    docker start fedora
}

function startRedir(){
    echo "$CHECK Starting local redir server..."
    docker exec fedora /bin/sh start-server.sh
}

function init(){
    startFedora
    startRedir
}