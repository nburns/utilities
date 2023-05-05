#!/usr/bin/env fish

if which batcat > /dev/null
    set bat batcat
else
    set bat bat
end

set preview $bat' --color=always --theme=GitHub --style=numbers --line-range=:100 {}'

set file (fzf -i --preview $preview)

if [ -n "$file" ]
    echo $file
    open $file
end
