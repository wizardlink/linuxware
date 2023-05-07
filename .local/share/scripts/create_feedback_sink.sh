#!/bin/sh

#
# Load sinks
#
pactl load-module module-null-sink  sink_name=output        sink_properties=device.description="Output"
pactl load-module module-null-sink  sink_name=applications  sink_properties=device.description="Applications"

#
# Loopback audio to the correct places
#

# Application audio forwarded to microphone
pactl load-module module-loopback   latency_msec=25 source=applications.monitor sink=output
# Microphone
pactl load-module module-loopback   latency_msec=25 source=rnnoise_source sink=output
# Application audio forwarded to me
pactl load-module module-loopback   latency_msec=25 source=applications.monitor sink=alsa_output.usb-Burr-Brown_from_TI_USB_Audio_CODEC-00.pro-output-0
