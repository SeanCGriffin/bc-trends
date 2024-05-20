# bc-trends
BurstCube telemetry trending dashboard. 

## Prerequisites
- Docker (for docker compose)
- A reference database, placed in the repositoy's root directory.

## Starting the Dashboard
- Set the environment variable `export BURSTCUBE_DATASOURCE=NAME_OF_YOUR_DATASOURCE` . For the time being, this must be a file co-located in `$REPO`. 
- Navigate to `$REPO` and execute `docker compose up`. 
- Go to `http://localhost:3001`, username `user` password `1234`.
- Open the BurstCube sandbox dashboard, you should see some empty plots. Play with the specified date range until you get to where you're doing.

## Provisioning New Dashboards
Exact procedure for this TBD but in a nutshell, copy the JSON for the dashboard to a file in `$REPODIR/grafana/dashboards`. 
You will need to change the `uid` field in any exported dashboard to `null` to allow Grafana to import it properly on refresh. 
Note: The file structure here will be copied within Grafana, so you we can separate different dashboards by type, but this only works for **top level folders** 
(i.e. nested folders do not nest). 
