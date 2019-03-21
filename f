#!/usr/bin/env fish

#set -x FZF_DEFAULT_COMMAND "find . -not -name '*.git*' -and -not -name '*.DS_Store'"

if [ -n "$argv" ]
    set file (fzf -i -q $argv)
else
    set file (fzf -i)
end

if [ -n "$file" ]
    echo $file
    open $file
end
