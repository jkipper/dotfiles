set toplevel (git rev-parse --show-toplevel)
if test $status -ne 0 
  return $status
end

set projectname (string split -- "/" $toplevel)[-1]
if test (uname) = "Darwin"
  set container_engine "docker"
else
  set container_engine "podman"
end

function start -a "image"
  set -l build_dir "$toplevel/../build"
  $container_engine run -d -v$toplevel:$toplevel -v$build_dir:$build_dir -w$PWD --name=$projectname $image tail -f /dev/null
end


function clangd
  docker exec -i "$projectname" -w$PWD clangd "$argv"
end


function deactivate 
  functions -e clangd
end
