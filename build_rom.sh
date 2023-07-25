# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/ArrowOS/android_manifest -b arrow-13.1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/itsmeNaraa/local_manifest.git --depth 1 -b ArrowOS .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch arrow_moonstone-userdebug
export BUILD_USERNAME=Kristo
export BUILD_HOSTNAME=Kristo
export KBUILD_USERNAME=Kristo
export KBUILD_HOSTNAME=Kristo
export TZ=Asia/Jakarta
export ALLOW_MISSING_DEPENDENCIES=true
m otapackage

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
