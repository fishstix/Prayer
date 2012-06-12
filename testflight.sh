#!/bin/bash

if [ $# -eq 0 ]
	then
	echo "use -help for usage."
	exit
fi
if [ $1 = "-help" ]
	then
	echo "Expects a single argument with the path to the desired .ipa to uplaod to TestFlight"
	exit
fi

read -p "Notes: " notes
read -p "Notify [True/False]:" notify
read -p "Distribution Lists [everyone/me]:" dist 

echo "File Location: $1";
echo "Notes: $notes";
echo "Notify: $notify";

api="cbe4c8104493b9b86712ee9ab9903cdf_MTYyOTMyMjAxMS0wOS0yMSAxOToxNToyNy45NjY5Mzg"
team="a4edf705be15644d54155657e239888b_OTgxMjcyMDEyLTA2LTA4IDE0OjQyOjA3LjMyMjA2OQ"

# Curl that sucka
curl http://testflightapp.com/api/builds.json -F file=@"$1" -F api_token="$api" -F team_token="$team" -F notes="$notes" -F notify=$notify -F distribution_lists="$dist"
