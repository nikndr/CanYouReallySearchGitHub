#!/bin/zsh

# Environment variables:
# CI_AUDIENCE - type of users that are allowed to download build
# CI_CLOUD_URL - cloud URL to use {"development", "staging", "production"}
# CI_LOG_LEVEL - desired log level {"DEBUG", "INFO"}
# CI_DROP_LOCATION - path to put all artifacts at
# CI_BUILD_CFG - build configuration can be one of {"Release", "Debug"}
# CI_PROVISIONING_PROFILE - UUID of provisioning profile
# CI_SIGN_IDENTITY - certificate for code signing
# URL - publishing URL for itms-services plist and html generation
# BUILD_NUMBER - build number of app to be set
# VERSION - version of app to be set
# CHANGELOG_FILE - path to changelog file that is to be copied to destionation as well
# CI_BUNDLE_ID - application bundle id
# CI_EXPORT_METHOD - xcode archive export method: 'ad-hoc', 'app-store' etc
# CI_DEV_TEAM - xcode development team
# CI_GIGYA_KEY - Gygia API key
# CI_FACEBOOK_KEY - Facebook API key
# CI_GOOGLE_SERVICES_PLIST (GoogleService-Info.plist)
# CI_ITNS_APP_ID - App id in AppStoreConnect used for communication with AppStore
# XCODEPATH - path to desired xcode version
#set -x
#trap read debug

if [ -z "${CI_PROVISIONING_PROFILE}" ] || [ -z "${CI_SIGN_IDENTITY}" ] || [ -z "${CI_DROP_LOCATION}" ] || [ -z "${CI_BUNDLE_ID}" ] || [ -z "${CI_EXPORT_METHOD}" ] || [ -z "${CI_DEV_TEAM}" ] || [ -z "${CI_BUILD_CFG}" ] || [ -z "${CI_GIGYA_KEY}" ] || [ -z "${CI_ITNS_APP_ID}" ]; then
  echo Set CI_PROVISIONING_PROFILE, CI_SIGN_IDENTITY, CI_DROP_LOCATION, CI_BUNDLE_ID, CI_DEV_TEAM, CI_BUILD_CFG, CI_GIGYA_KEY, CI_EXPORT_METHOD and CI_ITNS_APP_ID first
  exit 1
fi

WORKSPACE_NAME="iCUE Mobile Dev.xcworkspace"
SCHEME_NAME="iCUE Mobile Dev"
CONFIG_NAME="${CI_BUILD_CFG}"

THISDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ARCHIVE_PATH="${THISDIR}/ProjectArchive.tmp.xcarchive"
PROFILE_NAME=""
EXPORT_OPTIONS_PLIST_TEMPLATE="${THISDIR}/build/exportOptionsTemplate.plist"
EXPORT_OPTIONS_PLIST="${THISDIR}/exportOptions.plist"

VER="$VERSION"
if [ -z "$VER" ]; then
  VER="1.0.0"
fi

TARGET_PATH="${CI_DROP_LOCATION}/${VER}"

PlistBuddy="/usr/libexec/PlistBuddy"

IPANAME="iCUE_${VER}.ipa"

function replace
{
  local file=$1
  local what=$2
  local to=$3
  local tempfile="${file}.temp"
  sed "s~${what}~${to}~g" "${file}" > "${tempfile}" && mv -f "${tempfile}" "${file}"
}

PPTEMPDIR=$(mktemp -d)
for i in ~/Library/MobileDevice/Provisioning\ Profiles/*; do
  filename=$(basename "$i")
  tempfile="${PPTEMPDIR}/${filename}.plist"
  security cms -D -i "$i" > "${tempfile}"
  UUID=$("${PlistBuddy}" -c "Print :UUID" "${tempfile}")
  if [ "${UUID}" "==" "${CI_PROVISIONING_PROFILE}" ]; then
    PROFILE_NAME=$("${PlistBuddy}" -c "Print :Name" "${tempfile}")
    echo Resolved provisioning profile ${CI_PROVISIONING_PROFILE} name: ${PROFILE_NAME}
  fi
  rm -f "${tempfile}"
done
rm -rf "${PPTEMPDIR}"
if [ -z "${PROFILE_NAME}" ]; then
  echo Cannot resolve provisioning profile name
  exit 1
fi

rm -rf "${ARCHIVE_PATH}"
mkdir -p "${TARGET_PATH}"

pushd "${THISDIR}"

function finish {
  popd
}
trap finish EXIT

set -e

#pod install
# Info.plist
PLIST_PATH="iCUE Mobile Dev/Resources/Info.plist"
"${PlistBuddy}" -c "Set :CFBundleIdentifier ${CI_BUNDLE_ID}" "${PLIST_PATH}"
"${PlistBuddy}" -c "Set :CFBundleVersion ${BUILD_NUMBER}" "${PLIST_PATH}"
"${PlistBuddy}" -c "Set :CFBundleShortVersionString ${VER}" "${PLIST_PATH}"
"${PlistBuddy}" -c "Set :ITNSAppIdentifier ${CI_ITNS_APP_ID}" "${PLIST_PATH}"
"${PlistBuddy}" -c "Set :GigyaAplKey ${CI_GIGYA_KEY}" "${PLIST_PATH}"
"${PlistBuddy}" -c "Set :FirmwareUpdateURL ${CI_FIRMWARE_UPDATE_URL}" "${PLIST_PATH}"
[ -z "$CI_FACEBOOK_KEY" ] || "${PlistBuddy}" -c "Set :FacebookAppID ${CI_FACEBOOK_KEY}" "${PLIST_PATH}"
[ -z "$CI_FACEBOOK_KEY" ] || "${PlistBuddy}" -c "Set :CFBundleURLTypes:0:CFBundleURLSchemes:0 fb${CI_FACEBOOK_KEY}" "${PLIST_PATH}"
# GoogleService-Info.plist
GOOGLE_PLIST_PATH="iCUE Mobile Dev/Resources/GoogleService-Info.plist"

cp -v ${CI_GOOGLE_SERVICES_PLIST} ${GOOGLE_PLIST_PATH}

BUILD_CONFIGURATION_FILE_PATH="iCUE Mobile Dev/Resources/BuildConfiguration.plist"
# BuildConfiguration.plist (show/hide social network buttons according to Key being set)
## [oleksandr] IGNORING SO FAR!
# "${PlistBuddy}" -c "Set :ShowFacebook ${+CI_FACEBOOK_KEY}" "${BUILD_CONFIGURATION_FILE_PATH}"
# "${PlistBuddy}" -c "Set :ShowGoogle ${+CI_FIREBASE_KEY}" "${BUILD_CONFIGURATION_FILE_PATH}"
# "${PlistBuddy}" -c "Set :ShowInstagram ${+CI_GIGYA_KEY}" "${BUILD_CONFIGURATION_FILE_PATH}"

"${PlistBuddy}" -c "Set :CloudUrl ${CI_CLOUD_URL}" "${BUILD_CONFIGURATION_FILE_PATH}"


ASSOCIATED_DOMAIN_KEY="com.apple.developer.associated-domains"
APP_ENTITLEMENTS_PATH="iCUE Mobile Dev/iCUE Mobile DevRelease.entitlements"
"${PlistBuddy}" -c "delete ${ASSOCIATED_DOMAIN_KEY}" "${APP_ENTITLEMENTS_PATH}"
"${PlistBuddy}" -c "add :${ASSOCIATED_DOMAIN_KEY} array" -c "add :${ASSOCIATED_DOMAIN_KEY}:0 string applinks:${CI_CLOUD_URL}" "${APP_ENTITLEMENTS_PATH}"

PROJECT_CONFIG_PATH="iCUE Mobile Dev.xcodeproj/project.pbxproj"
sed -i "" -e "s/PROVISIONING_PROFILE_SPECIFIER = \"\";/PROVISIONING_PROFILE_SPECIFIER = \"${CI_PROVISIONING_PROFILE}\";/g" ${PROJECT_CONFIG_PATH}
sed -i "" -e "s/CODE_SIGN_IDENTITY = \"\";/CODE_SIGN_IDENTITY = \"${CI_SIGN_IDENTITY}\";/g" ${PROJECT_CONFIG_PATH}
sed -i "" -e "s/DEVELOPMENT_TEAM = UNDEFINED;/DEVELOPMENT_TEAM = ${CI_DEV_TEAM};/g" ${PROJECT_CONFIG_PATH}
sed -i "" -e "s/PRODUCT_BUNDLE_IDENTIFIER = UNDEFINED;/PRODUCT_BUNDLE_IDENTIFIER = ${CI_BUNDLE_ID};/g" ${PROJECT_CONFIG_PATH}

SUBMODULES=('ICUEUtil' 'ICUERealmConnector' 'ICUEAuthService' 'ICUECore' 'ICUEWindowManager' 'ICUELogging' 'ICUEToaster')
for module in $SUBMODULES; do
  module_config_path="${module}/${module}.xcodeproj/project.pbxproj"
  sed -i "" -e "s/CODE_SIGN_IDENTITY = \"\";/CODE_SIGN_IDENTITY = \"${CI_SIGN_IDENTITY}\";/g" ${module_config_path}
  sed -i "" -e "s/DEVELOPMENT_TEAM = UNDEFINED;/DEVELOPMENT_TEAM = ${CI_DEV_TEAM};/g" ${module_config_path}
  sed -i "" -e "s/PRODUCT_BUNDLE_IDENTIFIER = UNDEFINED;/PRODUCT_BUNDLE_IDENTIFIER = ${CI_BUNDLE_ID}.${module};/g" ${module_config_path}
done

if [ -n "${CI_BUNDLE_ID}" ]; then
  "${PlistBuddy}" -c "Set :CFBundleIdentifier ${CI_BUNDLE_ID}" "${PLIST_PATH}"
fi

cp -f "${EXPORT_OPTIONS_PLIST_TEMPLATE}" "${EXPORT_OPTIONS_PLIST}"
replace "${EXPORT_OPTIONS_PLIST}" "%METHOD%" "${CI_EXPORT_METHOD}"
replace "${EXPORT_OPTIONS_PLIST}" "%APPID%" "${CI_BUNDLE_ID}"
replace "${EXPORT_OPTIONS_PLIST}" "%CERTNAME%" "${CI_SIGN_IDENTITY}"
replace "${EXPORT_OPTIONS_PLIST}" "%PROFILENAME%" "${CI_PROVISIONING_PROFILE}"
replace "${EXPORT_OPTIONS_PLIST}" "%TEAMID%" "${CI_DEV_TEAM}"
replace "${EXPORT_OPTIONS_PLIST}" "%DESTINATION%" "export"

# extra keys for build (pragmas)
  CUSTOM_BUILD_FLAGS="OTHER_SWIFT_FLAGS="
if [ "$CI_AUDIENCE" = "Dev" ]; then
  CUSTOM_BUILD_FLAGS="${CUSTOM_BUILD_FLAGS}-D CI_AUDIENCE_DEV"
elif [ "$CI_AUDIENCE" = "Corsair Test" ]; then
  CUSTOM_BUILD_FLAGS="${CUSTOM_BUILD_FLAGS}-D CI_AUDIENCE_CORSAIR_TEST"
elif [ "$CI_AUDIENCE" = "Corsair Public" ]; then
  CUSTOM_BUILD_FLAGS="${CUSTOM_BUILD_FLAGS}-D CI_AUDIENCE_CORSAIR_PUBLIC"
fi

if [ "$CI_LOG_LEVEL" = "DEBUG" ]; then
    CUSTOM_BUILD_FLAGS="${CUSTOM_BUILD_FLAGS} -D CI_LOG_LEVEL_DEBUG"
else
    CUSTOM_BUILD_FLAGS="${CUSTOM_BUILD_FLAGS} -D CI_LOG_LEVEL_INFO"
fi

"${XCODEPATH}"/Contents/Developer/usr/bin/xcodebuild -workspace "${WORKSPACE_NAME}" -scheme "${SCHEME_NAME}" -configuration "${CONFIG_NAME}" clean
"${XCODEPATH}"/Contents/Developer/usr/bin/xcodebuild -archivePath "${ARCHIVE_PATH}" -workspace "${WORKSPACE_NAME}" -scheme "${SCHEME_NAME}" -configuration "${CONFIG_NAME}" archive ${CUSTOM_BUILD_FLAGS}
"${XCODEPATH}"/Contents/Developer/usr/bin/xcodebuild -exportArchive -archivePath "${ARCHIVE_PATH}" -exportPath "${TARGET_PATH}/${IPANAME}" -exportOptionsPlist "${EXPORT_OPTIONS_PLIST}"

BUNDLEID=$("${PlistBuddy}" -c "Print ApplicationProperties:CFBundleIdentifier" "${ARCHIVE_PATH}/Info.plist")

if [ -n "${URL}" ]; then
  TARGET_INSTALL_HTML="${TARGET_PATH}/install.html"
  cp "${THISDIR}/build/install.html" "${TARGET_INSTALL_HTML}"
  replace "${TARGET_INSTALL_HTML}" "%PLISTURL%" "${URL}${VER}/install.plist"

  TARGET_INSTALL_PLIST="${TARGET_PATH}/install.plist"
  cp "${THISDIR}/build/install.plist" "${TARGET_INSTALL_PLIST}"
  replace "${TARGET_INSTALL_PLIST}" "%BUNDLEID%" "${BUNDLEID}"
  replace "${TARGET_INSTALL_PLIST}" "%BUILD_NUMBER%" "${VER}"
  replace "${TARGET_INSTALL_PLIST}" "%IPAURL%" "${URL}${VER}/${IPANAME}"
fi

if [ -n "${CHANGELOG_FILE}" ]; then
  cp "${CHANGELOG_FILE}" "${TARGET_PATH}/"
fi

pushd "${ARCHIVE_PATH}"
set +e
zip -r "${TARGET_PATH}/dSYMs.zip" dSYMs
set -e
popd
