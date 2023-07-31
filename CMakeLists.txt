cmake_minimum_required(VERSION 3.15)
cmake_policy(SET CMP0091 NEW)
set (CMAKE_CXX_STANDARD 14)

project (puerts_lua)

find_package(Lua REQUIRED)

file(GLOB SOURCE_FILES "src/PesapiAddonLoad.cpp" "src/PesapiLuaImpl.cpp" "src/JSClassRegister.cpp" "src/CppObjectMapper.cpp")

if ( WIN32 AND NOT CYGWIN )
    list (APPEND SOURCE_FILES "src/win32-dlfcn.cc")
endif ( )

add_library(${PROJECT_NAME} MODULE ${SOURCE_FILES})
set_target_properties(${PROJECT_NAME} PROPERTIES PREFIX "")

target_link_libraries(${PROJECT_NAME} ${LUA_LIBRARIES})
target_include_directories(${PROJECT_NAME} PRIVATE ${LUA_INCLUDE_DIR})
set_target_properties(${PROJECT_NAME} PROPERTIES LIBRARY_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR})

if (CMAKE_INSTALL_PREFIX)
    install(TARGETS ${PROJECT_NAME} DESTINATION "${CMAKE_INSTALL_PREFIX}/lib")
    install(FILES puerts.lua DESTINATION "${CMAKE_INSTALL_PREFIX}/lua")
endif(CMAKE_INSTALL_PREFIX)
