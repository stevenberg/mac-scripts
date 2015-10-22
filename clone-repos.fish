#!/usr/bin/env fish

set repofile $argv[1]
set repodir $argv[2]

mkdir -p $repodir
cd $repodir
for repo in (cat $repofile)
    if test -e (basename $repo .git)
        continue
    end
    set_color --bold green
    echo "cloning $repo"
    for line in (git clone $repo ^&1)
        set_color --bold green
        echo -n ' |  '
        set_color normal
        echo $line
    end
    echo
end
