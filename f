#!/usr/bin/env fish

if which batcat
    set bat batcat
else
    set bat bat
end

set preview $bat' --color=always --theme=GitHub --style=numbers --line-range=:100 {}'

if [ -n "$argv" ]
    set file (fzf -i -q --preview $preview $argv)
else
    set file (fzf -i --preview $preview )
end

if [ -n "$file" ]
    echo $file
    open $file
end
