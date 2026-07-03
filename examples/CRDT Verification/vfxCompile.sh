#!/bin/sh

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Based on: https://unix.stackexchange.com/questions/31414/how-can-i-pass-a-command-line-argument-into-a-shell-script

helpFunction()
{
   echo ""
   echo "Usage: $0 -l targetLanguage -o outputDir"
   echo -e "\t-l The target language for transpilation."
   echo -e "\t-o (Optional) The output directory for tanspiled files."
   exit 1 # Exit script after printing help
}

while getopts "l:o:" opt
do
   case "$opt" in
      l ) lang="$OPTARG" ;;
      o ) out="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

# Print helpFunction in case parameters are empty
if [ -z "$lang" ]
then
   echo "Target language is missing.";
   helpFunction
fi

# Begin script in case all parameters are correct
exec env \
   DYLD_LIBRARY_PATH="$SCRIPT_DIR${DYLD_LIBRARY_PATH:+:$DYLD_LIBRARY_PATH}" \
   sbt "-J-Djava.library.path=$SCRIPT_DIR" "runMain org.verifx.CompilerRunner $lang $out"