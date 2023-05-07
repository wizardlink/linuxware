#!/var/home/wizardlink/.nimble/bin/nim r

from std/os import fileExists
from std/osproc import execProcess
import std/times

type
  TimeTrack = tuple
    pcBreak: Duration
    pcBreakCycle: Duration
    eyeBreak: Duration
    eyeBreakCycle: Duration
  NextAlerts = tuple
    pcBreakCycle: Time
    eyeBreakCycle: Time

let
  trackingDefaults: TimeTrack = (
    pcBreak:       initDuration(minutes = 10),
    pcBreakCycle:  initDuration(hours = 2),
    eyeBreak:      initDuration(seconds = 20),
    eyeBreakCycle: initDuration(minutes = 20),
  )

var
  nextAlerts: NextAlerts = (
    pcBreakCycle:  getTime() + trackingDefaults.pcBreakCycle,
    eyeBreakCycle: getTime() + trackingDefaults.eyeBreakCycle,
  )

while true:
  let currentTime = getTime()
  if fileExists("/var/home/wizardlink/.local/share/scripts/.stop"):
    break

  if nextAlerts.pcBreakCycle <= currentTime:
    nextAlerts.pcBreakCycle += trackingDefaults.pcBreakCycle
    nextAlerts.eyeBreakCycle += trackingDefaults.eyeBreakCycle # Clashes since it happens every 20 minutes
    discard execProcess "pw-play /var/mnt/internal/personal/memes/tetris-pJF_LwW-EWo.mp3"

  elif nextAlerts.eyeBreakCycle <= currentTime:
    nextAlerts.eyeBreakCycle += trackingDefaults.eyeBreakCycle
    discard execProcess "pw-play /var/mnt/internal/personal/memes/noooooo-eoNtgM4KGzc.mp3"
