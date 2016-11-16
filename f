#!/usr/bin/env fish
if set -q argv
    set file (fzf -i -q $argv)
else
    set file (fzf -i)
end

if [ -n "$file" ]
    echo $file
    open $file
end
