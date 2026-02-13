# RoboRip v5.0

**RoboRip** is a high-performance, parallel CD ripping suite designed for Linux systems with multiple optical drives. It automates the monitoring and ripping process, allowing you to "load and forget" your discs.

## Features
- **Parallel Ripping:** Monitors and rips from multiple drives (`/dev/sr0`, `/dev/sr1`, etc.) simultaneously using background workers.
- **Multiple Profiles:** Supports `flac`, `mp3-hq`, `mp3-norm`, and `ipod` (m4a) encoding out of the box.
    - `ipod`: An AAC profile (`.m4a`) specifically tuned for the **iPod Classic**. It is configured to be backwards compatible with **1st and 2nd Generation FireWire iPods**, ensuring your rips play perfectly on vintage hardware.
- **Automated Monitoring:** Polls drives every 5 seconds and triggers `abcde` automatically upon disc detection.
- **Custom Metadata:** Supports both MusicBrainz and GNUDB (CDDB) for metadata retrieval.

## Installation (Arch Linux)
For a complete list of dependencies and setup instructions, see [required_packages.md](./required_packages.md).

1. **Install Core Tools:**
   ```bash
   sudo pacman -S abcde cd-discid cdparanoia eject flac lame
   ```
2. **Setup Permissions:**
   ```bash
   sudo usermod -aG optical $USER
   ```
   *(Log out and back in after running this)*

## Usage

Run the script with your desired encoding profile:

```bash
./roborip.sh [flac|mp3-hq|mp3-norm|ipod] [OPTIONAL_DESTINATION]
```

### Examples:
- Rip to FLAC in the default directory: `./roborip.sh flac`
- Rip high-quality MP3s to a specific drive: `./roborip.sh mp3-hq /mnt/external/Music`

### Variants:
- `roborip.sh`: Standard version (prefers MusicBrainz metadata).
- `roborip-gnudb.sh`: Optimized for GNUDB/CDDB lookups (useful if MusicBrainz Perl modules are unavailable).

## Configuration
Open the scripts to modify the following variables to match your hardware:
- `DRIVES`: List of device paths (e.g., `("/dev/sr0" "/dev/sr1")`).
- `BASE_DIR`: Default destination for ripped music.

## How it Works
1. The script spawns a "worker" process for every drive listed in the configuration.
2. Each worker loops indefinitely, checking for a disc using `cd-discid`.
3. When a disc is found, it locks the drive speed, executes `abcde` with a dynamically generated config, and ejects the tray upon completion.
4. Output is logged to the console, prefixed by the drive ID.
