grammar EasyScript;

/**
 * Parser Rules
 */

easy: (instruction | ENDLINE)* EOF?;

instruction: command SPACE* (ENDLINE | EOF);

command: echo_ 
       | quit_ 
       | expect_
       | expect_error_
       | unknownCommand
       | assignment;

echo_: ECHO_ SPACE+ (WORD | VARIABLE | STRING);
quit_: QUIT_;
expect_: EXPECT_ SPACE+ (WORD | VARIABLE | STRING) SPACE+ unknownCommand;
expect_error_: EXPECT_ERROR_ SPACE+ (WORD | VARIABLE | STRING) SPACE+ unknownCommand;
unknownCommand: WORD argumentList?;
assignment: WORD EQUAL unknownCommand;

argumentList: argument (SPACE+ argumentList)?;
argument: WORD EQUAL (WORD | VARIABLE | STRING);

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