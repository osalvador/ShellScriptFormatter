#!/bin/bash
 
MENU="
1   Date and Time
2   Calendar for current month
3   quit
"
 
while true
do
clear
echo "$MENU"
echo -n "Please make your choice: "
read INPUT # Read user input and assign it to variable INPUT
 
case $INPUT in
1)
date
echo press ENTER to continue
read
;;
2)
cal
echo press ENTER to continue
read
;;
3|q|Q) # If user presses 3, q or Q we terminate
break
;;
*) # All other user input results in an usage message
clear
echo Please choose alternatves 1, 2 or 3
sleep 2
;;
esac
done


BEGIN=1 # Start counting here
END=10 # Stop counting here
 
END=`expr $END + 1`
 
while [ $END -ne $BEGIN ]
do # While END is not equal to BEGIN do ...
echo This is iteration $BEGIN
BEGIN=`expr $BEGIN + 1` # Increasing the value of BEGIN by one
done

# Defining Variable
STAFF="Anders Bertil Cesar Denise Emilia Filippa"
 
echo First LOOP
for PERSON in $STAFF
do
echo $PERSON is a member of the staff.
done
 
echo Second LOOP
echo -n "The staff members are: "
for PERSON in $STAFF
do
echo -n "$PERSON " # -n instructs echo not to print the trailing newline char
done
echo


VALIDUSER="Thorsten"
 
if [ $VALIDUSER = anders ]
then
echo $VALIDUSER is a valid user  
elif [ $VALIDUSER = bertil ]
then
echo $VALIDUSER is a valid user 
elif [ $VALIDUSER = Thorsten ]
then
echo $VALIDUSER is a valid user  
else
  																																																echo no valid user found
fi #end of condition


START=1 # The value to begin with
END=10  # When this value is reached we are done
SPEED=1 # Number of seconds between each iteration
while [ $START -le $END ]
do
echo this is iteration $START of $END
START=`expr $START + 1`
sleep $SPEED
done
