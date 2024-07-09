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
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'seqz', 'bgtu', 'bleu'}, {Register}, {Register}, {Label}
                ]
            ],
            [
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'seqz', 'bgtu', 'bleu'}, {Register}, {IntegerLiteral}, {Label}
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
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'seqz', 'bgtu', 'bleu'}, {Register}, {Register}, {Label}
                ]
            ],
            [
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'seqz', 'bgtu', 'bleu'}, {Register}, {IntegerLiteral}, {Label}
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
                    '__IGNORE_LINE__', {'addiw', 'lui'}, {Register}, {Register, MemoryAddress}, {IntegerLiteral, None}
                ],
                [
                    '__OPTIONAL__', {'li', 'lbu', 'lui'}, {Register}, {IntegerLiteral, MemoryAddress}
                ],
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'seqz', 'bgtu', 'bleu'}, {Register}, {Register}, {Label}
                ]
            ],
            [
                [
                    {'li'}, {Register}, {IntegerLiteral}
                ],
                [
                    '__IGNORE_LINE__', {'lbu'}, {Register}, {MemoryAddress}
                ],
                [
                    '__IGNORE_LINE__', {'lbu'}, {Register}, {MemoryAddress}
                ],
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'seqz', 'bgtu', 'bleu'}, {Register}, {Register}, {Label}
                ]
            ],
            [
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'seqz', 'bgtu', 'bleu'}, {Register}, {IntegerLiteral}, {Label}
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
                    {'word', 'byte', 'short', '2byte', '4byte', '8byte', 'long', 'sleb128', 'uleb128', 'half'}, {IntegerLiteral}
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
                    {'word', 'byte', 'short', '2byte', '4byte', '8byte', 'long', 'sleb128', 'uleb128', 'half'}, {IntegerLiteral}
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
                    '__IGNORE_LINE__', {'lui'}, {Register}, {MemoryAddress}
                ],
                [
                    {'sb', 'sd', 'sh', 'sw'}, {Register}, {MemoryAddress}
                ]
            ],
            [
                [
                    {'word', 'byte', 'short', '2byte', '4byte', '8byte', 'long', 'sleb128', 'uleb128', 'half'}, {IntegerLiteral}
                ]
            ]
        ]
    },
    'LoopCheck': {
        OptimizationLevel.O0: [
            [
                [
                    {'lw', 'ld', 'lbu', 'lb', 'lh'}, {Register}, {MemoryAddress}
                ],
                [
                    '__OPTIONAL__', {'mv', 'sext.w'}, {Register}, {Register}
                ],
                [
                    {'lw', 'ld', 'lbu', 'lb', 'lh'}, {Register}, {MemoryAddress}
                ],
                [
                    '__IGNORE_LINE__', {'sext.w', 'slliw'}, {Register}, {Register}, {IntegerLiteral, None}
                ],
                [
                    '__IGNORE_LINE__', {'sext.w', 'sraiw'}, {Register}, {Register}, {IntegerLiteral, None}
                ],
                [
                    '__IGNORE_LINE__', {'slliw'}, {Register}, {Register}, {IntegerLiteral}
                ],
                [
                    '__IGNORE_LINE__', {'sraiw'}, {Register}, {Register}, {IntegerLiteral}
                ],
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'seqz', 'bgtu', 'bleu'}, {Register}, {Register}, {Label}
                ]
            ],
            [
                [
                    {'lw', 'lh', 'lbu'}, {Register}, {MemoryAddress}
                ],
                [
                    {'sext.w', 'slliw'}, {Register}, {Register}, {IntegerLiteral, None}
                ],
                [
                    '__IGNORE_LINE__', {'sraiw'}, {Register}, {Register}, {IntegerLiteral}
                ],
                [
                    {'li'}, {Register}, {IntegerLiteral}
                ],
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'seqz', 'bgtu', 'bleu'}, {Register}, {Register}, {Label}
                ]
            ],
            [
                [
                    {'lw', 'lbu', 'lhu', 'lh'}, {Register}, {MemoryAddress}
                ],
                [
                    '__IGNORE_LINE__', {'sext.w', 'slliw'}, {Register}, {Register}, {IntegerLiteral, None}
                ],
                [
                    '__IGNORE_LINE__', {'sraiw'}, {Register}, {Register}, {IntegerLiteral}
                ],
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'seqz', 'bgtu', 'bleu'}, {Register}, {IntegerLiteral}, {Label}
                ]
            ]
        ],
        OptimizationLevel.O1: [
            [
                [
                    {'lhu', 'lbu', 'li'}, {Register}, {MemoryAddress}
                ],
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'seqz', 'bgtu', 'bleu'}, {Register}, {IntegerLiteral}, {Label}
                ]
            ],
            [
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'seqz', 'bgtu', 'bleu'}, {Register}, {Register, IntegerLiteral}, {Label}
                ],
                [
                    '__IGNORE_LINE__', {'ld', 'li'}, {Register}, {MemoryAddress, IntegerLiteral}
                ],
            ]
        ],
        OptimizationLevel.O2: [
            # [
            #     [
            #         {'lbu'}, {Register}, {MemoryAddress}
            #     ],
            #     [
            #         '__IGNORE_LINE__', {'addi', 'addiw'}, {Register}, {Register}, {IntegerLiteral}
            #     ],
            #     [
            #         {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'seqz'}, {Register}, {IntegerLiteral}, {Label}
            #     ]
            # ],
            [
                [
                    '__OPTIONAL__', {'addi', 'addiw'}, {Register}, {Register}, {IntegerLiteral}
                ],
                [
                    '__IGNORE_LINE__', {'call'}, {Label}
                ],
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'seqz', 'bgtu', 'bleu'}, {Register}, {Register, IntegerLiteral}, {Label}
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
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'seqz', 'bgtu', 'bleu'}, {Register}, {Register}, {Label}
                ]
            ],
            # [
            #     [
            #         {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'seqz'}, {Register}, {Register}, {Label}
            #     ],
            #     [
            #         '__IGNORE_LINE__', {'ld', 'li'}, {Register}, {MemoryAddress, IntegerLiteral}
            #     ],
            # ]
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
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'seqz', 'bgtu', 'bleu'}, {Register}, {Register, IntegerLiteral}, {Label, None}
                ]
            ]
        ],
        OptimizationLevel.O1: [
            [
                [
                    {'call'}, {Label}
                ],
                [
                    '__OPTIONAL__', {'mv', 'sext.w', 'subw', 'addw'}, {Register}, {Register}, {Register, None}
                ],
                [
                    '__IGNORE_LINE__', {'li', 'lw'}, {Register}, {IntegerLiteral, MemoryAddress}
                ],
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'seqz', 'bgtu', 'bleu'}, {Register}, {Register, IntegerLiteral}, {Label, None}
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
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bleu', 'bltu', 'seqz', 'bgtu', 'bleu'}, {Register}, {Register, IntegerLiteral}, {Label, None}
                ]
            ]
        ]
    }
}