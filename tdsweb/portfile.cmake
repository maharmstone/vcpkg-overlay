# Common Ambient Variables:
#   VCPKG_ROOT_DIR = <C:\path\to\current\vcpkg>
#   TARGET_TRIPLET is the current triplet (x86-windows, etc)
#   PORT is the current port name (zlib, etc)
#   CURRENT_BUILDTREES_DIR = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR  = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#

include(vcpkg_common_functions)
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/tdsweb-0.9)
vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/maharmstone/tdsweb/archive/0.9.tar.gz"
    FILENAME "tdsweb-0.9.tar.gz"
    SHA512 d5e8a8d49dd6dc790d20068a94e482db0b709865ea0c9b672770744759874f92ab86aa784113214b30c9436513d308ffb41b3f5165962923c4bb072059ef03b9
)
vcpkg_extract_source_archive(${ARCHIVE})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()
vcpkg_copy_pdbs()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

# Handle copyright
file(COPY ${SOURCE_PATH}/LICENCE DESTINATION ${CURRENT_PACKAGES_DIR}/share/tdsweb)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/tdsweb/LICENCE ${CURRENT_PACKAGES_DIR}/share/tdsweb/copyright)


