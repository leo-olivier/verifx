#!/bin/sh

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

exec env \
    DYLD_LIBRARY_PATH="$SCRIPT_DIR${DYLD_LIBRARY_PATH:+:$DYLD_LIBRARY_PATH}" \
    sbt "-J-Djava.library.path=$SCRIPT_DIR" "runMain org.verifx.ProofRunner"