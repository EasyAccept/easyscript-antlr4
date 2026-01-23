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
       | unknownCommand;

echo_: ECHO_ SPACE+ STRING;
quit_: QUIT_;
expect_: EXPECT_ SPACE+ (WORD | STRING) SPACE+ unknownCommand;
expect_error_: EXPECT_ERROR_ SPACE+ (WORD | STRING) SPACE+ unknownCommand;
unknownCommand: WORD argumentList?;

argumentList: argument (SPACE+ argumentList)?;
argument: WORD EQUAL (WORD | STRING);

/**
 * Lexer Rules
 */

EQUAL: '=';
ECHO_: 'echo';
QUIT_: 'quit';
EXPECT_: 'expect';
EXPECT_ERROR_: 'expectError';

WORD: ~["' \t\r\n]+;

STRING: '"' ~["']* '"'
      | '\'' ~["']* '\'';

ENDLINE: SPACE* '\r'? '\n';

SPACE: ' ' | '\t';

COMMENT: '#' ~[\r\n]* (ENDLINE | EOF) -> skip;