#!/usr/bin/env bash

set -e

MY_NAGIOS_HOSTNAME=`hostname -f`
SLACK_USERNAME=`hostname -f`
SLACK_CHANNEL="<#your channel name>"
WEBHOOK_URL="<your webhook url for nagios>"
ICON_URL="https://slack.global.ssl.fastly.net/7bf4/img/services/nagios_128.png"

case "$NAGIOS_SERVICESTATE" in
	OK )
		ICON=":white_check_mark:"
		;;
	WARNING )
		ICON=":warning:"
		;;
	CRITICAL )
		ICON=":exclamation:"
		;;
	UNKNOWN )
		ICON=":question:"
		;;
	* )
		ICON=":white_medium_square:"
		;;
esac

curl -X POST --data "payload={\"channel\": \"${SLACK_CHANNEL}\", \"username\": \"${SLACK_USERNAME}\", \"text\": \"${ICON} HOST: ${NAGIOS_HOSTNAME}   SERVICE: ${NAGIOS_SERVICEDISPLAYNAME}     MESSAGE: ${NAGIOS_SERVICEOUTPUT} <https://${MY_NAGIOS_HOSTNAME}/cgi-bin/nagios3/status.cgi?host=${NAGIOS_HOSTNAME}|See Nagios>\", \"icon_url\": \"${ICON_URL}\"}" ${WEBHOOK_URL}
