#!/bin/bash -x

if [ "$1" = 'bitbucket' ]; then
  exec /opt/atlassian-bitbucket/atlassian-bitbucket/bin/start-bitbucket.sh --no-search -fg
else
  exec "$@"
fi
