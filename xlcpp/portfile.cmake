# Common Ambient Variables:
#   VCPKG_ROOT_DIR = <C:\path\to\current\vcpkg>
#   TARGET_TRIPLET is the current triplet (x86-windows, etc)
#   PORT is the current port name (zlib, etc)
#   CURRENT_BUILDTREES_DIR = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR  = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#

include(vcpkg_common_functions)
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/xlcpp-0.9)
vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/maharmstone/xlcpp/archive/0.9.tar.gz"
    FILENAME "xlcpp-0.9.tar.gz"
    SHA512 89b6071204fd5127fb57b2cebed216150a9a81bb7d9f5308dfe15ad153cb8e5b75a7080c9667e3d960efb5dec9b16450ccccaecd54326579cea5df9946225a80
)
vcpkg_extract_source_archive(${ARCHIVE})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DBUILD_SAMPLE=OFF
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/xlcpp TARGET_PATH share/xlcpp)

vcpkg_copy_pdbs()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

# Handle copyright
file(COPY ${SOURCE_PATH}/LICENCE DESTINATION ${CURRENT_PACKAGES_DIR}/share/xlcpp)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/xlcpp/LICENCE ${CURRENT_PACKAGES_DIR}/share/xlcpp/copyright)

