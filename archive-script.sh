# Convenience 
alias PlistBuddy=/usr/libexec/PlistBuddy

function replace
{
  local file=$1
  local what=$2
  local to=$3
  local tempfile="${file}.temp"
  sed "s~${what}~${to}~g" "${file}" > "${tempfile}" && mv -f "${tempfile}" "${file}"
}

# Info Plist
INFO_PLIST_PATH="./CanYouReallySearchGitHub/Info.plist"

# Export Options Plist
EXPORT_OPTIONS_PLIST_TEMPLATE="exportOptionsTemplate.plist"
EXPORT_OPTIONS_PLIST="exportOptions.plist"

# Plist template values
EXPORT_METHOD="development"
BUNDLE_ID="ua.edu.ukma.nmarhal.CanYouReallySearchGitHub"
CERTIFICATE_NAME="iPhone Developer: Nikandr Marhal"
PROFILE_NAME="UKMA Edu Shared Profile"
TEAM_ID="VNU8KKW4GG"
DESTINATION="export"

# Archive and Export configuration
SCHEME_NAME="CanYouReallySearchGitHub (Release)"
VERSION=$1
if [ -z "${VERSION}" ]; then 
    VERSION="v_placeholder"
fi
ARCHIVE_PATH="./ARCHIVES/${VERSION}.xcarchive"
TARGET_PATH="./TARGETS/${VERSION}"

# Set values for exportOptions .plist
cp -f $EXPORT_OPTIONS_PLIST_TEMPLATE $EXPORT_OPTIONS_PLIST
replace "${EXPORT_OPTIONS_PLIST}" "%EXPORT_METHOD%" "${EXPORT_METHOD}"
replace "${EXPORT_OPTIONS_PLIST}" "%BUNDLE_ID%" "${BUNDLE_ID}"
replace "${EXPORT_OPTIONS_PLIST}" "%CERTIFICATE_NAME%" "${CERTIFICATE_NAME}"
replace "${EXPORT_OPTIONS_PLIST}" "%PROFILE_NAME%" "${PROFILE_NAME}"
replace "${EXPORT_OPTIONS_PLIST}" "%TEAM_ID%" "${TEAM_ID}"
replace "${EXPORT_OPTIONS_PLIST}" "%DESTINATION%" "${DESTINATION}"

# Clean build folder
xcodebuild clean \
-workspace CanYouReallySearchGitHub.xcworkspace \
-scheme "${SCHEME_NAME}" \
-configuration Release \
-destination generic/platform=iOS

# Create archive
xcodebuild archive \
-archivePath "${ARCHIVE_PATH}" \
-workspace CanYouReallySearchGitHub.xcworkspace \
-scheme "${SCHEME_NAME}" \
-configuration Release \
-destination generic/platform=iOS

# Export archive
xcodebuild -exportArchive \
-archivePath "${ARCHIVE_PATH}" \
-exportPath "${TARGET_PATH}" \
-exportOptionsPlist "${EXPORT_OPTIONS_PLIST}"
