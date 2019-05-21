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

VER_MAJ = 1
VER_MIN = 1
VER_PAT = 0

VERSION = $${VER_MAJ}.$${VER_MIN}.$${VER_PAT}

DEFINES += VERSION_STRING=\"\\\"$${VERSION}\\\"\"

CONFIG(release, debug|release) {
    DEFINES += QT_NO_DEBUG_OUTPUT
}

clazy {
    QT += quick qml
    DEFINES += CLAZY
    QMAKE_CXX = clang
    QMAKE_CXXFLAGS += "-Xclang -load -Xclang ClangLazy.so -Xclang -add-plugin -Xclang clang-lazy -Xclang -plugin-arg-clazy -Xclang level0,level1,level2"
}

include(../common/common.pri)

QML_IMPORT_PATH += $$PWD/../libintfuorit/imports

LIBS += -L$$OUT_PWD/../libintfuorit/Intfuorit -lintfuorit
INCLUDEPATH += $$PWD/../libintfuorit

SOURCES += \
    src/main.cpp \
    src/licensesmodel.cpp \
    src/languagesmodel.cpp

SAILFISHAPP_ICONS = 86x86 108x108 128x128 150x150 172x172

isEmpty(INSTALL_TRANSLATIONS_DIR): INSTALL_TRANSLATIONS_DIR = /usr/share/harbour-intfuorit/l10n

langfiles.path = $$INSTALL_TRANSLATIONS_DIR
langfiles.files = ../translations/*.qm
INSTALLS += langfiles

imgs.path = /usr/share/harbour-intfuorit/images
imgs.files = images/*
INSTALLS += imgs

icons.path = /usr/share/harbour-intfuorit/icons
icons.files = icons/z*
INSTALLS += icons

DISTFILES += \
    qml/harbour-intfuorit.qml \
    qml/phone/pages/MainPage.qml \
    qml/phone/cover/CoverPage.qml \
    qml/tablet/pages/MainPage.qml \
    qml/tablet/cover/CoverPage.qml \
    harbour-intfuorit.desktop \
    qml/phone/pages/BreachPage.qml \
    qml/phone/pages/BreachSearchPage.qml \
    qml/phone/pages/BreachesListDelegate.qml \
    qml/common/pages/Settings.qml \
    qml/common/pages/About.qml \
    qml/common/models/ChangelogModel.qml \
    qml/common/models/ContributorsModel.qml \
    qml/common/pages/PrivacyPolicy.qml \
    qml/common/pages/Help.qml \
    qml/common/pages/Welcome.qml

include(../HBN_SFOS_Components/HBN_SFOS_Components.pri)

HEADERS += \
    src/licensesmodel.h \
    src/languagesmodel.h
