#!/usr/bin/env bash
set -eu
outdir=~/documents/history
outfile="${outdir}/backup_$(date -Iseconds).txt"
outjson="${outdir}/backup_$(date -Iseconds).json"
cd "$(dirname "$0")"
profile=$(./get_profile.py)
cd ~/.mozilla/firefox/
cd "$profile"
tmpfile=$(mktemp /tmp/firefox-history-backup.XXXXXX.sqlite)
cp places.sqlite "$tmpfile"
sqlite3 "$tmpfile" 'select datetime(visit_date/1000000,"unixepoch"),url,title from moz_places, moz_historyvisits where moz_places.id = moz_historyvisits.place_id group by url;' > "$outfile"
sqlite3 "$tmpfile" "select json_object('date', datetime(visit_date/1000000,'unixepoch'), 'url', url, 'title', title) from moz_places, moz_historyvisits where moz_places.id = moz_historyvisits.place_id group by url;" > "$outjson"
echo "saved to $outfile, $outjson"
rm "$tmpfile"
