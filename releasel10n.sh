#!/bin/bash

lrelease-qt5 -idbased translations/intfuorit.ts

for LANG in de
do
lrelease-qt5 -idbased translations/intfuorit_$LANG.ts
done
