#!/bin/bash
# @vicinae.schemaVersion 1
# @vicinae.title Clean Keyboard
# @vicinae.keywords ["clean", "keyboard"]
# @vicinae.description disables keyboard for 15s
# @vicinae.mode silent
# @vicinae.icon /home/binaryraptor/.local/share/vicinae/scripts/icons/clean_keyboard.png

GRAB_PID=""

cleanup() {
  # Kill grab process immediately with -9
  if [ ! -z "$GRAB_PID" ] && kill -0 $GRAB_PID 2>/dev/null; then
    kill -9 $GRAB_PID 2>/dev/null || true
    wait $GRAB_PID 2>/dev/null || true
  fi

  # Force ungrab the device multiple times to ensure it's released
  for attempt in {1..5}; do
    python3 <<'EOF' 2>/dev/null || true
import fcntl, os, time
try:
    # Open fresh, ungrab, close
    fd = os.open('/dev/input/event2', os.O_RDONLY | os.O_NONBLOCK)
    try:
        fcntl.ioctl(fd, 0x40044590, 0)  # EVIOCGRAB with 0 to ungrab
    except:
        pass
    os.close(fd)
except:
    pass
EOF
    sleep 0.05
  done
}

trap cleanup EXIT INT TERM

# Start inline grabber
python3 <<'PYTHON_EOF' 2>/dev/null &
import fcntl, os, signal, sys, time, atexit

EVIOCGRAB = 0x40044590
fd = None
grabbed = False

def do_ungrab():
    global fd, grabbed
    if fd is not None and grabbed:
        try:
            fcntl.ioctl(fd, EVIOCGRAB, 0)
            grabbed = False
        except:
            pass
        try:
            os.close(fd)
        except:
            pass
        fd = None

def signal_handler(sig, frame):
    do_ungrab()
    sys._exit(0)

signal.signal(signal.SIGTERM, signal_handler)
signal.signal(signal.SIGINT, signal_handler)
atexit.register(do_ungrab)

try:
    fd = os.open('/dev/input/event2', os.O_RDONLY | os.O_NONBLOCK)
    fcntl.ioctl(fd, EVIOCGRAB, 1)
    grabbed = True
    
    while True:
        try:
            os.read(fd, 24)
        except:
            pass
        time.sleep(0.01)
except Exception as e:
    pass
finally:
    do_ungrab()
PYTHON_EOF

GRAB_PID=$!
sleep 0.3

id=$(dunstify -p "Keyboard Cleaning" "15s")

for i in {14..1}; do
  sleep 1
  dunstify -r "$id" "Keyboard Cleaning" "${i}s"
done
sleep 1
