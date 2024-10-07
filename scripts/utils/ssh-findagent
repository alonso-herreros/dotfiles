#/usr/bin/env sh

function findagent {
  if ssh-add -l; then
    echo "Your SSH Agent is already working."
    return 0
  fi
  for sock in `ls /tmp/ssh-*/agent.*`; do
    export SSH_AUTH_SOCK=$sock
    if ssh-add -l; then
      echo "Your SSH Agent is fixed. New socket=$sock."
      return 0
    fi
  done
  echo "Could not find any working SSH Agent sockets."
  return 1
};

findagent

