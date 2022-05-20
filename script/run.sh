#!/bin/bash

crontab script/crontab.txt
crontab -l

sbatch script/start.sh