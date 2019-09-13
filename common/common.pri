 

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

isEmpty(AES256_KEY) {
    error("You need to define a 32 byte AES256 encryption key with AES256_KEY")
}
DEFINES += AES256_KEY=\"\\\"$${AES256_KEY}\\\"\"
PKGCONFIG += openssl

commonQmlFiles.files = $$PWD/qml/*

sfos {
commonQmlFiles.path = /usr/share/harbour-intfuorit/qml/common
}

INSTALLS += commonQmlFiles
