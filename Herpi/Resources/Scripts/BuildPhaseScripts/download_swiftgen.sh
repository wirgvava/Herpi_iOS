#!/bin/bash

LIBS_PATH="3rdparty"
SWIFTGEN_PATH="${LIBS_PATH}/swiftgen"

if [ "$(ls -A $SWIFTGEN_PATH)" ]
then
    exit
fi

mkdir -p $SWIFTGEN_PATH

SWIFTGEN_VERSION="6.6.2"
SWIFTGEN_URL="https://github.com/SwiftGen/SwiftGen/releases/download/${SWIFTGEN_VERSION}/swiftgen-${SWIFTGEN_VERSION}.zip"

TMP_DIR="tmp"

mkdir -p $TMP_DIR

cd $TMP_DIR && { curl -LO $SWIFTGEN_URL ; cd -; }

unzip "${TMP_DIR}/swiftgen-${SWIFTGEN_VERSION}" -d $SWIFTGEN_PATH

rm -rf $TMP_DIR
