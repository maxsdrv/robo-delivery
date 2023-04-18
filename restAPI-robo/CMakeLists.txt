cmake_minimum_required(VERSION 3.19)

set(ROBO_DELIVERY_VERSION 0.1.0)
project(roboDelivery VERSION ${ROBO_DELIVERY_VERSION} LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)


find_package(Qt6 6.2 COMPONENTS Core Network Quick QuickControls2 Concurrent ShaderTools REQUIRED)

set(HEADERS
  Monitor.h
  shaderloader.h
  )

set(SOURCES 
  Monitor.cpp
  shaderloader.cpp
  main.cpp
  )

#set(RESOURCES
#  resource.qrc
#  )

qt6_add_resources(RESOURCES resource.qrc)

qt6_add_shaders(${PROJECT_NAME} "resource_shaders"
                PREFIX
                    "/Images"
                FILES
                    "color_overlay_shader.frag"
                )

set(IMAGES_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Images)

set(IMAGES_DEST ${CMAKE_CURRENT_BINARY_DIR}/images)

file(COPY ${IMAGES_DIR} DESTINATION ${IMAGES_DEST})

add_executable(${PROJECT_NAME} ${HEADERS} ${SOURCES} ${RESOURCES})

qt_add_qml_module(app${PROJECT_NAME}
                  URI untitled
                  VERSION 1.0
                  QML_FILES Viewer.qml)

target_compile_definitions(app${PROJECT_NAME}
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(${PROJECT_NAME}
  PRIVATE 
  Qt6::Core
  Qt6::Quick
  Qt6::QuickControls2
  Qt6::Concurrent
  Qt6::ShaderTools
  )


