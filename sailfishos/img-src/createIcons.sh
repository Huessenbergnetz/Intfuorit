#!/bin/bash


processSvg() {

    SVGFILE=$1
    FILENAME=`echo $SVGFILE | sed 's/.svg//'`

    echo "Processing $1"

    for RATIO in 1.0 1.25 1.5 1.75 2.0
    do

        echo "Processing ratio: $RATIO"

        DESTDIR="$PWD/../images/z${RATIO}"

        if [ ! -d "$DESTDIR" ]
        then
            echo "Creating directory z${RATIO}"
            mkdir -p "$DESTDIR"
        fi

        echo "Creating large icon"
        L1=`echo "88*${RATIO}" | bc`
        L2=`echo "96*${RATIO}" | bc`
        inkscape -z -e /tmp/icon-l-$FILENAME.png -w $L1 -h $L1 $PWD/$SVGFILE
        convert /tmp/icon-l-$FILENAME.png -gravity center -background '#ffffff00' -extent ${L2}x${L2} $DESTDIR/icon-l-$FILENAME.png
        rm /tmp/icon-l-$FILENAME.png

        echo "Creating medium icon"
        M1=`echo "58*${RATIO}" | bc`
        M2=`echo "64*${RATIO}" | bc`
        inkscape -z -e /tmp/icon-m-$FILENAME.png -w $M1 -h $M1 $PWD/$SVGFILE
        convert /tmp/icon-m-$FILENAME.png -gravity center -background '#ffffff00' -extent ${M2}x${M2} $DESTDIR/icon-m-$FILENAME.png
        rm /tmp/icon-m-$FILENAME.png

        echo "Creating small icon"
        S1=`echo "26*${RATIO}" | bc`
        S2=`echo "32*${RATIO}" | bc`
        inkscape -z -e /tmp/icon-s-$FILENAME.png -w $S1 -h $S1 $PWD/$SVGFILE
        convert /tmp/icon-s-$FILENAME.png -gravity center -background '#ffffff00' -extent ${S2}x${S2} $DESTDIR/icon-s-$FILENAME.png
        rm /tmp/icon-s-$FILENAME.png

    done

}

if [ "$1" == "" ]; then

    SVGFILES=`ls *.svg`

    for FILE in $SVGFILES
    do
        processSvg $FILE
    done

else

    processSvg $1

fi
