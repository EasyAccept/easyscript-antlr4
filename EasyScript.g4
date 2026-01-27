grammar EasyScript;

/**
 * Parser Rules
 */

easy: (instruction | ENDLINE)* EOF?;

instruction: command (ENDLINE | EOF);

command: echo_ 
       | quit_ 
       | expect_
       | expect_error_
       | unknownCommand
       | assignment;

echo_: ECHO_ SPACE+ data;
quit_: QUIT_;
expect_: EXPECT_ SPACE+ data SPACE+ unknownCommand;
expect_error_: EXPECT_ERROR_ SPACE+ data SPACE+ unknownCommand;
unknownCommand: WORD (SPACE+ argumentList)?;
assignment: WORD EQUAL unknownCommand;

argumentList: argument (SPACE+ argumentList)?;
argument: WORD EQUAL data;

data: WORD | VARIABLE | STRING;

/**
 * Lexer Rules
 */

EQUAL: '=';
ECHO_: 'echo';
QUIT_: 'quit';
EXPECT_: 'expect';
EXPECT_ERROR_: 'expectError';

WORD: ~["' \t=\r\n]+;

VARIABLE: '${' WORD '}';

STRING: '"' ~["']* '"'
      | '\'' ~["']* '\'';

ENDLINE: SPACE* '\r'? '\n';

SPACE: ' ' | '\t';

COMMENT: '#' ~[\r\n]* (ENDLINE | EOF) -> skip;