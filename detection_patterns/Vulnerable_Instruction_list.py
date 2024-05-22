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
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bltu'}, {Register}, {Register}, {Label}
                ]
            ],
            [
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bltu'}, {Register}, {IntegerLiteral}, {Label}
                ],
            ]
        ],
        OptimizationLevel.O1: [
            [
                [
                    {'li'}, {Register}, {IntegerLiteral}
                ],
                [
                    '__IGNORE_LINE__', {'li'}, {Register}, {IntegerLiteral}
                ],
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bltu'}, {Register}, {Register}, {Label}
                ]
            ],
            [
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bltu'}, {Register}, {IntegerLiteral}, {Label}
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
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bltu'}, {Register}, {IntegerLiteral}, {Label}
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
                    {'lw', 'ld'}, {Register}, {MemoryAddress}
                ],
                [
                    '__IGNORE_LINE__', {'sext.w'}, {Register}, {Register}
                ],
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bltu'}, {Register}, {Register}, {Label}
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
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bltu'}, {Register}, {Register}, {Label}
                ]
            ],
            [
                [
                    {'lbu'}, {Register}, {MemoryAddress}
                ],
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bltu'}, {Register}, {IntegerLiteral}, {Label}
                ]
            ]
        ],
        OptimizationLevel.O1: [
            [
                [
                    {'lbu'}, {Register}, {MemoryAddress}
                ],
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bltu'}, {Register}, {IntegerLiteral}, {Label}
                ]
            ],
            [
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bltu'}, {Register}, {Register}, {Label}
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
                    '__IGNORE_LINE__', {'addi', 'andi'}, {Register}, {Register}, {IntegerLiteral}
                ],
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bltu'}, {Register}, {IntegerLiteral}, {Label}
                ]
            ],
            [
                [
                    {'lhu'}, {Register}, {MemoryAddress}
                ],
                [
                    {'li'}, {Register}, {IntegerLiteral}
                ],
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bltu'}, {Register}, {Register}, {Label}
                ]
            ],
            [
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu', 'bltu'}, {Register}, {Register}, {Label}
                ],
                [
                    '__IGNORE_LINE__', {'ld', 'li'}, {Register}, {MemoryAddress, IntegerLiteral}
                ],
            ]
        ]
    }
}