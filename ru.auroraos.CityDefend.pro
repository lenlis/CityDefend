TARGET = ru.auroraos.CityDefend

CONFIG += \
    auroraapp

PKGCONFIG += \

SOURCES += \
    src/main.cpp \

HEADERS += \

DISTFILES += \
    qml/pages/CanvasPage.qml \
    qml/icons/plane.png \
    qml/icons/big_plane.png \
    qml/icons/rocket.png \
    qml/icons/city.png \
    qml/icons/HPupgrade.png \
    qml/icons/HP.png \
    qml/icons/zoneUpgrade.png \
    qml/icons/DMGupgrade.png \
    qml/icons/shop.png \
    qml/icons/bar.png \
    qml/icons/menuBack.png \
    qml/icons/sky.jpg \
    qml/pages/GamePage.qml \
    rpm/ru.auroraos.CityDefend.spec \

AURORAAPP_ICONS = 86x86 108x108 128x128 172x172

CONFIG += auroraapp_i18n

TRANSLATIONS += \
    translations/ru.auroraos.CityDefend.ts \
    translations/ru.auroraos.CityDefend-ru.ts \
