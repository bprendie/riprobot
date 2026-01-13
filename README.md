# 🤖 Rip Robot

> *Automated, parallelized, multi-drive CD ripping engine.*

Rip Robot is a bash-based automation tool designed to turn a stack of optical drives into a high-throughput audio ingestion machine. It monitors multiple drives simultaneously, automatically detects discs, rips them to high-quality AAC, and ejects them—all without user intervention.

## 🚀 Features

*   **Multi-Drive Parallelism:** Monitors `/dev/sr0` through `/dev/sr4` concurrently. Load 'em all up and watch them spin.
*   **Set & Forget:** Fully non-interactive. Just feed it discs.
*   **High-Quality Audio:** Configured for `fdkaac` (AAC-LC) at VBR Mode 4 (~192kbps) — the sweet spot for transparency and size.
*   **Smart Metadata:** Uses **MusicBrainz** and **CDDB** for accurate tagging.
*   **Auto-Normalization:** Applies **ReplayGain** tags automatically during the pipeline.
*   **Sanitized Organization:** Sorts output into `Artist/Album/Track - Title.m4a` and cleans up special characters.

## 🛠️ Configuration

The project relies on two main files:

1.  **`rip_robot.sh`**: The orchestrator. It manages the worker threads for each drive, handles polling logic, logging, and ejects discs upon completion.
2.  **`abcde.conf`**: The brain. Contains the specific `abcde` (A Better CD Encoder) profiles, path definitions, and encoder settings.

### Key Settings (`abcde.conf`)
- **Encoder:** `fdkaac`
- **Profile:** AAC-LC (Profile 2)
- **Quality:** VBR Mode 4 (High Quality)
- **Naming:** `${ARTISTFILE}/${ALBUMFILE}/${TRACKNUM} - ${TRACKFILE}`

## 📦 Usage

1.  **Install Dependencies:**
    Ensure you have the required packages (Debian/Ubuntu example):
    ```bash
    sudo apt install abcde fdkaac cd-discid
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
