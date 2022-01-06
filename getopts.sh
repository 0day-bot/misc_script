#!/bin/bash
#getopts example

function usage {
  echo "Usage: $(basename $0) [-abcd]" 2>&1
  echo '    -a  shows a in the output'
  echo '    -b  shows b in the output'
  echo '    -c  shows c in the output'
  echo '    -d  shows d in the output'
  exit 1
}

if [[ ${#} -eq 0 ]]; then
  usage
fi

optstring="m::abcd"

while getopts ${optstring} arg; do
  case "${arg}" in
    a) echo "Option a was called" ;;
    b) echo "Option b was called" ;;
    c) echo "Option c was called" ;;
    d) echo "Option d was called" ;;
    m) echo "Option m is $OPTARG" ;;

    ?)
      echo "Invalid option: -${OPTARG}"
      echo
      usage
      ;;
  esac
done

#Debug Output
echo "ALL args: ${@}"
echo "1st arg: $1"
echo "2nd arg: $2"
echo "3rd arg: $3"
echo "4th arg: $4"

#Inspect Option Index
echo "OPTIND: $OPTIND"

#getopts "n:" OPTION
#NUMBER=$OPTARG

#echo "The Number is $NUMBER"
