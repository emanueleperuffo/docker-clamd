#!/bin/bash
set -e
source /build/buildconfig
set -x

## Installing clamav and clamsmtp
$minimal_apt_get_install clamav-daemon clamav-freshclam clamsmtp

## Setting up clamd
mkdir /etc/service/clamd
cp /build/runit/clamd /etc/service/clamd/run
sed -i 's|^LogSyslog.*|LogSyslog true|' /etc/clamav/clamd.conf
sed -i 's|^Foreground.*|Foreground true|' /etc/clamav/clamd.conf
mkdir /var/run/clamav && chown clamav:clamav /var/run/clamav

## Setting up freshclam
mkdir /etc/service/freshclam
cp /build/runit/freshclam /etc/service/freshclam/run
sed -i 's|^LogSyslog.*|LogSyslog true|' /etc/clamav/freshclam.conf
sed -i 's|^Foreground.*|Foreground true|' /etc/clamav/freshclam.conf

## Setting up clamsmtp
mkdir /etc/service/clamsmtpd
cp /build/runit/clamsmtpd /etc/service/clamsmtpd/run
mkdir /var/run/clamsmtp && chown clamsmtp:clamsmtp /var/run/clamsmtp
sed -i 's|^Listen.*|Listen: 10025|' /etc/clamsmtpd.conf
sed -i 's|^OutAddress.*|OutAddress: 10026|' /etc/clamsmtpd.conf
echo 'Action: pass' >> /etc/clamsmtpd.conf