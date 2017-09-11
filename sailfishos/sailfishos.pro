# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-intfuorit

CONFIG += sailfishapp
CONFIG += c++11

QT += network

VER_MAJ = 0
VER_MIN = 0
VER_PAT = 1

VERSION = $${VER_MAJ}.$${VER_MIN}.$${VER_PAT}

DEFINES += VERSION_STRING=\"\\\"$${VERSION}\\\"\"

CONFIG(release, debug|release) {
    DEFINES += QT_NO_DEBUG_OUTPUT
}

contains(CONFIG, clazy) {
    QT += quick qml
    DEFINES += CLAZY
    QMAKE_CXXFLAGS += "-Xclang -load -Xclang ClangLazy.so -Xclang -add-plugin -Xclang clang-lazy"
}

include(../common/common.pri)

LIBS += -L$$OUT_PWD/../libintfuorit -lintfuorit
INCLUDEPATH += $$PWD/../libintfuorit

SOURCES += \
    src/main.cpp

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

isEmpty(INSTALL_TRANSLATIONS_DIR): INSTALL_TRANSLATIONS_DIR = /usr/share/harbour-fuoten/l10n

langfiles.path = $$INSTALL_TRANSLATIONS_DIR
langfiles.files = ../translations/*.qm
INSTALLS += langfiles


DISTFILES += \
    qml/harbour-intfuorit.qml \
    qml/phone/pages/MainPage.qml \
    qml/phone/cover/CoverPage.qml \
    qml/tablet/pages/MainPage.qml \
    qml/tablet/cover/CoverPage.qml \
    harbour-intfuorit.desktop \
    qml/phone/pages/BreachPage.qml \
    qml/phone/pages/BreachSearchPage.qml \
    qml/phone/pages/BreachesListDelegate.qml
