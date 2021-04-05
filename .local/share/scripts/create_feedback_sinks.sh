#!/bin/sh

# Create the virtual sinks
pactl load-module module-null-sink sink_name=feedback sink_properties=device.description=VirtualFeedback
pactl load-module module-null-sink sink_name=speaker sink_properties=device.description=VirtualSpeaker

# Loopback the microphone to the virtual speaker
pactl load-module module-loopback latency_msec=1 source=alsa_input.usb-Burr-Brown_from_TI_USB_Audio_CODEC-00.analog-stereo sink=speaker

# Loopback the feedback to the main sink and the virtual speaker
pactl load-module module-loopback latency_msec=1 source=feedback.monitor sink=1       # Assuming 1 is the main sink
pactl load-module module-loopback latency_msec=1 source=feedback.monitor sink=speaker
