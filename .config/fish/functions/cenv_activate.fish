if test (uname) = "Darwin"
  set _cenv_engine "docker"
else if set -q TOOLBOX_PATH
  # toolbox does not have direct access to podman
  set _cenv_engine flatpak-spawn --host podman
else
  set _cenv_engine "podman"
end


function __cenv_activate -a image register mounts
  if test "$image" = ""
    echo "Must provide an image"
    return 1
  end
  
  # if set -q _cenv_active
  #   echo "Container environment already active"
  #   return 1
  # end

  set -g _cenv_toplevel (git rev-parse --show-toplevel)
  if test $status -ne 0 
    return $status
  end

  set -g _cenv_projectname (string split -- "/" $_cenv_toplevel)[-1]
  
  set -l build_dir (realpath -- $_cenv_toplevel/../build)
  set -l mount_args --volume=$_cenv_toplevel:$_cenv_toplevel --volume=$build_dir:$build_dir
  for mount in (string split " "  -- $mounts)
    if string match "*:*" -- $mount 
      set -a mount_args --volume=$mount
    else
      set -a mount_args --volume=$mount:$mount
    end
  end
  set -g _cenv_registered_executables (string split " " -- $register)
  if not command $_cenv_engine run -d $mount_args -w$_cenv_toplevel --name=$_cenv_projectname $image tail -f /dev/null 
    echo "Starting container failed"
    return 1
  end

  for executable in $_cenv_registered_executables
    function $executable --wraps $executable --inherit-variable executable 
      command $_cenv_engine exec -i $_cenv_projectname $executable $argv 
    end
    printf "Registered executable %s\n" $executable
  end

  set -g _cenv_active 0
  
  function cenv_enter
    command $_cenv_engine exec -it $_cenv_projectname bash
  end

  function cenv_run
    command $_cenv_engine exec -i $_cenv_projectname $argv
  end

  function deactivate 
    for func in $_cenv_registered_executables
      functions -e $func
      printf "Unregistered executable %s\n" $func
    end
    set -e _cenv_toplevel
    set -e _cenv_registered_executables
    set -e _cenv_active
    command $_cenv_engine rm -f $_cenv_projectname &>/dev/null &
    set -e _cenv_projectname
    functions -e deactivate
    functions -e cenv_enter
    functions -e cenv_run
  end
end

function cenv_activate
  set -f options h/help
  set -a options i/image=
  set -a options r/register=+
  set -a options m/mount=+
  argparse -name cenv $options -- $argv 
  or exit 1
  __cenv_activate "$_flag_i" "$_flag_r" "$_flag_m"
end

