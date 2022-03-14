#! /bin/bash
DEVCONTAINER_FILE_PATH="$1/.devcontainer/devcontainer.json"
if ! test -f $DEVCONTAINER_FILE_PATH; then
  echo "No devcontainer.json found"
  exit 1
fi

DEVCONTAINER_JSON=$(any-json --input-format=json5 --output-format=json $DEVCONTAINER_FILE_PATH)
TOOLCHAIN_NAME=$(echo $DEVCONTAINER_JSON | jq -r ".name" | tr '[:upper:]' '[:lower:]')
BASE_IMAGE=$( echo $DEVCONTAINER_JSON |  jq -r ".image")
IFS="|" read image_name image_tag <<< $(echo $BASE_IMAGE | sed 's:.*/::' | tr ":" "|")
WORKING_DIR="/workspace/$(basename $(readlink -f $1))"

if ! podman image exists localhost/toolchain/$image_name:$image_tag
then
  echo "New image available, rebuilding"
  podman build --build-arg BASE=$BASE_IMAGE --build-arg GIT_USER="$(git config user.name)" --build-arg GIT_MAIL=$(git config user.email) -t toolchain/$image_name:$image_tag $(dirname $0)
  podman stop $TOOLCHAIN_NAME
  podman container rm $TOOLCHAIN_NAME
fi

if ! podman container exists $TOOLCHAIN_NAME
then
  echo "Creating new container"
  podman run -dit --secret git_credentials --name=$TOOLCHAIN_NAME -v$1:$WORKING_DIR --mount type=bind,source=$(readlink -f ~/.zsh_history),target=/root/.zsh_history localhost/toolchain/$image_name:$image_tag zsh
fi
podman start $TOOLCHAIN_NAME && podman exec -it -w $WORKING_DIR $TOOLCHAIN_NAME zsh

