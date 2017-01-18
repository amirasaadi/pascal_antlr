/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

grammar pascal;

start1 : {} (comment)*? ('program'|'Program') ID ';' (comment)*? (definition1)* (comment)*?  'begin' (co1|co2)*? (statement)* (comment)*?  'end.'(comment)*? EOF;

//statement
//case
statement :b1|write1|sw1|comment|definition1|read1|while1|for1|repeat1|assignment1|ifstat1;


//definition
definition1 : 'var' ( ( ID ':' type '=' (NUM|String1) ';' { })  |  (ID (',' ID)* ':' type ';' ) ) +   ;


//calculation

exp:'('exp')' | ('('exp')'|NUM|ID|'-'ID |'+'ID |String1|Char1) op2 exp |NUM |'-'ID |'+'ID |ID |String1 |Char1 ;


//###
//assignment1

assignment1 : ID ':=' exp (';')?|ID ':=' (NUM|String1|Char1) (';')?;


b1: 'begin' (statement)* ('end;'|'end');
b2: (statement);
//ifstat
ifstat1 :'if' condif 'then' (statement) (ifstat3 )?;

ifstat3:  ('else'  (b2 |ifstat1)   |  );
s20 : 'else' ( b1 | b2 ) ;


condif:'(' cond ')';


//switch case

sw1 : 'case' '(' ID ')'  'of' stat+  (('else' stat2 | ) 'end;');
stat2 : b1 | statement ;
z: (NUM)+ ',' ( z | (NUM)+ )+ ;
zch: '\'' . '\'' | '\'' . '\'' ',' zch ;
zst: String1 | String1 ',' zst ;
stat : (NUM)+ ( |',' z )':' stat2 | Char1 ( |',' zch )':' stat2  | String1 (|',' zst )':'stat2    ; 





//ifstat :'if''(' cond ')' statement('else if' '(' cond ')' statement)* ('else' statement)?;


//while
while1:'while' cond  'do'
     ('begin' (statement)+ 'end;'|statement);
//for
for1 : 'for' ID ':=' NUM ('to'|'downto') (NUM|ID) 'do' (b1|stfor);
stfor:write1|sw1|comment|definition1|read1|while1|for1|repeat1|assignment1|ifstat1;
//repeat
repeat1 : 'repeat' (statement)+ 'until' '('cond')'   ';' ;



cond:cond2 ('and'|'or') cond|'('cond2 ('and'|'or') cond2')'|cond2|'('cond2')'|'('cond')' ;
cond2:'(' exp (OP|'=') exp')'| exp (OP|'=') exp|'not' cond2;

//read
read1:'readln''('')'';'|'read''('')'';'|'read' '(' (ID',')*? ID ')' ';'|'readln' '('  (ID',')*? ID  ')' ';';

//write 
write1 : 'write''('output1')'';'|'writeln''('output1')'';'|'write''('')'';';

output1 : (ID|String1|exp) ( ',' ( ID | String1 ) )*? ;

//pascal 
// ###

ID : LETTER (LETTER |NUM |'_')* ;


comment : (co1| co2) ;


op2:'*'|'+'|'-'|'/'|'%';


type:'integer' | 'string' | 'char';

co1:  '{'(~'}')*'}';
co2: '{*' (~'*}')* '*}'  ;

String1:'\''.*?'\'';
Char1:'\''.'\'';

OP :'<=' | '>=' | '<>'  | '<' | '>'|'not'; 
OP1:'and'|'or' ;

LETTER :'a'..'z'|'A'..'Z';
NUM:('+'|'-')? ('0'..'9')+;
WS : (' '|'\t'|'\n'|'\r')+ {skip();}; 
