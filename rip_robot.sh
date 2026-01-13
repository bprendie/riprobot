#!/bin/bash

# Configuration
DRIVES=("/dev/sr0" "/dev/sr1" "/dev/sr2" "/dev/sr3" "/dev/sr4")
LOGFILE="$HOME/rip_log.txt"

# Ensure logfile exists
touch "$LOGFILE"

# Logging function (File only, keeps terminal for progress bars)
log_event() {
    local drive="$1"
    local message="$2"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - [$drive] - $message" >> "$LOGFILE"
}

# The Worker Function
rip_cycle() {
    local drive="$1"
    
    # Announce thread start to terminal
    echo "[$drive] Thread active. Monitoring..."

    while true; do
        # 1. POLL: Check for disc presence (silently)
        if cd-discid "$drive" >/dev/null 2>&1; then
            
            # 2. START: Log it and scream to the terminal
            echo "[$drive] DISC DETECTED. Starting abcde..."
            log_event "$drive" "Disc detected. Starting rip."

            # 3. EXECUTE: Run abcde
            # We let stdout/stderr hit the terminal for your "realtime info"
            abcde -d "$drive" -N
            
            # Capture exit code immediately
            RIP_STATUS=$?

            # 4. VERIFY & LOG
            if [ $RIP_STATUS -eq 0 ]; then
                echo "[$drive] SUCCESS."
                log_event "$drive" "COMPLETED SUCCESSFULLY."
            else
                echo "[$drive] FAILED."
                log_event "$drive" "FAILED with exit code $RIP_STATUS."
            fi

            # 5. EJECT
            echo "[$drive] Ejecting..."
            eject "$drive"

            # 6. DEBOUNCE
            # Give the user 10s to swap discs so the loop doesn't try to read 
            # the closing tray as a new insertion event immediately.
            sleep 10
            
        else
            # Drive empty. Sleep short to keep CPU usage low.
            sleep 2
        fi
    done
}

# Spawn background workers
echo "Starting Multi-Drive Rip Engine..."
echo "Logging audit trail to: $LOGFILE"

for drive in "${DRIVES[@]}"; do
    if [ -e "$drive" ]; then
        rip_cycle "$drive" &
        PID=$!
        log_event "$drive" "Worker thread started (PID: $PID)"
    else
        echo "Warning: Drive $drive not found."
    fi
done

# Keep parent process alive
wait
