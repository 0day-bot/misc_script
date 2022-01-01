#!/bin/bash
#getopts example


getopts "n:" OPTION
NUMBER=$OPTARG

echo "The Number is $NUMBER"
