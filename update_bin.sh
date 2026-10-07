#!/bin/bash
while pidof cargo > /dev/null; do
    sleep 5
done
cp /data/data/com.termux/files/home/Projects/TermuxHiveBear/target/release/hivebear $PREFIX/bin/hivebear
echo "Copiado!" > /data/data/com.termux/files/home/Projects/TermuxHiveBear/update_done.txt
