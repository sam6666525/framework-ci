include(${CMAKE_CURRENT_LIST_DIR}/CommonFunctions.cmake)
message(STATUS "VCPKG_BUILD_DIR=${VCPKG_BUILD_DIR}")
if (NOT VCPKG_BUILD_DIR)
  message(FATAL_ERROR "VCPKG_BUILD_DIR is not defined")
endif()
message(STATUS "VCPKG_BUILD_DIR = ${VCPKG_BUILD_DIR}")
message(STATUS "Env: VCPKG_BUILD_DIR = $ENV{VCPKG_BUILD_DIR}")

set(BOOTSTRAP_COMMAND "/bin/sh" "bootstrap-vcpkg.sh")
set(VCPKG_EXE "vcpkg")
if (WIN32)
  set(BOOTSTRAP_COMMAND "bootstrap-vcpkg.bat")
  set(VCPKG_EXE "vcpkg.exe")
endif()

# Si l'exécutable 'vcpkg' existe, pas la peine de faire le bootstrap.
set(VCPKG_FULL_PATH "${VCPKG_BUILD_DIR}/${VCPKG_EXE}")
message(STATUS "Check if vcpkg need to be boostraped. Expected file is '${VCPKG_FULL_PATH}'")
if(EXISTS "${VCPKG_FULL_PATH}")
  message(STATUS "File '${VCPKG_FULL_PATH}' exists. Do not bootstrap")
  return()
endif()

do_command(${BOOTSTRAP_COMMAND} WORKING_DIRECTORY "${VCPKG_BUILD_DIR}")
