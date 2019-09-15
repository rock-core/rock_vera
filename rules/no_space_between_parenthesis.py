# coding=utf-8
# The left and right parenthesis shall always be without surrounding spaces.
import re
whitespace_inside_parenthesis = re.compile('(\(\s.*\s\)|\(\s.*\)|\(.*\s\))');

for filename in vera.getSourceFileNames():
    file = open(filename, 'rb');
    lineCounter = 1;
    lines = file.readlines();

    for line in lines:
        for mem in re.finditer(whitespace_inside_parenthesis, line):
            vera.report(filename, lineCounter, ''.join(['no white space surrounding parenthesis']));

        lineCounter = lineCounter + 1;

    file.close();
