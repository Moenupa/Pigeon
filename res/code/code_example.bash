#!/bin/bash
echo "Foss Linux"
echo -n "I am a Linux User"
echo -e "\nGood \t Bye \t All"

#!/bin/bash
: '
This script calculates
sum of 2 and 8.
'
((sum=2+8))
# result will be 
echo "sum is $sum"

#!/bin/bash

website=www.fosslinux.com
year=2020

# Getting user name from special variables
name=$USER

echo "Welcome to $website"
echo -e "Hello $name \n"
echo -e "Year = $year \n"
echo "Running on $HOSTNAME"

#!/bin/bash
echo "Total arguments : $#"
echo "Username: $1"
echo "Age: $2"
echo "Full Name: $3"

#!/bin/bash
i=0

while [ $i -le 4 ]
do
  echo Number: $i
  ((i++))
done

#!/bin/bash

echo -n "Enter a number: "
read VAR

if [[ $VAR -gt 10 ]]
then
  echo "The variable is greater than 10."
fi

#!/bin/bash
function Sum()
{
  echo -n "Enter First Number: "
  read a
  echo -n "Enter Second Number: "
  read b
  echo "Sum is: $(( a+b ))"
}

#!/bin/bash

echo -e "\n$(date "+%d-%m-%Y --- %T") --- Starting work\n"

apt-get update
apt-get -y upgrade

apt-get -y autoremove
apt-get autoclean

echo -e "\n$(date "+%T") \t Script Terminated"