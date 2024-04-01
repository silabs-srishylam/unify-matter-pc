#!/bin/bash

if [ -z "${UCL_XML_PATH}" ]
then
  echo "Please direct the environment variable UCL_XML_PATH to the location of the Unify DotDot XML files."
  exit 1
fi

pushd ../third_party/connectedhomeip

echo "Generating Unify Data Model Templates"

output_dir=../../../linux/zap-generated/data-models

rm -rf $output_dir
mkdir -p $output_dir

./scripts/tools/zap/generate.py \
    -z ${UCL_XML_PATH}/library.xml \
    -t ../../../linux/templates/data_models/unify_data_model.json \
    -o $output_dir \
    ../../../unify-matter-pc-common/unify-matter-pc.zap

./scripts/tools/zap/generate.py \
    -t ../../../linux/templates/data_models/matter_data_model.json \
    -o $output_dir \
    ../../../unify-matter-pc-common/unify-matter-pc.zap

find $output_dir -type f -name "*.cpp" -o -name "*.c" -o -name "*.h" -o -name "*.hpp" -o -name "*.inc" | xargs clang-format -i -style=WebKit

popd
