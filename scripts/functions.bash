#!/usr/bin/env bash

# This file contains all the useful functions
# used to configure the SonarQube instance.

# Constants
if [ -z "$SONARQUBE_URL" ]
then
    SONARQUBE_URL="http://localhost:9000"
fi

# log
#
# This function logs a line.
# Log levels are: INFO, WARNING, ERROR
# INFO are logged on STDOUT.
# WARNING and ERROR are logged on STDERR.
#
# Parameters:
#   1: level of log
#   2: message to log
#   3: (optional) cause
#
# Example:
#   $ log $ERROR "Something went wrong" "a_faulty_function"
INFO="INFO"
WARNING="WARNING"
ERROR="ERROR"
log()
{
    msg="[$1] CNES LEQUAL SonarQube: $2"
    if [ -n "$3" ]
    then
        msg="$msg, caused by $3"
    fi
    if [ "$1" = "$INFO" ]
    then
        echo "$msg"
    else
        >&2 echo "$msg"
    fi
}

# wait_sonarqube_up
#
# This function waits for SonarQube to start and be
# in a UP status.
# If this function is run in background, call wait
# at some point.
#
# No parameter
#
# Environment variables required
#   * SONARQUBE_URL
#
# Example
#   $ wait_sonarqube_up
wait_sonarqube_up()
{
    sonar_status="DOWN"
    log $INFO "initiating connection with Sonarqube."
    sleep 15
    while [ "${sonar_status}" != "UP" ]
    do
        sleep 5
        log $INFO "retrieving Sonarqube's service status."
        sonar_status=$(curl -s -X GET "${SONARQUBE_URL}/api/system/status" | jq -r '.status')
        log $INFO "Sonarqube is ${sonar_status}, expecting it to be UP."
    done
    log $INFO "Sonarqube is ${sonar_status}."
}
