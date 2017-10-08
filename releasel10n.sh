#!/bin/bash

lrelease-qt5 -idbased translations/intfuorit.ts

for LANG in en_GB en_US de sv
do
lrelease-qt5 -idbased translations/intfuorit_$LANG.ts
done
