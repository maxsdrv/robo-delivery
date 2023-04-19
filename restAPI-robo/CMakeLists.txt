cmake_minimum_required(VERSION 3.19)

set(ROBO_DELIVERY_VERSION 0.1.0)
project(roboDelivery VERSION ${ROBO_DELIVERY_VERSION} LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)


find_package(Qt6 6.2 COMPONENTS Core Network Quick QuickControls2 Concurrent ShaderTools REQUIRED)

find_program(QSB_EXECUTABLE NAMES qsb "/home/maxim/Qt/6.3.1/gcc_64/bin/")

message("QSB_EXECUTABLE: ${QSB_EXECUTABLE}")

set(HEADERS
  Monitor.h
  shaderloader.h
  )

set(SOURCES 
  Monitor.cpp
  shaderloader.cpp
  main.cpp
  )

set(SHADER_FILES
    color_overlay_shader.frag
    arrow_direction.vert)

foreach(shader_file ${SHADER_FILES})
    set(SHADER_SOURCE "${CMAKE_SOURCE_DIR}/${shader_file}")
    set(SHADER_BINARY "${CMAKE_BINARY_DIR}/compiled_shaders/${shader_file}.qsb")

    message("SHADER_SOURCE: ${SHADER_SOURCE}")
    message("SHADER_BINARY: ${SHADER_BINARY}")

    add_custom_command(
        OUTPUT ${SHADER_BINARY}
        COMMAND ${QSB_EXECUTABLE} --glsl "100es,120,150" -o ${SHADER_BINARY} ${SHADER_SOURCE}
        DEPENDS ${SHADER_SOURCE}
        COMMENT "Compiling shader ${SHADER_SOURCE}"
    )

    list(APPEND COMPILED_SHADERS ${SHADER_BINARY})
endforeach()

qt6_add_resources(RESOURCES resource.qrc
    FILES ${COMPILED_SHADERS}
)


#set(IMAGES_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Images)

#set(IMAGES_DEST ${CMAKE_CURRENT_BINARY_DIR}/images)

#file(COPY ${IMAGES_DIR} DESTINATION ${IMAGES_DEST})

add_executable(${PROJECT_NAME} ${HEADERS} ${SOURCES} ${RESOURCES})
add_dependencies(${PROJECT_NAME} ${COMPILED_SHADERS})

#qt_add_qml_module(app${PROJECT_NAME}
#                  URI untitled
#                  VERSION 1.0
#                  QML_FILES Viewer.qml)

#target_compile_definitions(app${PROJECT_NAME}
#    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)



target_link_libraries(${PROJECT_NAME}
  PRIVATE 
  Qt6::Core
  Qt6::Quick
  Qt6::QuickControls2
  Qt6::Concurrent
  Qt6::ShaderTools
  )


