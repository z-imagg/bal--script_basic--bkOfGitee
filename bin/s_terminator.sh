#!/bin/sh

ping -c 1 server.host 1>/dev/null 2>/dev/null  && \
terminator --command "sshpass -p z ssh z@server.host"
