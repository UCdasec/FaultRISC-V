from .Pattern import *

sys.path.append('..')
from Parser import Register, IntegerLiteral, Label, MemoryAddress, VariableType

vulnerable_instruction_list = {
    "Branch": {
        OptimizationLevel.O0: [
            [
                [
                    {'li'}, {Register}, {IntegerLiteral}
                ],
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu'}, {Register}, {Register}, {Label}
                ]
            ],
            [
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu'}, {Register}, {IntegerLiteral}, {Label}
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
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu'}, {Register}, {Register}, {Label}
                ]
            ],
            [
                [
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu'}, {Register}, {IntegerLiteral}, {Label}
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
                    {'beq', 'bne', 'blt', 'bgt', 'ble', 'bge', 'bgeu'}, {Register}, {IntegerLiteral}, {Label}
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
    "ConstantCoding": {
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
                    {'.word'}, {IntegerLiteral}
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
                    {'.word'}, {IntegerLiteral}
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
                    {'.word'}, {IntegerLiteral}
                ]
            ]
        ]
    }
}