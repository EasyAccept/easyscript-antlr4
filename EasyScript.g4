grammar EasyScript;

/**
 * Parser Rules
 */

easy: (instruction | ENDLINE)* EOF?;

instruction: command SPACE* (ENDLINE | EOF);

command: echo_ 
       | quit_ 
       | unknownCommand;

echo_: ECHO_ SPACE+ (STRING | WORD);
quit_: QUIT_;
unknownCommand: WORD (SPACE+ argument)+;

argument: STRING
	| WORD (EQUAL (WORD | STRING))?;

/**
 * Lexer Rules
 */
EQUAL: '=';
ECHO_: 'echo';
QUIT_: 'quit';

WORD: ~["' \t\r\n]+;

STRING: '"' ~["']* '"'
      | '\'' ~["']* '\'';

ENDLINE: SPACE* '\r'? '\n';

SPACE: ' ' | '\t';

COMMENT: '#' ~[\r\n]* (ENDLINE | EOF) -> skip;