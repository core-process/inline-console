#!/bin/bash
set -e

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$ROOT_DIR"

ENABLE_PUBLISH=false
ENABLE_PUBLISH_BUMP="patch"
ENABLE_PUBLISH_VERSION="unknown"
ENABLE_REBUILD=false

for i in "$@"
do
  case $i in
    -r|--rebuild)
      ENABLE_REBUILD=true
    ;;
    -p|--publish)
      ENABLE_PUBLISH=true
      ENABLE_REBUILD=true
    ;;
    -p=*|--publish=*)
      ENABLE_PUBLISH=true
      ENABLE_PUBLISH_BUMP="${i#*=}"
      ENABLE_REBUILD=true
    ;;
    *)
    ;;
  esac
done

if [ "$ENABLE_PUBLISH" = true ]; then
  ENABLE_PUBLISH_VERSION=$(npm version "$ENABLE_PUBLISH_BUMP")
fi

if [ "$ENABLE_REBUILD" = true ]; then
  rm -r -f node_modules build
  npm install
fi

npm run build

if [ "$ENABLE_PUBLISH" = true ]; then
  npm publish
fi

echo "Done!"
