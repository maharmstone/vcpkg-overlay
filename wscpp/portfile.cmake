# Common Ambient Variables:
#   VCPKG_ROOT_DIR = <C:\path\to\current\vcpkg>
#   TARGET_TRIPLET is the current triplet (x86-windows, etc)
#   PORT is the current port name (zlib, etc)
#   CURRENT_BUILDTREES_DIR = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR  = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#

include(vcpkg_common_functions)
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/wscpp-0.9)
vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/maharmstone/wscpp/archive/0.9.tar.gz"
    FILENAME "wscpp-0.9.tar.gz"
    SHA512 adf6e30811d64efa5aec6f9c04da79e30910530381252f7f14e7778f09299821e1b2d69b565f71eb600a812b541a980a7a312dfcc8eaa7f9e542bf78520f07b4
)

vcpkg_extract_source_archive(${ARCHIVE})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/wscpp TARGET_PATH share/wscpp)

vcpkg_copy_pdbs()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

if(VCPKG_LIBRARY_LINKAGE STREQUAL static)
    file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin)
    file(REMOVE ${CURRENT_PACKAGES_DIR}/lib/wscpp.lib ${CURRENT_PACKAGES_DIR}/debug/lib/wscpp.lib)
else()
    file(REMOVE ${CURRENT_PACKAGES_DIR}/lib/wscppstatic.lib ${CURRENT_PACKAGES_DIR}/debug/lib/wscppstatic.lib)
endif()

# Handle copyright
file(COPY ${SOURCE_PATH}/LICENCE DESTINATION ${CURRENT_PACKAGES_DIR}/share/wscpp)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/wscpp/LICENCE ${CURRENT_PACKAGES_DIR}/share/wscpp/copyright)

