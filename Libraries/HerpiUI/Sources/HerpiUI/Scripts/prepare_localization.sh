#!/bin/bash

ROOT_PATH="../../../Sources/ReplyResources"
RESOURCES_PATH="${ROOT_PATH}/Resources"
LOCALIZATION_PATH="${RESOURCES_PATH}/Localization"

mkdir -p "${ROOT_PATH}/Generated"


LOCALIZATION_SAMPLE_PATH="${LOCALIZATION_PATH}/en.lproj/Localizable.strings"
LOCALIZATION_OUTPUT="${ROOT_PATH}/Generated/Localizable.swift"

sh download_swiftgen.sh

SWIFTGEN_PATH="3rdparty/swiftgen/bin/swiftgen"

$SWIFTGEN_PATH run strings $LOCALIZATION_SAMPLE_PATH --output $LOCALIZATION_OUTPUT -p "strings-swift4.stencil"
