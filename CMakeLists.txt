project (puerts_lua)
cmake_minimum_required(VERSION 2.8)

find_package(Lua REQUIRED)

file(GLOB SOURCE_FILES "src/PesapiAddonLoad.cpp" "src/PesapiLuaImpl.cpp" "src/JSClassRegister.cpp" "src/CppObjectMapper.cpp")

if ( WIN32 AND NOT CYGWIN )
    list (APPEND SOURCE_FILES "src/win32-dlfcn.cc")
endif ( )

add_library(${PROJECT_NAME} SHARED ${SOURCE_FILES})
set_target_properties(${PROJECT_NAME} PROPERTIES PREFIX "")

target_link_libraries(${PROJECT_NAME} ${LUA_LIBRARIES})
target_include_directories(${PROJECT_NAME} PRIVATE ${LUA_INCLUDE_DIR})
set_target_properties(${PROJECT_NAME} PROPERTIES LIBRARY_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR})