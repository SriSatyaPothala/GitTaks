#!/bin/bash

#give the file path
FILE_PATH="/home/ec2-user/textfiles/file1.txt"


#replacing all occurences of give with learning where there is welcome word but from 5th line
#using sed welcome/I keeps the line that has no welcome word in the final output unline grep
{ head -n 4 "$FILE_PATH" ;tail -n +5 "$FILE_PATH" | sed '/welcome/I s/\bgive/\blearning/g'; } > tempoutput.txt
mv tempoutput.txt "$FILE_PATH"

echo "Substitution Successfull"


#SubstitutionScriptOp.png has the output

