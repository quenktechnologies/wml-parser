/*
 Grammar for the Widget Markup Language
*/

%lex

/* Definitions */
DecimalDigit [0-9]
DecimalDigits [0-9]+
NonZeroDigit [1-9]
OctalDigit [0-7]
HexDigit [0-9a-fA-F]
ExponentIndicator [eE]
SignedInteger [+-]?[0-9]+
DecimalIntegerLiteral [-]?([0]|({NonZeroDigit}{DecimalDigits}*))
ExponentPart {ExponentIndicator}{SignedInteger}
OctalIntegerLiteral [0]{OctalDigit}+
HexIntegerLiteral [0][xX]{HexDigit}+
DecimalLiteral ([-]?{DecimalIntegerLiteral}\.{DecimalDigits}*{ExponentPart}?)|(\.{DecimalDigits}{ExponentPart}?)|({DecimalIntegerLiteral}{ExponentPart}?)
NumberLiteral {DecimalLiteral}|{HexIntegerLiteral}|{OctalIntegerLiteral}
Identifier [a-z$_][a-zA-Z$_0-9-]*
Constructor [A-Z][a-zA-Z$_0-9-]*
LineContinuation \\(\r\n|\r|\n)
OctalEscapeSequence (?:[1-7][0-7]{0,2}|[0-7]{2,3})
HexEscapeSequence [x]{HexDigit}{2}
UnicodeEscapeSequence [u]{HexDigit}{4}
SingleEscapeCharacter [\'\"\\bfnrtv]
NonEscapeCharacter [^\'\"\\bfnrtv0-9xu]
CharacterEscapeSequence {SingleEscapeCharacter}|{NonEscapeCharacter}
EscapeSequence {CharacterEscapeSequence}|{OctalEscapeSequence}|{HexEscapeSequence}|{UnicodeEscapeSequence}
DoubleStringCharacter ([^\"\\\n\r]+)|(\\{EscapeSequence})|{LineContinuation}
SingleStringCharacter ([^\'\\\n\r]+)|(\\{EscapeSequence})|{LineContinuation}
TemplateStringCharacter ([^\`\\\n\r]+)|(\\{EscapeSequence})|{LineContinuation}
StringLiteral (\"{DoubleStringCharacter}*\")|(\'{SingleStringCharacter}*\')|(\`{TemplateStringCharacter}*\`)
Text ({DoubleStringCharacter}*)|({SingleStringCharacter}*)

/* Lexer flags */
%options flex
%x CHILDREN
%x COMMENT
%x CONTROL
%x INTERPOLATION
%x CONTROL_CHILD
%x TAG
%%

/* Lexer rules */

<*>\s+                                                   return;               

<INITIAL>'{%'                this.begin('CONTROL');      return '{%';
<INITIAL>'<!--'              this.begin('COMMENT');      return;
<INITIAL>'<'                 this.begin('TAG');          return '<';
<INITIAL>'{{'                this.begin('INTERPOLATION');   return '{{';

<TAG>'true'                                              return 'TRUE';
<TAG>'false'                                             return 'FALSE';
<TAG>{Constructor}                                       return 'CONSTRUCTOR';
<TAG>{Identifier}                                        return 'IDENTIFIER';
<TAG>'/>'                    this.popState();            return '/>';
<TAG>'/'                                                 return 'NOSE';
<TAG>'>'                     this.begin('CHILDREN');     return '>';
<TAG>'{{'                    this.begin('INTERPOLATION');return '{{';
<TAG>'{'                                                 return '{';
<TAG>'}'                                                 return '}';

<CHILDREN>'{{'               this.begin('INTERPOLATION');   return '{{';
<CHILDREN>'{%'               this.begin('CONTROL');      return '{%';
<CHILDREN>'<!--'             this.begin('COMMENT');      return;
<CHILDREN>'</'               this.begin('TAG');          return '</';
<CHILDREN>'<'                this.begin('TAG');          return '<';
<CHILDREN>'{'                                            return '{';
<CHILDREN>'}'                                            return '}';
<CHILDREN>[^/<>{%}]+                                     return 'CHARACTERS';

<CONTROL>'import'                                        return 'IMPORT';
<CONTROL>'from'                                          return 'FROM';
<CONTROL>'as'                                            return 'AS';
<CONTROL>'macro'                                         return 'MACRO';
<CONTROL>'endmacro'                                      return 'ENDMACRO';
<CONTROL>'for'                                           return 'FOR';
<CONTROL>'endfor'                                        return 'ENDFOR';
<CONTROL>'if'                                            return 'IF';
<CONTROL>'endif'                                         return 'ENDIF';
<CONTROL>'else'                                          return 'ELSE';
<CONTROL>'elseif'                                        return 'ELSEIF';
<CONTROL>'in'                                            return 'IN';
<CONTROL>'of'                                            return 'OF';
<CONTROL>'export'                                        return 'EXPORT';
<CONTROL>'from'                                          return 'FROM';
<CONTROL>'view'                                          return 'VIEW';
<CONTROL>'instanceof'                                    return 'INSTANCEOF';
<CONTROL>'this'                                          return 'THIS';
<CONTROL>'fun'                                           return 'FUN';
<CONTROL>'endfun'                                        return 'ENDFUN';
<CONTROL>'as'                                            return 'AS';
<CONTROL>'@'                                             return '@';
<CONTROL>'=' this.popState();this.begin('CONTROL_CHILD');return '=';
<CONTROL>{Constructor}                                   return 'CONSTRUCTOR';
<CONTROL>{Identifier}                                    return 'IDENTIFIER';
<CONTROL>'%}'                this.popState();            return '%}';
<CONTROL>'{'                                             return '{';
<CONTROL>'}'                                             return '}';

<CONTROL_CHILD>'<'           this.begin('TAG');          return '<';
<CONTROL_CHILD>'{{'          this.begin('INTERPOLATION');return '{{';
<CONTROL_CHILD>'%}'          this.popState();            return '%}';
<CONTROL_CHILD>{Constructor}                             return 'CONSTRUCTOR';
<CONTROL_CHILD>{Identifier}                              return 'IDENTIFIER';
<CONTROL_CHILD>'{'                                       return '{';
<CONTROL_CHILD>'}'                                       return '}';

<INTERPOLATION>'|'                                       return '|';
<INTERPOLATION>'->'                                      return '->';
<INTERPOLATION>'@'                                       return '@';
<INTERPOLATION>'instanceof'                              return 'INSTANCEOF';
<INTERPOLATION>'true'                                    return 'TRUE';
<INTERPOLATION>'false'                                   return 'FALSE';
<INTERPOLATION>'if'                                      return 'IF';
<INTERPOLATION>'then'                                    return 'THEN';
<INTERPOLATION>'else'                                    return 'ELSE';
<INTERPOLATION>'as'                                      return 'AS';
<INTERPOLATION>{Constructor}                             return 'CONSTRUCTOR';
<INTERPOLATION>{Identifier}                              return 'IDENTIFIER';
<INTERPOLATION>'{'                                       return '{';
<INTERPOLATION>'}'                                       return '}';
<INTERPOLATION>'}}'             this.popState();         return '}}';

<COMMENT>(.|\r|\n)*?'-->'    this.popState();            return;

<*>{NumberLiteral}                                       return 'NUMBER_LITERAL';
<*>{StringLiteral}                                       return 'STRING_LITERAL';
<*>'>'                                                   return '>';
<*>'<'                                                   return '<';
<*>'('                                                   return '(';
<*>')'                                                   return ')';
<*>'['                                                   return '[';
<*>']'                                                   return ']';
<*>';'                                                   return ';'
<*>':'                                                   return ':';
<*>'='                                                   return '='
<*>'=='                                                  return '==';
<*>'!='                                                  return '!=';
<*>'>='                                                  return '>=';
<*>'<='                                                  return '<=';
<*>'+'                                                   return '+';
<*>'-'                                                   return '-';
<*>'*'                                                   return '*';
<*>'/'                                                   return '/';
<*>'\\'                                                  return '\\';
<*>'&&'                                                  return '&&';
<*>'||'                                                  return '||';
<*>'^'                                                   return '^';
<*>'!'                                                   return '!';
<*>','                                                   return ',';
<*>'?'                                                   return '?';
<*>'.'                                                   return '.';

<*><<EOF>>                                               return 'EOF';

/lex

%ebnf
%start module
%%

module

          : imports exports EOF
            {$$ = new yy.ast.Module($1, $2, @$); return $$;}

          | imports EOF
            {$$ = new yy.ast.Module($1, [], @$); return $$;} 

          | exports EOF
            {$$ = new yy.ast.Module([], $1, @$); return $$;}

          | EOF
            {$$ = new yy.ast.Module([], [], null, @$); }
          ;

imports
          : import_statement          {$$ =  [$1];         }
          | imports import_statement  {$$ = $1.concat($2); }
          ;

import_statement
          : '{%' IMPORT import_member FROM string_literal '%}'
            {$$ = new yy.ast.ImportStatement($3, $5, @$);}
          ;

import_member
          : aggregate_member
          | aliased_member
          | composite_member
          ;

aliased_member
          : member AS member
            {$$ = new yy.ast.AliasedMember($1, $3, @$);}
          ;

aggregate_member
          : '*' AS member
            {$$ = new yy.ast.AggregateMember($3, @$);}
          ;

composite_member
          : '(' member_list  ')'
            {$$ = new yy.ast.CompositeMember($2, @$);}
          ;

member_list
          : (member | aliased_member)
            {$$ = [$1];}

          | member_list ',' (member | aliased_member)
            {$$ = $1.concat($3);}
          ;
member
          : (unqualified_identifier | unqualified_constructor)
            {$$ = $1; }
          ;

exports
          : export
            {$$ = [$1]; }

          | exports export
            {$$ = $1.concat($2);}
          ;

export
          : view_statement           
          | fun_statement 
          | tag
            {$$ = $1; }
          ;

view_statement

          : '{%' VIEW unqualified_constructor type_params? '(' type ')' '%}'
             tag
            {$$ = new yy.ast.ViewStatement($3, $4||[], $6, $9, @$);}
          ;

fun_statement

          : '{%' FUN unqualified_identifier type_params parameters '%}' 
              children 
            '{%' ENDFUN '%}'
            {$$ = new yy.ast.FunStatement($3, $4, $5, $7, @$); }

          | '{%' FUN unqualified_identifier parameters '%}' 
              children 
            '{%' ENDFUN '%}'
            {$$ = new yy.ast.FunStatement($3, [], $4, $6, @$); }

          | '{%' FUN unqualified_identifier type_params parameters '='
              child '%}' 
            {$$ = new yy.ast.FunStatement($3, $4, $5, [$7], @$); }

          | '{%' FUN unqualified_identifier parameters '=' child '%}' 
            {$$ = new yy.ast.FunStatement($3, [], $4, [$6], @$); }
          ;

type_params
          : '[' type_class_list ']' {$$ = $2; }
          ;

type_class_list
          : type_class
            {$$ = [$1];                     }

          | type_class_list ',' type_class
            {$$ = $1.concat($3);            }
          ;

type_class
          : unqualified_identifier 
           {$$ = new yy.ast.TypedParameter($1, null, @$);}

          | unqualified_identifier ':' type
           {$$ = new yy.ast.TypedParameter($1, $3, @$);}

          | unqualified_constructor 
           {$$ = new yy.ast.TypedParameter($1, null, @$);}

          | unqualified_constructor ':' type
           {$$ = new yy.ast.TypedParameter($1, $3, @$);}
          ;

type 
          : cons type_params?
            { $$ = new yy.ast.Type($1, $2||[], false, @$); }               

          | cons type_params '[' ']'
            { $$ = new yy.ast.Type($1, $2, true, @$); }

          | cons '[' ']'
            { $$ = new yy.ast.Type($1, [], true, @$); }
          ;

parameters
          : '(' ')'                
            {$$ = [];}

          | '(' parameter ')'  
            {$$ = [$2];}

          | parameters '(' parameter ')'
            {$$ = $1.concat($3); }
          ;

parameter_list
          : parameter
            {$$ = [$1]; }

          | parameter_list ',' parameter
            {$$ = $1.concat($3); }
          ;

parameter
          : unqualified_identifier ':' type
            { $$ = new yy.ast.TypedParameter($1, $3, @$); }

          | unqualified_identifier
            { $$ = new yy.ast.UntypedParameter($1, @$);  }
          ;

children
          : child           {$$ = [$1];          }
          | children child  {$$ = $1.concat($2); }
          ;

child
          : (tag | interpolation | control | characters | identifier)
            { $$ = $1; }
          ;

tag
          : node    { $$ = $1; }
          | widget  { $$ = $1; }
          ;

node
          : '<' identifier attributes '>' children? '</' identifier '>'
             {$$ = new yy.ast.Node($2, $3, $5||[], $7, @$);}

          | '<' identifier '>' children? '</' identifier '>'
             {$$ = new yy.ast.Node($2, [], $4||[], $6, @$);}

          | '<' identifier attributes '/>'
            { $$ = new yy.ast.Node($2, $3, [], $2, @$); }

          | '<' identifier '/>'
            { $$ = new yy.ast.Node($2, [], [], $2, @$); }
          ;

widget
          : '<' cons attributes '>' children? '</' cons '>'
             {$$ = new yy.ast.Widget($2, $3, $5||[], $7, @$);}

          | '<' cons '>' children? '</' cons '>'
             {$$ = new yy.ast.Widget($2, [], $4||[], $6, @$);}

          | '<' cons attributes '/>'
            { $$ = new yy.ast.Widget($2, $3, [], $2, @$); }

          | '<' cons '/>'
            { $$ = new yy.ast.Widget($2, [], [], $2, @$); }
          ;

attributes
          : attribute            {$$ = [$1];     }
          | attributes attribute {$$ = $1.concat($2);}
          ;

attribute
          : unqualified_identifier ':' unqualified_identifier '=' attribute_value
            {$$ = new yy.ast.Attribute($1, $3, $5, @$);}

          | unqualified_identifier '=' attribute_value
            {$$ =
            new yy.ast.Attribute(new yy.ast.UnqualifiedIdentifier('html', @$),
            $1, $3, @$);}

          | unqualified_identifier ':' unqualified_identifier
            {$$ = new yy.ast.Attribute($1, $3,
            new yy.ast.BooleanLiteral(true, @$), @$);  }

          | unqualified_identifier
            {$$ = new yy.ast.Attribute(
            new yy.ast.UnqualifiedIdentifier('html', @$),
            $1, new yy.ast.BooleanLiteral(true, @$), @$);  }
          ;

attribute_value
          : (interpolation|literal)
            {$$ = $1;}
          ;

interpolation
          : '{{' expression '}}'
            {$$ = new yy.ast.Interpolation($2, [], @$);}

          | '{{' expression filters '}}'
            {$$ = new yy.ast.Interpolation($2, $3, @$);}
          ;

filters
          : filter              {$$ =  [$1];     }
          | filters filter      {$$ = $1.concat($2); }
          ;

filter
          : '|'  expression
            {$$ = $2}
          ;

control
          : (for_statement|if_statement) 
            {$$ = $1;}
          ;

for_statement
          : for_in
            {$$ = $1;}

          | for_of 
            {$$ = $1;}
          ;

for_in
          : '{%' FOR for_parameters IN expression '%}' children '{%' ENDFOR '%}'
            {$$ = new yy.ast.ForInStatement($3, $5, $7, [], @$);}

          | '{%' FOR for_parameters IN expression '%}' 
             children 
             '{%' ELSE '%}' children '{%' ENDFOR '%}'
            {$$ = new yy.ast.ForInStatement($3, $5, $7, $11, @$);}
          ;

for_of
          : '{%' FOR for_parameters OF expression '%}' children '{%' ENDFOR '%}'
            {$$ = new yy.ast.ForOfStatement($3, $5, $7, [], @$);}

          | '{%' FOR for_parameters OF expression '%}' 
             children 
             '{%' ELSE '%}' children '{%' ENDFOR '%}'
            {$$ = new yy.ast.ForOfStatement($3, $5, $7, $11, @$);}
          ;

for_parameters
          : parameter 
            {$$ = [$1];}

          | parameter ',' parameter
            {$$ = [$1, $2];}
          
          | paramter ',' paramter 
            {$$ = [$1, $2, $3];}
          ;
            
if_statement
          : '{%' IF expression '%}' children else_clause
           {$$ = new yy.ast.IfStatement($3, $5, $6, @$); }
          ;

else_clause

         :  '{%' ELSE '%}' children '{%' ENDIF '%}'
            { $$ = new yy.ast.ElseClause($4, @$); }

         |  '{%' ELSE IF expression '%}' children else_clause 
            { $$ = new yy.ast.ElseIfClause($4, $6, $7, @$); }
         ;

characters
          : CHARACTERS
            {$$ = new yy.ast.Characters($1, @$); }
          ;

arguments
          : '(' ')'
            {$$ = []; }

          | '(' argument_list ')'
            {$$ = $2; }

          ;

argument_list
          : expression
            {$$ = [$1]; }

          | argument_list ',' expression
            {$$ = $1.concat($3); }
          ;

expression
          : if_expression
            { $$ = $1; }
          
          | binary_expression 
            { $$ = $1; }

          | unary_expression
            { $$ = $1; }
         
          | simple_expression 
            { $$ = $1; }

          | function_expression
            { $$ = $1; }

          | '(' expression ')'
            { $$ = $2; }
          ;

if_expression
          : IF expression THEN expression ELSE expression
            { $$ = new yy.ast.IfThenExpression($2, $4, $6, @$); }
          ;

binary_expression
         : simple_expression binary_operator simple_expression 
           {$$ = new yy.ast.BinaryExpression($1, $2, $3, @$); }

         | simple_expression binary_operator '(' expression ')'
           {$$ = new yy.ast.BinaryExpression($1, $2, $4, @$); }

         | '(' expression ')' binary_operator simple_expression
           {$$ = new yy.ast.BinaryExpression($2, $4, $5, @$); }

         | '(' expression ')' binary_operator '(' expression ')'
           {$$ = new yy.ast.BinaryExpression($2, $4, $6, @$); }
         
         ;

unary_expression
          :  '!' expression 
            {$$ = new yy.ast.UnaryExpression($1, $2, @$); }
          ;

simple_expression
          : (
             view_construction
             |fun_application
             |construct_expression 
             |call_expression 
             |member_expression 
             |literal 
             |context_property 
             |cons 
             |identifier 
             |context_variable)
            { $$ = $1; }
          ;

view_construction
          : '<' cons '(' expression ')' '>'
            { $$ = new yy.ast.ViewConstruction($2, $4, @$); }
          ;

fun_application
          : '<' fun_target type_arguments partial_application '>'
            { $$ = new yy.ast.FunApplication($2, $3, $4||[], @$); }

          | '<' fun_target partial_application '>'
            { $$ = new yy.ast.FunApplication($2, [], $3 ||[], @$); }

          | '<' fun_target '>'
            { $$ = new yy.ast.FunApplication($2, [], [], @$); }

          ;

fun_target
          : identifier 
            { $$ = $1; }

          | context_property 
            { $$ = $1; }

          | '(' expression ')'
            { $$ = $2; }
          ;

type_arguments
          : '[' type_arg_list ']'
            { $$ = $2; }
          ;

type_arg_list
          :  type 
            { $$ = [$1]; }
          
          |  type_arg_list ',' type
            { $$ = $1.concat($3); }
          ;

partial_application

         : '(' ')'
           { $$ = [new yy.ast.UnqualifiedIdentifier('undefined', @$)]; } 

         | '(' expression ')'
           { $$ = [$2]; }

         | partial_application '(' expression ')'
          { $$ = $1.concat($3); }
         ;

construct_expression
          : cons arguments
            { $$ = new yy.ast.ConstructExpression($1, $2, @$); }
          ;

call_expression
          : identifier type_arguments partial_application
            {$$ = new yy.ast.CallExpression($1, $2, $3, @$);    }

          | identifier partial_application
            {$$ = new yy.ast.CallExpression($1, [], $2, @$);    }

          | context_property type_arguments partial_application
            {$$ = new yy.ast.CallExpression($1, $2, $3, @$);    }

          | context_property partial_application
            {$$ = new yy.ast.CallExpression($1, [], $2, @$);    }

          | member_expression type_arguments partial_application
            {$$ = new yy.ast.CallExpression($1, $2, $3, @$);    }

          | member_expression partial_application
            {$$ = new yy.ast.CallExpression($1, [], $2, @$);    }

          | '(' expression ')' type_arguments partial_application
            {$$ = new yy.ast.CallExpression($2, $4, $5, @$);    }

          | '(' expression ')' partial_application
            {$$ = new yy.ast.CallExpression($2, [], $4, @$);    }
          ;

member_expression

          : qualified_identifier '.' unqualified_identifier
            {$$ = new yy.ast.MemberExpression($1, $3, @$); }

          | qualified_constructor '.' unqualified_identifier
            {$$ = new yy.ast.MemberExpression($1, $3, @$); }

          | context_variable '.' unqualified_identifier
            {$$ = new yy.ast.MemberExpression($1, $3, @$); }

          | context_property '.' unqualified_identifier
            {$$ = new yy.ast.MemberExpression($1, $3, @$); }

          | list '.' unqualified_identifier   
            {$$ = new yy.ast.MemberExpression($1, $3, @$); }

          | record '.' unqualified_identifier   
            {$$ = new yy.ast.MemberExpression($1, $3, @$); }

          | string_literal '.' unqualified_identifier
            {$$ = new yy.ast.MemberExpression($1, $3, @$); }

          | call_expression '.' unqualified_identifier
            {$$ = new yy.ast.MemberExpression($1, $3, @$); }

          |'(' expression ')' '.' unqualified_identifier
            {$$ = new yy.ast.MemberExpression($2, $5, @$); }

          | member_expression '.' unqualified_identifier
            {$$ = new yy.ast.MemberExpression($1, $3, @$); }
          ;

function_expression

          : '\\' parameter_list '->'  expression
            {$$ = new yy.ast.FunctionExpression($2, $4, @$); }

          | '\\' '->' expression
            {$$ = new yy.ast.FunctionExpression([], $3, @$); }
          ;


literal 
        : (record|list|string_literal|number_literal|boolean_literal)
        ;

record
          : '{' '}'
            {$$ = new yy.ast.Record([], @$); }

          | '{' properties '}'
            {$$ = new yy.ast.Record($2, @$); }
          ;

properties
          : property
           {$$ = [$1]; }

          | properties ',' property
           {$$ = $1.concat($3); }
          ;

property
          : (unqualified_identifier|string_literal) ':' expression
            { $$ = new yy.ast.Property($1, $3, @$); }
          ;

list
          : '[' ']'
            {$$ = new yy.ast.List([], @$); }

          | '[' argument_list ']'
            {$$ = new yy.ast.List($2, @$); }
          ;

string_literal
          : STRING_LITERAL 
            {$$ = new yy.ast.StringLiteral($1.slice(1, $1.length - 1, @$)); }
          ;

number_literal
          : NUMBER_LITERAL
          {$$ = new yy.ast.NumberLiteral($1, @$); }
          ;

boolean_literal
          : TRUE
            {$$ = new yy.ast.BooleanLiteral(true, @$);}

          | FALSE
            {$$ = new yy.ast.BooleanLiteral(false, @$);}
          ;

context_property
          : '@' unqualified_identifier
            { $$ = new yy.ast.ContextProperty($2, @$) }
          ;

context_variable
          : '@' {$$ = new yy.ast.ContextVariable(@$);}
          ;

cons
         : qualified_constructor   { $$ = $1; }
         | unqualified_constructor { $$ = $1; }
         ;

qualified_constructor
        : IDENTIFIER '.' CONSTRUCTOR
          { $$ = new yy.ast.QualifiedConstructor($1, $3, @$); }

        | CONSTRUCTOR '.' CONSTRUCTOR
          { $$ = new yy.ast.QualifiedConstructor($1, $3, @$); }
        ;

unqualified_constructor
        : CONSTRUCTOR 
          { $$ = new yy.ast.UnqualifiedConstructor($1, @$); }
        ;

identifier
        : qualified_identifier 
          { $$ = $1; }

        | unqualified_identifier
          { $$ = $1; }
        ;

qualified_identifier
         : IDENTIFIER '.' IDENTIFIER
           {$$ = new yy.ast.QualifiedIdentifier($1, $3, @$); }

         | CONSTRUCTOR '.' IDENTIFIER
          {$$ = new yy.ast.QualifiedIdentifier($1, $3, @$); }
         ;

unqualified_identifier
         : IDENTIFIER
           {$$ = new yy.ast.UnqualifiedIdentifier($1, @$);   }
         ;

binary_operator
          : ('>'|'>='|'<'|'<='|'=='|'!='|'+'|'/'|'-'|'='|'&&'|'||'|'^'|INSTANCEOF)
            { $$ = $1; }
          ;

