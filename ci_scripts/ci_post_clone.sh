#!/bin/sh

script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
cd "$script_dir/.."

echo $FILE_FIREBASE | base64 -D > Multiplatform/GoogleService-Info.plist