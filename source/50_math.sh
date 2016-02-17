#!/usr/bin/env bash


# Convert Currencies: takes "10 usd eur"
curc() {   
	wget -qO- "http://www.google.com/finance/converter?a=$1&from=$2&to=$3&hl=es" | grep currency_converter_result | sed -e :a -e 's/<[^>]*>//g;/</N;//ba'
}


# Simple calculator
function calc() {
	local result="";
	result="$(printf "scale=10;$*\n" | bc --mathlib | tr -d '\\\n')";
	#                       └─ default (when `--mathlib` is used) is 20
	#
	if [[ "$result" == *.* ]]; then
		# improve the output for decimal numbers
		printf "$result" |
		sed -e 's/^\./0./'        `# add "0" for cases like ".5"` \
		    -e 's/^-\./-0./'      `# add "0" for cases like "-.5"`\
		    -e 's/0*$//;s/\.$//';  # remove trailing zeros
	else
		printf "$result";
	fi;
	printf "\n";
}