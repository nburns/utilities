#!/usr/bin/env fish
if [ (which gtac) ]
    gtac $argv
else
    sed 'x;1!H;$!d;x'
end
