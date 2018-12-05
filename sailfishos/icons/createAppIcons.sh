#!/bin/bash

ICONSDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
if [ $# -lt 1 ]
then
BASENAME=$(find $ICONSDIR -maxdepth 1 -type f -name "*.svg" -exec basename -s .svg {} \;)
else
BASENAME=$1
fi
SIZES="86 108 128 172"

if [ ! -x /usr/bin/inkscape ]
then
    echo "Can not find inkscape executable"
    exit 1
fi

if [ ! -r "$ICONSDIR/$BASENAME.svg" ]
then
    echo "Can not find SVG source file \"${BASENAME}.svg\"!"
    exit 1
fi

processSvg() {
    _SIZE=$1
    _ICONSDIR=$2
    _BASENAME=$3
    SVGFILE=$_BASENAME.svg

    SIZEDIR=$_ICONSDIR/${_SIZE}x${_SIZE}
    FULLPATH=$SIZEDIR/$_BASENAME.png

    if [ ! -r $FULLPATH ]
    then

        if [ ! -d $SIZEDIR ]
        then
            echo "Creating directory $SIZEDIR"
            mkdir -p $SIZEDIR
            if [ ! -d $SIZEDIR ]
            then
                echo "Failed to create directory $SIZEDIR"
                exit 1
            fi
        fi

        echo "Creating icon for size ${_SIZE}x${_SIZE}"

        FNAME=$(mktemp)
        inkscape -z -e $FNAME -w $_SIZE -h $_SIZE $SVGFILE &> /dev/null
        if [ -x /usr/bin/zopflipng ]
        then
            zopflipng -y --iterations=500 --filters=01234mepb --lossy_transparent $FNAME $FULLPATH
            if [ -s $FULLPATH ]
            then
                rm $FNAME
            else
                mv $FNAME $FULLPATH
            fi
        else
            mv $FNAME $FULLPATH
        fi
    else
        echo "Icon for size ${_SIZE}x${_SIZE} already exists"
    fi
}
export -f processSvg

if [ -x /usr/bin/parallel ]
then
    parallel processSvg ::: $SIZES ::: $ICONSDIR ::: $BASENAME
else
    echo "Can not find GNU parallel, using for loop"
    for SIZE in $SIZES
    do
        processSvg $SIZE $ICONSDIR $BASENAME
    done
fi

