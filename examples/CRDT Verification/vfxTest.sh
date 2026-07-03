#!/bin/sh

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <test-name>"
    exit 1
fi

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
TEST_NAME="$1"
TEST_FILTER="$TEST_NAME should"

exec env \
    DYLD_LIBRARY_PATH="$SCRIPT_DIR${DYLD_LIBRARY_PATH:+:$DYLD_LIBRARY_PATH}" \
    sbt "-J-Djava.library.path=$SCRIPT_DIR" \
        "testOnly org.verifx.crdtproofs.ProofTests -- -z \"$TEST_FILTER\""