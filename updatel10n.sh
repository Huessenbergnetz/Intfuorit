#!/bin/bash

if [ ! -d translations ]; then
    mkdir translations
fi

lupdate-qt5 -no-obsolete -source-language en -target-language en -locations none sailfishos common -ts translations/intfuorit.ts
