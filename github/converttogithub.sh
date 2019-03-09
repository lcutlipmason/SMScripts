#!/bin/bash
# iterate over folders and migrate them all to github, add one team a base description and X number of topics.
ORG=ORGNAME
TOPICS='"1TOPICTOADD", "2TOPICTOADD"'
DESCRIPTION='"DESCRIPTIONTOADD"'
TEAM='"NAMEOFUSERGROUP"'

GITUSER=USERNAME
GITPASS=PWD

function convert {
	for i in $1; do
	    
		echo "$i"
		git -C "$(cut -d'.' -f1 <<<"$i")".git remote remove origin
		git -C "$(cut -d'.' -f1 <<<"$i")".git remote add origin git@github.com:$ORG/$(basename "${i%.*}").git
		curl -k -u "$GITUSER:$GITPASS" https://api.github.com/orgs/$ORG/repos -d '{"name":"'$(basename "${i%.*}")'", "description":"Department of State Mexico Project", "private": true, "has_issues": true, "has_projects": true, "has_wiki":false}'
		git -C "$(cut -d'.' -f1 <<<"$i")".git push --all origin
		git -C "$(cut -d'.' -f1 <<<"$i")".git push --tags origin
		echo $teamid
		echo curl -k -u "$GITUSER:$GITPASS" "https://api.github.com/orgs/$ORG/teams" | grep -A1 "\"name\": \"$TEAM\"" | grep '"id":' | sed 's/^ *"id": \(.*\),/\1/g'
		curl -k -u "$GITUSER:$GITPASS" -H "Accept:application/vnd.github.hellcat-preview+json" https://api.github.com/teams/$2/repos/$ORG/$(basename "${i%.*}") -d '{"permission":"pull"}' -X PUT
	   
	done
}

for f in *; do
    if [ -d "$f" ];then
	echo "$f"
	teamid=$(curl -s -u "$GITUSER:$GITPASS" "https://api.github.com/orgs/$ORG/teams" | jq '.[] | select(.name=='$TEAM') | .id')
	convert $f $teamid
    fi
done
