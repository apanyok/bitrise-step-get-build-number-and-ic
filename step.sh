#!/bin/bash
set -ex
# set -o pipefail

if [[ ! -f $pubspec_path ]]
then
    echo "No pubspec file found at path: ${pubspec_path}"
    exit 1
fi

VERSION=`awk '/^version:/ {print $2}' ${pubspec_path}`

IFS='+'
read -a split <<< "${VERSION}"

# echo "PUBSPEC_VERSION: ${VERSION}"
# echo "PUBSPEC_VERSION_NAME: ${split[0]}"
# echo "PUBSPEC_BUILD_NUMBER: ${split[1]}"

#
# --- Export Environment Variables for other Steps:
# You can export Environment Variables for other Steps with
#  envman, which is automatically installed by `bitrise setup`.
# A very simple example:
envman add --key PUBSPEC_BUILD_NUMBER --value "${split[1] + 1}"
# Envman can handle piped inputs, which is useful if the text you want to
# share is complex and you don't want to deal with proper bash escaping:
#  cat file_with_complex_input | envman add --KEY EXAMPLE_STEP_OUTPUT
# You can find more usage examples on envman's GitHub page
#  at: https://github.com/bitrise-io/envman

#
# --- Exit codes:
# The exit code of your Step is very important. If you return
#  with a 0 exit code `bitrise` will register your Step as "successful".
# Any non zero exit code will be registered as "failed" by `bitrise`.
exit 0
