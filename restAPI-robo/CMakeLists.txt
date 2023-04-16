cmake_minimum_required(VERSION 3.19)


set(CMAKE_PREFIX_PATH "/home/maxim/Qt/6.3.1/gcc_64/lib/cmake/")

set(ROBO_DELIVERY_VERSION 0.1.0)
project(roboPipe VERSION ${ROBO_DELIVERY_VERSION} LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)


find_package(Qt6 COMPONENTS Core Network Quick QuickControls2 Concurrent REQUIRED)

set(HEADERS
  Monitor.h
  )

set(SOURCES 
  Monitor.cpp
  main.cpp
  )

#set(RESOURCES
#  resource.qrc
#  )

qt6_add_resources(RESOURCES resource.qrc)
set(IMAGES_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Images)

set(IMAGES_DEST ${CMAKE_CURRENT_BINARY_DIR}/images)

file(COPY ${IMAGES_DIR} DESTINATION ${IMAGES_DEST})

add_executable(${PROJECT_NAME} ${HEADERS} ${SOURCES} ${RESOURCES})

target_link_libraries(${PROJECT_NAME}
  PRIVATE 
  Qt6::Core
  Qt6::Quick
  Qt6::QuickControls2
  Qt6::Concurrent
  )


