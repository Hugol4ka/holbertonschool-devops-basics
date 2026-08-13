#!/usr/bin/env bash
ping -c 4 "$(ip -4 -brief address show scope host | tr -s ' ' | cut -d ' ' -f 3 | head -n 1 | cut -d '/' -f 1)"
