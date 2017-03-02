#!/bin/bash
set -ue;

if [ -z "${1:-}" ]; then
	echo "Usage: ./airport <interface>";
	exit 1;
fi;

iface=$1;
hexchars="0123456789ABCDEF";
end=$( for _ in {1..10} ; do echo -n ${hexchars:$((RANDOM % 16)):1} ; done | sed -e 's/\(..\)/:\1/g' );
MAC=00$end;

ifconfig "$iface" down;
ifconfig "$iface" hw ether "$MAC";
ifconfig "$iface" up;

echo "New MAC address: $MAC";
