bind \ea 'fuzzy_complete'


function _complete -a command
  commandline --current-token --replace -- (string unescape -- $command)
  commandline -f end-of-line
end

function fuzzy_complete
    set -l completion (complete -C | string escape)
    set -l completion_count (count (string split0 -- $completion))
    echo $completion_count
    set command_to_complete (complete -C | sort -u | fzf --height 40% --multi --reverse -q (commandline -t) | string split -f1 \t)
    _complete $command_to_complete
end
