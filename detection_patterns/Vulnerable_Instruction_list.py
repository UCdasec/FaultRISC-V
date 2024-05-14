from Pattern import *

sys.path.append('..')
from Parser import Register, IntegerLiteral, Label

vulnerable_instruction_list = {
    "Branch": {
        OptimizationLevel.O0: {
            [
                [
                    {'li'}, {Register}, {IntegerLiteral}
                ],
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge'}, {Register}, {Register}, {Label}
                ]
            ],
            [
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge'}, {Register}, {IntegerLiteral}, {Label}
                ],
            ]
        },
        OptimizationLevel.O1: {
            [
                [
                    {'li'}, {Register}, {IntegerLiteral}
                ],
                [
                    '__IGNORE_LINE__', {'li'}, {Register}, {IntegerLiteral}
                ],
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge'}, {Register}, {Register}, {Label}
                ]
            ],
            [
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge'}, {Register}, {IntegerLiteral}, {Label}
                ],
            ],
            [
                [
                    {'slti'}, {Register}, {Register}, {IntegerLiteral}
                ],
            ],
            [
                [
                    {'seqz'}, {Register}, {Register}
                ],
            ],
        },
        OptimizationLevel.O2: {
            [
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge'}, {Register}, {IntegerLiteral}, {Label}
                ],
            ],
            [
                [
                    {'slti'}, {Register}, {Register}, {IntegerLiteral}
                ],
            ],
            [
                [
                    {'seqz'}, {Register}, {Register}
                ],
            ],
        },
    }
}