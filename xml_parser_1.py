from lxml import etree

from io import StringIO, BytesIO

root = etree.parse('entities_pddf.xml')

etree.tostring(root)