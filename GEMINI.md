# RoboRip

RoboRip is an automated, multi-drive CD ripping utility for Linux. It is designed to manage a fleet of optical drives in parallel, providing verbose, real-time feedback directly to the terminal.

## Project Overview

*   **Purpose:** Automated parallel CD ripping and encoding with maximum verbosity.
*   **Main Technologies:** Bash, `abcde` (A Better CD Encoder), `cd-discid`, `cdparanoia`.
*   **Architecture:**
    *   **Config Generator:** Dynamically creates unique `abcde` configuration files for each drive to prevent path and process conflicts.
    *   **Verbose Workers:** Background processes for each drive that monitor for disc insertion and execute `abcde` with full output streaming.
    *   **Parallel Execution:** Multiple drives are handled simultaneously, with their logs interleaving in the terminal for real-time monitoring of queries, track information, and encoding progress.

## Dependencies

*   `abcde`: The primary ripping/encoding frontend.
*   `cd-discid`: For disc detection.
*   `cdparanoia`: For secure digital audio extraction.
*   `eject`: To handle disc ejection.
*   `lame`, `flac`, `fdkaac`: Audio encoders for various profiles.

## Usage

### Running RoboRip

Execute the script with a quality profile and an optional destination directory:

```bash
./roborip.sh [flac|mp3-hq|mp3-norm|ipod] [OPTIONAL_DESTINATION]
```

### Profiles
*   `flac`: Lossless compression (`-8 --verify`).
*   `mp3-hq`: High-quality variable bitrate (`-V 0`).
*   `mp3-norm`: Standard 160kbps constant bitrate.
*   `ipod`: M4A format optimized for legacy devices.

## Development Conventions

*   **Configuration:** Drive paths are defined in the `DRIVES` array (defaulting to `/dev/sr0` through `/dev/sr4`).
*   **Verbosity:** All `abcde` output is directed to `stdout`/`stderr` without redirection, allowing the user to see CDDB queries, tagging, and encode progress bars.
*   **Cleanup:** Uses a SIGINT/SIGTERM trap to ensure all background workers are terminated when the main script is stopped.