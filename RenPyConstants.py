# RenPyConstants

import re


VARIABLES = {
# MACRO VARS
    '#A' : '#1',
    '#B' : '#2',
    '#C' : '#3',
    '#I' : '#4',
    '#J' : '#5',
    '#K' : '#6',
    '#D' : '#7',
    '#E' : '#8',
    '#F' : '#9',
    '#H' : '#11',
    '#M' : '#13',
    '#Q' : '#17',
    '#R' : '#18',
    '#S' : '#19',
    '#T' : '#20',
    '#U' : '#21',
    '#V' : '#22',
    '#W' : '#23',
    '#X' : '#24',
    '#Y' : '#25',
    '#Z' : '#26',
# RENISHAW VARS
#    '#X_ERROR'    : '#140',
#    '#Y_ERROR'    : '#141',
#    '#Z_ERROR'    : '#142',
#    '#ERROR_FLAG' : '#148',
}

OPERATORS = {
    '==' : 'EQ',
    '!=' : 'NE',
    '>'  : 'GT',
    '<'  : 'LT',
    '>=' : 'GE',
    '<=' : 'LE',
    '->' : 'GOTO',
}

REN_CYCLES = {
    'PROBE_ON'   : '( PROBE ON )\nG65 P9832',
    'PROBE_OFF'  : '( PROBE OFF )\nG65 P9833',
    'POSITION'   : '( PROTECTED POSITIONING )\nG65 P9810',
    'SURFACE'    : '( SINGLE SURFACE MEASURE )\nG65 P9811',
    'WEB_POCKET' : 'G65 P9812',
}

re_COMMENT    = re.compile(r'\(.*\)')
re_VARIABLE   = re.compile(r'#([a-zA-Z0-9]+)')
re_OPERATORS  = re.compile(r'(==|!=|>|<|>=|<=)')
re_GOTO       = re.compile(r'\s?(\=\>\s?)[0-9]+')
re_PROGHEADER = re.compile(r'^(O|\:)[0-9]{4}\s?\(.*\)')
re_VARIABLES  = re.compile(r'(%s)' % '|'.join(list(VARIABLES.keys())))
re_REN_CYCLES = re.compile(r'^(%s)' % '|'.join(list(REN_CYCLES.keys())))
