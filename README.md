# 🤖 Rip Robot

> *Automated, parallelized, multi-drive CD ripping engine.*

Rip Robot is a bash-based automation tool designed to turn a stack of optical drives into a high-throughput audio ingestion machine. It monitors multiple drives simultaneously, automatically detects discs, rips them to high-quality AAC, and ejects them—all without user intervention.

## 🚀 Features

*   **Multi-Drive Parallelism:** Monitors `/dev/sr0` through `/dev/sr4` concurrently. Load 'em all up and watch them spin.
*   **Set & Forget:** Fully non-interactive. Just feed it discs.
*   **Legacy Hardware Optimization:** Specifically tuned for maximum compatibility with **legacy FireWire iPods** (1st-4th Gen).
*   **High-Quality Audio:** Configured for `fdkaac` (AAC-LC) at VBR Mode 4 (~192kbps) — the most efficient and compatible format for vintage Apple hardware.
*   **Smart Metadata:** Uses **MusicBrainz** and **CDDB** for accurate tagging.
*   **Auto-Normalization:** Applies **ReplayGain** tags automatically during the pipeline.
*   **Sanitized Organization:** Sorts output into `Artist/Album/Track - Title.m4a` and cleans up special characters.

## 🍏 Why AAC? (Legacy iPod Context)

This configuration is intentionally designed for users of vintage iPods (especially those using FireWire for syncing). 
*   **Efficiency:** AAC-LC (Low Complexity) is the native language of the iPod's hardware decoder. 
*   **Battery Life:** Because it's hardware-decoded, it minimizes CPU usage on the device, significantly extending playback time compared to MP3.
*   **Transparency:** At ~192kbps VBR, AAC provides near-transparency while keeping file sizes small enough to fit large collections on original or flash-modded drives.

## 🛠️ Configuration

The project relies on two main files:

1.  **`rip_robot.sh`**: The orchestrator. It manages the worker threads for each drive, handles polling logic, logging, and ejects discs upon completion.
2.  **`abcde.conf`**: The brain. Contains the specific `abcde` (A Better CD Encoder) profiles, path definitions, and encoder settings.

### Customizing the Output Format

If you aren't targeting legacy iPods and prefer a different format, modify these lines in `abcde.conf`:

#### For MP3 (Universal Compatibility)
```bash
OUTPUTTYPE=mp3
# Use LAME encoder
LAMEOPTS='-V 2' # Standard VBR high quality
```

#### For FLAC (Lossless Archival)
```bash
OUTPUTTYPE=flac
# No options needed for standard compression
```

## 📦 Usage

1.  **Install Dependencies:**
    Ensure you have the required packages (Debian/Ubuntu example):
    ```bash
    sudo apt install abcde fdkaac cd-discid flac lame
    ```

2.  **Run the Robot:**
    ```bash
    ./rip_robot.sh
    ```
    *The terminal will show real-time status from the active rippers. A permanent log is kept at `~/rip_log.txt`.*

3.  **Feed the Machine:**
    Insert CDs into any available drive. The system will detect, rip, and eject automatically.

## 📝 License

This project is a personal automation script. Feel free to fork and modify for your own archival needs.