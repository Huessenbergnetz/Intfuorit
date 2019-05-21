 

HEADERS += \
    $$PWD/configuration.h \
    $$PWD/namfactory.h \
    $$PWD/cacheperiodmodel.h

SOURCES += \
    $$PWD/configuration.cpp \
    $$PWD/namfactory.cpp \
    $$PWD/cacheperiodmodel.cpp

DISTFILES += \
    $$PWD/qml/models/PrivacyPolicyModel.qml \
    $$PWD/qml/models/HelpModel.qml

commonQmlFiles.files = $$PWD/qml/*

sfos {
commonQmlFiles.path = /usr/share/harbour-intfuorit/qml/common
}

INSTALLS += commonQmlFiles
