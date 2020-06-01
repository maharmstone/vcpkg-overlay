# Common Ambient Variables:
#   VCPKG_ROOT_DIR = <C:\path\to\current\vcpkg>
#   TARGET_TRIPLET is the current triplet (x86-windows, etc)
#   PORT is the current port name (zlib, etc)
#   CURRENT_BUILDTREES_DIR = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR  = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#

include(vcpkg_common_functions)
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/tdscpp-0.9)
vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/maharmstone/tdscpp/archive/0.9.tar.gz"
    FILENAME "tdscpp-0.9.tar.gz"
    SHA512 bdb4145cea890d92a25b220a10c3d73d893c21afcb1f4adf47d6c6a9f03fe6b9bb41e034327fcb21ee5492cd0095a6e4c793df7263ffc74c6ea12ee235bffeca
)
vcpkg_extract_source_archive(${ARCHIVE})

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

