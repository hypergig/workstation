#! /bin/bash

# cmd = export REMOTE LOCAL && /home/jordan/repos/bash_profile/lib/sublimerge_difftool.sh

set -e

# the window title
diff_window='(read-only) - Sublime Text'

# don't do this if a diff window is lingering open
if wmctrl -l | grep -q "$diff_window"; then
  echo 'ERROR - existing diff windows is open' >&2
  exit 1
fi

# open up the diff
subl -n --wait "$REMOTE" "$LOCAL" \
  --command "sublimerge_diff_views {\"left_read_only\": true, \"right_read_only\": true}"&

# kill diff window if i ctrl c
trap "echo 'closing diff window'; wmctrl -c \"$diff_window\"" INT

# wait for the diff window to open before attempting other things
until wmctrl -l | grep -q "$diff_window"; do echo 'waiting for sublimerge to start...'; sleep 1; done

# expand and focus the diff window, track the last window (term)
term_window=$(xdotool getwindowfocus)
wmctrl -r "$diff_window" -b add,maximized_vert,maximized_horz
wmctrl -a "$diff_window"

# wait for diff to be done
echo 'waiting for diff to finish...'
wait $!

# refocus term window
xdotool windowfocus $term_window
