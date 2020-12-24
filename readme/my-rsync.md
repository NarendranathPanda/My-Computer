Ref: https://www.digitalocean.com/community/tutorials/how-to-use-rsync-to-sync-local-and-remote-directories-on-a-vps


SOURCE_DIR=/root/data/
REMOTE_USER=root
REMOTE_HOST=<ip>
REMOTE_DESTINATION_DIR=/root/data/

SOURCE=$SOURCE_DIR
DESTINATION=$REMOTE_USER@$REMOTE_HOST:$REMOTE_DESTINATION_DIR
OPTIONS=-aznvp

# -a Archive 
# -z Compressed
# -n Dryrun
# -v Verbose
# -p Progress

rsync $OPTIONS $SOURCE $DESTINATION
