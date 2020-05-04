import xml.etree.ElementTree as ET
root = ET.parse('entities_mini.xml').getroot()

for elem in root.findall('ChangeItem'):
    root.remove(elem)

(root)


"""
elemList = []
for elem in root.findall('ChangeItem'):
    #elemList.append(elem.tag)
    root.remove(elem)
#print(len(elemList))

ET.dump(root)
"""
"""

elemList = []
elemList_type = []

for elem in root.iter():
    if elem.tag == 'Action':
        elemList.append(elem.tag)
    if elem.tag == 'Action' and elem.get('Type') == 'comment':
        elemList_type.append(elem.tag)

# print len of list
print(len(elemList))
print(len(elemList_type))

# now I remove duplicities - by convertion to set and back to list
elemList = list(set(elemList))

# Just printing out the result
print(elemList)
"""