#!/usr/bin/env fish
set fish_trace 1 2

set LOCKFILE ~/.youtube.lock
set COMMAND "cd /mnt/data/youtube; /home/nick/.local/bin/yt-dlp --cookies ./cookies.txt 'https://www.youtube.com/playlist?list=WL' -o '%(uploader)s-%(title)s-%(id)s.%(ext)s'"

function log
    echo (date):$argv >> ~/Desktop/youtube.log
end

log started
if flock --exclusive --nonblock "$LOCKFILE" --command "$COMMAND" >> ~/Desktop/youtube.log 2>&1
    log finished
else
    log "exiting, running in other instance"
end
