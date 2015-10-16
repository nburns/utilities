#!/usr/bin/env fish

if set file (fzf)
    echo $file
    open $file
end
