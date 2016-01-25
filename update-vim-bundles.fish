#!/usr/bin/env fish

function indent
    while read line
        if test "$line" = "Already up-to-date."
            return
        end
        set_color --bold green
        echo -n ' | '
        set_color normal
        echo $line
    end
    echo
end

for repo in $HOME/.vim/bundle/*
    set_color --bold green
    echo (basename $repo)
    cd $repo
    set_color normal
    git pull ^&1 | indent
end

set_color --bold green
echo 'updating helptags'
vim +Helptags +q
