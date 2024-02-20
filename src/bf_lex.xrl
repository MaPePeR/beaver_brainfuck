Definitions.

IGNORE = [^<>+.,\[\]-]+

Rules.
>           : {token, {move_right, TokenLine}}.
<           : {token, {move_left, TokenLine}}.
\+          : {token, {increment, TokenLine}}.
-           : {token, {decrement, TokenLine}}.
\.          : {token, {output, TokenLine}}.
,           : {token, {input, TokenLine}}.
\[          : {token, {block_start, TokenLine}}.
\]          : {token, {block_end, TokenLine}}.
{IGNORE}    : skip_token.

Erlang code.
