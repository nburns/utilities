#!/usr/bin/env fish
set LOCKFILE ~/sync.lock
set COMMAND 'rsync -hav --stats --fuzzy feral:/media/689d/swimmernick/private/transmission/data/ /mnt/data/seedbox'

function log
    echo (date):$argv
end

log started
if flock --exclusive --nonblock "$LOCKFILE" --command "$COMMAND"
    log finished
else
    log "exiting, running in other instance"
end
