cmake_minimum_required(VERSION 3.16)

project(QmlDev VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Quick3D)

qt_standard_project_setup(REQUIRES 6.10)

qt_add_executable(appQmlDev
    main.cpp
)

qt_add_qml_module(appQmlDev
    URI QmlDev
    QML_FILES
        Main.qml
        MainPage.qml
        SettingsPage.qml
)

set_target_properties(appQmlDev PROPERTIES
    MACOSX_BUNDLE FALSE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appQmlDev
    PRIVATE
        Qt6::Quick
        Qt6::Qml
        Qt6::Quick3D
)

install(TARGETS appQmlDev
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
