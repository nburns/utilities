#!/usr/bin/env fish
set fish_trace 1 2

set LOCKFILE ~/.youtube.lock
set COMMAND "cd /mnt/media/youtube;\
/home/nick/.local/bin/yt-dlp\
    --add-metadata\
    --embed-thumbnail\
    --xattrs\
    --postprocessor-args \"-metadata summary=%(url)s\"\
    --cookies ./cookies.txt\
    -f 'bestvideo[vcodec!*=av01][height<=?1080]+bestaudio[acodec!*=opus]'\
    --merge-output-format mkv\
    'https://www.youtube.com/playlist?list=WL' -o '%(uploader)s-%(title)s.%(ext)s';\
/home/nick/.local/bin/yt-dlp --print-json --flat-playlist --cookies cookies.txt\
    'https://www.youtube.com/playlist?list=WL' | jq -c 'with_entries(select([.key] | inside (["url", "title"])))' >> youtube.log;"

function log
    echo (date):$argv | tee -a ~/Desktop/youtube.log
end

log started
if flock --exclusive --nonblock "$LOCKFILE" --command "$COMMAND" 2>&1 | tee ~/Desktop/youtube.log
    log finished
else
    log "exiting, running in other instance"
end
