from .Pattern import *

sys.path.append('..')
from Parser import Register, IntegerLiteral, Label, MemoryAddress, VariableType

vulnerable_instruction_list = {
    'Branch': {
        OptimizationLevel.O0: [
            [
                [
                    {'li'}, {Register}, {IntegerLiteral}
                ],
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'seqz'}, {Register}, {Register}, {Label}
                ]
            ],
            [
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'seqz'}, {Register}, {IntegerLiteral}, {Label}
                ],
            ]
        ],
        OptimizationLevel.O1: [
            [
                [
                    {'li'}, {Register}, {IntegerLiteral}
                ],
                [
                    '__OPTIONAL__', {'li'}, {Register}, {IntegerLiteral}
                ],
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'seqz'}, {Register}, {Register}, {Label}
                ]
            ],
            [
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'seqz'}, {Register}, {IntegerLiteral}, {Label}
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
        ],
        OptimizationLevel.O2: [
            [
                [
                    {'li'}, {Register}, {IntegerLiteral}
                ],
                [
                  '__IGNORE_LINE__', {'addiw'}, {Register}, {Register}, {IntegerLiteral}
                ],
                [
                    '__OPTIONAL__', {'li', 'lbu', 'lui'}, {Register}, {IntegerLiteral, MemoryAddress}
                ],
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'seqz'}, {Register}, {Register}, {Label}
                ]
            ],
            [
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'seqz'}, {Register}, {IntegerLiteral}, {Label}
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
        ],
    },
    'ConstantCoding': {
        OptimizationLevel.O0: [
            [
                [
                    {VariableType.INTEGER}
                ]
            ],
            [
                [
                    {'sb', 'sd', 'sh', 'sw'}, {IntegerLiteral}, {MemoryAddress}
                ]
            ],
            [
                [
                    {'li'}, {Register}, {IntegerLiteral}
                ],
                [
                    {'sb', 'sd', 'sh', 'sw'}, {Register}, {MemoryAddress}
                ]
            ],
            [
                [
                    {'word'}, {IntegerLiteral}
                ]
            ]
        ],
        OptimizationLevel.O1: [
            [
                [
                    {VariableType.INTEGER}
                ]
            ],
            [
                [
                    {'sb', 'sd', 'sh', 'sw'}, {IntegerLiteral}, {MemoryAddress}
                ]
            ],
            [
                [
                    {'li'}, {Register}, {IntegerLiteral}
                ],
                [
                    '__IGNORE_LINE__', {'lui'}, {Register}, {MemoryAddress}
                ],
                [
                    {'sb', 'sd', 'sh', 'sw'}, {Register}, {MemoryAddress}
                ]
            ],
            [
                [
                    {'word'}, {IntegerLiteral}
                ]
            ]
        ],
        OptimizationLevel.O2: [
            [
                [
                    {VariableType.INTEGER}
                ]
            ],
            [
                [
                    {'sb', 'sd', 'sh', 'sw'}, {IntegerLiteral}, {MemoryAddress}
                ]
            ],
            [
                [
                    {'li'}, {Register}, {IntegerLiteral}
                ],
                [
                    {'sb', 'sd', 'sh', 'sw'}, {Register}, {MemoryAddress}
                ]
            ],
            [
                [
                    {'word'}, {IntegerLiteral}
                ]
            ]
        ]
    },
    'LoopCheck': {
        OptimizationLevel.O0: [
            [
                [
                    {'lw', 'ld'}, {Register}, {MemoryAddress}
                ],
                [
                    '__OPTIONAL__', {'mv'}, {Register}, {Register}
                ],
                [
                    {'lw', 'ld'}, {Register}, {MemoryAddress}
                ],
                [
                    '__IGNORE_LINE__', {'sext.w'}, {Register}, {Register}
                ],
                [
                    '__IGNORE_LINE__', {'sext.w'}, {Register}, {Register}
                ],
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'seqz'}, {Register}, {Register}, {Label}
                ]
            ],
            [
                [
                    {'lw'}, {Register}, {MemoryAddress}
                ],
                [
                    {'sext.w'}, {Register}, {Register}
                ],
                [
                    {'li'}, {Register}, {IntegerLiteral}
                ],
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'seqz'}, {Register}, {Register}, {Label}
                ]
            ],
            [
                [
                    {'lbu'}, {Register}, {MemoryAddress}
                ],
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'seqz'}, {Register}, {IntegerLiteral}, {Label}
                ]
            ]
        ],
        OptimizationLevel.O1: [
            [
                [
                    {'lhu', 'lbu', 'li'}, {Register}, {MemoryAddress}
                ],
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'seqz'}, {Register}, {IntegerLiteral}, {Label}
                ]
            ],
            [
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'seqz'}, {Register}, {Register, IntegerLiteral}, {Label}
                ],
                [
                    '__IGNORE_LINE__', {'ld', 'li'}, {Register}, {MemoryAddress, IntegerLiteral}
                ],
            ]
        ],
        OptimizationLevel.O2: [
            [
                [
                    {'lbu'}, {Register}, {MemoryAddress}
                ],
                [
                    '__IGNORE_LINE__', {'addi', 'andi', 'addiw'}, {Register}, {Register}, {IntegerLiteral}
                ],
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'seqz'}, {Register}, {IntegerLiteral}, {Label}
                ]
            ],
            [
                [
                    {'lhu', 'lbu', 'li'}, {Register}, {MemoryAddress}
                ],
                [
                    {'lhu', 'lbu', 'li'}, {Register}, {IntegerLiteral}
                ],
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'seqz'}, {Register}, {Register}, {Label}
                ]
            ],
            [
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'seqz'}, {Register}, {Register}, {Label}
                ],
                [
                    '__IGNORE_LINE__', {'ld', 'li'}, {Register}, {MemoryAddress, IntegerLiteral}
                ],
            ]
        ]
    },
    'Bypass': {
        OptimizationLevel.O0: [
            [
                [
                    {'call'}, {Label}
                ],
                [
                    {'mv', 'fmv.d', 'sext.w'}, {Register}, {Register}
                ],
                [
                    '__IGNORE_LINE__', {'fcvt.w.d'}, {Register}, {Register}, {Label}
                ],
                [
                    '__SECURE__', {'sw', 'sb', 'sd'}, {Register}, {MemoryAddress}
                ],
                [
                    '__SECURE__', {'lw', 'lb', 'lbu', 'ld'}, {Register}, {MemoryAddress}
                ],
                [
                    {'__OPTIONAL__', '__SECURE__'}, {'lw', 'lb', 'lbu', 'ld'}, {Register}, {MemoryAddress}
                ],
                [
                    '__OPTIONAL__', {'mv'}, {Register}, {Register}
                ],
                [
                    '__IGNORE_LINE__', {'li'}, {Register}, {IntegerLiteral}
                ],
                [
                    '__IGNORE_LINE__', {'sext.w', 'andi'}, {Register}, {Register}, {None, IntegerLiteral}
                ],
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'seqz'}, {Register}, {Register, IntegerLiteral}, {Label, None}
                ]
            ]
        ],
        OptimizationLevel.O1: [
            [
                [
                    {'call'}, {Label}
                ],
                [
                    '__OPTIONAL__', {'mv', 'sext.w'}, {Register}, {Register}
                ],
                [
                    '__IGNORE_LINE__', {'li'}, {Register}, {IntegerLiteral}
                ],
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bltu', 'seqz'}, {Register}, {Register, IntegerLiteral}, {Label, None}
                ]
            ]
        ],
        OptimizationLevel.O2: [
            [
                [
                    {'call'}, {Label}
                ],
                [
                    '__OPTIONAL__', {'mv', 'sext.w'}, {Register}, {Register}
                ],
                [
                    '__IGNORE_LINE__', {'li'}, {Register}, {IntegerLiteral}
                ],
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bltu', 'seqz'}, {Register}, {Register, IntegerLiteral}, {Label, None}
                ]
            ]
        ]
    },
    'DefaultFail': {
        OptimizationLevel.O0: [
            [
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'bgtu'}, {Register}, {Register, IntegerLiteral}, {Label, None}
                ],
                [
                    'j', {Label}
                ]
            ]
        ],
        OptimizationLevel.O1: [
            [
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'bgtu'}, {Register}, {Register, IntegerLiteral}, {Label, None}
                ],
                [
                    {'j', 'jr'}, {Label, Register}
                ],
                [
                    'ret'
                ],
                [
                    'call'
                ],
            ]
        ],
        OptimizationLevel.O2: [
            [
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'bgtu'}, {Register}, {Register, IntegerLiteral}, {Label, None}
                ],
                [
                    'j', {Label}
                ],
                [
                    'ret'
                ],
                [
                    'call'
                ],
            ]
        ]
    }
}