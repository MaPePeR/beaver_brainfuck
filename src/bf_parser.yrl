Nonterminals
    program
    code
    instruction
.

Terminals
    move_right
    move_left
    increment
    decrement
    output
    input
    '['
    ']'
.

Rootsymbol program.

program -> code: '$1'.

code -> instruction code: ['$1'] ++ '$2'.
code -> '$empty': [].

instruction -> '[' code ']': { block, '$2' }.
instruction -> move_right:  '$1'.
instruction -> move_left:   '$1'.
instruction -> increment:   '$1'.
instruction -> decrement:   '$1'.
instruction -> output:      '$1'.
instruction -> input:       '$1'.


Erlang code.
