# bc-trends
BurstCube telemetry trending dashboard. 

## Prerequisites
- Docker (for docker compose)
- A reference database, placed in the repositoy's root directory.

## Starting the Dashboard
- Set the environment variable `export BURSTCUBE_DATASOURCE=NAME_OF_YOUR_DATASOURCE.db`. Note that you are pointing to the **file** not the directory.  
- Navigate to `$REPO` and execute `docker compose up`. 
- Go to `http://localhost:3001`, username `user` password `1234`.
- Open up one of the dashboards, you should see some empty plots. Play with the specified date range until you get to something sensible.
- On almost any graph, you can double-click to zoom out, and click+drag to zoom into a specified window. 

## Provisioning New Dashboards

**NOTE:** Dashboards are only semi-persistant. 
Namely, they are persistent within the grafana docker volume, but need to be manually exported via `export_dashboards_datasource.sh` which will put all dashboards in a `backups` directory. 
Grab the new dashboard, edit the JSON to change the `uid` of the dashboard to `null`. 

Example tail of a dashboard JSON:
```
  "timepicker": {},
  "timezone": "browser",
  "title": "Instrument Things",
  "uid": "cdkf9zfpo2nlsd",
  "version": 5,
  "weekStart": ""
}
```
becomes
```
  "timepicker": {},
  "timezone": "browser",
  "title": "Instrument Things",
  "uid": null,
  "version": 5,
  "weekStart": ""
}
```

Once you have made this change, copy the dashboard to `grafana/dashboards/<subdirectory>` and refresh your grafana window. 
The new dashboard is now provisioned within grafana, and may be committed to Git. 
