#!/bin/bash
set -e
source /build/buildconfig
set -x

## Installing clamav and clamsmtp
$minimal_apt_get_install clamav-daemon clamav-freshclam clamsmtp

## Setting up clamd
mkdir /etc/service/clamd
cp /build/runit/spamd /etc/service/spamd/run
sed -i 's/^LogSyslog false.*/LogSyslog true' /etc/clamav/clamd.conf
sed -i 's/^Foreground false/Foreground true/' /etc/clamav/clamd.conf
mkdir /var/run/clamav && chown clamav:clamav /var/run/clamav

## Setting up freshclam
mkdir /etc/service/freshclam
cp /build/runit/freshclam /etc/service/freshclam/run
sed -i 's/^LogSyslog false.*/LogSyslog true' /etc/clamav/freshclam.conf

## Setting up clamsmtp
mkdir /etc/service/clamsmtp
cp /build/runit/clamsmtp /etc/service/clamsmtp/run
mkdir /var/run/clamsmtp && chown clamsmtp:clamsmtp /var/run/clamsmtp