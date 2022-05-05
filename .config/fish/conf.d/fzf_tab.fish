bind \ec 'fuzzy_complete'


function _complete -a command
  commandline --current-token --replace -- (string unescape -- $command)
  commandline -f end-of-line
end

function fuzzy_complete
    if test (complete -C | count) -eq 0;
    commandline -f end-of-line
    fish_prompt
      return 0
    else
    echo "OUTEr"
      set command_to_complete (complete -C | sort -u | fzf --height 40% --multi --reverse -q (commandline -t) | string split -f1 \t)
      cancel
      _complete $command_to_complete
    end
end
