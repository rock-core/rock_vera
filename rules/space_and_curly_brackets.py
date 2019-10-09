# coding=utf-8
import re
failed_rx = re.compile('(\{(?!\s|$))|([^\s]})');

for filename in vera.getSourceFileNames():
    file = open(filename, 'rb');
    lineCounter = 1;
    lines = file.readlines();

    for line in lines:
        for mem in re.finditer(failed_rx, line):
            vera.report(filename, lineCounter, ''.join(['missing spaces inside { } at position ', str(mem.start() + 1)]));

        lineCounter = lineCounter + 1;

    file.close();

