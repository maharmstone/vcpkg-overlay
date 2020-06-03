# Common Ambient Variables:
#   VCPKG_ROOT_DIR = <C:\path\to\current\vcpkg>
#   TARGET_TRIPLET is the current triplet (x86-windows, etc)
#   PORT is the current port name (zlib, etc)
#   CURRENT_BUILDTREES_DIR = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR  = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#

include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO maharmstone/tdscpp
    REF 0.9
    SHA512 723463fcb0832f4a25d96e98a0921207955a25cd6d584b167f3f8302ab988a80ad69893abe1dbb08af24f7d88d6b8497149cad18a74654163039c549eb4d0d84
)

set(BUILD_tdscpp_openssl OFF)
if("openssl" IN_LIST FEATURES)
    set(BUILD_tdscpp_openssl ON)
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DWITH_OPENSSL=${BUILD_tdscpp_openssl}
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/tdscpp TARGET_PATH share/tdscpp)

vcpkg_copy_pdbs()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

# Handle copyright
file(COPY ${SOURCE_PATH}/LICENCE DESTINATION ${CURRENT_PACKAGES_DIR}/share/tdscpp)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/tdscpp/LICENCE ${CURRENT_PACKAGES_DIR}/share/tdscpp/copyright)

