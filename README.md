Makes a backup of firefox history

# Install

1. Clone somewhere.
2. Edit outdir in save.sh
3. Copy savehistory.service and savehistory.timer to ~/.local/share/systemd/user/
4. Edit ~/.local/share/systemd/user/savehistory.service so that the path is right
5. Run `systemctl --user start --now savehistory.timer`
