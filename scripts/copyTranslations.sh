#! /bin/bash
set -x #echo on

SOURCE_DIR="$DOWNLOADS/Delivery - SSR R4 Static Translation"
declare -A langs
langs["es"]="ES"
langs["ja"]="JP"
langs["ko"]="KO"
langs["pt_BR"]="PTBR"
langs["zh_CN"]="CN"
langs["zh_TW"]="TW"

#
# Descriptions
#
cp "${SOURCE_DIR}"/CN/*_desc.xml descriptions/zh_CN/.
cp "${SOURCE_DIR}"/ES/*_desc.xml descriptions/es/.
cp "${SOURCE_DIR}"/JP/*_desc.xml descriptions/ja/.
cp "${SOURCE_DIR}"/KO/*_desc.xml descriptions/ko/.
cp "${SOURCE_DIR}"/PTBR/*_desc.xml descriptions/pt_BR/.
cp "${SOURCE_DIR}"/TW/*_desc.xml descriptions/zh_TW/.

#
# standardsMappingDescriptions.xml
#
cp "${SOURCE_DIR}"/CN/standardsMappingDescriptions.xml config/zh_CN/standardsMappingDescriptions.xml
cp "${SOURCE_DIR}"/ES/standardsMappingDescriptions.xml config/es/standardsMappingDescriptions.xml
cp "${SOURCE_DIR}"/JP/standardsMappingDescriptions.xml config/ja/standardsMappingDescriptions.xml
cp "${SOURCE_DIR}"/KO/standardsMappingDescriptions.xml config/ko/standardsMappingDescriptions.xml
cp "${SOURCE_DIR}"/PTBR/standardsMappingDescriptions.xml config/pt_BR/standardsMappingDescriptions.xml
cp "${SOURCE_DIR}"/TW/standardsMappingDescriptions.xml config/zh_TW/standardsMappingDescriptions.xml

#
# Create new dirs and Copy rpbuilder.properties for each new rulepack
#
# declare -a arr=("es" "ja" "ko" "pt_BR" "zh_CN" "zh_TW")
# declare -a packs=("comm_cloud" "comm_universal" "core_universal" "java_security_assistant_config")

# for i in "${arr[@]}"
# do
#     files=$(diff -q config/en config/$i | grep "Only in" | sed -e 's/^Only in config\/en: //' )

#     for f in $files
#     # for f in "${packs[@]}"
#     do
#         mkdir config/$i/$f
#         cp config/en/$f/rpbuilder.properties config/$i/$f/rpbuilder.properties
#         sed -i "s/\\/en\\//\\/${i}\\//g" config/$i/$f/rpbuilder.properties
#         cp "${SOURCE_DIR}"/${langs[${i}]}/${f}_definition.xml config/$i/$f/${f}_definition.xml
#         sed -i "s/<SKU>RUL.*<\\/SKU>/<SKU>RUL${RANDOM}<\\/SKU>/g" config/$i/$f/${f}_definition.xml
#         sed -i "s/<RulePackID>.*<\\/RulePackID>/<RulePackID>$(uuidgen | tr 'a-z' 'A-Z')<\\/RulePackID>/g" config/$i/$f/${f}_definition.xml
#     done
# done

