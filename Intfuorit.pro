TEMPLATE = subdirs

sfos {

SUBDIRS += libintfuorit
SUBDIRS += sailfishos

sailfishos.depends = libintfuorit

OTHER_FILES += \
    rpm/harbour-intfuorit.changes.in \
    rpm/harbour-intfuorit.changes \
    rpm/harbour-intfuorit.yaml \
    rpm/harbour-intfuorit.spec
}
