#!/usr/bin/env bash
# source: https://gist.github.com/crisidev/bd52bdcc7f029be2f295?permalink_comment_id=4197302#gistcomment-4197302

# SOURCE VARIABLES
#export token=xxxxx#admin token
export grafanaurl=http://admin:admin@localhost:3000/api


rm -rf backups
mkdir -p backups
cd backups



datasources=$(curl -s -X GET $grafanaurl/datasources)
for uid in $(echo $datasources | jq -r '.[] | .uid'); do
  uid="${uid/$'\r'/}" # remove the trailing '/r'
  curl -s -X GET "$grafanaurl/datasources/uid/$uid" | jq > grafana-datasource-$uid.json
  slug=$(cat grafana-datasource-$uid.json | jq -r '.name')
  mv grafana-datasource-$uid.json grafana-datasource-$uid-$slug.json # rename with datasource name and id
  echo "Datasource $uid exported"
done



dashboards=$(curl -s -X GET $grafanaurl/search?folderIds=0&query=&starred=false)
for uid in $(echo $dashboards | jq -r '.[] | .uid'); do
  uid="${uid/$'\r'/}" # remove the trailing '/r'
  curl -s -X GET "$grafanaurl/dashboards/uid/$uid" | jq > grafana-dashboard-$uid.json
  slug=$(cat grafana-dashboard-$uid.json | jq -r '.meta.slug')
  mv grafana-dashboard-$uid.json grafana-dashboard-$uid-$slug.json # rename with dashboard name and id
  echo "Dashboard $uid exported"
done



# https://www.ifconfig.it/hugo/2021/12/backup-grafana-dashboards-with-api-and-jq/
# https://gist.github.com/crisidev/bd52bdcc7f029be2f295