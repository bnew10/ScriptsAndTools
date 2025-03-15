#!/usr/bin/env bash

# first time usage of "aws" cli tool requires user to run "aws configure"

echo 'Copying plex config, "Preferences.xml"'
aws s3 cp /mnt/Seagate/plex-config/Library/Application\ Support/Plex\ Media\ Server/Preferences.xml s3://bnew10-storage/plex-config/

echo 'Copying sabnzbd config, "sabnzbd.ini"'
aws s3 cp /mnt/Seagate/sabnzbd-config/sabnzbd.ini s3://bnew10-storage/sabnzbd-config/

echo 'Syncing servarr dirs'
aws s3 rm s3://bnew10-storage/sonarr-config
aws s3 sync /mnt/Seagate/sonarr-config s3://bnew10-storage/sonarr-config
aws s3 rm s3://bnew10-storage/radarr-config
aws s3 sync /mnt/Seagate/radarr-config s3://bnew10-storage/radarr-config
