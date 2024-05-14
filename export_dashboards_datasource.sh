#!/usr/bin/env bash
# source: https://gist.github.com/crisidev/bd52bdcc7f029be2f295?permalink_comment_id=4197302#gistcomment-4197302

# SOURCE VARIABLES
#export token=xxxxx#admin token
export FULLURL=http://user:1234@localhost:3001


#!/bin/bash

set -o errexit
set -o pipefail
# set -x

rm -rf backups
mkdir backups

headers=""
in_path=dashboards_raw
set -o nounset

echo "Exporting Grafana dashboards from $FULLURL"
mkdir -p $in_path
for dash in $(curl -H "$headers" -s "$FULLURL/api/search?query=&" | jq -r '.[] | select(.type == "dash-db") | .uid'); do
        curl -H "$headers" -s "$FULLURL/api/search?query=&" 1>/dev/null
        dash_path="$in_path/$dash.json"
        curl -H "$headers" -s "$FULLURL/api/dashboards/uid/$dash" | jq -r . > $dash_path 
        jq -r .dashboard $dash_path > $in_path/dashboard.json 
        title=$(jq -r .dashboard.title $dash_path)
        folder="$(jq -r '.meta.folderTitle' $dash_path)"
        mkdir -p backups/"$folder"
        mv -f $in_path/dashboard.json backups/"$folder/${title}.json"
       echo "exported backups/$folder/${title}.json"
       
done
rm -r $in_path

# FIXME: datasources
# datasources=$(curl -s -X GET $grafanaurl/datasources)
# for uid in $(echo $datasources | jq -r '.[] | .uid'); do
#   uid="${uid/$'\r'/}" # remove the trailing '/r'
#   curl -s -X GET "$grafanaurl/datasources/uid/$uid" | jq > grafana-datasource-$uid.json
#   slug=$(cat grafana-datasource-$uid.json | jq -r '.name')
#   mv grafana-datasource-$uid.json grafana-datasource-$uid-$slug.json # rename with datasource name and id
#   echo "Datasource $uid exported"
# done

# https://www.ifconfig.it/hugo/2021/12/backup-grafana-dashboards-with-api-and-jq/
# https://gist.github.com/crisidev/bd52bdcc7f029be2f295