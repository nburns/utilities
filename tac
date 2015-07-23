#!/usr/bin/env fish
if [ (which gtac) ]
    gtac $argv
else if [ (which tac) ]
    tac $argv
else
    sed 'x;1!H;$!d;x'
end
