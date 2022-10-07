#! /usr/bin/python
import xml.etree.ElementTree as ET
import re

# https://docs.python.org/3/library/xml.etree.elementtree.html#xml.etree.ElementTree.Element.find


def getExternalCategoryDefinitionNames(file_name):
    NAMESPACE = '{xmlns://www.fortifysoftware.com/schema/externalMetadata}'
    external_cats = []

    tree = ET.parse(file_name)
    root = tree.getroot()
    externalList = root.findall('.//{0}ExternalList'.format(NAMESPACE))
    for e in externalList:
        if "OWASP ASVS 4.0" in e.find(NAMESPACE + 'Name').text:
            external_cat = e.findall(NAMESPACE + 'ExternalCategoryDefinition')

            for definition in external_cat:
                external_cats.append(definition.find(NAMESPACE + 'Name').text)
            break
    
    # print(external_cats)
    return external_cats

#TODO: Parse and write CDATA
# def replaceExternalCategoryDefinitionNames():
#     external_cats = []
#     with open('/home/bruce/rules/config/es/standardsMappingDescriptions.xml', encoding='utf-8', mode='r') as xml_file:
#         ET.register_namespace("", "xmlns://www.fortifysoftware.com/schema/externalMetadata")
#         ET.register_namespace("xsi", "htt//www.w3.org/2001/XMLSchema-instance")
#         tree = ET.parse(xml_file)
#         root = tree.getroot()
#         externalList = root.findall('.//{0}ExternalList'.format(NAMESPACE))
#         for e in externalList:
#             if "OWASP ASVS 4.0" in e.find(NAMESPACE + 'Name').text:

#                 for definition in e.iter(NAMESPACE + 'Name'):
#                     new_definition = definition.text + " CHANGE"
#                     definition.text = new_definition
#                     print(definition.text)
#         tree.write("/home/bruce/rules/config/es/new_standardsMappingDescriptions.xml", encoding='utf-8')

def replaceLines(old_names, new_names, file_name):
    new_file_name = file_name + ".NEW"

    print("Replacing lines in: " + file_name)

    with open(file_name, "r") as fr:
        xml_data = fr.read()
        for old_str in old_names:
            new_list = list(filter(lambda l: l.startswith(old_str), new_names))

            if len(new_list) < 1:
                print("\"{}\" not found in {}!".format(old_str, file_name))
            elif len(new_list) > 1:
                print("More than one match! Str: \"{}\". File: {}".format(old_str, file_name))
            # new_str = str(new_list[0])
            new_str = str(new_list[0])

            # print("{0}".format(new_str))
            xml_data = re.sub(r"(.*<Name>){}(<\/Name>)".format(old_str), '\t\t\t<Name>{0}</Name>'.format(new_str), xml_data, 1)
    fr.close()

    with open(new_file_name, "w") as fw:
        fw.write(xml_data)
    fw.close()


def main():
    # Skipping config/ja/standardsMappingDescriptions.xml
    mappings = [
        "/home/bruce/rules/config/es/standardsMappingDescriptions.xml",
        "/home/bruce/rules/config/ko/standardsMappingDescriptions.xml",
        "/home/bruce/rules/config/pt_BR/standardsMappingDescriptions.xml",
        "/home/bruce/rules/config/zh_TW/standardsMappingDescriptions.xml",
        "/home/bruce/rules/config/zh_CN/standardsMappingDescriptions.xml",
    ]
    new_names = getExternalCategoryDefinitionNames("/home/bruce/rules/config/en/standardsMappingDescriptions.xml")

    for lang in mappings:
        old_names = getExternalCategoryDefinitionNames(lang)
        replaceLines(old_names, new_names, lang)


if __name__ == "__main__":
    main()
    print("Done")
