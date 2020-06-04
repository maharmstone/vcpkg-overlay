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
    SHA512 5686f86f8f919032724922fd11359c1b5800a1f53bb87857ce92cddf2afdb01fa8a763741e94c89572eb8d09d1129a5f6a73aaca2a5c2e33f50eebd2bd51aefd
 )

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DBUILD_SAMPLE=OFF
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

