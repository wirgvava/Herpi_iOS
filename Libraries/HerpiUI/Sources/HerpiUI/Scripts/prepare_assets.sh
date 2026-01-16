#!/bin/bash

ROOT_PATH="../../../Sources/ReplyResources"
ASSETS_PATH="${ROOT_PATH}/Resources/Assets.xcassets"
GENERATED_PATH="${ROOT_PATH}/Generated"

ASSETS_OUTPUT="${GENERATED_PATH}/Assets.swift"

mkdir -p "${ROOT_PATH}/Generated"

sh download_swiftgen.sh

SWIFTGEN_PATH="3rdparty/swiftgen/bin/swiftgen"

$SWIFTGEN_PATH run xcassets $ASSETS_PATH --output $ASSETS_OUTPUT -p "xcassets-assets.stencil"
