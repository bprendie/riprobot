# RoboRip Dependencies (Arch Linux)

To run `roborip.sh` or `roborip-gnudb.sh` on a fresh Arch Linux installation, you need the following components.

## 1. Core System Packages
Install these via `pacman`:

```bash
sudo pacman -S abcde cd-discid cdparanoia eject flac lame id3v2 wget
```

*   `abcde`: The main ripping frontend.
*   `cd-discid`: Used by the script to detect disc insertion.
*   `cdparanoia`: The extraction engine.
*   `eject`: Used to open/close trays and set drive speed.
*   `flac` / `lame`: Audio encoders for the various profiles.

## 2. MusicBrainz Support (AUR)
If you use the default `roborip.sh` (which prefers MusicBrainz), you MUST install these Perl modules from the AUR (using `yay` or `paru`):

```bash
yay -S perl-musicbrainz-discid perl-webservice-musicbrainz
```

*Without these, `abcde` will fail with "Can't locate MusicBrainz/DiscID.pm".*

## 3. User Permissions
Your user must have permission to access the hardware blocks for the optical drives.

```bash
# Add user to the optical group
sudo usermod -aG optical $USER
```

**Note:** You must log out and log back in for this group change to take effect.

## 4. Hardware Verification
The script is currently configured for two drives. If the destination machine has a different number of drives, update this line in the scripts:

```bash
DRIVES=("/dev/sr0" "/dev/sr1")
```
