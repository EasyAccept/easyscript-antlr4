grammar EasyScript;

/**
 * Parser Rules
 */

easy: ENDLINE* instruction? ENDLINE* EOF;

instruction: SPACE* command (ENDLINE+ instruction)?;

command: echo_ 
       | quit_ 
       | unknownCommand;

echo_: ECHO_ argumentList?;
quit_: QUIT_;

unknownCommand: WORD argumentList?;

argumentList: SPACE+ argument argumentList?;

argument: WORD ('=' (WORD | STRING))?
        | STRING;

/**
 * Lexer Rules
 */
// Known commands
ECHO_: 'echo';
QUIT_: 'quit';

WORD: ~[ \t\r\n]+;

STRING: '"' ~["' \t\r\n]* '"'
	     | '\'' ~["' \t\r\n]* '\'';

ENDLINE: SPACE* NEWLINE;

NEWLINE: '\r'? '\n';

SPACE: ' ' | '\t';

COMMENT: '#' ~[\r\n]* (NEWLINE | EOF) -> channel(HIDDEN);
