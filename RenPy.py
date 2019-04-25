#!/usr/bin/env python

'''RenPy - A parser for converting custom NC code into pure Fanuc Macro B NC code'''
from __future__ import print_function
from lib.RenPyConstants import *
import re
import sys
import os.path

def eprint(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)

class RenPy:
    input_file  = ''
    input_lines = None
    output_file = None
    USR_VARS    = []
    variables   = []
    proccessed  = []


    def __init__(self, filename):
        self.input_file = filename
        self.output_file = os.path.basename(self.input_file.replace('.renpy', '.NC'))

        with open(self.input_file, 'r') as input_file:
            self.input_lines = input_file.read().splitlines()

    def run(self):
        #self.syntax_checks()
        self.process_vars()
        self.process_input()
        self.writeout()

    def syntax_checks(self):
        errors = False

        if self.input_lines[0] is not '%':
            eprint('SYNTAX ERROR: Program must begin with a %')
            errors = True

        if re_PROGHEADER.search(self.input_lines[1]) is None:
            eprint('SYNTAX ERROR: The program\'s second line must follow the format [O|:]1234 (PROGRAM TITLE)')
            errors = True

        if self.input_lines[len(self.input_lines)-1] is not '%':
            eprint('SYNTAX ERROR: Program must end with a %')
            errors = True

        if errors:
            exit(1)

    def process_vars(self):
        end = 0

        for i, line in zip(range(len(self.input_lines)), self.input_lines):
            if line is '%':
                end = i
                break

        for vardef in self.input_lines[:end]:
            parts = vardef.split(":")

            self.USR_VARS.append((parts[0].strip(), parts[1].strip()))

        del self.input_lines[:end]

    def process_input(self):
        for line in self.input_lines:
            for usrvar, repl in self.USR_VARS:
                line = line.replace(usrvar, repl)

            line = self.interpolator(re.compile(r'\s?(->\s?)'), {'-> ':'GOTO', '->':'GOTO'}, line)
            line = self.interpolator(re_REN_CYCLES, REN_CYCLES, line)
            line = self.interpolator(re_OPERATORS, OPERATORS, line)
            line = self.interpolator(re_VARIABLES, VARIABLES, line)
            line = self.interpolator(re.compile(r'(\s=\s)'), {' = ': '='}, line)

            self.proccessed.append(line)

    def interpolator(self, regex, replacements, line):
        matches = regex.findall(line)

        if matches is not None:
            for match in matches:
                line = line.replace(match, replacements[match])

        return line

    def writeout(self):
        output = '\n'.join(self.proccessed)

        try:
            self.output_file = os.path.abspath(os.path.join('NC', self.output_file))

            with open(self.output_file, 'w') as fd:
                print(output, file=fd)
            print('Wrote program to %s' % self.output_file)
        except Exception as e:
            print('ERROR: There was a problem writing out the file.')
            print('EXCEPTION: %s' % str(e))


if __name__ == '__main__':
    try:
        file = sys.argv[1]
    except:
        print('No file to interpret')

    renpy = RenPy(file)
    renpy.run()
