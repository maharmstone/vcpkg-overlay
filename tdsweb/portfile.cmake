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
    SHA512 cf9e050752942f1c336ca3b851e66a4a1f2cf8a3650c11b2ccc672a6586e1857af9d9a65179b61efdd84c3526987ce6f70593a0d2f86ce331701386136da9860
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


