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
    REPO maharmstone/wscpp
    REF 0.9
    SHA512 291ef35fa0544d538e0e3c5da481be4703365f677de5797e46aa27e390490a5caf7b4c3d580792705f9e4a863cd6cda429026b42fa3ea7a78423da4114c2b5fc
 )

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

