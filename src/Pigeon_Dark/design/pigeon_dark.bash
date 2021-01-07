#!/bin/sh
if [ "$TERM" = "linux" ]; then
  /bin/echo -e "
  \e]P0666666
  \e]P1cc6666
  \e]P28fcc66
  \e]P3ccb866
  \e]P466a3cc
  \e]P5b866cc
  \e]P666cca3
  \e]P7666666
  \e]P8999999
  \e]P9ff8080
  \e]PAb2ff80
  \e]PBffe680
  \e]PC80ccff
  \e]PDe680ff
  \e]PE80ffcc
  \e]PF999999
  "
  # get rid of artifacts
  clear
fi
