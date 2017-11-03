#/usr/bin/env bash
# -----------------------------------
# 05.11.2007 Author: osalvador for HaciendoTI haciendoti@gmail.com
# -----------------------------------
# Shell script beautifier
#
# The basic premise:
# The script syntax must be correct.
#
# All statements in source script must be on a new line, NOT VALID conditions such as:
# if [ ]; then 	        # Wrong
# 	sentences
# fi
#
# Should be:
# if [ ]                # Correct
# then
# 	sentences
# fi
#
# No use reserved words as variables, such
# if = "Hello world"    # Incorrect
# else = "Ho My God!"   # Incorrect
# then = 25             # Incorrect
#
# Instead if you shou ld use capitalization but is not recomended
# IF = "Hello world"    # Correct
# ELSE = "Ho My God!"   # Correct
# THEN = 25             # Correct
# ----------------------------------
# Input parameters
# $1 = Path of the script you want formatted
# $2 = Path of formatted output file
# $3 = Number of spaces you want to apply to tab
# ----------------------------------

FILENAME="$1"
FILEFORMATTED="$2"
N_SPACES="$3"

# Default out file
FILEFORMATTED=${FILEFORMATTED:-"${FILENAME}_beauty"}

# clear the destination file
: > $FILEFORMATTED

# Default number of spaces
N_SPACES=${N_SPACES:-4}

PADDER=""

for i in $(seq 1 $N_SPACES); do
	PADDER="${PADDER} "
done

if_counter=0

LINE_NUMBER=$(cat $1 | wc -l)
ACTUAL_LINE=1

while read -r line; do

	# Remove all spaces and tabs on the left
	linea=$(echo "$line" | sed 's/^[	 ]*//')

	# Take the first 4 characters
	current_statment=$(echo "$linea" | cut -c 1-4)

	# Just for fi's, 3 characters and trim blank space
	is_fi=$(echo "$current_statment" | cut -c 1-3 | tr -d ' ')

	# If it is a condition close
	if [ "$is_fi" = "fi"  -o "$current_statment" = "else" -o "$current_statment" = "esac" -o "$current_statment" = "done" -o "$current_statment" = "elif" ]; then	
		if_counter=$(( $if_counter - 1 ))
	  #echo "FI = $if_counter $current_statment "
	fi

	# Tabulates the code
	i=0
	while [ $i -lt $if_counter ]; do
		linea=$(echo "${PADDER}${linea}")
		i=$(( $i + 1 ))
	done

	#Just for do's, 3 characters and Trim balnk space
	is_do=$(echo "$current_statment" | cut -c 1-3 | tr -d ' ')

	# If it is a condition open
	if [ "$current_statment" = "else" -o "$current_statment" = "case" -o "$current_statment" = "then" -o "$is_do" = "do" ]; then
		if_counter=$(( $if_counter + 1 ))
		#echo "IF =$if_counter $current_statment "
	fi

	#Save the formatted line into file
	echo "$linea" >> "$FILEFORMATTED"
	
	#Progress bar
	percent=$(( $ACTUAL_LINE * 100 ))
	percent=$(( $percent / $LINE_NUMBER ))
	echo -ne $percent "% completed" "\r"
	ACTUAL_LINE=$(( $ACTUAL_LINE + 1 ))
	
done <"$FILENAME"
echo
exit 0
