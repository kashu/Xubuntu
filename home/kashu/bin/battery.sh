#!/bin/bash
#Author: kashu
#My Website: https://kashu.org
#Date: 2016-01-06
#Filename: battery.sh
#Description: Get the state of my battery

#cat /sys/class/power_supply/BAT1/uevent
_path=/sys/class/power_supply/BAT1/
cd $_path

_status(){
echo "Model_Name: `tr ' ' '_' < model_name`"
echo "Status: `cat status`"
echo "Capacity: `cat capacity`%"
echo "Energy_Full_Desigh: $((`cat energy_full_design`/1000))mAh"
echo "Energy_Full: $((`cat energy_full`/1000))mAh"
echo "Energy_Now: $((`cat energy_now`/1000))mAh"
}
_status | column -t
