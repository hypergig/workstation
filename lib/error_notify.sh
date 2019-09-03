#! /bin/bash

start=$SECONDS
dmesg -Hw --level=err | while read; do
  if [ $(( $SECONDS - $start )) -le 5 ]; then
    echo "ignoring old messages"
    continue
  fi

  notify-send -u critical "$REPLY"
done
