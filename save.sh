#!/usr/bin/env bash
set -eu
outdir=~/documents/history
outfile="${outdir}/backup_$(date -Iseconds).txt"
cd "$(dirname "$0")"
profile=$(./get_profile.py)
cd ~/.mozilla/firefox/
cd "$profile"
tmpfile=$(mktemp /tmp/firefox-history-backup.XXXXXX.sqlite)
cp places.sqlite "$tmpfile"
sqlite3 "$tmpfile" 'select url,title from moz_places, moz_historyvisits where moz_places.id = moz_historyvisits.place_id group by url;' > "$outfile"
echo "saved to $outfile"
rm "$tmpfile"
